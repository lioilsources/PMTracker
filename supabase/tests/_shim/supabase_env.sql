-- ============================================================
-- Minimální náhrada Supabase prostředí pro běh testů na holém
-- PostgreSQL (CI, lokální psql). Na skutečném Supabase toto
-- NENÍ potřeba — auth schéma i role tam existují.
-- ============================================================

CREATE SCHEMA IF NOT EXISTS auth;

-- BYPASSRLS na service_role by odpovídalo produkci, ale vyžaduje, aby
-- připojená role byla superuser — na obraze supabase/postgres (používá ho
-- CI) role "postgres" superuser NENÍ (schválně, kvůli paritě s hostovaným
-- Supabase). Testy service_role nikde nepoužívají, takže atribut nechybí.
DO $$ BEGIN CREATE ROLE anon NOLOGIN NOINHERIT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE ROLE authenticated NOLOGIN NOINHERIT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN CREATE ROLE service_role NOLOGIN NOINHERIT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- Na obraze supabase/postgres (CI) auth.users už existuje, ale jen s
-- baseline schématem z docker-entrypoint-initdb.d — sloupce, které přidávají
-- pozdější GoTrue migrace (mj. email_confirmed_at, tam je jen starší
-- confirmed_at), se aplikují až za běhu skutečné auth služby, kterou tu
-- nespouštíme. CREATE TABLE IF NOT EXISTS by na téhle existující tabulce
-- byl no-op, takže chybějící sloupce místo toho doplňujeme přes
-- ADD COLUMN IF NOT EXISTS — funguje jak nad touto tabulkou, tak nad
-- prázdnou databází (bare Postgres), kde se založí od nuly.
CREATE TABLE IF NOT EXISTS auth.users (
  id UUID PRIMARY KEY
);

ALTER TABLE auth.users
  ADD COLUMN IF NOT EXISTS instance_id UUID,
  ADD COLUMN IF NOT EXISTS aud TEXT,
  ADD COLUMN IF NOT EXISTS role TEXT,
  ADD COLUMN IF NOT EXISTS email TEXT,
  ADD COLUMN IF NOT EXISTS encrypted_password TEXT,
  ADD COLUMN IF NOT EXISTS email_confirmed_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS raw_app_meta_data JSONB,
  ADD COLUMN IF NOT EXISTS raw_user_meta_data JSONB,
  ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW(),
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- auth.uid() čte sub z JWT claimů stejně jako na Supabase.
CREATE OR REPLACE FUNCTION auth.uid() RETURNS UUID
LANGUAGE sql STABLE AS $$
  SELECT COALESCE(
    NULLIF(current_setting('request.jwt.claim.sub', TRUE), ''),
    (NULLIF(current_setting('request.jwt.claims', TRUE), '')::jsonb ->> 'sub')
  )::uuid
$$;

GRANT USAGE ON SCHEMA auth TO anon, authenticated, service_role;
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO authenticated;
