-- get_member_utilization(): report vytížení a jeho viditelnost podle role.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(8);

-- A1 (roster A): 2 h na Praze (A) + 1 h na Brně (B)
-- A2 (roster A): 1 h na Praze (A)
-- B1 (roster B): 1 h na Brně (B)
INSERT INTO time_entries (company_id, job_id, member_id, started_at, stopped_at, within_geofence) VALUES
  ('00000000-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
   '44444444-4444-4444-4444-444444444444', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '3 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   '44444444-4444-4444-4444-444444444444', NOW() - INTERVAL '2 hours', NOW() - INTERVAL '1 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
   '55555555-5555-5555-5555-555555555555', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '4 hours', TRUE),
  ('00000000-0000-0000-0000-000000000001', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
   '66666666-6666-6666-6666-666666666666', NOW() - INTERVAL '5 hours', NOW() - INTERVAL '4 hours', TRUE);

-- ---------- Manager A ----------
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', TRUE);

SELECT is(
  (SELECT count(*)::int FROM get_member_utilization()),
  3,
  'manager A vidí v reportu 3 řádky (svůj roster napříč zakázkami)'
);

SELECT is(
  (SELECT total_seconds FROM get_member_utilization()
    WHERE member_id = '44444444-4444-4444-4444-444444444444'
      AND job_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  7200::bigint,
  'součet hodin sedí s ručním součtem (2 h)'
);

SELECT is(
  (SELECT count(*)::int FROM get_member_utilization()
    WHERE member_id = '66666666-6666-6666-6666-666666666666'),
  0,
  'manager A nevidí v reportu cizí roster mimo své zakázky'
);

-- ---------- Manager B ----------
SELECT set_config('request.jwt.claim.sub', '33333333-3333-3333-3333-333333333333', TRUE);

SELECT is(
  (SELECT count(*)::int FROM get_member_utilization()),
  2,
  'manager B vidí svého člena + půjčeného člena na své zakázce'
);

SELECT is(
  (SELECT count(*)::int FROM get_member_utilization()
    WHERE member_id = '44444444-4444-4444-4444-444444444444'
      AND job_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  0,
  'manager B nevidí práci půjčeného člena na cizí zakázce'
);

-- ---------- filtr období ----------
SELECT is(
  (SELECT count(*)::int FROM get_member_utilization(
     (CURRENT_DATE - INTERVAL '10 days')::date,
     (CURRENT_DATE - INTERVAL '5 days')::date)),
  0,
  'filtr období vyřadí záznamy mimo rozsah'
);

-- ---------- běžící záznam se do reportu nepočítá ----------
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);
SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.0827, 14.4244);
SELECT set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', TRUE);
SELECT is(
  (SELECT entry_count FROM get_member_utilization()
    WHERE member_id = '44444444-4444-4444-4444-444444444444'
      AND job_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'),
  1::bigint,
  'dosud neukončený záznam se do reportu nezapočítá'
);

-- ---------- člen report nevidí ----------
SELECT set_config('request.jwt.claim.sub', '55555555-5555-5555-5555-555555555555', TRUE);
SELECT is(
  (SELECT count(*)::int FROM get_member_utilization()),
  0,
  'člen bez rosteru a bez vlastních zakázek nedostane z reportu nic'
);

SELECT * FROM finish();
ROLLBACK;
