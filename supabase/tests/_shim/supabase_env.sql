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

-- Podmnožina sloupců skutečné auth.users, které používá supabase/seed.sql.
CREATE TABLE IF NOT EXISTS auth.users (
  instance_id UUID,
  id UUID PRIMARY KEY,
  aud TEXT,
  role TEXT,
  email TEXT UNIQUE,
  encrypted_password TEXT,
  email_confirmed_at TIMESTAMPTZ,
  raw_app_meta_data JSONB,
  raw_user_meta_data JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

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
