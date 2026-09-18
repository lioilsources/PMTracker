-- ============================================================
-- PMTracker — Demo fixes
-- 20260703000000_demo_fixes.sql
--
-- 1. Zámek citlivých sloupců profiles (role/company_id/manager_id)
-- 2. SET search_path pro všechny SECURITY DEFINER funkce
-- 3. jobs_manager_update s WITH CHECK
-- 4. SELECT politiky pro companies a projects
-- 5. Generované sloupce jobs.lat / jobs.lng pro čtení polohy klientem
-- 6. handle_new_user — auto-provisioning profilu po signupu
-- 7. auto_stop: audit jen skutečně zastavených řádků + cron.schedule
-- 8. Rozbití RLS cyklu jobs <-> job_assignments (infinite recursion)
-- ============================================================

-- ------------------------------------------------------------
-- 1. Zámek sloupců profilu — člen si nesmí změnit roli, firmu
--    ani roster. RLS neumí porovnat OLD/NEW, proto trigger.
--    Kontexty bez auth.uid() (seed, service_role) projdou.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION protect_profile_columns()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF auth.uid() IS NOT NULL
     AND NOT COALESCE(is_admin(), FALSE)
     AND (
       NEW.role IS DISTINCT FROM OLD.role
       OR NEW.company_id IS DISTINCT FROM OLD.company_id
       OR NEW.manager_id IS DISTINCT FROM OLD.manager_id
     )
  THEN
    RAISE EXCEPTION 'Roli, firmu a roster smí měnit jen admin';
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_protect_profile_columns ON profiles;
CREATE TRIGGER trg_protect_profile_columns
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION protect_profile_columns();

-- ------------------------------------------------------------
-- 2. SECURITY DEFINER funkce: pevný search_path
--    (schéma "extensions" používá hostovaný Supabase pro PostGIS;
--    neexistující schéma v search_path Postgres ignoruje)
-- ------------------------------------------------------------
ALTER FUNCTION get_my_company_id() SET search_path = public, extensions;
ALTER FUNCTION get_my_role() SET search_path = public, extensions;
ALTER FUNCTION is_admin() SET search_path = public, extensions;
ALTER FUNCTION is_manager_or_admin() SET search_path = public, extensions;
ALTER FUNCTION owns_job(UUID) SET search_path = public, extensions;
ALTER FUNCTION in_my_roster(UUID) SET search_path = public, extensions;
ALTER FUNCTION start_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION, TEXT) SET search_path = public, extensions;
ALTER FUNCTION stop_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION) SET search_path = public, extensions;
ALTER FUNCTION get_active_entry() SET search_path = public, extensions;
ALTER FUNCTION get_today_seconds() SET search_path = public, extensions;
ALTER FUNCTION get_member_utilization(DATE, DATE) SET search_path = public, extensions;

-- ------------------------------------------------------------
-- 3. jobs_manager_update: doplnit WITH CHECK — manager nesmí
--    přepsat company_id ani předat zakázku jinému uživateli
-- ------------------------------------------------------------
DROP POLICY IF EXISTS "jobs_manager_update" ON jobs;
CREATE POLICY "jobs_manager_update" ON jobs FOR UPDATE
  USING (
    company_id = get_my_company_id() AND (
      is_admin() OR
      (is_manager_or_admin() AND manager_id = auth.uid())
    )
  )
  WITH CHECK (
    company_id = get_my_company_id() AND (
      is_admin() OR
      manager_id = auth.uid()
    )
  );

-- ------------------------------------------------------------
-- 4. companies + projects: RLS je zapnuté, ale chyběly politiky
--    (default deny → klient nepřečetl ani název vlastní firmy)
-- ------------------------------------------------------------
DROP POLICY IF EXISTS "companies_select_own" ON companies;
CREATE POLICY "companies_select_own" ON companies FOR SELECT
  USING (id = get_my_company_id());

DROP POLICY IF EXISTS "projects_select_same_company" ON projects;
CREATE POLICY "projects_select_same_company" ON projects FOR SELECT
  USING (company_id = get_my_company_id());

-- ------------------------------------------------------------
-- 5. jobs.lat / jobs.lng — generované sloupce pro čtení polohy
--    přes PostgREST (zápis jde WKT stringem do "location")
-- ------------------------------------------------------------
ALTER TABLE jobs
  ADD COLUMN IF NOT EXISTS lat DOUBLE PRECISION
    GENERATED ALWAYS AS (ST_Y(location::geometry)) STORED,
  ADD COLUMN IF NOT EXISTS lng DOUBLE PRECISION
    GENERATED ALWAYS AS (ST_X(location::geometry)) STORED;

-- ------------------------------------------------------------
-- 6. handle_new_user — po vytvoření auth uživatele založí profil.
--    company_id/role/full_name čte z raw_user_meta_data;
--    fallback: první (jediná) firma + role member.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_company_id UUID;
BEGIN
  v_company_id := COALESCE(
    (NEW.raw_user_meta_data->>'company_id')::UUID,
    (SELECT id FROM companies ORDER BY created_at LIMIT 1)
  );
  IF v_company_id IS NULL THEN
    RAISE EXCEPTION 'No company exists — run seed or pass company_id in user metadata';
  END IF;

  INSERT INTO profiles (id, company_id, full_name, role)
  VALUES (
    NEW.id,
    v_company_id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'member')
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_handle_new_user ON auth.users;
CREATE TRIGGER trg_handle_new_user
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ------------------------------------------------------------
-- 7a. auto_stop: audit přes RETURNING (původní verze logovala
--     podle časového okna → duplicitní/chybějící záznamy)
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION auto_stop_forgotten_entries()
RETURNS INTEGER
LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, extensions
AS $$
DECLARE
  v_count INTEGER;
BEGIN
  WITH stopped AS (
    UPDATE time_entries
    SET stopped_at = NOW(), auto_stopped = TRUE
    WHERE stopped_at IS NULL
      AND started_at < NOW() - INTERVAL '12 hours'
    RETURNING id, company_id, member_id, started_at, stopped_at
  )
  INSERT INTO audit_log (company_id, actor_id, action, entity_type, entity_id, details)
  SELECT company_id, member_id, 'auto_stopped', 'time_entries', id,
    jsonb_build_object('started_at', started_at, 'stopped_at', stopped_at)
  FROM stopped;

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count;
END;
$$;

-- ------------------------------------------------------------
-- 8. Rozbití RLS cyklu: politiky jobs a job_assignments (a tasks)
--    se navzájem odkazovaly přes EXISTS → "infinite recursion
--    detected in policy" při každém dotazu přihlášeného uživatele.
--    SECURITY DEFINER helpery vyhodnotí podmínku bez RLS.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION is_assigned_to_job(p_job_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM job_assignments
    WHERE job_id = p_job_id AND member_id = auth.uid()
  )
$$;

CREATE OR REPLACE FUNCTION job_company_id(p_job_id UUID) RETURNS UUID
LANGUAGE sql SECURITY DEFINER STABLE
SET search_path = public
AS $$
  SELECT company_id FROM jobs WHERE id = p_job_id
$$;

DROP POLICY IF EXISTS "jobs_member_assigned" ON jobs;
CREATE POLICY "jobs_member_assigned" ON jobs FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR
      is_assigned_to_job(id)
    )
  );

DROP POLICY IF EXISTS "job_assignments_select" ON job_assignments;
CREATE POLICY "job_assignments_select" ON job_assignments FOR SELECT
  USING (job_company_id(job_id) = get_my_company_id());

DROP POLICY IF EXISTS "tasks_select" ON tasks;
CREATE POLICY "tasks_select" ON tasks FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR
      is_assigned_to_job(job_id)
    )
  );

DROP POLICY IF EXISTS "tasks_member_complete" ON tasks;
CREATE POLICY "tasks_member_complete" ON tasks FOR UPDATE
  USING (
    company_id = get_my_company_id() AND
    is_assigned_to_job(job_id)
  )
  WITH CHECK (
    completed_by = auth.uid()
  );

-- ------------------------------------------------------------
-- 7b. Naplánovat auto-stop každých 30 minut (pg_cron)
-- ------------------------------------------------------------
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pg_cron') THEN
    IF EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'auto-stop-forgotten') THEN
      PERFORM cron.unschedule('auto-stop-forgotten');
    END IF;
    PERFORM cron.schedule(
      'auto-stop-forgotten',
      '*/30 * * * *',
      'SELECT auto_stop_forgotten_entries()'
    );
  END IF;
END;
$$;
