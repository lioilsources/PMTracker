-- ============================================================
-- PMTracker — Seed Data (lokální development + testy)
-- ============================================================
-- Spouští se automaticky přes `supabase db reset`.
-- Vytváří auth uživatele i profily s PEVNÝMI UUID, aby na ně
-- mohly navazovat pgTAP testy v supabase/tests/database/.
--
-- Testovací účty (heslo vždy odpovídá roli):
--   admin@pmtracker.test      / Admin123!
--   manager.a@pmtracker.test  / Manager123!
--   manager.b@pmtracker.test  / Manager123!
--   member.a1@pmtracker.test  / Member123!
--   member.a2@pmtracker.test  / Member123!
--   member.b1@pmtracker.test  / Member123!
--
-- Struktura:
--   1 firma "Stavby s.r.o."
--   Manager A → roster: member.a1, member.a2; zakázka Praha (r=200 m)
--   Manager B → roster: member.b1;            zakázka Brno  (r=150 m)
--   member.a1 je půjčený i na zakázku Brno (cross-team assignment)
-- ============================================================

-- ---------- pevná UUID (sdílená s testy) ----------
-- 1111… admin, 2222… manager A, 3333… manager B
-- 4444… member A1, 5555… member A2, 6666… member B1
-- aaaa… zakázka Praha, bbbb… zakázka Brno

-- ---------- auth uživatelé ----------
-- Na hostovaném Supabase se uživatelé zakládají přes invite/Auth API;
-- lokálně je vložíme přímo, aby šlo `supabase db reset` a hned se přihlásit.
INSERT INTO auth.users (
  instance_id, id, aud, role, email, encrypted_password,
  email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
  created_at, updated_at
)
VALUES
  ('00000000-0000-0000-0000-000000000000', '11111111-1111-1111-1111-111111111111',
   'authenticated', 'authenticated', 'admin@pmtracker.test', crypt('Admin123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Adam Novák"}', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000000', '22222222-2222-2222-2222-222222222222',
   'authenticated', 'authenticated', 'manager.a@pmtracker.test', crypt('Manager123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Martin Procházka"}', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000000', '33333333-3333-3333-3333-333333333333',
   'authenticated', 'authenticated', 'manager.b@pmtracker.test', crypt('Manager123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Jana Horáková"}', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000000', '44444444-4444-4444-4444-444444444444',
   'authenticated', 'authenticated', 'member.a1@pmtracker.test', crypt('Member123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Petr Svoboda"}', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000000', '55555555-5555-5555-5555-555555555555',
   'authenticated', 'authenticated', 'member.a2@pmtracker.test', crypt('Member123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Tomáš Novotný"}', NOW(), NOW()),
  ('00000000-0000-0000-0000-000000000000', '66666666-6666-6666-6666-666666666666',
   'authenticated', 'authenticated', 'member.b1@pmtracker.test', crypt('Member123!', gen_salt('bf')),
   NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Eva Dvořáková"}', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- ---------- firma ----------
INSERT INTO companies (id, name) VALUES
  ('00000000-0000-0000-0000-000000000001', 'Stavby s.r.o.')
ON CONFLICT (id) DO NOTHING;

-- ---------- profily + roster ----------
INSERT INTO profiles (id, company_id, full_name, role, manager_id) VALUES
  ('11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0000-000000000001', 'Adam Novák',       'admin',   NULL),
  ('22222222-2222-2222-2222-222222222222', '00000000-0000-0000-0000-000000000001', 'Martin Procházka', 'manager', NULL),
  ('33333333-3333-3333-3333-333333333333', '00000000-0000-0000-0000-000000000001', 'Jana Horáková',    'manager', NULL),
  ('44444444-4444-4444-4444-444444444444', '00000000-0000-0000-0000-000000000001', 'Petr Svoboda',     'member',  '22222222-2222-2222-2222-222222222222'),
  ('55555555-5555-5555-5555-555555555555', '00000000-0000-0000-0000-000000000001', 'Tomáš Novotný',    'member',  '22222222-2222-2222-2222-222222222222'),
  ('66666666-6666-6666-6666-666666666666', '00000000-0000-0000-0000-000000000001', 'Eva Dvořáková',    'member',  '33333333-3333-3333-3333-333333333333')
ON CONFLICT (id) DO NOTHING;

-- ---------- zakázky ----------
INSERT INTO jobs (id, company_id, manager_id, name, description, status, address,
                  geofence_radius_m, location, estimated_hours)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000001',
   '22222222-2222-2222-2222-222222222222',
   'Rekonstrukce kanceláří Praha', 'Kompletní rekonstrukce 3. patra budovy',
   'active', 'Václavské náměstí 1, Praha 1', 200,
   ST_SetSRID(ST_MakePoint(14.4244, 50.0827), 4326)::geography, 480),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000000-0000-0000-0000-000000000001',
   '33333333-3333-3333-3333-333333333333',
   'Instalace klimatizace Brno', 'Klimatizace pro obchodní centrum',
   'active', 'Náměstí Svobody 1, Brno', 150,
   ST_SetSRID(ST_MakePoint(16.6071, 49.1951), 4326)::geography, 120)
ON CONFLICT (id) DO NOTHING;

-- ---------- přiřazení (vč. půjčení napříč rostery) ----------
INSERT INTO job_assignments (job_id, member_id, assigned_by) VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222'),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '66666666-6666-6666-6666-666666666666', '33333333-3333-3333-3333-333333333333'),
  -- půjčení: člen z rosteru A pracuje na zakázce managera B
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '44444444-4444-4444-4444-444444444444', '33333333-3333-3333-3333-333333333333')
ON CONFLICT (job_id, member_id) DO NOTHING;

-- ---------- úkoly ----------
INSERT INTO tasks (job_id, company_id, title, sort_order)
SELECT * FROM (VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::uuid, '00000000-0000-0000-0000-000000000001'::uuid, 'Vyklizení stávajícího nábytku', 1),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000001', 'Elektroinstalace — hrubá montáž', 2),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000001', 'Sádrokartonové příčky', 3),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000001', 'Malba a finální úpravy', 4),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000000-0000-0000-0000-000000000001', 'Příprava rozvodů', 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000000-0000-0000-0000-000000000001', 'Montáž jednotek', 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '00000000-0000-0000-0000-000000000001', 'Testování a předání', 3)
) AS t(job_id, company_id, title, sort_order)
WHERE NOT EXISTS (SELECT 1 FROM tasks);
