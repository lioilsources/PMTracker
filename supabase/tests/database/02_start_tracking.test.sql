-- start_tracking(): geofence, override, autorizace.
-- Nejrizikovější část systému — server je jediná autorita nad within_geofence.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(15);

-- Zakázka Praha: 14.4244 / 50.0827, poloměr 200 m
-- Zakázka Brno:  16.6071 / 49.1951, poloměr 150 m
-- member.a1 (4444…) je na obou, member.b1 (6666…) jen na Brnu.

-- ============================================================
-- 1) Start uvnitř geofence
-- ============================================================
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);

SELECT lives_ok(
  $$ SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.0827, 14.4244) $$,
  'member přiřazený na zakázku může spustit tracking na místě'
);

SELECT is(
  (SELECT within_geofence FROM time_entries WHERE stopped_at IS NULL),
  TRUE,
  'server označil záznam jako within_geofence = true'
);

SELECT is(
  (SELECT override_reason FROM time_entries WHERE stopped_at IS NULL),
  NULL,
  'bez override není uložen žádný důvod'
);

RESET ROLE;
SELECT is(
  (SELECT count(*)::int FROM audit_log WHERE action = 'geofence_override'),
  0,
  'start na místě nezapisuje do audit_logu'
);

-- ============================================================
-- 2) Dvojitý start je odmítnut
-- ============================================================
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);

SELECT throws_ok(
  $$ SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.0827, 14.4244) $$,
  'P0001',
  'Already tracking time — stop current entry first',
  'druhý souběžný start je odmítnut'
);

-- uklidíme běžící záznam, ať další scénáře začínají čistě
SELECT stop_tracking(id) FROM time_entries WHERE member_id = '44444444-4444-4444-4444-444444444444' AND stopped_at IS NULL;

-- ============================================================
-- 3) Start mimo geofence bez důvodu je odmítnut
-- ============================================================
SELECT throws_ok(
  $$ SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 49.1951, 16.6071) $$,
  'P0001',
  'Outside geofence: provide override_reason',
  'start mimo geofence bez důvodu je odmítnut'
);

SELECT is(
  (SELECT count(*)::int FROM time_entries WHERE member_id = '44444444-4444-4444-4444-444444444444' AND stopped_at IS NULL),
  0,
  'odmítnutý start nezaložil žádný záznam'
);

-- ============================================================
-- 4) Start mimo geofence s důvodem projde a zaloguje se
-- ============================================================
SELECT lives_ok(
  $$ SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 49.1951, 16.6071, 'Materiál vyzvedávám na jiné adrese') $$,
  'start mimo geofence s důvodem projde'
);

SELECT is(
  (SELECT within_geofence FROM time_entries WHERE stopped_at IS NULL),
  FALSE,
  'server označil záznam jako within_geofence = false'
);

RESET ROLE;
SELECT is(
  (SELECT count(*)::int FROM audit_log WHERE action = 'geofence_override'),
  1,
  'override je zapsán do audit_logu'
);

SELECT is(
  (SELECT details ->> 'override_reason' FROM audit_log WHERE action = 'geofence_override'),
  'Materiál vyzvedávám na jiné adrese',
  'audit log obsahuje důvod override'
);

-- ============================================================
-- 5) Hranice geofence — 200 m poloměr zakázky Praha
-- ============================================================
-- ~150 m severně od středu (0.00135° zeměpisné šířky) → uvnitř
-- ~330 m severně (0.003°) → mimo
SELECT ok(
  ST_DWithin(
    (SELECT location FROM jobs WHERE id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
    ST_SetSRID(ST_MakePoint(14.4244, 50.0827 + 0.00135), 4326)::geography,
    200),
  'bod ~150 m od zakázky je uvnitř geofence'
);
SELECT ok(
  NOT ST_DWithin(
    (SELECT location FROM jobs WHERE id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
    ST_SetSRID(ST_MakePoint(14.4244, 50.0827 + 0.003), 4326)::geography,
    200),
  'bod ~330 m od zakázky je mimo geofence'
);

-- ============================================================
-- 6) Nepřiřazený člen nesmí startovat
-- ============================================================
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '66666666-6666-6666-6666-666666666666', TRUE);

SELECT throws_ok(
  $$ SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.0827, 14.4244) $$,
  'P0001',
  'Not assigned to this active job',
  'člen nepřiřazený na zakázku nemůže startovat'
);

-- ============================================================
-- 7) Neaktivní zakázka nejde trackovat
-- ============================================================
RESET ROLE;
UPDATE jobs SET status = 'paused' WHERE id = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '66666666-6666-6666-6666-666666666666', TRUE);

SELECT throws_ok(
  $$ SELECT start_tracking('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 49.1951, 16.6071) $$,
  'P0001',
  'Not assigned to this active job',
  'pozastavenou zakázku nelze trackovat'
);

SELECT * FROM finish();
ROLLBACK;
