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
    ├── DECISIONS.md         # Architektonická rozhodnutí
    └── DEMO.md              # Demo scénář + testovací účty
```

## Spuštění (lokální dev)

```bash
# 1. Start Supabase (migrace + seed vč. testovacích účtů — viz docs/DEMO.md)
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

---

## Investor pitch (English)

**In one sentence:** a mobile time tracker that proves someone was actually on
site — without ever storing their location.

### Problem

Construction firms and field-service teams still report hours on paper, over
WhatsApp and in Excel. Managers have no way to verify who was where; workers
have no way to prove overtime. Existing tools either track location continuously
— which meets resistance from employees and runs into GDPR — or they are generic
HR products with no link to a specific job.

### Solution

A Flutter app (iOS + Android) on Supabase. Coordinates are transmitted **only on
start/stop**. The server (PostgreSQL + PostGIS) verifies with `ST_DWithin` that
the point falls inside the job's geofence, stores only the boolean
`within_geofence` — and **discards the coordinates**. Work outside the geofence
can be permitted with an override, which is written to an audit log. The
member / manager / admin roles are enforced in the database (RLS), not in the
app.

### Why it can win

- **Privacy by design as a sales argument.** "We don't store your people's
  location" is a sentence that shortens the sale — it removes the negotiation
  with works councils and legal.
- **Verifiability instead of trust.** The output isn't a movement map but an
  auditable "was / wasn't on site" record — exactly what billing the end
  customer requires.
- **Offline-first.** Construction sites have no signal. The architecture
  accounts for that from the start with PowerSync (activated in phase 2).

### Status

MVP, initial commit June 2026. The data model, migrations, RLS, roles, geofence
RPC and the Flutter shell with its feature modules (auth, tracking, jobs,
roster, reports, admin) are in place. This is not a deployed product: the
offline layer is prepared but not activated, and it is not yet running at any
customer.

### Next milestones

Pilot deployments with the first companies, activating offline mode, export to
payroll systems, distribution via the App Store and Google Play.

---

## Investor pitch (česky)

**Jednou větou:** mobilní time tracker, který díky geofencingu na straně serveru
prokáže, že člověk opravdu byl na stavbě — a přitom nesbírá jeho polohu.

### Problém

Stavební firmy a servisní týmy dodnes vykazují hodiny přes papír, WhatsApp
a Excel. Manažer nemá jak ověřit, kdo kde byl; dělník nemá jak doložit přesčas.
Existující řešení buď trackují polohu nepřetržitě — což naráží na odpor
zaměstnanců i na GDPR — nebo jsou to obecné HR nástroje bez vazby na konkrétní
zakázku.

### Řešení

Flutter aplikace (iOS + Android) nad Supabase. Souřadnice se odesílají **pouze
při stisku start/stop**. Server (PostgreSQL + PostGIS) ověří přes `ST_DWithin`,
že bod leží v geofence zakázky, uloží jen booleovský výsledek `within_geofence`
— a **souřadnice zahodí**. Práce mimo geofence jde povolit s override, který se
zapíše do audit logu. Role member / manager / admin jsou vynucené na úrovni
databáze (RLS), ne v aplikaci.

### Proč to může vyhrát

- **Privacy by design jako prodejní argument.** „Neukládáme polohu vašich lidí"
  je věta, která zkracuje nákup — odpadá vyjednávání s odbory i s právním
  oddělením.
- **Ověřitelnost místo důvěry.** Výstup není mapa pohybu, ale auditovatelný
  záznam „byl / nebyl na místě" — přesně to, co potřebuje fakturace vůči
  koncovému zákazníkovi.
- **Offline-first.** Stavby nemají signál. Architektura s PowerSync na to
  počítá od začátku (aktivace ve fázi 2).

### Stav

MVP, iniciální commit červen 2026. Stojí datový model, migrace, RLS, role,
geofence RPC a Flutter shell s feature moduly (auth, tracking, jobs, roster,
reports, admin). Není to nasazený produkt: offline vrstva je připravená, ale
neaktivovaná, a zatím neběží u žádného zákazníka.

### Nejbližší milníky

Pilotní nasazení u prvních firem, aktivace offline režimu, export do mzdových
systémů, distribuce přes App Store a Google Play.
