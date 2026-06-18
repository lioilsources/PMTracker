# TimeTracker — Implementační plán (POC → MVP → PM)

Firemní mobilní appka pro evidenci času na zakázkách s ověřením polohy,
s výhledem do projektového řízení. Vstup pro pokračování v terminálu (claude-code).

---

## 1. Cíl a dvě persony

Mobilní appka (iOS + Android). Produkt cílí na dvě persony:

- **Persona 1 — Manager (= rozsah MVP).** Potřebuje jen time tracker: vlastní zakázky, přiřazuje na ně lidi (i půjčené z cizích rosterů), členové trackují čas ověřený polohou, manager vidí reporty vytížení.
- **Persona 2 — PM (= pozdější fáze).** Navíc potřebuje vrstvu budgetu, plánování a vytíženosti napříč rostery.

**Strategie: MVP stavíme pro personu 1, ale architektura nesmí zavřít dveře pro PM.** Většina PM vrstvy je čistě aditivní (nové tabulky) — viz Fáze 3. Reálné „door-closery" jsou jen dva (viz sekce 3).

Hlavní hodnotová smyčka MVP: *manager založí zakázku s místem → přiřadí člena → člen na místě trackuje čas → manager vidí report.*

---

## 2. Tech stack (zamčeno)

| Vrstva | Volba |
|---|---|
| Mobil | Flutter (iOS + Android) |
| Backend | Supabase — Postgres + Auth + RLS + PostGIS, **EU region (Frankfurt)** |
| Offline sync | PowerSync (Postgres ↔ lokální SQLite) |
| State management | Riverpod (návrh — dle preference) |
| Poloha | `geolocator` |
| Push (Fáze 2+) | FCM přes Supabase Edge Function |

Backend logika žije v Postgresu (RLS, RPC, triggery) a Edge Functions — žádný samostatný server.

**Inflection point:** jakmile přijde PM-level analytika (cross-project rollupy, marže, portfolio) a/nebo multi-tenant SaaS, Supabase-only přestává být samozřejmé. Cílový stav pak je **hybrid**: Supabase na operativní/capture vrstvě + **Go služba** nad stejným Postgresem na PM/plánování/analytiku. Viz Fáze 4.

---

## 3. Architektonická rozhodnutí

**Zamčeno:**
- Zápis do `time_entries` a `audit_log` **výhradně přes SECURITY DEFINER RPC** — klient nikdy nerozhoduje o `within_geofence`.
- **Roster = 1:1** (`profiles.manager_id`) → čistá kapacita bez dvojího započítání.
- **Zakázka = 1:1 vlastník** (`jobs.manager_id`); půjčování lidí jde přes `job_assignments` (M:N).
- Viditelnost managera ze dvou zdrojů: roster (plné vytížení člena) + vlastní zakázky (jen záznamy na nich).
- Autorita (přiřazení, schvalování) vázaná na **zakázku**, ne na osobu.
- **GDPR:** v `time_entries` se neukládají syrové souřadnice — jen výsledek ověření. Syrové coords žijí jen dočasně v offline frontě, server je po ověření zahodí.
- Schvalování (až přijde) bude **per záznam/zakázka**, ne per osoba/den.
- **Tasks** (úkoly na zakázce) jsou aditivní checklist vrstva; v MVP se **čas trackuje dál na zakázku**, ne na úkol.

**Load-bearing — rozhodnout PŘED stavbou MVP (jinak se PM draho retrofituje):**
1. **Hierarchie zakázka vs. projekt.** Je „zakázka" nejvyšší jednotka, nebo projekt obsahuje víc zakázek? Budget/deadliny/rollupy v PM visí na projektu. Přidat rodiče zpětně = přepis FK + reportů. **Cheap insurance:** zavést `projects` jako rodiče jobů hned (klidně 1 default projekt/job, UI to může skrýt).
2. **Jedna firma vs. multi-tenant SaaS.** Určuje investici do izolace a pozdější Supabase→Go hybrid. `company_id` je už všude jako pojistka.

**Rezervovat (levné teď, ne door-closer):**
- Read-only **org-wide role** (resource manager / PM) v návrhu RLS — pro budoucí cross-roster vytížení.

---

## 4. Otázky k odsouhlasení se zákazníkem

**Musí se odsouhlasit teď (door-closery):**
- Terminologie **zakázka vs. projekt** (viz load-bearing #1).
- **Jedna firma, nebo produkt na prodej (SaaS)?** (viz load-bearing #2).
- Kdo v org legitimně potřebuje cross-team viditelnost (rezervace org-wide role)?

**Pro MVP tak jako tak:**
- **GDPR poloha:** kdo je správce, právní základ sledování, doba uchování time dat. *(Největší riziko projektu.)*
- **Model geofence:** ověření jen při start/stop (ne kontinuálně) — OK? Pevný poloměr, nebo per zakázka?
- **Telefony:** firemní vs. BYOD (oprávnění, MDM, GDPR příběh).
- **Override:** kdo a jak často reviduje?
- **Auto-stop a zaokrouhlování** (očekávání kvůli mzdám).
- **Půjčování:** smí manager vzít člověka z cizího rosteru bez souhlasu jeho roster-managera?
- **Import struktury týmu:** CSV vs. Excel + jaká pole.
- **Auth:** e-mail+heslo, magic link, nebo SSO?
- **Schvalování výkazů:** stačí personě 1 holé trackování, nebo už chce schvalování?

**Řekni klientovi, že to do MVP NEpatří (proti scope creepu):**
- Budget a sazby, kapacita/dovolená, plánované alokace, engine flowing deadlines, org-wide pohled na vytížení. Vše aditivní → až PM fáze.

---

## 5. Repo struktura (monorepo)

```
timetracker/
├── supabase/
│   ├── migrations/        # SQL (schéma, RLS, RPC, triggery)
│   ├── functions/         # Edge Functions (Fáze 2+: push, CSV)
│   └── seed.sql           # testovací data pro POC
├── app/                   # Flutter aplikace
│   ├── lib/
│   │   ├── core/          # supabase/powersync klient, auth, sync connector
│   │   ├── features/      # tracking, jobs, reports, admin
│   │   └── shared/        # UI komponenty, téma
│   └── ...
└── docs/
    ├── PLAN.md            # tento dokument
    └── DECISIONS.md       # log rozhodnutí + odpovědi klienta
```

---

## 6. Klíčový technický bod: offline + serverové ověření geofence

Trackování musí fungovat offline. Geofence ověřuje server. Řešení **capture-then-verify**:

1. Job (vč. `location`, `geofence_radius_m`) se přes PowerSync synchronizuje do lokální SQLite.
2. Při startu offline appka udělá **orientační** client-side kontrolu (Haversine proti cached poloze) jen pro UX — není autoritativní.
3. Start se zapíše do lokální SQLite + upload fronty, **se souřadnicemi**.
4. PowerSync `uploadData` connector nevkládá řádek napřímo — volá **RPC `start_tracking`**. Server spočítá `ST_DWithin`, nastaví autoritativní `within_geofence`, případně zaloguje override a coords zahodí.
5. Autoritativní řádek se přes PowerSync vrátí na klienta a nahradí optimistický záznam.

→ Trust model zůstává serverový i offline. **Nejrizikovější integrace — proto je předmětem POC.**

---

## 7. Fáze 0 — POC (de-risking)

**Cíl:** dokázat, že riziková architektura funguje. Žádné polished UI.

1. Dokončit kanonickou migraci (schéma + delty: roster scalar, `jobs.manager_id`, `owns_job`, upravené politiky). Přidat `tasks` (aditivní) a `projects` rodiče dle rozhodnutí klienta.
2. `supabase init` + link (EU region), `db push`, povolit PostGIS.
3. `seed.sql`: 1 firma, 1 admin, 2 manageři (A, B), 3 členové (2 v rosteru A, 1 v B), 2 zakázky s reálnými souřadnicemi, přiřazení + jedno **půjčení**.
4. Throwaway Flutter obrazovka: login, seznam zakázek, Start/Stop přes RPC.
5. PowerSync: lokální SQLite, `uploadData` connector volající `start_tracking` / `stop_tracking`.
6. Test geofence: v geofence (projde), mimo bez override (odmítnuto), mimo s override (projde + audit).
7. Test offline: airplane mode → start/stop → online → ověřit doplnění autoritativního `within_geofence`.
8. Test RLS: A / B / člen — izolace viditelnosti (roster vs. vlastník zakázky).

**Hotovo když:**
- Offline start/stop přežije airplane mode a po syncu má serverem nastavený geofence flag.
- Override mimo geofence je v `audit_log` s důvodem.
- A vidí plné vytížení svého člena (i na zakázce B); B vidí téhož jen na své zakázce; člen jen své.
- Přímý INSERT do `time_entries` z klienta je odmítnut.

---

## 8. Fáze 1 — MVP (persona 1)

**Cíl:** čistá, jednoduchá appka pokrývající hodnotovou smyčku pro tři role.

**Backend:**
1. Reportovací views: vytížení člena (hodiny/období), vytížení zakázky (skutečnost vs. `estimated_hours`).
2. RPC pro CSV import týmu (admin) — validace, vytvoření profilů, nastavení rosteru.
3. Auto-stop zapomenutých časovačů přes `pg_cron` + audit.

**Flutter — Člen (90 % užití, max jednoduché):**
4. Domů: velké **Start/Stop** + dnešní součet + indikace „jsi na místě / mimo".
5. Override dialog (povinný důvod) při startu mimo geofence.
6. Seznam mých zakázek (+ úkoly jako checklist) a moje historie.
7. Offline-first UX: jasná indikace stavu sync.

**Flutter — Manager:**
8. Zakázky: CRUD (název, místo + geofence, `estimated_hours`, stav, úkoly), přiřazení vč. půjčení.
9. Roster: seznam mých lidí + aktuální vytížení.
10. Reporty: filtr období, vytížení lidí a zakázek, export CSV.

**Flutter — Admin:**
11. Správa uživatelů + CSV import (se šablonou).

**Cross-cutting:**
12. Auth + invite flow nastavující `company_id`+`role` do user metadata.
13. Jednotné téma, prázdné stavy, lidské chybové hlášky (vč. RPC výjimek).
14. Store buildy — zdůvodnění location permissions (iOS i Play review).

**Hotovo když:** tři role projdou celou smyčku na reálném telefonu; reporty sedí s ručním součtem; appka funguje offline a po obnově sítě dosynchronizuje.

---

## 9. Fáze 2 — provoz & důvěra v data

- **Schvalovací workflow** výkazů (per zakázka/záznam, uzamčení období) — schvaluje vlastník zakázky.
- **Push notifikace & připomínky** (běžící časovač, konec dne, překročení rozpočtu) přes Edge Function + FCM.
- **Anti-fraud:** detekce mock-location, namátkové ověření polohy během práce.
- **Live dashboard** „kdo právě pracuje" přes Supabase Realtime.
- **NFC/QR check-in** jako alternativa ke GPS.

---

## 10. Fáze 3 — PM vrstva (persona 2)

Vše aditivní, žádný zásah do foundationu. Stavět jako samostatný track.

- **Finanční vrstva:** sazby (per člověk/role/zakázka) **effective-dated** (náklad = hodiny × sazba platná *tehdy*), budget v penězích, billable/non-billable, čerpání vs. rozpočet.
- **Hierarchie & deadliny:** projekt → fáze → úkoly, milníky, závislosti, **engine na flowing deadlines** (přepočet downstream termínů, prevence cyklů). Vlastní mini-zadání.
- **Plánovací vrstva:** kapacita člověka (FTE, hodiny/týden, dovolená, svátky) + alokace dopředu → **plán vs. skutečnost** jako druhá osa všech reportů.
- **Cross-roster vytížení:** aktivace rezervované **org-wide read role**; portfolio pohled kapacita vs. poptávka napříč rostery. Pozor na GDPR — striktně role-gated.
- Rozhodnout zde: **trackuje se čas dál na zakázku, nebo nově na úkol** (`time_entries.task_id`).

---

## 11. Fáze 4 — integrace & škálování

- **Multi-tenant SaaS** (předplatné per seat) — zde zvážit **hybrid Supabase + Go backend** pro PM/analytiku.
- **Integrace na účetnictví/mzdy** (Pohoda, Money S3, ABRA) — silný prodejní argument.
- **Web admin panel** + **export do PDF** s brandingem.
- **Workflow půjčování** se souhlasem roster-managera.
- Biometrie, fotky/poznámky k záznamu, wearables.

---

## 12. Rizika

| Riziko | Dopad | Mitigace |
|---|---|---|
| Offline + serverové ověření geofence | vysoký | ověřit v POC (capture-then-verify) |
| GDPR / sledování polohy zaměstnanců | vysoký | jen ověření při start/stop, žádné syrové coords, směrnice u klienta |
| Zamítnutí background location v App Store / Play | střední | model „ověř při akci"; připravit zdůvodnění |
| Mock-location (podvržené GPS) | střední | detekce ve Fázi 2 |
| Komplexní PM reporty v SQL | střední | views/materialized; při růstu hybrid Go backend |
| Scope creep směrem k PM v MVP | střední | persona 1 = MVP; PM až Fáze 3 |

---

## 13. První kroky v terminálu

```bash
# Supabase
supabase init
supabase link --project-ref <REF>          # projekt v EU regionu
# vlož kanonickou migraci (schéma + delty + tasks/projects) do supabase/migrations/
supabase db push                            # PostGIS: create extension postgis

# Flutter
flutter create app && cd app
flutter pub add supabase_flutter powersync geolocator flutter_riverpod

# seed pro POC
supabase db execute --file supabase/seed.sql
```

**Pořadí práce:** nejdřív získat od klienta odpovědi na door-closery (sekce 4) → Fáze 0 úkol 1–3 (backend) → 4–5 (klient + sync) → 6–8 (testy rizik). Teprve po zeleném POC stavět MVP.
