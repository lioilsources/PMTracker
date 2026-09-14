-- ============================================================
-- PMTracker — Seed Data (demo / development)
-- ============================================================
-- Předpoklad: testovací auth uživatelé už existují.
--   node scripts/create-test-users.mjs
--
-- Testovací účty:
--   admin@pmtracker.test      / Admin123!    Adam Novák       (admin)
--   manager.a@pmtracker.test  / Manager123!  Martin Procházka (manager, tým A)
--   manager.b@pmtracker.test  / Manager123!  Jana Horáková    (manager, tým B)
--   member.a1@pmtracker.test  / Member123!   Petr Svoboda     (tým A)
--   member.a2@pmtracker.test  / Member123!   Tomáš Novotný    (tým A)
--   member.b1@pmtracker.test  / Member123!   Eva Dvořáková    (tým B)
--
-- Struktura: 1 firma, 1 admin, 2 manažeři s vlastními týmy,
-- 2 zakázky (Praha / Brno), member.a1 je půjčený i na brněnskou (cross-team).
--
-- Skript je idempotentní — lze spustit opakovaně.
-- ============================================================

DO $$
DECLARE
  v_company_id    UUID := '00000000-0000-0000-0000-000000000001';
  v_job_prague_id UUID := '00000000-0000-0000-0000-0000000000a1';
  v_job_brno_id   UUID := '00000000-0000-0000-0000-0000000000b1';
  v_admin_id  UUID;
  v_mgr_a_id  UUID;
  v_mgr_b_id  UUID;
  v_mem_a1_id UUID;
  v_mem_a2_id UUID;
  v_mem_b1_id UUID;
  v_missing   TEXT[] := '{}';

BEGIN
  -- Dohledání UUID podle e-mailu (žádné ruční vyplňování)
  SELECT id INTO v_admin_id  FROM auth.users WHERE email = 'admin@pmtracker.test';
  SELECT id INTO v_mgr_a_id  FROM auth.users WHERE email = 'manager.a@pmtracker.test';
  SELECT id INTO v_mgr_b_id  FROM auth.users WHERE email = 'manager.b@pmtracker.test';
  SELECT id INTO v_mem_a1_id FROM auth.users WHERE email = 'member.a1@pmtracker.test';
  SELECT id INTO v_mem_a2_id FROM auth.users WHERE email = 'member.a2@pmtracker.test';
  SELECT id INTO v_mem_b1_id FROM auth.users WHERE email = 'member.b1@pmtracker.test';

  IF v_admin_id  IS NULL THEN v_missing := v_missing || 'admin@pmtracker.test'; END IF;
  IF v_mgr_a_id  IS NULL THEN v_missing := v_missing || 'manager.a@pmtracker.test'; END IF;
  IF v_mgr_b_id  IS NULL THEN v_missing := v_missing || 'manager.b@pmtracker.test'; END IF;
  IF v_mem_a1_id IS NULL THEN v_missing := v_missing || 'member.a1@pmtracker.test'; END IF;
  IF v_mem_a2_id IS NULL THEN v_missing := v_missing || 'member.a2@pmtracker.test'; END IF;
  IF v_mem_b1_id IS NULL THEN v_missing := v_missing || 'member.b1@pmtracker.test'; END IF;

  IF array_length(v_missing, 1) > 0 THEN
    RAISE EXCEPTION 'Chybí auth uživatelé: %. Spusť nejdřív: node scripts/create-test-users.mjs',
      array_to_string(v_missing, ', ');
  END IF;

  -- Firma
  INSERT INTO companies (id, name) VALUES (v_company_id, 'Stavby s.r.o.')
  ON CONFLICT (id) DO NOTHING;

  -- Profily
  INSERT INTO profiles (id, company_id, full_name, role) VALUES
    (v_admin_id,  v_company_id, 'Adam Novák',       'admin'),
    (v_mgr_a_id,  v_company_id, 'Martin Procházka', 'manager'),
    (v_mgr_b_id,  v_company_id, 'Jana Horáková',    'manager'),
    (v_mem_a1_id, v_company_id, 'Petr Svoboda',     'member'),
    (v_mem_a2_id, v_company_id, 'Tomáš Novotný',    'member'),
    (v_mem_b1_id, v_company_id, 'Eva Dvořáková',    'member')
  ON CONFLICT (id) DO NOTHING;

  -- Roster (1:1 — každý člen má právě jednoho manažera)
  UPDATE profiles SET manager_id = v_mgr_a_id WHERE id IN (v_mem_a1_id, v_mem_a2_id);
  UPDATE profiles SET manager_id = v_mgr_b_id WHERE id = v_mem_b1_id;

  -- Zakázky
  INSERT INTO jobs (id, company_id, manager_id, name, description, status, address,
                    geofence_radius_m, location, estimated_hours)
  VALUES
    (v_job_prague_id, v_company_id, v_mgr_a_id,
     'Rekonstrukce kanceláří Praha', 'Kompletní rekonstrukce 3. patra budovy',
     'active', 'Václavské náměstí 1, Praha 1', 200,
     ST_SetSRID(ST_MakePoint(14.4244, 50.0827), 4326)::geography, 480),
    (v_job_brno_id, v_company_id, v_mgr_b_id,
     'Instalace klimatizace Brno', 'Klimatizace pro obchodní centrum',
     'active', 'Náměstí Svobody 1, Brno', 150,
     ST_SetSRID(ST_MakePoint(16.6071, 49.1951), 4326)::geography, 120)
  ON CONFLICT (id) DO NOTHING;

  -- Přiřazení na zakázky
  INSERT INTO job_assignments (job_id, member_id, assigned_by) VALUES
    (v_job_prague_id, v_mem_a1_id, v_mgr_a_id),
    (v_job_prague_id, v_mem_a2_id, v_mgr_a_id),
    (v_job_brno_id,   v_mem_b1_id, v_mgr_b_id),
    (v_job_brno_id,   v_mem_a1_id, v_mgr_b_id)   -- půjčený napříč týmy
  ON CONFLICT (job_id, member_id) DO NOTHING;

  -- Úkoly (v MVP jen checklist, čas se trackuje na zakázku)
  INSERT INTO tasks (job_id, company_id, title, sort_order)
  SELECT v.job_id, v_company_id, v.title, v.sort_order
  FROM (VALUES
    (v_job_prague_id, 'Vyklizení stávajícího nábytku',   1),
    (v_job_prague_id, 'Elektroinstalace — hrubá montáž', 2),
    (v_job_prague_id, 'Sádrokartonové příčky',           3),
    (v_job_prague_id, 'Malba a finální úpravy',          4),
    (v_job_brno_id,   'Příprava rozvodů',                1),
    (v_job_brno_id,   'Montáž jednotek',                 2),
    (v_job_brno_id,   'Testování a předání',             3)
  ) AS v(job_id, title, sort_order)
  WHERE NOT EXISTS (
    SELECT 1 FROM tasks t WHERE t.job_id = v.job_id AND t.title = v.title
  );

  RAISE NOTICE 'Seed hotový — 1 firma, 6 profilů, 2 zakázky, 4 přiřazení, 7 úkolů.';
END;
$$;
