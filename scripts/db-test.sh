#!/usr/bin/env bash
# ============================================================
# Spustí pgTAP testy databázové vrstvy (supabase/tests/database).
#
# Dva režimy:
#   1) bez argumentů + běžící `supabase start`  → `supabase test db`
#   2) DATABASE_URL=postgres://…                → holý Postgres (CI)
#      Vytvoří schéma auth + role, které jinak dodává Supabase,
#      aplikuje migrace i seed a spustí pg_prove.
#
# Použití:
#   ./scripts/db-test.sh
#   DATABASE_URL=postgres://postgres:postgres@localhost:5432/pmtracker_test ./scripts/db-test.sh
# ============================================================
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ -z "${DATABASE_URL:-}" ]]; then
  if ! command -v supabase >/dev/null 2>&1; then
    echo "Chybí Supabase CLI i DATABASE_URL." >&2
    echo "Buď spusť 'supabase start', nebo nastav DATABASE_URL na testovací Postgres." >&2
    exit 1
  fi
  echo "▶ supabase test db"
  exec supabase test db
fi

command -v psql     >/dev/null || { echo "Chybí psql." >&2; exit 1; }
command -v pg_prove >/dev/null || { echo "Chybí pg_prove (balík pgtap / libtap-parser-sourcehandler-pgtap-perl)." >&2; exit 1; }

echo "▶ příprava testovací databáze"
psql "$DATABASE_URL" -q -v ON_ERROR_STOP=1 \
  -f supabase/tests/_shim/supabase_env.sql

for migration in supabase/migrations/*.sql; do
  echo "  · $migration"
  psql "$DATABASE_URL" -q -v ON_ERROR_STOP=1 -f "$migration"
done

echo "  · supabase/seed.sql"
psql "$DATABASE_URL" -q -v ON_ERROR_STOP=1 -f supabase/seed.sql

echo "▶ pg_prove"
pg_prove --failures --dbname "$DATABASE_URL" supabase/tests/database/*.test.sql
