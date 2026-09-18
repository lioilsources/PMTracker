# Architecture Decisions

## Rozhodnutí učiněná v MVP bez klienta

### D1: projects tabulka přidána (cheap insurance)
UI ji v MVP skrývá, ale FK projects.id → jobs.project_id existuje pro PM fázi.

### D2: company_id všude (multi-tenant ready)
get_my_company_id() helper zajišťuje izolaci. SaaS switch = přidání billing vrstvy.

### D3: Geofence ověření jen při start/stop
GDPR model: žádné syrové souřadnice v DB. Server vypočítá ST_DWithin a zahodí coords.

### D4: PowerSync připraven ale nevyžaduje účet pro lokální dev
V MVP se používá přímý Supabase klient. PowerSync connector je připraven v core/sync/.

### D5: Riverpod + code generation
Všechny providers jsou anotovány (@riverpod) a generují se přes build_runner.
Soubory *.g.dart jsou v .gitignore, generovat přes:
```bash
cd app && dart run build_runner build --delete-conflicting-outputs
```

### D6: time_entries jsou write-only přes RPC
INSERT/UPDATE/DELETE jsou explicitně zakázány RLS polítikami (WITH CHECK (FALSE)).
Vše jde přes start_tracking() / stop_tracking() SECURITY DEFINER funkce.

### D7: Demo je online-only, PowerSync odloženo (2026-07)
Pro demo MVP se offline sync (PowerSync) neaktivuje — appka čte/píše přímo
přes Supabase klienta. Capture-then-verify offline architektura (PLAN §6)
zůstává dalším krokem po demu; závislost `powersync` v pubspec zůstává.

### D8: Bezpečnostní opravy v migraci 20260703000000_demo_fixes (2026-07)
- Trigger `protect_profile_columns`: člen si nesmí změnit `role`,
  `company_id` ani `manager_id` (eskalace práv přes profiles_update_own).
- Všechny SECURITY DEFINER funkce mají `SET search_path = public, extensions`.
- `jobs_manager_update` doplněn `WITH CHECK` (nelze předat zakázku/firmu).
- `companies` a `projects` dostaly SELECT politiky (dřív default-deny).
- Rozbit RLS cyklus jobs ↔ job_assignments (infinite recursion při každém
  SELECTu přihlášeného uživatele) — podmínky přes SECURITY DEFINER helpery
  `is_assigned_to_job()` a `job_company_id()`.

### D9: Poloha zakázky přes WKT + generované sloupce (2026-07)
Klient zapisuje `jobs.location` jako WKT string `SRID=4326;POINT(lon lat)`
(PostgREST ho převede na geography). Pro čtení slouží generované sloupce
`jobs.lat` / `jobs.lng` (ST_Y/ST_X). Profily nových uživatelů zakládá
trigger `handle_new_user` z user metadata; auto-stop zapomenutých časovačů
plánuje pg_cron každých 30 minut.

## Lokální development setup

### Předpoklady
- Supabase CLI nainstalován
- Flutter 3.x+
- Docker Desktop (pro lokální Supabase)

### Kroky
1. `supabase start`
2. `supabase db reset` (aplikuje migrace + seed — vytvoří i testovací účty, viz docs/DEMO.md)
3. `cd app && dart run build_runner build --delete-conflicting-outputs`
4. `flutter run --dart-define=SUPABASE_URL=http://localhost:54321 --dart-define=SUPABASE_ANON_KEY=<anon-key>`

### Anon key lokálně
Po `supabase start` zkopírovat anon key z výstupu nebo:
```bash
supabase status
```

## Otevřené otázky (od klienta)
- [ ] Hierarchie zakázka vs. projekt (momentálně: jobs.project_id nullable)
- [ ] Jedna firma nebo SaaS (momentálně: company_id jako pojistka)
- [ ] GDPR právní základ a DPA
- [ ] Schvalovací workflow (Fáze 2)
- [ ] Push notifikace pro geofence override (Fáze 2)
- [ ] Export reportů do Excel/PDF (Fáze 2)
