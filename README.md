# PMTracker

Firemní time tracker s GPS geofencingem a offline podporou.

## Stack

- **Frontend**: Flutter (iOS + Android)
- **Backend**: Supabase (PostgreSQL + PostGIS + RLS + RPC)
- **State**: Riverpod + code generation
- **Navigation**: GoRouter
- **Location**: Geolocator
- **Offline**: PowerSync (připraven, aktivace Fáze 2)

## Struktura

```
PMTracker/
├── supabase/
│   ├── migrations/          # SQL migrace
│   └── seed.sql             # Testovací data
├── app/                     # Flutter aplikace
│   └── lib/
│       ├── core/            # Router, theme, Supabase client
│       ├── features/        # auth, tracking, jobs, roster, reports, admin
│       └── shared/          # Shell, widgets
└── docs/
    └── DECISIONS.md         # Architektonická rozhodnutí
```

## Spuštění (lokální dev)

```bash
# 1. Start Supabase
supabase start
supabase db reset

# 2. Získej anon key
supabase status

# 3. Spusť Flutter app
cd app
dart run build_runner build --delete-conflicting-outputs
flutter run \
  --dart-define=SUPABASE_URL=http://localhost:54321 \
  --dart-define=SUPABASE_ANON_KEY=<anon-key>
```

Po `supabase db reset` je databáze rovnou naplněná testovacími účty
(`admin@pmtracker.test` / `Admin123!`, `manager.a@…` / `Manager123!`,
`member.a1@…` / `Member123!`, …) — viz `supabase/seed.sql`.

## Testy

```bash
# databáze (pgTAP)
supabase start && ./scripts/db-test.sh

# aplikace
cd app && dart run build_runner build --delete-conflicting-outputs
flutter analyze && flutter test
```

Podrobnosti, fixtures a pravidla pro psaní testů: [docs/TESTING.md](docs/TESTING.md).

Pro ruční projití celé smyčky na hostovaném Supabase: založ v Dashboardu
uživatele `admin@`, `manager.a@`, `manager.b@`, `member.a1@`, `member.a2@`,
`member.b1@pmtracker.test` (Auto Confirm User) a v SQL Editoru spusť
[`supabase/demo/demo_data.sql`](supabase/demo/demo_data.sql) — dohledá je
podle e-mailu a založí firmu, roster, zakázky, týdenní úkoly i týden
výkazů. Postup krok za krokem je v [docs/TESTING.md](docs/TESTING.md#4-ruční-otestování-celého-flow).

## Známé mezery

- **Onboarding uživatele chybí.** Nic nezakládá řádek v `profiles`, když
  vznikne `auth.users` — přihlášený uživatel bez profilu nemá `company_id`,
  takže nevidí nic a `start_tracking` skončí chybou `Profile not found`.
  Chybí trigger na `auth.users` + invite flow (PLAN.md §8, bod 12).
  Lokálně to obchází `seed.sql`.
- **Offline vrstva neexistuje.** PowerSync je v závislostech, ale connector
  není zapojený — capture-then-verify z PLAN.md §6 zatím nikdo neověřil.
- **`stop_tracking` souřadnice ignoruje.** Klient je posílá (a kvůli tomu si
  říká o polohu), server je zahodí. Buď se má geofence ověřovat i při
  ukončení, nebo je klient nemá posílat.
- **CSV import týmu a export reportů** z PLAN.md §8 nejsou implementované.
- **`auto_stop_forgotten_entries()` nikdo nevolá** — funkce existuje, ale
  `pg_cron` job není nikde naplánovaný.
- **Feature bez repository vrstvy** (jobs, roster, reports, admin) sahají na
  `Supabase.instance` napřímo, takže je nejde testovat bez sítě.

## Role

| Role    | Může                                              |
|---------|--------------------------------------------------|
| member  | Trackovat čas na přiřazených zakázkách            |
| manager | + Spravovat zakázky, roster, vidět reporty        |
| admin   | + Spravovat uživatele, přístup ke všemu           |

## Geofencing

Souřadnice uživatele se odesílají pouze při start/stop trackingu.
Server (PostgreSQL/PostGIS) ověří `ST_DWithin` a souřadnice zahodí.
Výsledek (`within_geofence BOOLEAN`) se uloží do `time_entries`.
Při override mimo geofence se zapíše audit log.
