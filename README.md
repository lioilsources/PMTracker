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
