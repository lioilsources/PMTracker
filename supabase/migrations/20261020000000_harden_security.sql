-- ============================================================
-- PMTracker — Bezpečnostní nálezy ze Supabase Advisors
-- 20261020000000_harden_security.sql
-- ============================================================
-- 1) rls_disabled_in_public (CRITICAL): PostGIS v public vystavuje přes REST
--    tabulku spatial_ref_sys a anon do ní může i mazat (smazání SRID 4326
--    rozbije geofence). Tabulka patří supabase_admin, takže RLS ani REVOKE
--    nejdou — PostGIS se přesouvá do schématu extensions. Není relocatable,
--    proto DROP + CREATE; jediný sloupec jobs.location se zálohuje a obnoví.
-- 2) function_search_path_mutable: pevný search_path u všech funkcí.
-- 3) anon_security_definer_function_executable: RPC nejsou pro nepřihlášené.
--    Helpery volané z RLS policies (get_my_company_id, is_admin, …) zůstávají
--    spustitelné pro anon — jinak by anon dotaz na tabulku padal na 42501
--    místo prázdného výsledku (a s ním keep-alive). Pro anon vrací NULL/false.

CREATE SCHEMA IF NOT EXISTS extensions;
-- 1) PostGIS → extensions
CREATE TEMP TABLE _job_locations ON COMMIT DROP AS
  SELECT id, ST_X(location::geometry) AS lon, ST_Y(location::geometry) AS lat
  FROM jobs WHERE location IS NOT NULL;
DROP EXTENSION postgis CASCADE;
-- odstraní i sloupec jobs.location
CREATE EXTENSION postgis WITH SCHEMA extensions;
ALTER TABLE jobs ADD COLUMN location extensions.GEOGRAPHY(POINT, 4326);
UPDATE jobs j
SET location = extensions.ST_SetSRID(extensions.ST_MakePoint(l.lon, l.lat), 4326)::extensions.geography
FROM _job_locations l WHERE l.id = j.id;
-- 2) search_path
ALTER FUNCTION get_my_company_id()                                   SET search_path = public, extensions;
ALTER FUNCTION get_my_role()                                         SET search_path = public, extensions;
ALTER FUNCTION is_admin()                                            SET search_path = public, extensions;
ALTER FUNCTION is_manager_or_admin()                                 SET search_path = public, extensions;
ALTER FUNCTION owns_job(UUID)                                        SET search_path = public, extensions;
ALTER FUNCTION in_my_roster(UUID)                                    SET search_path = public, extensions;
ALTER FUNCTION is_assigned_to_job(UUID)                              SET search_path = public, extensions;
ALTER FUNCTION get_job_company_id(UUID)                              SET search_path = public, extensions;
ALTER FUNCTION start_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION, TEXT) SET search_path = public, extensions;
ALTER FUNCTION stop_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION)        SET search_path = public, extensions;
ALTER FUNCTION get_active_entry()                                    SET search_path = public, extensions;
ALTER FUNCTION get_today_seconds()                                   SET search_path = public, extensions;
ALTER FUNCTION get_member_utilization(DATE, DATE)                    SET search_path = public, extensions;
ALTER FUNCTION auto_stop_forgotten_entries()                         SET search_path = public, extensions;
ALTER FUNCTION update_updated_at()                                   SET search_path = public, extensions;
-- 3) RPC jen pro přihlášené
REVOKE EXECUTE ON FUNCTION start_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION, TEXT) FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION stop_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION)        FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION get_active_entry()                 FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION get_today_seconds()                FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION get_member_utilization(DATE, DATE) FROM PUBLIC, anon;
GRANT  EXECUTE ON FUNCTION start_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION, TEXT) TO authenticated;
GRANT  EXECUTE ON FUNCTION stop_tracking(UUID, DOUBLE PRECISION, DOUBLE PRECISION)        TO authenticated;
GRANT  EXECUTE ON FUNCTION get_active_entry()                 TO authenticated;
GRANT  EXECUTE ON FUNCTION get_today_seconds()                TO authenticated;
GRANT  EXECUTE ON FUNCTION get_member_utilization(DATE, DATE) TO authenticated;
-- auto_stop zastaví záznamy všem firmám — volá ho jen pg_cron (postgres)
REVOKE EXECUTE ON FUNCTION auto_stop_forgotten_entries() FROM PUBLIC, anon, authenticated;
