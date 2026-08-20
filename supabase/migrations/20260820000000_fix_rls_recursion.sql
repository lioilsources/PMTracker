-- ============================================================
-- Oprava: nekonečná rekurze v RLS politikách
-- 20260820000000_fix_rls_recursion.sql
-- ============================================================
-- Politika "jobs_member_assigned" se ptala do job_assignments a politika
-- "job_assignments_select" se ptala zpět do jobs. Postgres na poddotazy
-- uvnitř politiky aplikuje RLS znovu → vzájemná rekurze:
--
--   ERROR: infinite recursion detected in policy for relation "jobs"
--
-- Důsledek: člen (member) si nedokázal načíst ani jednu zakázku — tedy
-- hlavní obrazovka aplikace. Řešení je stejné jako u owns_job(): dotazy
-- schovat do SECURITY DEFINER helperů, které RLS nespouštějí znovu.

-- ---------- helpery ----------
CREATE OR REPLACE FUNCTION is_assigned_to_job(p_job_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT EXISTS (
    SELECT 1 FROM job_assignments
    WHERE job_id = p_job_id AND member_id = auth.uid()
  )
$$;

CREATE OR REPLACE FUNCTION job_in_my_company(p_job_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT EXISTS (
    SELECT 1 FROM jobs
    WHERE id = p_job_id AND company_id = get_my_company_id()
  )
$$;

-- ---------- jobs ----------
DROP POLICY IF EXISTS "jobs_member_assigned" ON jobs;
CREATE POLICY "jobs_member_assigned" ON jobs FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR is_assigned_to_job(id)
    )
  );

-- ---------- job_assignments ----------
DROP POLICY IF EXISTS "job_assignments_select" ON job_assignments;
CREATE POLICY "job_assignments_select" ON job_assignments FOR SELECT
  USING (job_in_my_company(job_id));

-- ---------- tasks ----------
DROP POLICY IF EXISTS "tasks_select" ON tasks;
CREATE POLICY "tasks_select" ON tasks FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR is_assigned_to_job(job_id)
    )
  );

DROP POLICY IF EXISTS "tasks_member_complete" ON tasks;
CREATE POLICY "tasks_member_complete" ON tasks FOR UPDATE
  USING (
    company_id = get_my_company_id() AND is_assigned_to_job(job_id)
  )
  -- Původní WITH CHECK (completed_by = auth.uid()) šlo splnit jen při
  -- zaškrtnutí — odškrtnout úkol (completed_by → NULL) nešlo vůbec.
  -- Nově: člen smí měnit jen úkoly na svých zakázkách a nesmí podepsat
  -- splnění cizím jménem.
  WITH CHECK (
    company_id = get_my_company_id()
    AND is_assigned_to_job(job_id)
    AND (completed_by IS NULL OR completed_by = auth.uid())
  );

-- ---------- time_entries ----------
-- Admin neměl na výkazy žádnou cestu: podmínka vyžadovala buď vlastní
-- záznam, nebo vlastnictví zakázky / roster — a admin typicky nevlastní
-- ani jedno. Viditelnost "admin vidí vše" (README, role model) tak
-- platila jen v reportu get_member_utilization, ne nad tabulkou.
DROP POLICY IF EXISTS "time_entries_member_own" ON time_entries;
CREATE POLICY "time_entries_member_own" ON time_entries FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      member_id = auth.uid() OR
      is_admin() OR
      (is_manager_or_admin() AND (owns_job(job_id) OR in_my_roster(member_id)))
    )
  );

-- ============================================================
-- Oprava: časové pásmo v denních a reportovacích součtech
-- ============================================================
-- get_today_seconds() porovnávalo DATE(started_at AT TIME ZONE 'Europe/Prague')
-- s CURRENT_DATE, což je datum v časovém pásmu serveru (na Supabase UTC).
-- Mezi půlnocí a 02:00 letního času tak "dnešek" na serveru byl ještě včerejšek
-- a součet za dnešek vycházel nula. Obě hranice musí být ve stejném pásmu.
CREATE OR REPLACE FUNCTION get_today_seconds()
RETURNS INTEGER
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT COALESCE(SUM(
    CASE WHEN stopped_at IS NOT NULL THEN duration_seconds
    ELSE EXTRACT(EPOCH FROM (NOW() - started_at))::INTEGER
    END
  ), 0)::INTEGER
  FROM time_entries
  WHERE member_id = auth.uid()
    AND (started_at AT TIME ZONE 'Europe/Prague')::DATE
        = (NOW() AT TIME ZONE 'Europe/Prague')::DATE;
$$;

-- Report filtroval podle DATE(te.started_at), tedy podle data v UTC —
-- směna od 23:00 do 01:00 padla do jiného dne, než jaký vidí uživatel.
CREATE OR REPLACE FUNCTION get_member_utilization(
  p_from DATE DEFAULT CURRENT_DATE - INTERVAL '30 days',
  p_to DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE(
  member_id UUID,
  full_name TEXT,
  job_id UUID,
  job_name TEXT,
  total_seconds BIGINT,
  entry_count BIGINT
)
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT
    te.member_id,
    p.full_name,
    te.job_id,
    j.name AS job_name,
    SUM(te.duration_seconds) AS total_seconds,
    COUNT(*) AS entry_count
  FROM time_entries te
  JOIN profiles p ON p.id = te.member_id
  JOIN jobs j ON j.id = te.job_id
  WHERE
    te.stopped_at IS NOT NULL AND
    (te.started_at AT TIME ZONE 'Europe/Prague')::DATE BETWEEN p_from AND p_to AND
    (
      in_my_roster(te.member_id) OR
      owns_job(te.job_id) OR
      is_admin()
    )
  GROUP BY te.member_id, p.full_name, te.job_id, j.name
  ORDER BY p.full_name, j.name;
$$;
