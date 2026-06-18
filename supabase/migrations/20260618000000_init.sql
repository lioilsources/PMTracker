-- ============================================================
-- PMTracker — Complete Schema Migration
-- 20260618000000_init.sql
-- ============================================================

-- Extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS pg_cron;  -- pro auto-stop

-- Enums (drop and recreate for idempotency)
DO $$ BEGIN
  CREATE TYPE user_role AS ENUM ('admin', 'manager', 'member');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE job_status AS ENUM ('active', 'paused', 'completed', 'archived');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ============================================================
-- TABLES
-- ============================================================

-- Companies (multi-tenant insurance)
CREATE TABLE IF NOT EXISTS companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Profiles (extends auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  company_id UUID NOT NULL REFERENCES companies(id),
  full_name TEXT NOT NULL,
  role user_role NOT NULL DEFAULT 'member',
  manager_id UUID REFERENCES profiles(id),  -- 1:1 roster
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Projects (cheap insurance for PM layer, hidden in MVP UI)
CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id),
  manager_id UUID NOT NULL REFERENCES profiles(id),
  name TEXT NOT NULL,
  description TEXT,
  status job_status NOT NULL DEFAULT 'active',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Jobs (zakázky) — 1:1 owner
CREATE TABLE IF NOT EXISTS jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id),
  project_id UUID REFERENCES projects(id),
  manager_id UUID NOT NULL REFERENCES profiles(id),
  name TEXT NOT NULL,
  description TEXT,
  status job_status NOT NULL DEFAULT 'active',
  location GEOGRAPHY(POINT, 4326),
  geofence_radius_m INTEGER NOT NULL DEFAULT 200,
  estimated_hours NUMERIC(10,2),
  address TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Job assignments (M:N members <-> jobs)
CREATE TABLE IF NOT EXISTS job_assignments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  member_id UUID NOT NULL REFERENCES profiles(id),
  assigned_by UUID NOT NULL REFERENCES profiles(id),
  assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(job_id, member_id)
);

-- Tasks (additive checklist — v MVP čas se trackuje na job, ne task)
CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  company_id UUID NOT NULL REFERENCES companies(id),
  title TEXT NOT NULL,
  is_completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_by UUID REFERENCES profiles(id),
  completed_at TIMESTAMPTZ,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Time entries — zápis VÝHRADNĚ přes SECURITY DEFINER RPC
CREATE TABLE IF NOT EXISTS time_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id),
  job_id UUID NOT NULL REFERENCES jobs(id),
  member_id UUID NOT NULL REFERENCES profiles(id),
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  stopped_at TIMESTAMPTZ,
  duration_seconds INTEGER GENERATED ALWAYS AS (
    CASE WHEN stopped_at IS NOT NULL
    THEN EXTRACT(EPOCH FROM (stopped_at - started_at))::INTEGER
    ELSE NULL END
  ) STORED,
  within_geofence BOOLEAN,  -- nastavuje POUZE server
  override_reason TEXT,
  notes TEXT,
  auto_stopped BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Audit log
CREATE TABLE IF NOT EXISTS audit_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL REFERENCES companies(id),
  actor_id UUID REFERENCES profiles(id),
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id UUID,
  details JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE job_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE time_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_log ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================

-- Helper function: get current user's company_id
CREATE OR REPLACE FUNCTION get_my_company_id() RETURNS UUID
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT company_id FROM profiles WHERE id = auth.uid()
$$;

-- Helper function: get current user's role
CREATE OR REPLACE FUNCTION get_my_role() RETURNS user_role
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT role FROM profiles WHERE id = auth.uid()
$$;

-- Helper: is admin
CREATE OR REPLACE FUNCTION is_admin() RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT role = 'admin' FROM profiles WHERE id = auth.uid()
$$;

-- Helper: is manager or admin
CREATE OR REPLACE FUNCTION is_manager_or_admin() RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT role IN ('admin', 'manager') FROM profiles WHERE id = auth.uid()
$$;

-- Helper: owns_job (manager owns the job)
CREATE OR REPLACE FUNCTION owns_job(p_job_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT EXISTS (SELECT 1 FROM jobs WHERE id = p_job_id AND manager_id = auth.uid())
$$;

-- Helper: in_roster (member is in manager's roster)
CREATE OR REPLACE FUNCTION in_my_roster(p_member_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = p_member_id AND manager_id = auth.uid())
$$;

-- ============================================================
-- RLS POLICIES
-- ============================================================

-- Drop existing policies to allow re-running
DO $$ BEGIN
  DROP POLICY IF EXISTS "profiles_select_same_company" ON profiles;
  DROP POLICY IF EXISTS "profiles_update_own" ON profiles;
  DROP POLICY IF EXISTS "profiles_admin_all" ON profiles;
  DROP POLICY IF EXISTS "jobs_member_assigned" ON jobs;
  DROP POLICY IF EXISTS "jobs_manager_insert" ON jobs;
  DROP POLICY IF EXISTS "jobs_manager_update" ON jobs;
  DROP POLICY IF EXISTS "job_assignments_select" ON job_assignments;
  DROP POLICY IF EXISTS "job_assignments_insert_manager" ON job_assignments;
  DROP POLICY IF EXISTS "job_assignments_delete_manager" ON job_assignments;
  DROP POLICY IF EXISTS "tasks_select" ON tasks;
  DROP POLICY IF EXISTS "tasks_manager_write" ON tasks;
  DROP POLICY IF EXISTS "tasks_member_complete" ON tasks;
  DROP POLICY IF EXISTS "time_entries_member_own" ON time_entries;
  DROP POLICY IF EXISTS "time_entries_no_direct_insert" ON time_entries;
  DROP POLICY IF EXISTS "time_entries_no_direct_update" ON time_entries;
  DROP POLICY IF EXISTS "time_entries_no_direct_delete" ON time_entries;
  DROP POLICY IF EXISTS "audit_log_admin_only" ON audit_log;
  DROP POLICY IF EXISTS "audit_log_no_write" ON audit_log;
END $$;

-- profiles RLS
CREATE POLICY "profiles_select_same_company" ON profiles FOR SELECT
  USING (company_id = get_my_company_id());

CREATE POLICY "profiles_update_own" ON profiles FOR UPDATE
  USING (id = auth.uid()) WITH CHECK (id = auth.uid());

CREATE POLICY "profiles_admin_all" ON profiles FOR ALL
  USING (is_admin());

-- jobs RLS
CREATE POLICY "jobs_member_assigned" ON jobs FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR
      EXISTS (SELECT 1 FROM job_assignments WHERE job_id = jobs.id AND member_id = auth.uid())
    )
  );

CREATE POLICY "jobs_manager_insert" ON jobs FOR INSERT
  WITH CHECK (
    company_id = get_my_company_id() AND
    is_manager_or_admin() AND
    manager_id = auth.uid()
  );

CREATE POLICY "jobs_manager_update" ON jobs FOR UPDATE
  USING (
    company_id = get_my_company_id() AND (
      is_admin() OR
      (is_manager_or_admin() AND manager_id = auth.uid())
    )
  );

-- job_assignments RLS
CREATE POLICY "job_assignments_select" ON job_assignments FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM jobs WHERE id = job_assignments.job_id AND company_id = get_my_company_id())
  );

CREATE POLICY "job_assignments_insert_manager" ON job_assignments FOR INSERT
  WITH CHECK (
    is_manager_or_admin() AND
    owns_job(job_id)
  );

CREATE POLICY "job_assignments_delete_manager" ON job_assignments FOR DELETE
  USING (
    is_manager_or_admin() AND
    owns_job(job_id)
  );

-- tasks RLS
CREATE POLICY "tasks_select" ON tasks FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      is_manager_or_admin() OR
      EXISTS (SELECT 1 FROM job_assignments WHERE job_id = tasks.job_id AND member_id = auth.uid())
    )
  );

CREATE POLICY "tasks_manager_write" ON tasks FOR ALL
  USING (
    company_id = get_my_company_id() AND
    is_manager_or_admin() AND
    owns_job(job_id)
  );

CREATE POLICY "tasks_member_complete" ON tasks FOR UPDATE
  USING (
    company_id = get_my_company_id() AND
    EXISTS (SELECT 1 FROM job_assignments WHERE job_id = tasks.job_id AND member_id = auth.uid())
  )
  WITH CHECK (
    completed_by = auth.uid()
  );

-- time_entries RLS — SELECT only (INSERT/UPDATE via RPC)
CREATE POLICY "time_entries_member_own" ON time_entries FOR SELECT
  USING (
    company_id = get_my_company_id() AND (
      member_id = auth.uid() OR
      (is_manager_or_admin() AND (
        owns_job(job_id) OR
        in_my_roster(member_id)
      ))
    )
  );

-- Explicitně zakázat INSERT/UPDATE/DELETE z klienta
CREATE POLICY "time_entries_no_direct_insert" ON time_entries FOR INSERT
  WITH CHECK (FALSE);

CREATE POLICY "time_entries_no_direct_update" ON time_entries FOR UPDATE
  USING (FALSE);

CREATE POLICY "time_entries_no_direct_delete" ON time_entries FOR DELETE
  USING (FALSE);

-- audit_log RLS
CREATE POLICY "audit_log_admin_only" ON audit_log FOR SELECT
  USING (is_admin() AND company_id = get_my_company_id());

CREATE POLICY "audit_log_no_write" ON audit_log FOR INSERT
  WITH CHECK (FALSE);

-- ============================================================
-- RPC FUNCTIONS (SECURITY DEFINER)
-- ============================================================

-- start_tracking: member zahájí time entry
CREATE OR REPLACE FUNCTION start_tracking(
  p_job_id UUID,
  p_lat DOUBLE PRECISION,
  p_lon DOUBLE PRECISION,
  p_override_reason TEXT DEFAULT NULL
) RETURNS UUID
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_member_id UUID := auth.uid();
  v_company_id UUID;
  v_within_geofence BOOLEAN;
  v_entry_id UUID;
  v_job_name TEXT;
BEGIN
  SELECT company_id INTO v_company_id FROM profiles WHERE id = v_member_id;
  IF v_company_id IS NULL THEN RAISE EXCEPTION 'Profile not found'; END IF;

  -- Check assignment
  IF NOT EXISTS (
    SELECT 1 FROM job_assignments ja
    JOIN jobs j ON j.id = ja.job_id
    WHERE ja.job_id = p_job_id AND ja.member_id = v_member_id
      AND j.company_id = v_company_id AND j.status = 'active'
  ) THEN
    RAISE EXCEPTION 'Not assigned to this active job';
  END IF;

  -- Check no active entry
  IF EXISTS (
    SELECT 1 FROM time_entries WHERE member_id = v_member_id AND stopped_at IS NULL
  ) THEN
    RAISE EXCEPTION 'Already tracking time — stop current entry first';
  END IF;

  -- Geofence check (PostGIS ST_DWithin)
  SELECT
    j.name,
    CASE WHEN j.location IS NULL THEN TRUE
    ELSE ST_DWithin(
      j.location::geography,
      ST_SetSRID(ST_MakePoint(p_lon, p_lat), 4326)::geography,
      j.geofence_radius_m
    ) END
  INTO v_job_name, v_within_geofence
  FROM jobs j WHERE j.id = p_job_id AND j.company_id = v_company_id;

  IF NOT FOUND THEN RAISE EXCEPTION 'Job not found'; END IF;

  IF NOT v_within_geofence AND p_override_reason IS NULL THEN
    RAISE EXCEPTION 'Outside geofence: provide override_reason';
  END IF;

  INSERT INTO time_entries (company_id, job_id, member_id, started_at, within_geofence, override_reason)
  VALUES (v_company_id, p_job_id, v_member_id, NOW(), v_within_geofence, p_override_reason)
  RETURNING id INTO v_entry_id;

  IF NOT v_within_geofence THEN
    INSERT INTO audit_log (company_id, actor_id, action, entity_type, entity_id, details)
    VALUES (v_company_id, v_member_id, 'geofence_override', 'time_entries', v_entry_id,
      jsonb_build_object('job_id', p_job_id, 'override_reason', p_override_reason, 'job_name', v_job_name));
  END IF;

  RETURN v_entry_id;
END;
$$;

-- stop_tracking
CREATE OR REPLACE FUNCTION stop_tracking(
  p_entry_id UUID,
  p_lat DOUBLE PRECISION DEFAULT NULL,
  p_lon DOUBLE PRECISION DEFAULT NULL
) RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_member_id UUID := auth.uid();
BEGIN
  UPDATE time_entries
  SET stopped_at = NOW()
  WHERE id = p_entry_id AND member_id = v_member_id AND stopped_at IS NULL;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Time entry not found, already stopped, or not yours';
  END IF;
END;
$$;

-- get_active_entry: aktuální aktivní time entry přihlášeného člena
CREATE OR REPLACE FUNCTION get_active_entry()
RETURNS TABLE(id UUID, job_id UUID, job_name TEXT, started_at TIMESTAMPTZ, within_geofence BOOLEAN)
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT te.id, te.job_id, j.name, te.started_at, te.within_geofence
  FROM time_entries te
  JOIN jobs j ON j.id = te.job_id
  WHERE te.member_id = auth.uid() AND te.stopped_at IS NULL
  LIMIT 1;
$$;

-- get_today_seconds: součet sekund dnes pro přihlášeného člena
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
    AND DATE(started_at AT TIME ZONE 'Europe/Prague') = CURRENT_DATE;
$$;

-- get_member_utilization: report vytížení pro managera
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
    DATE(te.started_at) BETWEEN p_from AND p_to AND
    (
      -- manager sees their roster or their jobs
      in_my_roster(te.member_id) OR
      owns_job(te.job_id) OR
      is_admin()
    )
  GROUP BY te.member_id, p.full_name, te.job_id, j.name
  ORDER BY p.full_name, j.name;
$$;

-- auto_stop_forgotten: pg_cron ho zavolá každých 5 minut (nastavit v Supabase dashboard)
CREATE OR REPLACE FUNCTION auto_stop_forgotten_entries()
RETURNS INTEGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_count INTEGER;
BEGIN
  UPDATE time_entries
  SET stopped_at = NOW(), auto_stopped = TRUE
  WHERE stopped_at IS NULL
    AND started_at < NOW() - INTERVAL '12 hours';

  GET DIAGNOSTICS v_count = ROW_COUNT;

  IF v_count > 0 THEN
    INSERT INTO audit_log (company_id, actor_id, action, entity_type, entity_id, details)
    SELECT company_id, member_id, 'auto_stopped', 'time_entries', id,
      jsonb_build_object('started_at', started_at, 'stopped_at', stopped_at)
    FROM time_entries
    WHERE auto_stopped = TRUE AND stopped_at >= NOW() - INTERVAL '1 minute';
  END IF;

  RETURN v_count;
END;
$$;

-- ============================================================
-- TRIGGERS
-- ============================================================

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$;

DROP TRIGGER IF EXISTS trg_profiles_updated_at ON profiles;
CREATE TRIGGER trg_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS trg_jobs_updated_at ON jobs;
CREATE TRIGGER trg_jobs_updated_at BEFORE UPDATE ON jobs FOR EACH ROW EXECUTE FUNCTION update_updated_at();

DROP TRIGGER IF EXISTS trg_projects_updated_at ON projects;
CREATE TRIGGER trg_projects_updated_at BEFORE UPDATE ON projects FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_profiles_company ON profiles(company_id);
CREATE INDEX IF NOT EXISTS idx_profiles_manager ON profiles(manager_id);
CREATE INDEX IF NOT EXISTS idx_jobs_company ON jobs(company_id);
CREATE INDEX IF NOT EXISTS idx_jobs_manager ON jobs(manager_id);
CREATE INDEX IF NOT EXISTS idx_job_assignments_job ON job_assignments(job_id);
CREATE INDEX IF NOT EXISTS idx_job_assignments_member ON job_assignments(member_id);
CREATE INDEX IF NOT EXISTS idx_time_entries_member ON time_entries(member_id);
CREATE INDEX IF NOT EXISTS idx_time_entries_job ON time_entries(job_id);
CREATE INDEX IF NOT EXISTS idx_time_entries_active ON time_entries(member_id) WHERE stopped_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_time_entries_started_at ON time_entries(started_at);
CREATE INDEX IF NOT EXISTS idx_audit_log_company ON audit_log(company_id, created_at DESC);
