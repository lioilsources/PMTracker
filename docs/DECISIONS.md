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

## Lokální development setup

### Předpoklady
- Supabase CLI nainstalován
- Flutter 3.x+
- Docker Desktop (pro lokální Supabase)

### Kroky
1. `cd /Volumes/YOTTA/Dev/PMTracker && supabase start`
2. `supabase db reset` (aplikuje migrace + seed)
3. Otevřít Supabase Studio: http://localhost:54323
4. Vytvořit testovací uživatele v Authentication > Users
5. Zjistit jejich UUID: `SELECT id, email FROM auth.users;`
6. Vyplnit UUID v supabase/seed.sql a spustit seed
7. `cd app && flutter run --dart-define=SUPABASE_URL=http://localhost:54321 --dart-define=SUPABASE_ANON_KEY=<anon-key>`

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
