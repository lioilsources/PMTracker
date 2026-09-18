# Demo scénář — PMTracker MVP

Hodnotová smyčka: *manager založí zakázku s místem → přiřadí člena →
člen na místě trackuje čas → manager vidí report.*

## 1. Příprava prostředí

```bash
# Backend (vyžaduje Docker + Supabase CLI)
supabase start
supabase db reset        # migrace + seed (testovací účty níže)
supabase status          # zkopíruj anon key

# App
cd app
dart run build_runner build --delete-conflicting-outputs
flutter run \
  --dart-define=SUPABASE_URL=http://localhost:54321 \
  --dart-define=SUPABASE_ANON_KEY=<anon-key>
```

Na fyzickém telefonu nahraď `localhost` IP adresou počítače v LAN
(např. `http://192.168.1.10:54321`).

## 2. Testovací účty (vytváří seed)

| E-mail | Heslo | Role |
|---|---|---|
| admin@pmtracker.test | Admin123! | admin |
| manager.a@pmtracker.test | Manager123! | manager A (roster: Petr, Tomáš) |
| manager.b@pmtracker.test | Manager123! | manager B (roster: Eva) |
| member.a1@pmtracker.test | Member123! | člen — Petr Svoboda (půjčen i na zakázku B) |
| member.a2@pmtracker.test | Member123! | člen — Tomáš Novotný |
| member.b1@pmtracker.test | Member123! | člen — Eva Dvořáková |

Seed obsahuje 2 zakázky: **Praha** (Václavské nám., geofence 200 m,
vlastní manager A) a **Brno** (nám. Svobody, 150 m, manager B).

## 3. Průchod dema

### Manager A — zakázka a tým (5 min)
1. Přihlas se jako `manager.a@pmtracker.test`.
2. **Zakázky** → detail „Rekonstrukce kanceláří Praha": adresa, geofence, odhad hodin.
3. Vytvoř novou zakázku: vyplň název + **lat/lon** (pro demo použij souřadnice,
   kde právě jsi) → geofence pak projde „na místě".
4. V detailu zakázky **Přidat** člena (vyber kohokoliv z firmy — i z cizího
   rosteru = půjčení) a **Přidat** úkol do checklistu.
5. **Roster**: seznam vlastních lidí.

### Člen — tracking (5 min)
6. Přihlas se jako `member.a1@pmtracker.test`.
7. Domů: velké **Start** → vyber zakázku. Appka pošle polohu, server ověří
   geofence (indikátor „Na místě" / „Override").
8. **Override demo:** vyber zakázku, u které nejsi (Praha/Brno) → appka si
   vyžádá **povinný důvod** → záznam projde s `within_geofence = false`
   a zapíše se audit log.
9. **Stop** → dnešní součet se aktualizuje. Odškrtni úkol v detailu zakázky.

### Manager A — reporty (3 min)
10. Přihlas se zpět jako manager A → **Reporty** → zvol období.
11. Ukáž, že vidí *plné* vytížení Petra (i hodiny na brněnské zakázce
    managera B — je v jeho rosteru), rozpad po zakázkách.
12. Volitelně jako `manager.b@pmtracker.test`: vidí Petra **jen** na své
    zakázce — izolace viditelnosti funguje.

### Admin (1 min)
13. `admin@pmtracker.test` → **Admin**: seznam uživatelů, změna role.

## 4. Co říct, když se klient zeptá (known gaps — po demu)

- **Offline režim** — architektura připravena (capture-then-verify, PowerSync),
  v demu appka vyžaduje připojení.
- **CSV import týmu a export reportů** — Fáze 1 backlog.
- **Historie výkazů člena v appce** — Fáze 1 backlog (data v DB jsou).
- **Vytížení přímo v rosteru a vytížení zakázky vs. odhad** — Fáze 1 backlog.
- **Schvalování výkazů, push notifikace, anti-fraud (mock GPS)** — Fáze 2.
- **Invite flow** — účty zatím zakládá admin/seed; e-mailové pozvánky Fáze 1/2.
- Auto-stop zapomenutých časovačů běží (pg_cron, každých 30 min, 12h limit).

## 5. Smoke test backendu bez telefonu

Celý flow lze předvést i z SQL konzole (Studio → SQL editor):
```sql
-- přímý zápis musí selhat (vše jde přes RPC):
INSERT INTO time_entries (company_id, job_id, member_id)
VALUES ('00000000-0000-0000-0000-000000000001',
        '00000000-0000-0000-0000-000000000101',
        '00000000-0000-0000-0000-000000000013');  -- ERROR (RLS)
```
