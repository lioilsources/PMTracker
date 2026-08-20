-- ============================================================
-- PMTracker — demo data pro ruční otestování celého flow
-- ============================================================
-- Určeno pro HOSTOVANÉ Supabase (Dashboard → SQL Editor), kde se uživatelé
-- zakládají přes Auth a jejich UUID se předem nezná. Skript si je najde
-- podle e-mailu, takže se nic neopisuje ručně.
--
-- PŘEDPOKLAD: v Dashboard → Authentication → Users jsou založení uživatelé
-- s těmito e-maily (Auto Confirm User zaškrtnuto):
--
--   admin@pmtracker.test
--   manager.a@pmtracker.test
--   manager.b@pmtracker.test
--   member.a1@pmtracker.test
--   member.a2@pmtracker.test
--   member.b1@pmtracker.test
--
-- Skript je idempotentní — dá se pustit opakovaně.
-- Lokálně (supabase db reset) není potřeba, tam totéž dělá seed.sql.
-- ============================================================

DO $$
DECLARE
  v_company_id  UUID;
  v_admin       UUID;
  v_mgr_a       UUID;
  v_mgr_b       UUID;
  v_mem_a1      UUID;
  v_mem_a2      UUID;
  v_mem_b1      UUID;
  v_job_praha   UUID;
  v_job_brno    UUID;
  v_monday      DATE;
  v_day         INTEGER;
  v_missing     TEXT;
BEGIN
  -- ---------- 1. dohledání auth uživatelů ----------
  SELECT string_agg(e, ', ')
    INTO v_missing
    FROM unnest(ARRAY[
      'admin@pmtracker.test', 'manager.a@pmtracker.test', 'manager.b@pmtracker.test',
      'member.a1@pmtracker.test', 'member.a2@pmtracker.test', 'member.b1@pmtracker.test'
    ]) AS e
   WHERE NOT EXISTS (SELECT 1 FROM auth.users u WHERE u.email = e);

  IF v_missing IS NOT NULL THEN
    RAISE EXCEPTION
      'Chybí auth uživatelé: %. Založ je v Dashboard → Authentication → Users (Auto Confirm User) a spusť skript znovu.',
      v_missing;
  END IF;

  SELECT id INTO v_admin  FROM auth.users WHERE email = 'admin@pmtracker.test';
  SELECT id INTO v_mgr_a  FROM auth.users WHERE email = 'manager.a@pmtracker.test';
  SELECT id INTO v_mgr_b  FROM auth.users WHERE email = 'manager.b@pmtracker.test';
  SELECT id INTO v_mem_a1 FROM auth.users WHERE email = 'member.a1@pmtracker.test';
  SELECT id INTO v_mem_a2 FROM auth.users WHERE email = 'member.a2@pmtracker.test';
  SELECT id INTO v_mem_b1 FROM auth.users WHERE email = 'member.b1@pmtracker.test';

  -- ---------- 2. firma ----------
  SELECT id INTO v_company_id FROM companies WHERE name = 'Stavby s.r.o.';
  IF v_company_id IS NULL THEN
    INSERT INTO companies (name) VALUES ('Stavby s.r.o.') RETURNING id INTO v_company_id;
  END IF;

  -- ---------- 3. profily ----------
  -- Bez profilu je uživatel po přihlášení "neviditelný" — nemá company_id.
  INSERT INTO profiles (id, company_id, full_name, role) VALUES
    (v_admin,  v_company_id, 'Adam Novák',       'admin'),
    (v_mgr_a,  v_company_id, 'Martin Procházka', 'manager'),
    (v_mgr_b,  v_company_id, 'Jana Horáková',    'manager'),
    (v_mem_a1, v_company_id, 'Petr Svoboda',     'member'),
    (v_mem_a2, v_company_id, 'Tomáš Novotný',    'member'),
    (v_mem_b1, v_company_id, 'Eva Dvořáková',    'member')
  ON CONFLICT (id) DO UPDATE
    SET company_id = EXCLUDED.company_id,
        full_name  = EXCLUDED.full_name,
        role       = EXCLUDED.role;

  -- ---------- 4. roster (1:1, profiles.manager_id) ----------
  UPDATE profiles SET manager_id = v_mgr_a WHERE id IN (v_mem_a1, v_mem_a2);
  UPDATE profiles SET manager_id = v_mgr_b WHERE id = v_mem_b1;

  -- ---------- 5. zakázky s reálným geofencem ----------
  SELECT id INTO v_job_praha FROM jobs
   WHERE company_id = v_company_id AND name = 'Rekonstrukce kanceláří Praha';
  IF v_job_praha IS NULL THEN
    INSERT INTO jobs (company_id, manager_id, name, description, status, address,
                      geofence_radius_m, location, estimated_hours)
    VALUES (v_company_id, v_mgr_a,
            'Rekonstrukce kanceláří Praha', 'Kompletní rekonstrukce 3. patra budovy',
            'active', 'Václavské náměstí 1, Praha 1', 200,
            ST_SetSRID(ST_MakePoint(14.4244, 50.0827), 4326)::geography, 480)
    RETURNING id INTO v_job_praha;
  END IF;

  SELECT id INTO v_job_brno FROM jobs
   WHERE company_id = v_company_id AND name = 'Instalace klimatizace Brno';
  IF v_job_brno IS NULL THEN
    INSERT INTO jobs (company_id, manager_id, name, description, status, address,
                      geofence_radius_m, location, estimated_hours)
    VALUES (v_company_id, v_mgr_b,
            'Instalace klimatizace Brno', 'Klimatizace pro obchodní centrum',
            'active', 'Náměstí Svobody 1, Brno', 150,
            ST_SetSRID(ST_MakePoint(16.6071, 49.1951), 4326)::geography, 120)
    RETURNING id INTO v_job_brno;
  END IF;

  -- ---------- 6. přiřazení vč. půjčení napříč rostery ----------
  INSERT INTO job_assignments (job_id, member_id, assigned_by) VALUES
    (v_job_praha, v_mem_a1, v_mgr_a),
    (v_job_praha, v_mem_a2, v_mgr_a),
    (v_job_brno,  v_mem_b1, v_mgr_b),
    (v_job_brno,  v_mem_a1, v_mgr_b)   -- půjčení: člen rosteru A na zakázce B
  ON CONFLICT (job_id, member_id) DO NOTHING;

  -- ---------- 7. týdenní úkoly (checklist na zakázce) ----------
  -- Pozor: čas se v MVP trackuje na ZAKÁZKU, ne na úkol. Úkoly jsou jen
  -- checklist — plánovací/týdenní vrstva je až Fáze 3 (PLAN.md §10).
  v_monday := date_trunc('week', CURRENT_DATE)::date;

  DELETE FROM tasks WHERE job_id IN (v_job_praha, v_job_brno)
    AND title LIKE 'Týden %';

  FOR v_day IN 0..4 LOOP
    INSERT INTO tasks (job_id, company_id, title, sort_order, is_completed,
                       completed_by, completed_at)
    VALUES (
      v_job_praha, v_company_id,
      'Týden ' || to_char(v_monday, 'DD.MM.') || ' — ' ||
        (ARRAY['Po: vyklizení patra',
               'Út: elektroinstalace — hrubá montáž',
               'St: sádrokartonové příčky',
               'Čt: rozvody vody',
               'Pá: malba a úklid'])[v_day + 1],
      v_day + 1,
      v_day < 2,                                        -- pondělí a úterý hotové
      CASE WHEN v_day < 2 THEN v_mem_a1 END,
      CASE WHEN v_day < 2 THEN (v_monday + v_day)::timestamptz + INTERVAL '16 hours' END
    );

    INSERT INTO tasks (job_id, company_id, title, sort_order, is_completed)
    VALUES (
      v_job_brno, v_company_id,
      'Týden ' || to_char(v_monday, 'DD.MM.') || ' — ' ||
        (ARRAY['Po: příprava rozvodů',
               'Út: montáž vnitřních jednotek',
               'St: montáž venkovní jednotky',
               'Čt: tlaková zkouška',
               'Pá: testování a předání'])[v_day + 1],
      v_day + 1,
      FALSE
    );
  END LOOP;

  -- ---------- 8. odpracovaný týden, ať mají reporty co ukazovat ----------
  DELETE FROM time_entries
   WHERE company_id = v_company_id
     AND notes = 'demo';

  FOR v_day IN 0..4 LOOP
    -- Petr Svoboda: Po–St Praha, Čt–Pá půjčený do Brna
    INSERT INTO time_entries (company_id, job_id, member_id, started_at, stopped_at,
                              within_geofence, notes)
    VALUES (
      v_company_id,
      CASE WHEN v_day < 3 THEN v_job_praha ELSE v_job_brno END,
      v_mem_a1,
      (v_monday + v_day)::timestamptz + INTERVAL '7 hours',
      (v_monday + v_day)::timestamptz + INTERVAL '15 hours 30 minutes',
      TRUE, 'demo'
    );

    -- Tomáš Novotný: celý týden Praha, ve středu start mimo geofence
    INSERT INTO time_entries (company_id, job_id, member_id, started_at, stopped_at,
                              within_geofence, override_reason, notes)
    VALUES (
      v_company_id, v_job_praha, v_mem_a2,
      (v_monday + v_day)::timestamptz + INTERVAL '8 hours',
      (v_monday + v_day)::timestamptz + INTERVAL '16 hours',
      v_day <> 2,
      CASE WHEN v_day = 2 THEN 'Vyzvedával jsem materiál ve skladu' END,
      'demo'
    );

    -- Eva Dvořáková: celý týden Brno
    INSERT INTO time_entries (company_id, job_id, member_id, started_at, stopped_at,
                              within_geofence, notes)
    VALUES (
      v_company_id, v_job_brno, v_mem_b1,
      (v_monday + v_day)::timestamptz + INTERVAL '6 hours 30 minutes',
      (v_monday + v_day)::timestamptz + INTERVAL '15 hours',
      TRUE, 'demo'
    );
  END LOOP;

  RAISE NOTICE 'Demo data připravena. Firma % — 2 zakázky, 3 členové, týden výkazů.', v_company_id;
END $$;

-- Kontrolní výpis
SELECT p.full_name,
       p.role,
       COALESCE(m.full_name, '—') AS roster_manager,
       (SELECT COUNT(*) FROM job_assignments ja WHERE ja.member_id = p.id) AS zakazek,
       (SELECT COALESCE(SUM(te.duration_seconds), 0) / 3600.0
          FROM time_entries te
         WHERE te.member_id = p.id AND te.notes = 'demo')::numeric(6, 1)
         AS hodin_tento_tyden
  FROM profiles p
  LEFT JOIN profiles m ON m.id = p.manager_id
 ORDER BY p.role, p.full_name;
