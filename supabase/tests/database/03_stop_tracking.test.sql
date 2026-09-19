-- stop_tracking(), get_active_entry(), get_today_seconds(), auto-stop.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(11);

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);
SELECT start_tracking('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 50.0827, 14.4244);

-- ---------- get_active_entry ----------
SELECT is(
  (SELECT count(*)::int FROM get_active_entry()),
  1,
  'get_active_entry vrací běžící záznam'
);
SELECT is(
  (SELECT job_name FROM get_active_entry()),
  'Rekonstrukce kanceláří Praha',
  'get_active_entry vrací název zakázky pro UI'
);
SELECT is(
  (SELECT within_geofence FROM get_active_entry()),
  TRUE,
  'get_active_entry vrací serverem ověřený geofence flag'
);

-- ---------- cizí člen nemůže ukončit můj záznam ----------
SELECT set_config('request.jwt.claim.sub', '55555555-5555-5555-5555-555555555555', TRUE);
SELECT throws_ok(
  format($$ SELECT stop_tracking(%L) $$,
         (SELECT id FROM time_entries WHERE stopped_at IS NULL)),
  'P0001',
  'Time entry not found, already stopped, or not yours',
  'cizí člen nemůže ukončit můj běžící záznam'
);
SELECT is(
  (SELECT count(*)::int FROM get_active_entry()),
  0,
  'jiný člen nevidí cizí běžící záznam jako svůj'
);

-- ---------- vlastní stop ----------
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);
SELECT lives_ok(
  format($$ SELECT stop_tracking(%L) $$,
         (SELECT id FROM time_entries WHERE stopped_at IS NULL)),
  'člen ukončí svůj vlastní záznam'
);
SELECT is(
  (SELECT count(*)::int FROM get_active_entry()),
  0,
  'po stopu už není žádný aktivní záznam'
);

-- ---------- dvojitý stop ----------
SELECT throws_ok(
  format($$ SELECT stop_tracking(%L) $$,
         (SELECT id FROM time_entries ORDER BY started_at DESC LIMIT 1)),
  'P0001',
  'Time entry not found, already stopped, or not yours',
  'už ukončený záznam nelze ukončit znovu'
);

-- ---------- duration_seconds se dopočítá ----------
RESET ROLE;
UPDATE time_entries
   SET started_at = NOW() - INTERVAL '2 hours', stopped_at = NOW()
 WHERE member_id = '44444444-4444-4444-4444-444444444444';
SELECT is(
  (SELECT duration_seconds FROM time_entries WHERE member_id = '44444444-4444-4444-4444-444444444444'),
  7200,
  'duration_seconds odpovídá rozdílu started_at a stopped_at'
);

-- ---------- get_today_seconds ----------
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '44444444-4444-4444-4444-444444444444', TRUE);
SELECT is(
  get_today_seconds(),
  7200,
  'get_today_seconds sečte dnešní ukončené záznamy'
);

-- ---------- auto-stop zapomenutého timeru ----------
RESET ROLE;
INSERT INTO time_entries (company_id, job_id, member_id, started_at, within_geofence)
VALUES ('00000000-0000-0000-0000-000000000001',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '55555555-5555-5555-5555-555555555555',
        NOW() - INTERVAL '20 hours', TRUE);

SELECT is(
  auto_stop_forgotten_entries(),
  1,
  'auto_stop_forgotten_entries ukončí timer běžící přes 12 hodin'
);

SELECT * FROM finish();
ROLLBACK;
