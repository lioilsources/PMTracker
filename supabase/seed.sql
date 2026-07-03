-- ============================================================
-- PMTracker — Seed Data (lokální development / demo)
-- ============================================================
-- Plně spustitelné bez ručních kroků:
--   supabase db reset      (aplikuje migrace + tento seed)
--
-- Testovací účty (heslo za lomítkem):
--   admin@pmtracker.test     / Admin123!    — Adam Novák (admin)
--   manager.a@pmtracker.test / Manager123!  — Martin Procházka (manager A)
--   manager.b@pmtracker.test / Manager123!  — Jana Horáková (manager B)
--   member.a1@pmtracker.test / Member123!   — Petr Svoboda (roster A, půjčen i na zakázku B)
--   member.a2@pmtracker.test / Member123!   — Tomáš Novotný (roster A)
--   member.b1@pmtracker.test / Member123!   — Eva Dvořáková (roster B)
--
-- Struktura:
--   1 firma: Stavby s.r.o.
--   Manager A: 2 členové v rosteru + zakázka Praha (Václavské náměstí)
--   Manager B: 1 člen v rosteru + zakázka Brno (Náměstí Svobody)
--   Půjčení: member.a1 je přiřazen i na zakázku managera B
-- ============================================================

-- 1 firma (musí existovat před auth uživateli — handle_new_user na ni váže profily)
INSERT INTO companies (id, name) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Stavby s.r.o.')
ON CONFLICT (id) DO NOTHING;

-- ------------------------------------------------------------
-- Auth uživatelé — profily založí trigger handle_new_user
-- z raw_user_meta_data (full_name, role, company_id)
-- ------------------------------------------------------------
DO $$
DECLARE
  v_company_id CONSTANT UUID := '00000000-0000-0000-0000-000000000001';
  v_admin_id   CONSTANT UUID := '00000000-0000-0000-0000-000000000010';
  v_mgr_a_id   CONSTANT UUID := '00000000-0000-0000-0000-000000000011';
  v_mgr_b_id   CONSTANT UUID := '00000000-0000-0000-0000-000000000012';
  v_mem_a1_id  CONSTANT UUID := '00000000-0000-0000-0000-000000000013';
  v_mem_a2_id  CONSTANT UUID := '00000000-0000-0000-0000-000000000014';
  v_mem_b1_id  CONSTANT UUID := '00000000-0000-0000-0000-000000000015';
  v_job_prague_id CONSTANT UUID := '00000000-0000-0000-0000-000000000101';
  v_job_brno_id   CONSTANT UUID := '00000000-0000-0000-0000-000000000102';

  v_user RECORD;
BEGIN
  -- Auth users (idempotentně)
  FOR v_user IN
    SELECT * FROM (VALUES
      (v_admin_id,  'admin@pmtracker.test',     'Admin123!',   'Adam Novák',       'admin'),
      (v_mgr_a_id,  'manager.a@pmtracker.test', 'Manager123!', 'Martin Procházka', 'manager'),
      (v_mgr_b_id,  'manager.b@pmtracker.test', 'Manager123!', 'Jana Horáková',    'manager'),
      (v_mem_a1_id, 'member.a1@pmtracker.test', 'Member123!',  'Petr Svoboda',     'member'),
      (v_mem_a2_id, 'member.a2@pmtracker.test', 'Member123!',  'Tomáš Novotný',    'member'),
      (v_mem_b1_id, 'member.b1@pmtracker.test', 'Member123!',  'Eva Dvořáková',    'member')
    ) AS t(id, email, password, full_name, user_role)
  LOOP
    INSERT INTO auth.users (
      instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
      raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
      confirmation_token, recovery_token, email_change_token_new, email_change
    ) VALUES (
      '00000000-0000-0000-0000-000000000000',
      v_user.id, 'authenticated', 'authenticated',
      v_user.email, crypt(v_user.password, gen_salt('bf')), NOW(),
      '{"provider":"email","providers":["email"]}'::jsonb,
      jsonb_build_object(
        'full_name', v_user.full_name,
        'role', v_user.user_role,
        'company_id', v_company_id
      ),
      NOW(), NOW(), '', '', '', ''
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO auth.identities (
      id, user_id, provider_id, identity_data, provider,
      last_sign_in_at, created_at, updated_at
    ) VALUES (
      gen_random_uuid(), v_user.id, v_user.id::text,
      jsonb_build_object('sub', v_user.id::text, 'email', v_user.email, 'email_verified', true),
      'email', NOW(), NOW(), NOW()
    )
    ON CONFLICT (provider_id, provider) DO NOTHING;
  END LOOP;

  -- Pojistka: profily i bez triggeru (např. starší schéma)
  INSERT INTO profiles (id, company_id, full_name, role) VALUES
    (v_admin_id,  v_company_id, 'Adam Novák',       'admin'),
    (v_mgr_a_id,  v_company_id, 'Martin Procházka', 'manager'),
    (v_mgr_b_id,  v_company_id, 'Jana Horáková',    'manager'),
    (v_mem_a1_id, v_company_id, 'Petr Svoboda',     'member'),
    (v_mem_a2_id, v_company_id, 'Tomáš Novotný',    'member'),
    (v_mem_b1_id, v_company_id, 'Eva Dvořáková',    'member')
  ON CONFLICT (id) DO NOTHING;

  -- Rostery (1:1 manager)
  UPDATE profiles SET manager_id = v_mgr_a_id WHERE id IN (v_mem_a1_id, v_mem_a2_id);
  UPDATE profiles SET manager_id = v_mgr_b_id WHERE id = v_mem_b1_id;

  -- Zakázky s reálnými souřadnicemi
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

  -- Přiřazení (vč. půjčení member.a1 na zakázku managera B)
  INSERT INTO job_assignments (job_id, member_id, assigned_by) VALUES
    (v_job_prague_id, v_mem_a1_id, v_mgr_a_id),
    (v_job_prague_id, v_mem_a2_id, v_mgr_a_id),
    (v_job_brno_id,   v_mem_b1_id, v_mgr_b_id),
    (v_job_brno_id,   v_mem_a1_id, v_mgr_b_id)  -- cross-team (půjčený člen)
  ON CONFLICT (job_id, member_id) DO NOTHING;

  -- Úkoly (checklist)
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE job_id = v_job_prague_id) THEN
    INSERT INTO tasks (job_id, company_id, title, sort_order) VALUES
      (v_job_prague_id, v_company_id, 'Vyklizení stávajícího nábytku', 1),
      (v_job_prague_id, v_company_id, 'Elektroinstalace — hrubá montáž', 2),
      (v_job_prague_id, v_company_id, 'Sádrokartonové příčky', 3),
      (v_job_prague_id, v_company_id, 'Malba a finální úpravy', 4);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM tasks WHERE job_id = v_job_brno_id) THEN
    INSERT INTO tasks (job_id, company_id, title, sort_order) VALUES
      (v_job_brno_id, v_company_id, 'Příprava rozvodů', 1),
      (v_job_brno_id, v_company_id, 'Montáž jednotek', 2),
      (v_job_brno_id, v_company_id, 'Testování a předání', 3);
  END IF;

  RAISE NOTICE 'Seed: 6 uživatelů, 2 zakázky, přiřazení a úkoly vloženy';
END;
$$;
