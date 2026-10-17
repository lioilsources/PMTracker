-- ============================================================
-- PMTracker — Oprava nekonečné rekurze v RLS
-- 20260914000000_fix_rls_recursion.sql
-- ============================================================
-- jobs_member_assigned četl job_assignments a job_assignments_select četl jobs,
-- takže každý SELECT na jobs, job_assignments i tasks padal na 42P17
-- "infinite recursion detected in policy". Křížové kontroly teď jdou přes
-- SECURITY DEFINER helpery (stejně jako owns_job), které RLS druhé tabulky
-- nevyhodnocují.

-- Helper: is_assigned_to_job (přihlášený člen je přiřazený na zakázku)
CREATE OR REPLACE FUNCTION is_assigned_to_job(p_job_id UUID) RETURNS BOOLEAN
LANGUAGE sql SECURITY DEFINER STABLE AS $$
  SELECT EXISTS (SELECT 1 FROM job_assignments WHERE job_id = p_job_id AND member_id = auth.uid())
$$;

-- Helper: get_job_company_id (firma zakázky bez vyhodnocení RLS na jobs)
CREATE OR REPLACE FUNCTION get_job_company_id(p_job_id UUID) RETURNS UUID
LANGUAGE sql SECURITY DEFINER STABLE AS $$
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
  USING (get_job_company_id(job_id) = get_my_company_id());
