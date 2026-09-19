-- RLS: kdo co vidí a co nesmí zapsat.
-- Model: člen vidí jen sebe, manager vidí svůj roster + záznamy na svých
-- zakázkách, admin vidí vše. Zápis do time_entries jen přes RPC.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(17);

-- ---------- příprava dat (jako superuser, RLS se neuplatní) ----------
-- A1 (roster A) odpracoval na zakázce Prahy (A) i Brna (B)
-- A2 (roster A) odpracoval jen na Praze (A)
-- B1 (roster B) odpracoval jen na Brně (B)
INSERT INTO time_entries (company_id, job_id, member_id, started_at, stopped_at, within_geofence) VALUES
  ('00000000-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
   '44444444-4444-4444-4444-444444444444', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '3 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   '44444444-4444-4444-4444-444444444444', NOW() - INTERVAL '2 hours', NOW() - INTERVAL '1 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
   '55555555-5555-5555-5555-555555555555', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '4 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   '66666666-6666-6666-6666-666666666666', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '4 hours', TRUE);

-- ============================================================
-- Člen
-- ============================================================
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);

SELECT is(
  (SELECT count(*)::int FROM time_entries),
  2,
  'člen vidí pouze své vlastní výkazy'
);

SELECT throws_ok(
  $$ INSERT INTO time_entries (company_id, job_id, member_id, within_geofence)
     VALUES ('00000000-0000-0000-0000-000000000001',
             'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
             '44444444-4444-4444-4444-444444444444', TRUE) $$,
  '42501',
  NULL,
  'přímý INSERT do time_entries je odmítnut (jen přes RPC)'
);

UPDATE time_entries SET within_geofence = TRUE, override_reason = NULL
 WHERE member_id = '44444444-4444-4444-4444-444444444444';
SELECT is(
  (SELECT count(*)::int FROM time_entries WHERE member_id = '44444444-4444-4444-4444-444444444444'),
  2,
  'přímý UPDATE time_entries neprojde žádným řádkem'
);

DELETE FROM time_entries WHERE member_id = '44444444-4444-4444-4444-444444444444';
SELECT is(
  (SELECT count(*)::int FROM time_entries),
  2,
  'přímý DELETE time_entries neprojde žádným řádkem'
);

SELECT is(
  (SELECT count(*)::int FROM audit_log),
  0,
  'člen nevidí audit_log'
);

SELECT throws_ok(
  $$ INSERT INTO jobs (company_id, manager_id, name)
     VALUES ('00000000-0000-0000-0000-000000000001',
             '44444444-4444-4444-4444-444444444444', 'Podvržená zakázka') $$,
  '42501',
  NULL,
  'člen nemůže zakládat zakázky'
);

-- člen vidí jen zakázky, na které je přiřazen
SELECT set_config('request.jwt.claim.sub', '55555555-5555-5555-5555-555555555555', TRUE);
SELECT is(
  (SELECT count(*)::int FROM jobs),
  1,
  'člen vidí jen zakázky, na které je přiřazen'
);

-- ============================================================
-- Manager A — roster (A1, A2) + vlastní zakázka Praha
-- ============================================================
SELECT set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', TRUE);

SELECT is(
  (SELECT count(*)::int FROM time_entries),
  3,
  'manager A vidí všechny výkazy svého rosteru (i na cizí zakázce)'
);

SELECT ok(
  EXISTS (SELECT 1 FROM time_entries
           WHERE member_id = '44444444-4444-4444-4444-444444444444'
             AND job_id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'),
  'manager A vidí vytížení svého člena i na půjčené zakázce managera B'
);

SELECT is(
  (SELECT count(*)::int FROM time_entries
    WHERE member_id = '66666666-6666-6666-6666-666666666666'),
  0,
  'manager A nevidí výkazy cizího rosteru mimo své zakázky'
);

SELECT is(
  (SELECT count(*)::int FROM audit_log),
  0,
  'manager nevidí audit_log (jen admin)'
);

SELECT throws_ok(
  $$ INSERT INTO job_assignments (job_id, member_id, assigned_by)
     VALUES ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
             '55555555-5555-5555-5555-555555555555',
             '22222222-2222-2222-2222-222222222222') $$,
  '42501',
  NULL,
  'manager nemůže přiřazovat lidi na cizí zakázku'
);

-- ============================================================
-- Manager B — roster (B1) + vlastní zakázka Brno
-- ============================================================
SELECT set_config('request.jwt.claim.sub', '33333333-3333-3333-3333-333333333333', TRUE);

SELECT is(
  (SELECT count(*)::int FROM time_entries),
  2,
  'manager B vidí jen výkazy na své zakázce a ve svém rosteru'
);

SELECT is(
  (SELECT count(*)::int FROM time_entries
    WHERE member_id = '44444444-4444-4444-4444-444444444444'),
  1,
  'manager B vidí půjčeného člena jen na své zakázce, ne jeho plné vytížení'
);

-- ============================================================
-- Admin
-- ============================================================
SELECT set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', TRUE);

SELECT is(
  (SELECT count(*)::int FROM time_entries),
  4,
  'admin vidí všechny výkazy ve firmě'
);

SELECT lives_ok(
  $$ SELECT count(*) FROM audit_log $$,
  'admin má přístup k audit_logu'
);

SELECT is(
  (SELECT count(*)::int FROM profiles),
  6,
  'admin vidí všechny profily ve firmě'
);

SELECT * FROM finish();
ROLLBACK;
