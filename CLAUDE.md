# PMTracker

## Účel
Firemní time tracker (Flutter iOS + Android) nad Supabase. Poloha se ověřuje
geofencem na serveru jen při start/stop a souřadnice se neukládají.

## Build a test
```
supabase start && supabase db reset        # lokální backend (Docker)
cd app && flutter pub get
dart run build_runner build --delete-conflicting-outputs   # *.g.dart nejsou v gitu
flutter analyze --no-fatal-infos && flutter test           # gate, stejně jako CI
./scripts/run.sh                          # flutter run s klíči z .env
./scripts/build-apk.sh                    # release APK pro testery
```

## Mapa
- `app/` — Flutter appka; `lib/core` (router, theme, Supabase klient), `lib/features` (auth, tracking, jobs, roster, reports, admin), `lib/shared`.
- `supabase/` — migrace, `seed.sql`, `config.toml`.
- `scripts/` — spouštění, build APK, `create-test-users.mjs`.
- `docs/` — `DECISIONS.md` (architektonická rozhodnutí), `PLAN.md` (fáze POC → MVP → PM).
- `.github/workflows/` — CI a release workflowy.

## Invarianty
- `time_entries` se zapisují jen přes RPC `start_tracking()` / `stop_tracking()`; přímé INSERT/UPDATE/DELETE blokuje RLS.
- Žádné syrové souřadnice v DB: server spočte `ST_DWithin`, uloží `within_geofence` a souřadnice zahodí.
- Role member / manager / admin vynucuje databáze (RLS), ne appka.
- `SUPABASE_SECRET_KEY` obchází RLS: jen pro `scripts/create-test-users.mjs`, nikdy do appky.

## Kam dál
README, `docs/DECISIONS.md`, `docs/PLAN.md`, `Prompts/`.
