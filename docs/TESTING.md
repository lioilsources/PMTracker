# Testování PMTracker

Dvě nezávislé vrstvy, každá se spouští zvlášť:

| Vrstva | Nástroj | Kde | Co pokrývá |
|---|---|---|---|
| Databáze | pgTAP + `pg_prove` | `supabase/tests/database/` | RPC, geofence, RLS, reporty |
| Aplikace | `flutter_test` | `app/test/` | logika providerů, obrazovky |

Autorita nad `within_geofence` a nad viditelností dat je v databázi, ne
v aplikaci. Proto je těžiště testů v SQL vrstvě.

---

## 1. Databázové testy

### Rychlý běh (lokální Supabase)

```bash
supabase start          # aplikuje migrace i seed
./scripts/db-test.sh    # = supabase test db
```

### Bez Supabase CLI (CI, holý Postgres)

Potřeba je Postgres s **PostGIS** a **pgTAP** (nejjednodušeji obraz
`supabase/postgres`), plus `psql` a `pg_prove` na stroji:

```bash
sudo apt-get install -y postgresql-client libtap-parser-sourcehandler-pgtap-perl

DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres \
  ./scripts/db-test.sh
```

Skript v tomto režimu:

1. aplikuje `supabase/tests/_shim/supabase_env.sql` — minimální náhradu
   Supabase prostředí (schéma `auth`, `auth.uid()`, role `anon` /
   `authenticated` / `service_role`),
2. aplikuje všechny migrace a `seed.sql`,
3. pustí `pg_prove` nad `supabase/tests/database/*.test.sql`.

Shim se na skutečném Supabase nepoužívá — tam `auth` schéma i role existují.

### Jak jsou testy postavené

Každý soubor běží v transakci, která se na konci rolluje zpět, takže testy
na sobě nezávisí a databáze zůstává čistá.

Přepnutí na konkrétního uživatele se dělá stejně, jako to dělá PostgREST:

```sql
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '<uuid uživatele>', TRUE);
```

`RESET ROLE` vrátí superuživatele, pod kterým se připravují data mimo RLS.

### Fixtures

Testy staví na `supabase/seed.sql`, který má **pevná UUID**:

| Uživatel | UUID | Role | Roster / zakázka |
|---|---|---|---|
| admin@pmtracker.test | `1111…` | admin | — |
| manager.a@pmtracker.test | `2222…` | manager | roster A, zakázka Praha `aaaa…` |
| manager.b@pmtracker.test | `3333…` | manager | roster B, zakázka Brno `bbbb…` |
| member.a1@pmtracker.test | `4444…` | member | roster A, na Praze **i Brně** (půjčení) |
| member.a2@pmtracker.test | `5555…` | member | roster A, jen Praha |
| member.b1@pmtracker.test | `6666…` | member | roster B, jen Brno |

Hesla: `Admin123!`, `Manager123!`, `Member123!`. Uživatelé se zakládají
přímo v `auth.users`, takže po `supabase db reset` jde rovnou přihlásit.

### Co je pokryté

- `01_schema` — tabulky, RLS zapnuté všude, RPC jsou `SECURITY DEFINER`,
  `time_entries` neobsahuje sloupec se souřadnicemi (GDPR),
  `duration_seconds` je generovaný.
- `02_start_tracking` — start uvnitř geofence, dvojitý start, start mimo
  geofence bez důvodu a s důvodem, zápis do `audit_log`, hranice poloměru,
  nepřiřazený člen, pozastavená zakázka.
- `03_stop_tracking` — `get_active_entry`, cizí stop, dvojitý stop,
  `duration_seconds`, `get_today_seconds`, auto-stop po 12 h.
- `04_rls` — člen vidí jen sebe; přímý INSERT/UPDATE/DELETE do
  `time_entries` neprojde; manager vidí roster i na půjčené zakázce;
  manager B vidí půjčeného člena jen na své zakázce; `audit_log` jen admin.
- `05_reports` — `get_member_utilization` podle role, filtr období,
  běžící záznam se nezapočítá.

---

## 2. Flutter testy

```bash
cd app
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # *.g.dart nejsou v gitu
flutter analyze
flutter test
```

### Jak psát testovatelný kód

Providery **nesmí sahat na `Supabase.instance` napřímo** — jinak nejde
v testu podstrčit nic jiného než živou síť. Vzor je v tracking feature:

```
core/location_service.dart              LocationService  ← obal nad geolocatorem
features/tracking/tracking_repository.dart
                                        TrackingRepository ← obal nad Supabase RPC
features/tracking/tracking_provider.dart  notifier čte obojí přes ref
```

V testu se pak přepíšou dva providery:

```dart
ProviderScope(overrides: [
  trackingRepositoryProvider.overrideWithValue(FakeTrackingRepository()),
  locationServiceProvider.overrideWithValue(FakeLocationService()),
]);
```

Fake implementace jsou v `app/test/support/fakes.dart` a zaznamenávají
volání, takže jde tvrdit „RPC dostalo tyhle souřadnice“ nebo „bez polohy
neodešlo nic“.

**Zbývající feature (jobs, roster, reports, admin) tenhle obal zatím
nemají** — dokud ho nedostanou, nejdou pro ně psát testy bez sítě.

### Pozor na sekundový ticker

`TrackingScreen` drží `Timer.periodic(1s)`. `pumpAndSettle()` se proto
nikdy nedočká klidu a spadne na timeout — v testech se pumpuje ručně:

```dart
await tester.pump();
await tester.pump(const Duration(milliseconds: 300));
```

---

## 3. CI

`.github/workflows/ci.yml` pouští obě vrstvy při každém pushi:

- **database** — `supabase/postgres` jako service container + `./scripts/db-test.sh`
- **flutter** — `flutter pub get`, build_runner, `dart format --set-exit-if-changed`,
  `flutter analyze`, `flutter test`

---

## 4. Co testy zatím nepokrývají

- **Offline / PowerSync** — connector zatím není zapojený (viz D4
  v `DECISIONS.md`); capture-then-verify z PLAN.md §6 je tím pádem
  neověřený. Až se PowerSync zapne, patří sem integrační test „letecký
  režim → start/stop → online → autoritativní `within_geofence`“.
- **Skutečné GPS a oprávnění** — `GeolocatorLocationService` se testuje
  jen ručně na zařízení.
- **Přihlášení a invite flow** — chybí serverový trigger, který novému
  `auth.users` založí `profiles` řádek (viz README, sekce Známé mezery).
- **Obrazovky jobs / roster / reports / admin** — chybí jim repository
  vrstva, viz výše.
