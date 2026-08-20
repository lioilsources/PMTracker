-- Strukturální kontrakt schématu: tabulky, RLS, RPC.
-- Chrání před tichým rozpadem bezpečnostního modelu při budoucích migracích.
BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(26);

-- ---------- tabulky ----------
SELECT has_table('public', 'companies',       'tabulka companies existuje');
SELECT has_table('public', 'profiles',        'tabulka profiles existuje');
SELECT has_table('public', 'projects',        'tabulka projects existuje');
SELECT has_table('public', 'jobs',            'tabulka jobs existuje');
SELECT has_table('public', 'job_assignments', 'tabulka job_assignments existuje');
SELECT has_table('public', 'tasks',           'tabulka tasks existuje');
SELECT has_table('public', 'time_entries',    'tabulka time_entries existuje');
SELECT has_table('public', 'audit_log',       'tabulka audit_log existuje');

-- ---------- RLS je zapnuté všude ----------
SELECT is_empty(
  $$ SELECT c.relname FROM pg_class c
     JOIN pg_namespace n ON n.oid = c.relnamespace
     WHERE n.nspname = 'public' AND c.relkind = 'r'
       AND c.relname IN ('companies','profiles','projects','jobs','job_assignments',
                         'tasks','time_entries','audit_log')
       AND NOT c.relrowsecurity $$,
  'RLS je zapnuté na všech doménových tabulkách'
);

-- ---------- GDPR: žádné souřadnice v time_entries ----------
SELECT is_empty(
  $$ SELECT column_name FROM information_schema.columns
     WHERE table_schema = 'public' AND table_name = 'time_entries'
       AND column_name ~* '(lat|lon|coord|geom|geog|position)' $$,
  'time_entries neobsahuje žádný sloupec se syrovými souřadnicemi'
);

-- ---------- time_entries: within_geofence smí psát jen server ----------
SELECT col_is_null('public', 'time_entries', 'within_geofence',
  'within_geofence je nullable (dokud server nerozhodne)');
SELECT has_column('public', 'time_entries', 'duration_seconds',
  'duration_seconds existuje');
SELECT is(
  (SELECT is_generated FROM information_schema.columns
    WHERE table_schema='public' AND table_name='time_entries' AND column_name='duration_seconds'),
  'ALWAYS',
  'duration_seconds je generovaný sloupec — klient ho nemůže ovlivnit'
);

-- ---------- RPC funkce existují a jsou SECURITY DEFINER ----------
SELECT has_function('public', 'start_tracking',  'start_tracking existuje');
SELECT has_function('public', 'stop_tracking',   'stop_tracking existuje');
SELECT has_function('public', 'get_active_entry', 'get_active_entry existuje');
SELECT has_function('public', 'get_today_seconds', 'get_today_seconds existuje');
SELECT has_function('public', 'get_member_utilization', 'get_member_utilization existuje');
SELECT has_function('public', 'auto_stop_forgotten_entries', 'auto_stop_forgotten_entries existuje');

SELECT is_empty(
  $$ SELECT p.proname FROM pg_proc p
     JOIN pg_namespace n ON n.oid = p.pronamespace
     WHERE n.nspname = 'public'
       AND p.proname IN ('start_tracking','stop_tracking','get_active_entry',
                         'get_today_seconds','get_member_utilization',
                         'auto_stop_forgotten_entries','get_my_company_id','get_my_role',
                         'is_admin','is_manager_or_admin','owns_job','in_my_roster')
       AND NOT p.prosecdef $$,
  'všechny RPC a helper funkce jsou SECURITY DEFINER'
);

-- ---------- politiky, které nesou bezpečnostní model ----------
SELECT ok(
  EXISTS (SELECT 1 FROM pg_policies WHERE tablename='time_entries'
            AND policyname='time_entries_no_direct_insert' AND cmd='INSERT'),
  'existuje politika blokující přímý INSERT do time_entries'
);
SELECT ok(
  EXISTS (SELECT 1 FROM pg_policies WHERE tablename='time_entries'
            AND policyname='time_entries_no_direct_update' AND cmd='UPDATE'),
  'existuje politika blokující přímý UPDATE time_entries'
);
SELECT ok(
  EXISTS (SELECT 1 FROM pg_policies WHERE tablename='audit_log'
            AND policyname='audit_log_no_write' AND cmd='INSERT'),
  'existuje politika blokující přímý zápis do audit_log'
);

-- ---------- PostGIS ----------
SELECT ok(
  EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'postgis'),
  'PostGIS je nainstalované (geofence)'
);

-- ---------- seed ----------
SELECT is((SELECT count(*)::int FROM profiles), 6, 'seed vytvořil 6 profilů');
SELECT is((SELECT count(*)::int FROM jobs), 2, 'seed vytvořil 2 zakázky');

SELECT * FROM finish();
ROLLBACK;
