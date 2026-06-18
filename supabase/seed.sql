-- ============================================================
-- PMTracker — Seed Data (lokální development)
-- ============================================================
-- Předpoklady:
--   1. Spusť `supabase start`
--   2. Vytvoř uživatele v Supabase Studio (http://localhost:54323)
--      nebo přes CLI: supabase auth create
--   3. Zkopíruj jejich UUID a doplň níže
--   4. Spusť: psql $(supabase db url) -f supabase/seed.sql
--
-- Testovací uživatelé (vytvořit v Studio):
--   admin@pmtracker.test / Admin123!
--   manager.a@pmtracker.test / Manager123!
--   manager.b@pmtracker.test / Manager123!
--   member.a1@pmtracker.test / Member123!
--   member.a2@pmtracker.test / Member123!
--   member.b1@pmtracker.test / Member123!
-- ============================================================

-- 1 firma
INSERT INTO companies (id, name) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Stavby s.r.o.')
ON CONFLICT (id) DO NOTHING;

-- Profiles (id musí odpovídat auth.users.id)
-- POZOR: Nahraď UUID placeholder skutečnými UUID z auth.users tabulky!
-- Příkaz pro zjištění UUID: SELECT id, email FROM auth.users;

-- Dokumentace struktury seed dat:
-- 1 firma: Stavby s.r.o.
-- 1 admin: spravuje celou firmu
-- 2 manageři (A, B): každý má svůj tým
-- Manager A: 2 členové v rosteru + 1 zakázka v Praze (Wenceslas Square)
-- Manager B: 1 člen v rosteru + 1 zakázka v Brně (Freedom Square)
-- Přídavné přiřazení: member.a1 je přiřazen i na zakázku managera B

-- Po vytvoření auth users spusť tento skript s vyplněnými UUID:
/*
DO $$
DECLARE
  v_admin_id UUID := '<uuid-admin>';
  v_mgr_a_id UUID := '<uuid-manager-a>';
  v_mgr_b_id UUID := '<uuid-manager-b>';
  v_mem_a1_id UUID := '<uuid-member-a1>';
  v_mem_a2_id UUID := '<uuid-member-a2>';
  v_mem_b1_id UUID := '<uuid-member-b1>';
  v_company_id UUID := '00000000-0000-0000-0000-000000000001';
  v_job_prague_id UUID := gen_random_uuid();
  v_job_brno_id UUID := gen_random_uuid();
BEGIN
  -- Profiles
  INSERT INTO profiles (id, company_id, full_name, role) VALUES
    (v_admin_id, v_company_id, 'Adam Novák', 'admin'),
    (v_mgr_a_id, v_company_id, 'Martin Procházka', 'manager'),
    (v_mgr_b_id, v_company_id, 'Jana Horáková', 'manager'),
    (v_mem_a1_id, v_company_id, 'Petr Svoboda', 'member'),
    (v_mem_a2_id, v_company_id, 'Tomáš Novotný', 'member'),
    (v_mem_b1_id, v_company_id, 'Eva Dvořáková', 'member')
  ON CONFLICT (id) DO NOTHING;

  -- Roster assignments
  UPDATE profiles SET manager_id = v_mgr_a_id WHERE id IN (v_mem_a1_id, v_mem_a2_id);
  UPDATE profiles SET manager_id = v_mgr_b_id WHERE id = v_mem_b1_id;

  -- Jobs
  INSERT INTO jobs (id, company_id, manager_id, name, description, status, address, geofence_radius_m,
    location, estimated_hours)
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

  -- Job assignments
  INSERT INTO job_assignments (job_id, member_id, assigned_by) VALUES
    (v_job_prague_id, v_mem_a1_id, v_mgr_a_id),
    (v_job_prague_id, v_mem_a2_id, v_mgr_a_id),
    (v_job_brno_id, v_mem_b1_id, v_mgr_b_id),
    (v_job_brno_id, v_mem_a1_id, v_mgr_b_id)  -- cross-team assignment
  ON CONFLICT (job_id, member_id) DO NOTHING;

  -- Tasks for Prague job
  INSERT INTO tasks (job_id, company_id, title, sort_order) VALUES
    (v_job_prague_id, v_company_id, 'Vyklizení stávajícího nábytku', 1),
    (v_job_prague_id, v_company_id, 'Elektroinstalace — hrubá montáž', 2),
    (v_job_prague_id, v_company_id, 'Sádrokartonové příčky', 3),
    (v_job_prague_id, v_company_id, 'Malba a finální úpravy', 4),
    (v_job_brno_id, v_company_id, 'Příprava rozvodů', 1),
    (v_job_brno_id, v_company_id, 'Montáž jednotek', 2),
    (v_job_brno_id, v_company_id, 'Testování a předání', 3);

  RAISE NOTICE 'Seed data inserted successfully';
END;
$$;
*/

SELECT 'Seed: Vyplň UUID v komentáři výše a spusť seed_local.sql po nastavení auth users via Studio' AS info;
