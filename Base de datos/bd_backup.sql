--
-- PostgreSQL database dump
--

\restrict 9ztgAcGiCCi5x7Pe6HHwCpxUSK3GSqLs7RwlDI7jz1T1kmqf1VKRpzuCvyAOBWj

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.0

-- Started on 2026-06-07 22:01:58

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 23 (class 2615 OID 16498)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 14 (class 2615 OID 16392)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 22 (class 2615 OID 16578)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 21 (class 2615 OID 16567)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 9 (class 2615 OID 16390)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 10 (class 2615 OID 16559)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 24 (class 2615 OID 16546)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 20 (class 2615 OID 16607)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 2 (class 3079 OID 16393)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 4 (class 3079 OID 16447)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16608)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 3 (class 3079 OID 16436)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1112 (class 1247 OID 16744)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1136 (class 1247 OID 16885)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1109 (class 1247 OID 16738)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1106 (class 1247 OID 16732)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1154 (class 1247 OID 16988)
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1166 (class 1247 OID 17061)
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1148 (class 1247 OID 16966)
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1157 (class 1247 OID 16998)
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1142 (class 1247 OID 16927)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1220 (class 1247 OID 17407)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1184 (class 1247 OID 17176)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1187 (class 1247 OID 17191)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1226 (class 1247 OID 17448)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1223 (class 1247 OID 17419)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 1208 (class 1247 OID 17329)
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- TOC entry 412 (class 1255 OID 16544)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 425 (class 1255 OID 16714)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 411 (class 1255 OID 16543)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 410 (class 1255 OID 16542)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 413 (class 1255 OID 16551)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 417 (class 1255 OID 16572)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
begin
    if not exists (
        select 1
        from pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 414 (class 1255 OID 16553)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 415 (class 1255 OID 16563)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 416 (class 1255 OID 16564)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 418 (class 1255 OID 16574)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 424 (class 1255 OID 16665)
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- TOC entry 360 (class 1255 OID 16391)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 457 (class 1255 OID 17558)
-- Name: actualizar_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.actualizar_updated_at() OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 17559)
-- Name: obtener_indicadores(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.obtener_indicadores() RETURNS TABLE(indicador character varying, valor bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 'Hectáreas activas'::VARCHAR, COUNT(*)::BIGINT
    FROM hectareas WHERE activo = TRUE;
    
    RETURN QUERY
    SELECT 'Trabajadores activos'::VARCHAR, COUNT(*)::BIGINT
    FROM trabajadores WHERE activo = TRUE;
    
    RETURN QUERY
    SELECT 'Cosechas este mes'::VARCHAR, COUNT(*)::BIGINT
    FROM cosechas 
    WHERE DATE_TRUNC('month', fec_cosecha) = DATE_TRUNC('month', CURRENT_DATE);
    
    RETURN QUERY
    SELECT 'Productos con stock bajo'::VARCHAR, COUNT(*)::BIGINT
    FROM materiales 
    WHERE activo = TRUE AND stock_actual <= stock_minimo;
    
    RETURN QUERY
    SELECT 'Ciclos en curso'::VARCHAR, COUNT(*)::BIGINT
    FROM ciclos_cultivo 
    WHERE estado NOT IN ('Barbecho', 'Cosechado');
END;
$$;


ALTER FUNCTION public.obtener_indicadores() OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 17560)
-- Name: registrar_movimiento_stock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.registrar_movimiento_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Solo registrar si el stock realmente cambió
    IF NEW.stock_actual IS DISTINCT FROM OLD.stock_actual THEN
        INSERT INTO movimientos_material (
            id_material,
            tipo_movimiento,
            cantidad,
            stock_anterior,
            stock_nuevo,
            observacion
        ) VALUES (
            NEW.id_mat,
            CASE
                WHEN NEW.stock_actual > OLD.stock_actual THEN 'ENTRADA'
                WHEN NEW.stock_actual < OLD.stock_actual THEN 'SALIDA'
                ELSE 'AJUSTE'
            END,
            ABS(NEW.stock_actual - OLD.stock_actual),
            OLD.stock_actual,
            NEW.stock_actual,
            'Cambio automático via sistema'
        );
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.registrar_movimiento_stock() OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 17441)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 453 (class 1255 OID 17520)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 450 (class 1255 OID 17453)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 446 (class 1255 OID 17404)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 445 (class 1255 OID 17399)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 449 (class 1255 OID 17449)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 455 (class 1255 OID 17556)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 444 (class 1255 OID 17398)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 452 (class 1255 OID 17519)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 456 (class 1255 OID 17557)
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 426 (class 1255 OID 17205)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(c.column_name order by c.ordinal_position),
            '{}'::text[]
        )
        from
            information_schema.columns c
        where
            format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                format('%I.%I', c.table_schema, c.table_name)::regclass,
                c.column_name,
                'SELECT'
            );
    table_col_names text[] = coalesce(
            array_agg(pa.attname),
            '{}'::text[]
        )
        from
            pg_attribute pa
        where
            pa.attrelid = new.entity
            and pa.attnum > 0;
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        -- Filtered column is valid
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        -- Type is sanitized and safe for string interpolation
        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;
        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        else
            -- raises an exception if value is not coercable to type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    -- Validate that selected_columns reference columns the role can SELECT
    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint on
    -- (subscription_id, entity, filters) can't be tricked by a different filter order
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value),
        '{}'
    ) from unnest(new.filters) f;

    -- Normalize selected_columns order so ARRAY['a','b'] and ARRAY['b','a'] are
    -- treated as the same subscription group in apply_rls
    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 447 (class 1255 OID 17430)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 451 (class 1255 OID 17513)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 454 (class 1255 OID 17555)
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO supabase_admin;

--
-- TOC entry 443 (class 1255 OID 17394)
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 442 (class 1255 OID 17393)
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- TOC entry 433 (class 1255 OID 17270)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 436 (class 1255 OID 17326)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 429 (class 1255 OID 17245)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 428 (class 1255 OID 17244)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 427 (class 1255 OID 17243)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 437 (class 1255 OID 17382)
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- TOC entry 430 (class 1255 OID 17257)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 434 (class 1255 OID 17309)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 438 (class 1255 OID 17383)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- TOC entry 435 (class 1255 OID 17325)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 441 (class 1255 OID 17389)
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- TOC entry 431 (class 1255 OID 17259)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 440 (class 1255 OID 17387)
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 439 (class 1255 OID 17386)
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 432 (class 1255 OID 17260)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 16529)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4740 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 262 (class 1259 OID 17084)
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 256 (class 1259 OID 16889)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4743 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- TOC entry 247 (class 1259 OID 16686)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4745 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4746 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 242 (class 1259 OID 16522)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4748 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 251 (class 1259 OID 16776)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4750 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 250 (class 1259 OID 16764)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4752 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 249 (class 1259 OID 16751)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4754 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 4755 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- TOC entry 259 (class 1259 OID 17001)
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- TOC entry 261 (class 1259 OID 17074)
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4758 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- TOC entry 258 (class 1259 OID 16971)
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- TOC entry 260 (class 1259 OID 17034)
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- TOC entry 257 (class 1259 OID 16939)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 241 (class 1259 OID 16511)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4763 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 240 (class 1259 OID 16510)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4765 (class 0 OID 0)
-- Dependencies: 240
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 254 (class 1259 OID 16818)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4767 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 255 (class 1259 OID 16836)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4769 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 244 (class 1259 OID 16537)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4771 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 248 (class 1259 OID 16716)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4773 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4774 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 4775 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- TOC entry 4776 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- TOC entry 253 (class 1259 OID 16803)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4778 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 252 (class 1259 OID 16794)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4780 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4781 (class 0 OID 0)
-- Dependencies: 252
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 239 (class 1259 OID 16499)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4783 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4784 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 264 (class 1259 OID 17149)
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 263 (class 1259 OID 17126)
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- TOC entry 280 (class 1259 OID 17561)
-- Name: abono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.abono (
    id_abono integer NOT NULL,
    id_trab integer NOT NULL,
    fecha date DEFAULT CURRENT_DATE NOT NULL,
    tipo_saco character varying(50) NOT NULL,
    cantidad_sacos integer DEFAULT 0 NOT NULL,
    parcela character varying(255),
    observacion character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.abono OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17569)
-- Name: abono_id_abono_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.abono_id_abono_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.abono_id_abono_seq OWNER TO postgres;

--
-- TOC entry 4791 (class 0 OID 0)
-- Dependencies: 281
-- Name: abono_id_abono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.abono_id_abono_seq OWNED BY public.abono.id_abono;


--
-- TOC entry 282 (class 1259 OID 17570)
-- Name: asistencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asistencia (
    id_asist integer NOT NULL,
    id_trab integer NOT NULL,
    fec_asist date NOT NULL,
    hora_entrada time without time zone,
    hora_salida time without time zone,
    presente boolean DEFAULT true,
    sacos_cosechados integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    observacion text,
    tipo_tarea character varying(20),
    tareas_completadas integer DEFAULT 0,
    observacion_supervisor character varying(300),
    estado_aprobacion character varying(20) DEFAULT 'PENDIENTE'::character varying,
    CONSTRAINT asistencia_tareas_completadas_check CHECK ((tareas_completadas >= 0)),
    CONSTRAINT asistencia_tipo_tarea_check CHECK (((tipo_tarea)::text = ANY (ARRAY[('TRANSPLANTE'::character varying)::text, ('SACA'::character varying)::text, ('CARGA'::character varying)::text, ('RIEGO'::character varying)::text, ('ABONO'::character varying)::text, ('CHALEO'::character varying)::text, ('MOTO_BOMBA'::character varying)::text])))
);


ALTER TABLE public.asistencia OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17583)
-- Name: asistencia_id_asist_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.asistencia_id_asist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.asistencia_id_asist_seq OWNER TO postgres;

--
-- TOC entry 4794 (class 0 OID 0)
-- Dependencies: 283
-- Name: asistencia_id_asist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.asistencia_id_asist_seq OWNED BY public.asistencia.id_asist;


--
-- TOC entry 284 (class 1259 OID 17584)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    id_cargo integer NOT NULL,
    nom_cargo character varying(50) NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17589)
-- Name: cargos_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cargos_id_cargo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cargos_id_cargo_seq OWNER TO postgres;

--
-- TOC entry 4797 (class 0 OID 0)
-- Dependencies: 285
-- Name: cargos_id_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargos_id_cargo_seq OWNED BY public.cargos.id_cargo;


--
-- TOC entry 286 (class 1259 OID 17590)
-- Name: ciclos_cultivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciclos_cultivo (
    id_ciclo integer NOT NULL,
    id_hect integer NOT NULL,
    nombre_ciclo character varying(50) NOT NULL,
    fecha_siembra date NOT NULL,
    fecha_cosecha_estimada date,
    fecha_cosecha_real date,
    estado character varying(20) DEFAULT 'Preparación'::character varying,
    rendimiento_real_kg_ha numeric(10,2),
    CONSTRAINT ciclos_cultivo_estado_check CHECK (((estado)::text = ANY (ARRAY[('Preparación'::character varying)::text, ('Sembrado'::character varying)::text, ('Crecimiento'::character varying)::text, ('Floración'::character varying)::text, ('Maduración'::character varying)::text, ('Cosechado'::character varying)::text, ('Barbecho'::character varying)::text])))
);


ALTER TABLE public.ciclos_cultivo OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17595)
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ciclos_cultivo_id_ciclo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ciclos_cultivo_id_ciclo_seq OWNER TO postgres;

--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 287
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ciclos_cultivo_id_ciclo_seq OWNED BY public.ciclos_cultivo.id_ciclo;


--
-- TOC entry 288 (class 1259 OID 17596)
-- Name: compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compras (
    id_compra integer NOT NULL,
    id_proveedor integer,
    fecha_compra date DEFAULT CURRENT_DATE NOT NULL,
    tipo_compra character varying(30),
    monto_total numeric(12,2) NOT NULL,
    factura_numero character varying(50),
    CONSTRAINT compras_monto_total_check CHECK ((monto_total > (0)::numeric)),
    CONSTRAINT compras_tipo_compra_check CHECK (((tipo_compra)::text = ANY (ARRAY[('Insumos'::character varying)::text, ('Maquinaria'::character varying)::text, ('Servicios'::character varying)::text, ('Otros'::character varying)::text])))
);


ALTER TABLE public.compras OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17602)
-- Name: compras_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compras_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compras_id_compra_seq OWNER TO postgres;

--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 289
-- Name: compras_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compras_id_compra_seq OWNED BY public.compras.id_compra;


--
-- TOC entry 290 (class 1259 OID 17603)
-- Name: compras_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compras_material (
    id_compra integer NOT NULL,
    id_material integer NOT NULL,
    id_proveedor integer,
    cantidad numeric(10,2) NOT NULL,
    precio_unitario numeric(10,2),
    precio_total numeric(10,2) GENERATED ALWAYS AS ((cantidad * precio_unitario)) STORED,
    fecha_compra date DEFAULT CURRENT_DATE NOT NULL,
    observacion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.compras_material OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17611)
-- Name: compras_material_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compras_material_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compras_material_id_compra_seq OWNER TO postgres;

--
-- TOC entry 4806 (class 0 OID 0)
-- Dependencies: 291
-- Name: compras_material_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compras_material_id_compra_seq OWNED BY public.compras_material.id_compra;


--
-- TOC entry 292 (class 1259 OID 17612)
-- Name: control_calidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.control_calidad (
    id_calidad integer NOT NULL,
    id_cosecha integer NOT NULL,
    fecha_analisis date DEFAULT CURRENT_DATE NOT NULL,
    porcentaje_granos_enteros numeric(5,2),
    porcentaje_granos_partidos numeric(5,2),
    porcentaje_granos_verdes numeric(5,2),
    porcentaje_impurezas numeric(5,2),
    porcentaje_humedad numeric(5,2),
    grado_comercial character varying(10),
    observaciones text,
    CONSTRAINT control_calidad_grado_comercial_check CHECK (((grado_comercial)::text = ANY (ARRAY[('Extra'::character varying)::text, ('Primera'::character varying)::text, ('Segunda'::character varying)::text, ('Tercera'::character varying)::text])))
);


ALTER TABLE public.control_calidad OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17619)
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.control_calidad_id_calidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.control_calidad_id_calidad_seq OWNER TO postgres;

--
-- TOC entry 4809 (class 0 OID 0)
-- Dependencies: 293
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.control_calidad_id_calidad_seq OWNED BY public.control_calidad.id_calidad;


--
-- TOC entry 294 (class 1259 OID 17620)
-- Name: cosechas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cosechas (
    id_cosecha integer NOT NULL,
    id_hect integer NOT NULL,
    id_tipo_cosecha integer NOT NULL,
    fec_cosecha date NOT NULL,
    hora_inicio time without time zone,
    hora_fin time without time zone,
    metodo_cosecha character varying(30),
    id_maq integer,
    cantidad_sacos integer,
    peso_total_kg numeric(12,2),
    humedad_porcentaje numeric(5,2),
    calidad_arroz character varying(20),
    observaciones text,
    CONSTRAINT cosechas_calidad_arroz_check CHECK (((calidad_arroz)::text = ANY (ARRAY[('Extra'::character varying)::text, ('Superior'::character varying)::text, ('Corriente'::character varying)::text]))),
    CONSTRAINT cosechas_cantidad_sacos_check CHECK ((cantidad_sacos >= 0)),
    CONSTRAINT cosechas_metodo_cosecha_check CHECK (((metodo_cosecha)::text = ANY (ARRAY[('Manual'::character varying)::text, ('Mecanizada'::character varying)::text]))),
    CONSTRAINT cosechas_peso_total_kg_check CHECK ((peso_total_kg >= (0)::numeric))
);


ALTER TABLE public.cosechas OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17629)
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cosechas_id_cosecha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cosechas_id_cosecha_seq OWNER TO postgres;

--
-- TOC entry 4812 (class 0 OID 0)
-- Dependencies: 295
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cosechas_id_cosecha_seq OWNED BY public.cosechas.id_cosecha;


--
-- TOC entry 296 (class 1259 OID 17630)
-- Name: detalle_compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_compras (
    id_detalle integer NOT NULL,
    id_compra integer NOT NULL,
    id_mat integer,
    cantidad numeric(10,2) NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);


ALTER TABLE public.detalle_compras OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17633)
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_compras_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_compras_id_detalle_seq OWNER TO postgres;

--
-- TOC entry 4815 (class 0 OID 0)
-- Dependencies: 297
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_compras_id_detalle_seq OWNED BY public.detalle_compras.id_detalle;


--
-- TOC entry 298 (class 1259 OID 17634)
-- Name: detalle_cosecha; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_cosecha (
    id_detalle integer NOT NULL,
    id_trab integer NOT NULL,
    fecha date NOT NULL,
    cantidad_sacos integer DEFAULT 0 NOT NULL,
    observacion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_cosecha OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17641)
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_cosecha_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_cosecha_id_detalle_seq OWNER TO postgres;

--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 299
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_cosecha_id_detalle_seq OWNED BY public.detalle_cosecha.id_detalle;


--
-- TOC entry 300 (class 1259 OID 17642)
-- Name: gasolina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gasolina (
    id_gasolina integer NOT NULL,
    fecha date DEFAULT CURRENT_DATE NOT NULL,
    tipo_uso character varying(30) NOT NULL,
    vehiculo character varying(50),
    maquina_fumigacion character varying(50),
    litros numeric(6,2),
    parcela character varying(50),
    responsable character varying(100),
    id_trab integer,
    observacion character varying(300),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.gasolina OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17649)
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gasolina_id_gasolina_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gasolina_id_gasolina_seq OWNER TO postgres;

--
-- TOC entry 4821 (class 0 OID 0)
-- Dependencies: 301
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gasolina_id_gasolina_seq OWNED BY public.gasolina.id_gasolina;


--
-- TOC entry 302 (class 1259 OID 17650)
-- Name: gestion_cultivos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gestion_cultivos (
    id_gestion integer NOT NULL,
    id_ciclo integer NOT NULL,
    id_hect integer NOT NULL,
    id_cosecha integer,
    id_calidad integer,
    anio_cosecha integer NOT NULL,
    temporada character varying(20),
    gastos_totales numeric(12,2) DEFAULT 0,
    ingresos_totales numeric(12,2) DEFAULT 0,
    rentabilidad numeric(8,2),
    CONSTRAINT gestion_cultivos_temporada_check CHECK (((temporada)::text = ANY (ARRAY[('Lluviosa'::character varying)::text, ('Secas'::character varying)::text, ('Invierno'::character varying)::text, ('Verano'::character varying)::text])))
);


ALTER TABLE public.gestion_cultivos OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17656)
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gestion_cultivos_id_gestion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gestion_cultivos_id_gestion_seq OWNER TO postgres;

--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 303
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gestion_cultivos_id_gestion_seq OWNED BY public.gestion_cultivos.id_gestion;


--
-- TOC entry 304 (class 1259 OID 17657)
-- Name: hectareas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hectareas (
    id_hect integer NOT NULL,
    ubi_hect character varying(100),
    tam_hect numeric(8,2),
    variedad_arroz character varying(50) NOT NULL,
    activo boolean DEFAULT true,
    CONSTRAINT hectareas_tam_hect_check CHECK ((tam_hect > (0)::numeric))
);


ALTER TABLE public.hectareas OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17662)
-- Name: hectareas_id_hect_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hectareas_id_hect_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hectareas_id_hect_seq OWNER TO postgres;

--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 305
-- Name: hectareas_id_hect_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hectareas_id_hect_seq OWNED BY public.hectareas.id_hect;


--
-- TOC entry 306 (class 1259 OID 17663)
-- Name: incidencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incidencia (
    id_inc integer NOT NULL,
    id_trab integer,
    fecha date,
    tipo character varying(60),
    descripcion text,
    estado character varying(30) DEFAULT 'PENDIENTE'::character varying
);


ALTER TABLE public.incidencia OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 17669)
-- Name: incidencia_id_inc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incidencia_id_inc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.incidencia_id_inc_seq OWNER TO postgres;

--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 307
-- Name: incidencia_id_inc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.incidencia_id_inc_seq OWNED BY public.incidencia.id_inc;


--
-- TOC entry 308 (class 1259 OID 17670)
-- Name: logs_sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs_sistema (
    id_log integer NOT NULL,
    tabla character varying(100) NOT NULL,
    accion character varying(20) NOT NULL,
    registro_id integer,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    id_usuario integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT logs_sistema_accion_check CHECK (((accion)::text = ANY (ARRAY[('INSERT'::character varying)::text, ('UPDATE'::character varying)::text, ('DELETE'::character varying)::text])))
);


ALTER TABLE public.logs_sistema OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 17677)
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_sistema_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_sistema_id_log_seq OWNER TO postgres;

--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 309
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_sistema_id_log_seq OWNED BY public.logs_sistema.id_log;


--
-- TOC entry 310 (class 1259 OID 17678)
-- Name: maquinaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maquinaria (
    id_maq integer NOT NULL,
    nom_maq character varying(50) NOT NULL,
    tipo_maq character varying(50) NOT NULL,
    costo_alquiler_hora numeric(10,2),
    activo boolean DEFAULT true,
    CONSTRAINT maquinaria_costo_alquiler_hora_check CHECK ((costo_alquiler_hora >= (0)::numeric))
);


ALTER TABLE public.maquinaria OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 17683)
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maquinaria_id_maq_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maquinaria_id_maq_seq OWNER TO postgres;

--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 311
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maquinaria_id_maq_seq OWNED BY public.maquinaria.id_maq;


--
-- TOC entry 312 (class 1259 OID 17684)
-- Name: materiales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materiales (
    id_mat integer NOT NULL,
    nom_mat character varying(50) NOT NULL,
    tipo_mat character varying(30),
    stock_actual numeric(10,2) DEFAULT 0,
    stock_minimo numeric(10,2) DEFAULT 0,
    unidad_medida character varying(10),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_stock_positivo CHECK ((stock_actual >= (0)::numeric)),
    CONSTRAINT materiales_stock_actual_check CHECK ((stock_actual >= (0)::numeric))
);


ALTER TABLE public.materiales OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 17694)
-- Name: materiales_id_mat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materiales_id_mat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materiales_id_mat_seq OWNER TO postgres;

--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 313
-- Name: materiales_id_mat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materiales_id_mat_seq OWNED BY public.materiales.id_mat;


--
-- TOC entry 314 (class 1259 OID 17695)
-- Name: monitoreo_plagas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monitoreo_plagas (
    id_monitoreo integer NOT NULL,
    id_ciclo integer NOT NULL,
    id_plaga integer NOT NULL,
    fecha_deteccion date DEFAULT CURRENT_DATE NOT NULL,
    nivel_infestacion character varying(20),
    accion_tomada text,
    costo_control numeric(10,2),
    CONSTRAINT monitoreo_plagas_nivel_infestacion_check CHECK (((nivel_infestacion)::text = ANY (ARRAY[('Bajo'::character varying)::text, ('Medio'::character varying)::text, ('Alto'::character varying)::text, ('Crítico'::character varying)::text])))
);


ALTER TABLE public.monitoreo_plagas OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 17702)
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monitoreo_plagas_id_monitoreo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.monitoreo_plagas_id_monitoreo_seq OWNER TO postgres;

--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 315
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monitoreo_plagas_id_monitoreo_seq OWNED BY public.monitoreo_plagas.id_monitoreo;


--
-- TOC entry 316 (class 1259 OID 17703)
-- Name: movimientos_caja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimientos_caja (
    id_mov integer NOT NULL,
    fec_mov date DEFAULT CURRENT_DATE NOT NULL,
    hora_mov time without time zone DEFAULT CURRENT_TIME NOT NULL,
    tipo_mov character varying(10) NOT NULL,
    categoria character varying(50) NOT NULL,
    monto numeric(12,2) NOT NULL,
    id_trab integer,
    id_cosecha integer,
    comprobante_url text,
    descripcion text,
    CONSTRAINT movimientos_caja_monto_check CHECK ((monto > (0)::numeric)),
    CONSTRAINT movimientos_caja_tipo_mov_check CHECK (((tipo_mov)::text = ANY (ARRAY[('Ingreso'::character varying)::text, ('Egreso'::character varying)::text])))
);


ALTER TABLE public.movimientos_caja OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 17712)
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_caja_id_mov_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movimientos_caja_id_mov_seq OWNER TO postgres;

--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 317
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_caja_id_mov_seq OWNED BY public.movimientos_caja.id_mov;


--
-- TOC entry 318 (class 1259 OID 17713)
-- Name: movimientos_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimientos_material (
    id_movimiento integer NOT NULL,
    id_material integer NOT NULL,
    tipo_movimiento character varying(20) NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    stock_anterior numeric(10,2),
    stock_nuevo numeric(10,2),
    observacion text,
    fecha_movimiento timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_usuario integer,
    CONSTRAINT movimientos_material_tipo_movimiento_check CHECK (((tipo_movimiento)::text = ANY (ARRAY[('ENTRADA'::character varying)::text, ('SALIDA'::character varying)::text, ('AJUSTE'::character varying)::text])))
);


ALTER TABLE public.movimientos_material OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 17720)
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_material_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movimientos_material_id_movimiento_seq OWNER TO postgres;

--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 319
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_material_id_movimiento_seq OWNED BY public.movimientos_material.id_movimiento;


--
-- TOC entry 320 (class 1259 OID 17721)
-- Name: plagas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plagas (
    id_plaga integer NOT NULL,
    nombre_cientifico character varying(100),
    nombre_comun character varying(60) NOT NULL,
    tipo character varying(20),
    CONSTRAINT plagas_tipo_check CHECK (((tipo)::text = ANY (ARRAY[('Plaga'::character varying)::text, ('Enfermedad'::character varying)::text, ('Maleza'::character varying)::text])))
);


ALTER TABLE public.plagas OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 17725)
-- Name: plagas_id_plaga_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plagas_id_plaga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plagas_id_plaga_seq OWNER TO postgres;

--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 321
-- Name: plagas_id_plaga_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plagas_id_plaga_seq OWNED BY public.plagas.id_plaga;


--
-- TOC entry 322 (class 1259 OID 17726)
-- Name: planilla_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planilla_pago (
    id_planilla integer NOT NULL,
    id_trab integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    total_sacos integer DEFAULT 0,
    total_dias integer DEFAULT 0,
    monto_total numeric(10,2),
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    observacion text,
    fecha_generacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_tareas integer DEFAULT 0,
    tipo_tarea_planilla character varying(20),
    CONSTRAINT planilla_pago_estado_check CHECK (((estado)::text = ANY (ARRAY[('pendiente'::character varying)::text, ('pagado'::character varying)::text, ('anulado'::character varying)::text])))
);


ALTER TABLE public.planilla_pago OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 17737)
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planilla_pago_id_planilla_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.planilla_pago_id_planilla_seq OWNER TO postgres;

--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 323
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planilla_pago_id_planilla_seq OWNED BY public.planilla_pago.id_planilla;


--
-- TOC entry 324 (class 1259 OID 17738)
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    ruc character(11),
    razon_social character varying(100) NOT NULL,
    telefono character varying(15),
    email character varying(100),
    direccion text
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 17743)
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNER TO postgres;

--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 325
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;


--
-- TOC entry 326 (class 1259 OID 17744)
-- Name: regadio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regadio (
    id_reg integer NOT NULL,
    id_hect integer NOT NULL,
    fec_reg date DEFAULT CURRENT_DATE NOT NULL,
    hora_inicio time without time zone,
    hora_fin time without time zone,
    cantidad_agua_m3 numeric(10,2),
    id_responsable integer,
    id_trab_regador integer,
    observacion character varying(300),
    estado_riego character varying(20) DEFAULT 'completado'::character varying,
    CONSTRAINT hora_valida CHECK ((hora_fin > hora_inicio)),
    CONSTRAINT regadio_cantidad_agua_m3_check CHECK ((cantidad_agua_m3 >= (0)::numeric)),
    CONSTRAINT regadio_estado_riego_check CHECK (((estado_riego)::text = ANY (ARRAY[('completado'::character varying)::text, ('parcial'::character varying)::text, ('cancelado'::character varying)::text])))
);


ALTER TABLE public.regadio OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 17752)
-- Name: regadio_id_reg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.regadio_id_reg_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regadio_id_reg_seq OWNER TO postgres;

--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 327
-- Name: regadio_id_reg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.regadio_id_reg_seq OWNED BY public.regadio.id_reg;


--
-- TOC entry 328 (class 1259 OID 17753)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_permisos (
    id_rol integer NOT NULL,
    nombre_rol character varying(30) NOT NULL,
    descripcion text,
    nivel_acceso integer DEFAULT 1
);


ALTER TABLE public.roles_permisos OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 17759)
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_permisos_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_permisos_id_rol_seq OWNER TO postgres;

--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 329
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_permisos_id_rol_seq OWNED BY public.roles_permisos.id_rol;


--
-- TOC entry 330 (class 1259 OID 17760)
-- Name: tipo_cosecha; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_cosecha (
    id_tipo_cosecha integer NOT NULL,
    nombre_tipo character varying(30) NOT NULL,
    descripcion text,
    rendimiento_esperado_kg_ha numeric(10,2),
    orden_ciclo integer
);


ALTER TABLE public.tipo_cosecha OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 17765)
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq OWNER TO postgres;

--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 331
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq OWNED BY public.tipo_cosecha.id_tipo_cosecha;


--
-- TOC entry 332 (class 1259 OID 17766)
-- Name: trabajadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trabajadores (
    id_trab integer NOT NULL,
    nom_trab character varying(50) NOT NULL,
    ape_trab character varying(50) NOT NULL,
    dni_trab character(8) NOT NULL,
    id_cargo integer NOT NULL,
    tipo_pago character varying(12) DEFAULT 'tiempo'::character varying,
    sueldo_base_dia numeric(10,2),
    pago_por_saco numeric(10,2),
    fecha_contrato date DEFAULT CURRENT_DATE,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    pago_por_tarea numeric(10,2),
    CONSTRAINT chk_dni_length CHECK ((length(dni_trab) = 8)),
    CONSTRAINT trabajadores_pago_por_saco_check CHECK ((pago_por_saco >= (0)::numeric)),
    CONSTRAINT trabajadores_pago_por_tarea_check CHECK ((pago_por_tarea >= (0)::numeric)),
    CONSTRAINT trabajadores_sueldo_base_dia_check CHECK ((sueldo_base_dia >= (0)::numeric)),
    CONSTRAINT trabajadores_tipo_pago_check CHECK (((tipo_pago)::text = ANY (ARRAY[('tiempo'::character varying)::text, ('rendimiento'::character varying)::text, ('jornal'::character varying)::text, ('por_saco'::character varying)::text, ('destajo'::character varying)::text, ('transplante'::character varying)::text, ('saca'::character varying)::text, ('carga'::character varying)::text, ('riego'::character varying)::text])))
);


ALTER TABLE public.trabajadores OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 17779)
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trabajadores_id_trab_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trabajadores_id_trab_seq OWNER TO postgres;

--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 333
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trabajadores_id_trab_seq OWNED BY public.trabajadores.id_trab;


--
-- TOC entry 334 (class 1259 OID 17780)
-- Name: uso_materiales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uso_materiales (
    id_uso integer NOT NULL,
    id_mat integer NOT NULL,
    id_hect integer NOT NULL,
    fec_uso date DEFAULT CURRENT_DATE NOT NULL,
    hora_uso time without time zone DEFAULT CURRENT_TIME,
    cantidad numeric(10,2),
    detalle_uso text,
    CONSTRAINT uso_materiales_cantidad_check CHECK ((cantidad > (0)::numeric))
);


ALTER TABLE public.uso_materiales OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 17786)
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uso_materiales_id_uso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.uso_materiales_id_uso_seq OWNER TO postgres;

--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 335
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uso_materiales_id_uso_seq OWNED BY public.uso_materiales.id_uso;


--
-- TOC entry 336 (class 1259 OID 17787)
-- Name: usuario_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_roles (
    id_usuario_rol integer NOT NULL,
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    fecha_asignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuario_roles OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 17791)
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_roles_id_usuario_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_roles_id_usuario_rol_seq OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 337
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_roles_id_usuario_rol_seq OWNED BY public.usuario_roles.id_usuario_rol;


--
-- TOC entry 338 (class 1259 OID 17792)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    id_trab integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    contrasena_hash character varying(255) NOT NULL,
    email character varying(100),
    ultimo_login timestamp without time zone,
    intentos_fallidos integer DEFAULT 0,
    bloqueado boolean DEFAULT false,
    activo boolean DEFAULT true,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rol character varying(20) DEFAULT 'TRABAJADOR'::character varying
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 17802)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 339
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 340 (class 1259 OID 17803)
-- Name: vista_alerta_stock; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_alerta_stock AS
 SELECT nom_mat,
    stock_actual,
    stock_minimo,
    unidad_medida,
        CASE
            WHEN (stock_actual <= stock_minimo) THEN 'CRÍTICO - Comprar urgente'::text
            WHEN (stock_actual <= (stock_minimo * 1.5)) THEN 'BAJO - Revisar stock'::text
            ELSE 'NORMAL'::text
        END AS estado_stock
   FROM public.materiales
  WHERE (activo = true)
  ORDER BY (stock_actual / NULLIF(stock_minimo, (0)::numeric));


ALTER VIEW public.vista_alerta_stock OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 17807)
-- Name: vista_ciclos_activos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_ciclos_activos AS
 SELECT cc.id_ciclo,
    cc.nombre_ciclo,
    h.ubi_hect,
    h.variedad_arroz,
    cc.fecha_siembra,
    cc.fecha_cosecha_estimada,
    cc.estado,
    cc.rendimiento_real_kg_ha
   FROM (public.ciclos_cultivo cc
     JOIN public.hectareas h ON ((cc.id_hect = h.id_hect)))
  WHERE ((cc.estado)::text <> ALL (ARRAY[('Barbecho'::character varying)::text, ('Cosechado'::character varying)::text]));


ALTER VIEW public.vista_ciclos_activos OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 17812)
-- Name: vista_pagos_trabajadores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_pagos_trabajadores AS
 SELECT t.id_trab,
    t.nom_trab,
    t.ape_trab,
    t.tipo_pago,
    a.fec_asist,
    a.sacos_cosechados,
    a.tipo_tarea,
    a.tareas_completadas,
        CASE
            WHEN (((t.tipo_pago)::text = ANY (ARRAY[('tiempo'::character varying)::text, ('jornal'::character varying)::text])) AND (a.presente = true)) THEN COALESCE(t.sueldo_base_dia, (0)::numeric)
            WHEN ((t.tipo_pago)::text = ANY (ARRAY[('rendimiento'::character varying)::text, ('por_saco'::character varying)::text, ('destajo'::character varying)::text])) THEN ((a.sacos_cosechados)::numeric * COALESCE(t.pago_por_saco, (0)::numeric))
            WHEN ((t.tipo_pago)::text = ANY (ARRAY[('transplante'::character varying)::text, ('saca'::character varying)::text, ('carga'::character varying)::text, ('riego'::character varying)::text])) THEN ((a.tareas_completadas)::numeric * COALESCE(t.pago_por_tarea, (0)::numeric))
            ELSE (0)::numeric
        END AS monto_a_pagar
   FROM (public.trabajadores t
     JOIN public.asistencia a ON ((t.id_trab = a.id_trab)))
  WHERE (t.activo = true);


ALTER VIEW public.vista_pagos_trabajadores OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 17817)
-- Name: vista_reporte_riego; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_reporte_riego AS
 SELECT r.id_reg,
    r.fec_reg,
    h.ubi_hect AS parcela,
    h.variedad_arroz,
    r.hora_inicio,
    r.hora_fin,
    r.cantidad_agua_m3,
    r.estado_riego,
    r.observacion,
    concat(tr.nom_trab, ' ', tr.ape_trab) AS responsable,
    concat(tw.nom_trab, ' ', tw.ape_trab) AS trabajador_regador,
    tw.tipo_pago AS tipo_pago_regador,
    tw.pago_por_tarea AS tarifa_riego
   FROM (((public.regadio r
     JOIN public.hectareas h ON ((r.id_hect = h.id_hect)))
     LEFT JOIN public.trabajadores tr ON ((r.id_responsable = tr.id_trab)))
     LEFT JOIN public.trabajadores tw ON ((r.id_trab_regador = tw.id_trab)))
  ORDER BY r.fec_reg DESC;


ALTER VIEW public.vista_reporte_riego OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 17822)
-- Name: vista_resumen_cosechas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_resumen_cosechas AS
 SELECT c.id_cosecha,
    h.ubi_hect,
    h.variedad_arroz,
    tc.nombre_tipo AS tipo_cosecha,
    c.fec_cosecha,
    c.cantidad_sacos,
    c.calidad_arroz
   FROM ((public.cosechas c
     JOIN public.hectareas h ON ((c.id_hect = h.id_hect)))
     JOIN public.tipo_cosecha tc ON ((c.id_tipo_cosecha = tc.id_tipo_cosecha)))
  WHERE (h.activo = true);


ALTER VIEW public.vista_resumen_cosechas OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 17827)
-- Name: vista_resumen_financiero; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_resumen_financiero AS
 SELECT date_trunc('month'::text, (fec_mov)::timestamp with time zone) AS mes,
    tipo_mov,
    count(*) AS cantidad_movimientos,
    sum(monto) AS total_mes
   FROM public.movimientos_caja
  WHERE (fec_mov >= date_trunc('year'::text, (CURRENT_DATE)::timestamp with time zone))
  GROUP BY (date_trunc('month'::text, (fec_mov)::timestamp with time zone)), tipo_mov
  ORDER BY (date_trunc('month'::text, (fec_mov)::timestamp with time zone)) DESC, tipo_mov;


ALTER VIEW public.vista_resumen_financiero OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 17831)
-- Name: vista_resumen_tareas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_resumen_tareas AS
 SELECT a.tipo_tarea,
    a.fec_asist,
    t.nom_trab,
    t.ape_trab,
    t.tipo_pago,
    a.tareas_completadas,
    ((a.tareas_completadas)::numeric * COALESCE(t.pago_por_tarea, (0)::numeric)) AS monto_tarea,
    a.observacion_supervisor
   FROM (public.asistencia a
     JOIN public.trabajadores t ON ((a.id_trab = t.id_trab)))
  WHERE (a.tipo_tarea IS NOT NULL)
  ORDER BY a.fec_asist DESC, a.tipo_tarea;


ALTER VIEW public.vista_resumen_tareas OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 17836)
-- Name: vw_login; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_login AS
 SELECT u.nombre_usuario,
    u.contrasena_hash,
    u.activo,
    u.bloqueado,
    t.nom_trab,
    t.ape_trab,
    c.nom_cargo,
    rp.nombre_rol
   FROM ((((public.usuarios u
     JOIN public.trabajadores t ON ((u.id_trab = t.id_trab)))
     JOIN public.cargos c ON ((t.id_cargo = c.id_cargo)))
     LEFT JOIN public.usuario_roles ur ON ((u.id_usuario = ur.id_usuario)))
     LEFT JOIN public.roles_permisos rp ON ((ur.id_rol = rp.id_rol)))
  WHERE (u.activo = true);


ALTER VIEW public.vw_login OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17523)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 265 (class 1259 OID 17170)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 268 (class 1259 OID 17193)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 267 (class 1259 OID 17192)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 270 (class 1259 OID 17215)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 270
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 274 (class 1259 OID 17334)
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- TOC entry 275 (class 1259 OID 17347)
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- TOC entry 269 (class 1259 OID 17207)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 271 (class 1259 OID 17225)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 271
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 272 (class 1259 OID 17274)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 273 (class 1259 OID 17288)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 276 (class 1259 OID 17357)
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- TOC entry 3792 (class 2604 OID 16514)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3869 (class 2604 OID 17841)
-- Name: abono id_abono; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abono ALTER COLUMN id_abono SET DEFAULT nextval('public.abono_id_abono_seq'::regclass);


--
-- TOC entry 3873 (class 2604 OID 17842)
-- Name: asistencia id_asist; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistencia ALTER COLUMN id_asist SET DEFAULT nextval('public.asistencia_id_asist_seq'::regclass);


--
-- TOC entry 3880 (class 2604 OID 17843)
-- Name: cargos id_cargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos ALTER COLUMN id_cargo SET DEFAULT nextval('public.cargos_id_cargo_seq'::regclass);


--
-- TOC entry 3883 (class 2604 OID 17844)
-- Name: ciclos_cultivo id_ciclo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciclos_cultivo ALTER COLUMN id_ciclo SET DEFAULT nextval('public.ciclos_cultivo_id_ciclo_seq'::regclass);


--
-- TOC entry 3885 (class 2604 OID 17845)
-- Name: compras id_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras ALTER COLUMN id_compra SET DEFAULT nextval('public.compras_id_compra_seq'::regclass);


--
-- TOC entry 3887 (class 2604 OID 17846)
-- Name: compras_material id_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras_material ALTER COLUMN id_compra SET DEFAULT nextval('public.compras_material_id_compra_seq'::regclass);


--
-- TOC entry 3891 (class 2604 OID 17847)
-- Name: control_calidad id_calidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad ALTER COLUMN id_calidad SET DEFAULT nextval('public.control_calidad_id_calidad_seq'::regclass);


--
-- TOC entry 3893 (class 2604 OID 17848)
-- Name: cosechas id_cosecha; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cosechas ALTER COLUMN id_cosecha SET DEFAULT nextval('public.cosechas_id_cosecha_seq'::regclass);


--
-- TOC entry 3894 (class 2604 OID 17849)
-- Name: detalle_compras id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compras ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_compras_id_detalle_seq'::regclass);


--
-- TOC entry 3895 (class 2604 OID 17850)
-- Name: detalle_cosecha id_detalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cosecha ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_cosecha_id_detalle_seq'::regclass);


--
-- TOC entry 3898 (class 2604 OID 17851)
-- Name: gasolina id_gasolina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasolina ALTER COLUMN id_gasolina SET DEFAULT nextval('public.gasolina_id_gasolina_seq'::regclass);


--
-- TOC entry 3901 (class 2604 OID 17852)
-- Name: gestion_cultivos id_gestion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos ALTER COLUMN id_gestion SET DEFAULT nextval('public.gestion_cultivos_id_gestion_seq'::regclass);


--
-- TOC entry 3904 (class 2604 OID 17853)
-- Name: hectareas id_hect; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hectareas ALTER COLUMN id_hect SET DEFAULT nextval('public.hectareas_id_hect_seq'::regclass);


--
-- TOC entry 3906 (class 2604 OID 17854)
-- Name: incidencia id_inc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia ALTER COLUMN id_inc SET DEFAULT nextval('public.incidencia_id_inc_seq'::regclass);


--
-- TOC entry 3908 (class 2604 OID 17855)
-- Name: logs_sistema id_log; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_sistema ALTER COLUMN id_log SET DEFAULT nextval('public.logs_sistema_id_log_seq'::regclass);


--
-- TOC entry 3910 (class 2604 OID 17856)
-- Name: maquinaria id_maq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maquinaria ALTER COLUMN id_maq SET DEFAULT nextval('public.maquinaria_id_maq_seq'::regclass);


--
-- TOC entry 3912 (class 2604 OID 17857)
-- Name: materiales id_mat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiales ALTER COLUMN id_mat SET DEFAULT nextval('public.materiales_id_mat_seq'::regclass);


--
-- TOC entry 3918 (class 2604 OID 17858)
-- Name: monitoreo_plagas id_monitoreo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoreo_plagas ALTER COLUMN id_monitoreo SET DEFAULT nextval('public.monitoreo_plagas_id_monitoreo_seq'::regclass);


--
-- TOC entry 3920 (class 2604 OID 17859)
-- Name: movimientos_caja id_mov; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_caja ALTER COLUMN id_mov SET DEFAULT nextval('public.movimientos_caja_id_mov_seq'::regclass);


--
-- TOC entry 3923 (class 2604 OID 17860)
-- Name: movimientos_material id_movimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_material ALTER COLUMN id_movimiento SET DEFAULT nextval('public.movimientos_material_id_movimiento_seq'::regclass);


--
-- TOC entry 3925 (class 2604 OID 17861)
-- Name: plagas id_plaga; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plagas ALTER COLUMN id_plaga SET DEFAULT nextval('public.plagas_id_plaga_seq'::regclass);


--
-- TOC entry 3926 (class 2604 OID 17862)
-- Name: planilla_pago id_planilla; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planilla_pago ALTER COLUMN id_planilla SET DEFAULT nextval('public.planilla_pago_id_planilla_seq'::regclass);


--
-- TOC entry 3932 (class 2604 OID 17863)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 3933 (class 2604 OID 17864)
-- Name: regadio id_reg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regadio ALTER COLUMN id_reg SET DEFAULT nextval('public.regadio_id_reg_seq'::regclass);


--
-- TOC entry 3936 (class 2604 OID 17865)
-- Name: roles_permisos id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_permisos_id_rol_seq'::regclass);


--
-- TOC entry 3938 (class 2604 OID 17866)
-- Name: tipo_cosecha id_tipo_cosecha; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cosecha ALTER COLUMN id_tipo_cosecha SET DEFAULT nextval('public.tipo_cosecha_id_tipo_cosecha_seq'::regclass);


--
-- TOC entry 3939 (class 2604 OID 17867)
-- Name: trabajadores id_trab; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores ALTER COLUMN id_trab SET DEFAULT nextval('public.trabajadores_id_trab_seq'::regclass);


--
-- TOC entry 3945 (class 2604 OID 17868)
-- Name: uso_materiales id_uso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uso_materiales ALTER COLUMN id_uso SET DEFAULT nextval('public.uso_materiales_id_uso_seq'::regclass);


--
-- TOC entry 3948 (class 2604 OID 17869)
-- Name: usuario_roles id_usuario_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_roles ALTER COLUMN id_usuario_rol SET DEFAULT nextval('public.usuario_roles_id_usuario_rol_seq'::regclass);


--
-- TOC entry 3950 (class 2604 OID 17870)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 4545 (class 0 OID 16529)
-- Dependencies: 243
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- TOC entry 4562 (class 0 OID 17084)
-- Dependencies: 262
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4556 (class 0 OID 16889)
-- Dependencies: 256
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- TOC entry 4547 (class 0 OID 16686)
-- Dependencies: 247
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- TOC entry 4544 (class 0 OID 16522)
-- Dependencies: 242
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4551 (class 0 OID 16776)
-- Dependencies: 251
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- TOC entry 4550 (class 0 OID 16764)
-- Dependencies: 250
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4549 (class 0 OID 16751)
-- Dependencies: 249
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- TOC entry 4559 (class 0 OID 17001)
-- Dependencies: 259
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- TOC entry 4561 (class 0 OID 17074)
-- Dependencies: 261
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- TOC entry 4558 (class 0 OID 16971)
-- Dependencies: 258
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- TOC entry 4560 (class 0 OID 17034)
-- Dependencies: 260
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- TOC entry 4557 (class 0 OID 16939)
-- Dependencies: 257
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4543 (class 0 OID 16511)
-- Dependencies: 241
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- TOC entry 4554 (class 0 OID 16818)
-- Dependencies: 254
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4555 (class 0 OID 16836)
-- Dependencies: 255
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4546 (class 0 OID 16537)
-- Dependencies: 244
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- TOC entry 4548 (class 0 OID 16716)
-- Dependencies: 248
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- TOC entry 4553 (class 0 OID 16803)
-- Dependencies: 253
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4552 (class 0 OID 16794)
-- Dependencies: 252
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- TOC entry 4541 (class 0 OID 16499)
-- Dependencies: 239
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- TOC entry 4564 (class 0 OID 17149)
-- Dependencies: 264
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- TOC entry 4563 (class 0 OID 17126)
-- Dependencies: 263
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- TOC entry 4576 (class 0 OID 17561)
-- Dependencies: 280
-- Data for Name: abono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.abono (id_abono, id_trab, fecha, tipo_saco, cantidad_sacos, parcela, observacion, created_at) FROM stdin;
\.


--
-- TOC entry 4578 (class 0 OID 17570)
-- Dependencies: 282
-- Data for Name: asistencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asistencia (id_asist, id_trab, fec_asist, hora_entrada, hora_salida, presente, sacos_cosechados, created_at, updated_at, observacion, tipo_tarea, tareas_completadas, observacion_supervisor, estado_aprobacion) FROM stdin;
3	6	2026-05-25	15:00:00	16:00:00	t	11	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	\N	\N	0	\N	PENDIENTE
4	5	2026-05-14	06:00:00	02:00:00	t	3	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	\N	\N	0	\N	PENDIENTE
6	25	2026-05-26	09:30:00	12:30:00	t	0	2026-05-26 03:41:44.25085	2026-05-26 03:41:44.25085	\N	RIEGO	1	no lleno el 4 cajon	PENDIENTE
7	25	2026-05-28	14:05:00	23:37:00	t	0	2026-05-28 14:36:08.62982	2026-05-28 14:36:08.62982	\N	RIEGO	1		PENDIENTE
10	25	2026-05-29	14:37:00	20:42:00	t	0	2026-05-28 14:37:17.707479	2026-05-28 14:37:17.707479	\N	RIEGO	1	asd	PENDIENTE
11	26	2026-06-03	\N	\N	t	0	2026-06-02 20:37:34.26605	2026-06-02 20:37:34.26605	\N	TRANSPLANTE	1	Lote A – Zona Norte	PENDIENTE
12	25	2026-06-03	\N	\N	t	0	2026-06-02 20:43:25.537512	2026-06-02 20:43:25.537512	\N	CARGA	1	Lote A – Zona Norte	PENDIENTE
14	28	2026-06-03	\N	\N	t	0	2026-06-02 22:50:31.375961	2026-06-02 22:50:31.375961	\N	SACA	1	Lote A – Zona Norte	PENDIENTE
15	26	2026-06-04	\N	\N	t	0	2026-06-03 19:35:43.225359	2026-06-03 20:11:24.320023	\N	TRANSPLANTE	1	Lote A – Zona Norte	APROBADO
16	25	2026-06-04	\N	\N	t	0	2026-06-03 20:12:07.232895	2026-06-04 04:07:34.221367	\N	CARGA	1	Lote A – Zona Norte	APROBADO
17	32	2026-06-04	\N	\N	t	0	2026-06-04 03:55:55.270353	2026-06-04 04:07:36.58968	\N	CARGA	3	Lote A – Zona Norte — se demoro\n	APROBADO
23	32	2026-06-05	\N	\N	t	0	2026-06-04 19:14:27.031732	2026-06-04 19:14:27.031732	\N	CARGA	1	Lote A – Zona Norte — asd	PENDIENTE
24	29	2026-06-04	05:00:00	14:00:00	t	0	2026-06-04 19:16:55.261432	2026-06-04 19:16:55.261432	\N	RIEGO	1		PENDIENTE
26	32	2026-06-06	\N	\N	t	0	2026-06-06 03:42:27.983839	2026-06-06 03:42:34.418844	\N	CARGA	1	Lote A – Zona Norte	APROBADO
27	34	2026-06-06	\N	\N	t	0	2026-06-06 03:59:51.010995	2026-06-06 04:00:02.920018	\N	SACA	1	Lote A – Zona Norte	APROBADO
28	31	2026-06-06	05:00:00	15:00:00	t	0	2026-06-06 04:01:15.065509	2026-06-06 04:01:43.905006	\N	RIEGO	1		APROBADO
35	30	2026-06-06	\N	\N	t	20	2026-06-06 04:32:30.0338	2026-06-06 04:32:41.836693	\N	\N	0		APROBADO
37	31	2026-06-20	\N	\N	t	0	2026-06-06 04:33:08.916923	2026-06-06 04:33:08.916923	\N	\N	1		PENDIENTE
40	20	2026-06-06	\N	\N	t	0	2026-06-06 04:48:35.275829	2026-06-06 04:48:39.606876	\N	\N	1		APROBADO
42	30	2026-06-18	\N	\N	t	15	2026-06-06 04:48:48.920372	2026-06-06 04:48:48.920372	\N	\N	0		PENDIENTE
43	30	2026-06-24	\N	\N	t	40	2026-06-06 04:50:31.404352	2026-06-06 04:50:31.404352	\N	\N	0		PENDIENTE
44	6	2026-06-06	\N	\N	t	0	2026-06-06 04:53:30.779571	2026-06-06 04:53:34.449507	\N	\N	1		APROBADO
45	30	2026-06-10	\N	\N	t	25	2026-06-06 04:53:42.88158	2026-06-06 04:53:42.88158	\N	\N	0		PENDIENTE
46	33	2026-06-29	\N	\N	t	0	2026-06-06 05:47:50.818659	2026-06-06 05:47:50.818659	\N	\N	1		PENDIENTE
47	30	2026-06-25	\N	\N	t	23	2026-06-06 05:48:04.234322	2026-06-06 05:48:04.234322	\N	\N	0		PENDIENTE
30	26	2026-06-07	\N	\N	t	0	2026-06-06 04:02:04.446159	2026-06-07 17:24:35.96024	\N	TRANSPLANTE	1	Lote A – Zona Norte	APROBADO
32	34	2026-06-07	\N	\N	t	0	2026-06-06 04:02:18.495179	2026-06-07 17:24:38.124781	\N	TRANSPLANTE	1	Lote A – Zona Norte	APROBADO
48	29	2026-06-07	\N	\N	t	0	2026-06-07 19:39:42.572663	2026-06-07 21:08:12.579102	\N	RIEGO	1	d	APROBADO
49	28	2026-06-08	\N	\N	t	0	2026-06-08 00:08:35.314193	2026-06-08 00:08:35.314193	\N	SACA	1	Lote A – Zona Norte	PENDIENTE
\.


--
-- TOC entry 4580 (class 0 OID 17584)
-- Dependencies: 284
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (id_cargo, nom_cargo, activo, created_at) FROM stdin;
1	Administrador	t	2026-05-26 02:13:45.907169
2	Supervisor	t	2026-05-26 02:13:45.907169
3	Operario	t	2026-05-26 02:13:45.907169
4	Jornalero	t	2026-05-26 02:13:45.907169
\.


--
-- TOC entry 4582 (class 0 OID 17590)
-- Dependencies: 286
-- Data for Name: ciclos_cultivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciclos_cultivo (id_ciclo, id_hect, nombre_ciclo, fecha_siembra, fecha_cosecha_estimada, fecha_cosecha_real, estado, rendimiento_real_kg_ha) FROM stdin;
\.


--
-- TOC entry 4584 (class 0 OID 17596)
-- Dependencies: 288
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compras (id_compra, id_proveedor, fecha_compra, tipo_compra, monto_total, factura_numero) FROM stdin;
\.


--
-- TOC entry 4586 (class 0 OID 17603)
-- Dependencies: 290
-- Data for Name: compras_material; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compras_material (id_compra, id_material, id_proveedor, cantidad, precio_unitario, fecha_compra, observacion, created_at) FROM stdin;
\.


--
-- TOC entry 4588 (class 0 OID 17612)
-- Dependencies: 292
-- Data for Name: control_calidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.control_calidad (id_calidad, id_cosecha, fecha_analisis, porcentaje_granos_enteros, porcentaje_granos_partidos, porcentaje_granos_verdes, porcentaje_impurezas, porcentaje_humedad, grado_comercial, observaciones) FROM stdin;
\.


--
-- TOC entry 4590 (class 0 OID 17620)
-- Dependencies: 294
-- Data for Name: cosechas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cosechas (id_cosecha, id_hect, id_tipo_cosecha, fec_cosecha, hora_inicio, hora_fin, metodo_cosecha, id_maq, cantidad_sacos, peso_total_kg, humedad_porcentaje, calidad_arroz, observaciones) FROM stdin;
\.


--
-- TOC entry 4592 (class 0 OID 17630)
-- Dependencies: 296
-- Data for Name: detalle_compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_compras (id_detalle, id_compra, id_mat, cantidad, precio_unitario) FROM stdin;
\.


--
-- TOC entry 4594 (class 0 OID 17634)
-- Dependencies: 298
-- Data for Name: detalle_cosecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_cosecha (id_detalle, id_trab, fecha, cantidad_sacos, observacion, created_at) FROM stdin;
\.


--
-- TOC entry 4596 (class 0 OID 17642)
-- Dependencies: 300
-- Data for Name: gasolina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gasolina (id_gasolina, fecha, tipo_uso, vehiculo, maquina_fumigacion, litros, parcela, responsable, id_trab, observacion, created_at) FROM stdin;
1	2026-05-29	TRANSPORTE_PERSONAL	Carguera ROJA	\N	2.00	Peralta	Luis Santamaria	\N	Recojo de personal 	2026-05-29 00:07:11.934889
2	2026-05-29	FUMIGACION	C	Mochila Honda	1.00	Paico	juan montalvan	\N	\N	2026-05-29 00:08:19.0211
\.


--
-- TOC entry 4598 (class 0 OID 17650)
-- Dependencies: 302
-- Data for Name: gestion_cultivos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gestion_cultivos (id_gestion, id_ciclo, id_hect, id_cosecha, id_calidad, anio_cosecha, temporada, gastos_totales, ingresos_totales, rentabilidad) FROM stdin;
\.


--
-- TOC entry 4600 (class 0 OID 17657)
-- Dependencies: 304
-- Data for Name: hectareas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hectareas (id_hect, ubi_hect, tam_hect, variedad_arroz, activo) FROM stdin;
1	Lote A - Zona Norte	5.50	IR-43	t
2	Lote B - Zona Sur	3.20	Jabalí	t
3	Lote C - Zona Este	7.00	Amazonas	t
\.


--
-- TOC entry 4602 (class 0 OID 17663)
-- Dependencies: 306
-- Data for Name: incidencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incidencia (id_inc, id_trab, fecha, tipo, descripcion, estado) FROM stdin;
2	25	2026-06-04	FALTA		EN_PROCESO
3	14	2026-06-04	FALTA		RESUELTO
1	25	2026-06-04	FALTA		PENDIENTE
\.


--
-- TOC entry 4604 (class 0 OID 17670)
-- Dependencies: 308
-- Data for Name: logs_sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs_sistema (id_log, tabla, accion, registro_id, datos_anteriores, datos_nuevos, id_usuario, fecha) FROM stdin;
\.


--
-- TOC entry 4606 (class 0 OID 17678)
-- Dependencies: 310
-- Data for Name: maquinaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maquinaria (id_maq, nom_maq, tipo_maq, costo_alquiler_hora, activo) FROM stdin;
1	Tractor John Deere	Tractor	50.00	t
2	Cosechadora New Holland	Cosechadora	80.00	t
3	Rastra de discos	Implemento	30.00	t
\.


--
-- TOC entry 4608 (class 0 OID 17684)
-- Dependencies: 312
-- Data for Name: materiales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.materiales (id_mat, nom_mat, tipo_mat, stock_actual, stock_minimo, unidad_medida, activo, created_at, updated_at) FROM stdin;
2	Fosfato diamónico	Fertilizante	51.00	50.00	kg	t	2026-05-26 02:13:45.907169	2026-06-04 19:28:27.836596
1	Urea	Fertilizante	980.00	100.00	kg	t	2026-05-26 02:13:45.907169	2026-06-04 19:46:57.665441
3	Cloruro de potasio	Fertilizante	802.00	80.00	kg	t	2026-05-26 02:13:45.907169	2026-06-07 19:39:33.475208
4	Glifosato	Herbicida	196.00	20.00	litros	t	2026-05-26 02:13:45.907169	2026-06-08 00:13:06.757456
5	Hoz	Herramienta	5.00	5.00	unidad	t	2026-06-02 22:31:30.834829	2026-06-08 00:56:33.666629
\.


--
-- TOC entry 4610 (class 0 OID 17695)
-- Dependencies: 314
-- Data for Name: monitoreo_plagas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monitoreo_plagas (id_monitoreo, id_ciclo, id_plaga, fecha_deteccion, nivel_infestacion, accion_tomada, costo_control) FROM stdin;
\.


--
-- TOC entry 4612 (class 0 OID 17703)
-- Dependencies: 316
-- Data for Name: movimientos_caja; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimientos_caja (id_mov, fec_mov, hora_mov, tipo_mov, categoria, monto, id_trab, id_cosecha, comprobante_url, descripcion) FROM stdin;
3	2026-06-03	22:10:33.506695	Egreso	General	240.00	\N	\N	\N	Pago planilla 16 · juan montalvan
4	2026-06-03	22:20:24.646693	Egreso	General	240.00	\N	\N	\N	Pago planilla 22 · juan montalvan
5	2026-06-03	22:20:53.296037	Egreso	General	240.00	\N	\N	\N	Pago planilla 23 · juan montalvan
6	2026-06-03	22:23:20.306536	Egreso	General	50.00	\N	\N	\N	Pago planilla 24 · miguel velazques
7	2026-06-04	20:11:46.254812	Egreso	General	50.00	\N	\N	\N	Pago planilla 25 · Rodrigo Diaz
8	2026-06-04	04:01:29.561942	Egreso	General	120.00	\N	\N	\N	Pago planilla 26 · juan montalvan
9	2026-06-04	04:23:28.376365	Egreso	General	240.00	\N	\N	\N	Pago planilla 27 · juan montalvan
10	2026-06-04	19:14:56.13864	Egreso	General	240.00	\N	\N	\N	Pago planilla 28 · Jhordan Valencia
11	2026-06-04	19:17:37.397864	Egreso	General	50.00	\N	\N	\N	Pago planilla 30 · Juan Martinez
12	2026-06-06	00:52:47.180107	Egreso	General	240.00	\N	\N	\N	Pago planilla 33 · Jhordan Valencia
13	2026-06-06	01:11:53.320397	Egreso	General	240.00	\N	\N	\N	Pago planilla 38 · Jhordan Valencia
14	2026-06-06	03:16:57.957876	Egreso	General	100.00	\N	\N	\N	Pago planilla 40 · María López
15	2026-06-06	04:55:08.325134	Egreso	General	350.00	\N	\N	\N	Pago planilla 43 · Diego Cardenas
16	2026-06-06	04:56:25.467611	Egreso	General	100.00	\N	\N	\N	Pago planilla 45 · Mario Gutierrez
17	2026-06-06	05:40:04.765712	Egreso	General	100.00	\N	\N	\N	Pago planilla 39 · Matias Rodriguez
18	2026-06-06	05:48:54.638469	Egreso	General	430.50	\N	\N	\N	Pago planilla 52 · Diego Cardenas
19	2026-06-06	19:21:07.99756	Egreso	General	50.00	\N	\N	\N	Pago planilla 29 · Juan Martinez
20	2026-06-07	20:58:54.010948	Egreso	General	150.00	\N	\N	\N	Pago planilla 49 · miguel velazques
21	2026-06-07	21:04:19.4806	Egreso	General	50.00	\N	\N	\N	Pago planilla 53 · Jose Santamaria
22	2026-06-07	22:47:33.548413	Ingreso	General	400000.00	\N	\N	\N	
\.


--
-- TOC entry 4614 (class 0 OID 17713)
-- Dependencies: 318
-- Data for Name: movimientos_material; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movimientos_material (id_movimiento, id_material, tipo_movimiento, cantidad, stock_anterior, stock_nuevo, observacion, fecha_movimiento, id_usuario) FROM stdin;
1	2	SALIDA	1.00	500.00	499.00	Uso de material (-1)	2026-06-02 22:27:36.569241	\N
2	2	SALIDA	1.00	500.00	499.00	Cambio automático via sistema	2026-06-02 22:27:36.566515	\N
3	2	SALIDA	390.00	499.00	109.00	Uso de material (-390)	2026-06-02 22:27:45.645014	\N
4	2	SALIDA	390.00	499.00	109.00	Cambio automático via sistema	2026-06-02 22:27:45.644162	\N
5	2	SALIDA	100.00	109.00	9.00	Uso de material (-100)	2026-06-02 22:27:50.347215	\N
6	2	SALIDA	100.00	109.00	9.00	Cambio automático via sistema	2026-06-02 22:27:50.347555	\N
7	2	ENTRADA	1.00	9.00	10.00	Ingreso de material (+1)	2026-06-02 22:28:39.727121	\N
8	2	ENTRADA	1.00	9.00	10.00	Cambio automático via sistema	2026-06-02 22:28:39.726679	\N
9	2	ENTRADA	1.00	10.00	11.00	Ingreso de material (+1)	2026-06-02 22:28:40.232029	\N
10	2	ENTRADA	1.00	10.00	11.00	Cambio automático via sistema	2026-06-02 22:28:40.232281	\N
11	2	ENTRADA	1.00	11.00	12.00	Ingreso de material (+1)	2026-06-02 22:28:40.387433	\N
12	2	ENTRADA	1.00	11.00	12.00	Cambio automático via sistema	2026-06-02 22:28:40.386995	\N
13	2	ENTRADA	1.00	12.00	13.00	Ingreso de material (+1)	2026-06-02 22:28:40.547328	\N
14	2	ENTRADA	1.00	12.00	13.00	Cambio automático via sistema	2026-06-02 22:28:40.54743	\N
15	2	ENTRADA	1.00	13.00	14.00	Ingreso de material (+1)	2026-06-02 22:28:40.689486	\N
16	2	ENTRADA	1.00	13.00	14.00	Cambio automático via sistema	2026-06-02 22:28:40.689688	\N
17	2	ENTRADA	1.00	14.00	15.00	Ingreso de material (+1)	2026-06-02 22:28:40.84756	\N
18	2	ENTRADA	1.00	14.00	15.00	Cambio automático via sistema	2026-06-02 22:28:40.846894	\N
19	2	ENTRADA	1.00	15.00	16.00	Ingreso de material (+1)	2026-06-02 22:28:41.003139	\N
20	2	ENTRADA	1.00	15.00	16.00	Cambio automático via sistema	2026-06-02 22:28:41.002433	\N
21	2	ENTRADA	1.00	16.00	17.00	Ingreso de material (+1)	2026-06-02 22:28:41.163536	\N
22	2	ENTRADA	1.00	16.00	17.00	Cambio automático via sistema	2026-06-02 22:28:41.162362	\N
23	2	ENTRADA	1.00	17.00	18.00	Ingreso de material (+1)	2026-06-02 22:28:41.31626	\N
24	2	ENTRADA	1.00	17.00	18.00	Cambio automático via sistema	2026-06-02 22:28:41.315735	\N
25	2	ENTRADA	1.00	18.00	19.00	Ingreso de material (+1)	2026-06-02 22:28:41.473709	\N
26	2	ENTRADA	1.00	18.00	19.00	Cambio automático via sistema	2026-06-02 22:28:41.473663	\N
27	2	ENTRADA	1.00	19.00	20.00	Ingreso de material (+1)	2026-06-02 22:28:41.627255	\N
28	2	ENTRADA	1.00	19.00	20.00	Cambio automático via sistema	2026-06-02 22:28:41.627054	\N
29	2	ENTRADA	1.00	20.00	21.00	Ingreso de material (+1)	2026-06-02 22:28:41.782671	\N
30	2	ENTRADA	1.00	20.00	21.00	Cambio automático via sistema	2026-06-02 22:28:41.78284	\N
31	2	ENTRADA	1.00	21.00	22.00	Ingreso de material (+1)	2026-06-02 22:28:42.219466	\N
32	2	ENTRADA	1.00	21.00	22.00	Cambio automático via sistema	2026-06-02 22:28:42.219004	\N
33	2	ENTRADA	1.00	22.00	23.00	Ingreso de material (+1)	2026-06-02 22:28:42.423026	\N
34	2	ENTRADA	1.00	22.00	23.00	Cambio automático via sistema	2026-06-02 22:28:42.423618	\N
35	2	ENTRADA	1.00	23.00	24.00	Ingreso de material (+1)	2026-06-02 22:28:42.626752	\N
36	2	ENTRADA	1.00	23.00	24.00	Cambio automático via sistema	2026-06-02 22:28:42.626916	\N
37	2	ENTRADA	1.00	24.00	25.00	Ingreso de material (+1)	2026-06-02 22:28:42.836334	\N
38	2	ENTRADA	1.00	24.00	25.00	Cambio automático via sistema	2026-06-02 22:28:42.836152	\N
39	2	ENTRADA	1.00	25.00	26.00	Ingreso de material (+1)	2026-06-02 22:28:43.039468	\N
40	2	ENTRADA	1.00	25.00	26.00	Cambio automático via sistema	2026-06-02 22:28:43.039207	\N
41	2	ENTRADA	1.00	26.00	27.00	Ingreso de material (+1)	2026-06-02 22:28:43.245676	\N
42	2	ENTRADA	1.00	26.00	27.00	Cambio automático via sistema	2026-06-02 22:28:43.245318	\N
43	2	ENTRADA	1.00	27.00	28.00	Ingreso de material (+1)	2026-06-02 22:28:43.451339	\N
44	2	ENTRADA	1.00	27.00	28.00	Cambio automático via sistema	2026-06-02 22:28:43.451612	\N
45	2	ENTRADA	1.00	28.00	29.00	Ingreso de material (+1)	2026-06-02 22:28:43.654626	\N
46	2	ENTRADA	1.00	28.00	29.00	Cambio automático via sistema	2026-06-02 22:28:43.655046	\N
47	2	ENTRADA	1.00	29.00	30.00	Ingreso de material (+1)	2026-06-02 22:28:43.862794	\N
48	2	ENTRADA	1.00	29.00	30.00	Cambio automático via sistema	2026-06-02 22:28:43.862968	\N
49	2	ENTRADA	1.00	30.00	31.00	Ingreso de material (+1)	2026-06-02 22:28:44.065776	\N
50	2	ENTRADA	1.00	30.00	31.00	Cambio automático via sistema	2026-06-02 22:28:44.065766	\N
51	2	ENTRADA	1.00	31.00	32.00	Ingreso de material (+1)	2026-06-02 22:28:44.272505	\N
52	2	ENTRADA	1.00	31.00	32.00	Cambio automático via sistema	2026-06-02 22:28:44.271629	\N
53	2	ENTRADA	1.00	32.00	33.00	Ingreso de material (+1)	2026-06-02 22:28:44.47736	\N
54	2	ENTRADA	1.00	32.00	33.00	Cambio automático via sistema	2026-06-02 22:28:44.476909	\N
55	2	ENTRADA	1.00	33.00	34.00	Ingreso de material (+1)	2026-06-02 22:28:44.683209	\N
56	2	ENTRADA	1.00	33.00	34.00	Cambio automático via sistema	2026-06-02 22:28:44.68321	\N
57	2	ENTRADA	26.00	34.00	60.00	Ingreso de material (+26)	2026-06-02 22:28:48.035537	\N
58	2	ENTRADA	26.00	34.00	60.00	Cambio automático via sistema	2026-06-02 22:28:48.035513	\N
59	2	SALIDA	1.00	60.00	59.00	Uso de material (-1)	2026-06-02 22:28:49.196644	\N
60	2	SALIDA	1.00	60.00	59.00	Cambio automático via sistema	2026-06-02 22:28:49.197037	\N
61	2	SALIDA	1.00	59.00	58.00	Uso de material (-1)	2026-06-02 22:28:49.431299	\N
62	2	SALIDA	1.00	59.00	58.00	Cambio automático via sistema	2026-06-02 22:28:49.431068	\N
63	2	SALIDA	1.00	58.00	57.00	Uso de material (-1)	2026-06-02 22:28:49.839187	\N
64	2	SALIDA	1.00	58.00	57.00	Cambio automático via sistema	2026-06-02 22:28:49.839575	\N
65	2	SALIDA	1.00	57.00	56.00	Uso de material (-1)	2026-06-02 22:28:50.042572	\N
66	2	SALIDA	1.00	57.00	56.00	Cambio automático via sistema	2026-06-02 22:28:50.043027	\N
67	2	SALIDA	1.00	56.00	55.00	Uso de material (-1)	2026-06-02 22:28:50.251144	\N
68	2	SALIDA	1.00	56.00	55.00	Cambio automático via sistema	2026-06-02 22:28:50.251393	\N
69	2	SALIDA	1.00	55.00	54.00	Uso de material (-1)	2026-06-02 22:28:50.453886	\N
70	2	SALIDA	1.00	55.00	54.00	Cambio automático via sistema	2026-06-02 22:28:50.453905	\N
71	2	SALIDA	1.00	54.00	53.00	Uso de material (-1)	2026-06-02 22:28:50.657247	\N
72	2	SALIDA	1.00	54.00	53.00	Cambio automático via sistema	2026-06-02 22:28:50.657732	\N
73	2	SALIDA	1.00	53.00	52.00	Uso de material (-1)	2026-06-02 22:28:50.864027	\N
74	2	SALIDA	1.00	53.00	52.00	Cambio automático via sistema	2026-06-02 22:28:50.86442	\N
75	2	SALIDA	1.00	52.00	51.00	Uso de material (-1)	2026-06-02 22:28:51.067461	\N
76	2	SALIDA	1.00	52.00	51.00	Cambio automático via sistema	2026-06-02 22:28:51.067329	\N
77	2	SALIDA	1.00	51.00	50.00	Uso de material (-1)	2026-06-02 22:28:51.273266	\N
78	2	SALIDA	1.00	51.00	50.00	Cambio automático via sistema	2026-06-02 22:28:51.272896	\N
79	2	SALIDA	1.00	50.00	49.00	Uso de material (-1)	2026-06-02 22:28:51.481288	\N
80	2	SALIDA	1.00	50.00	49.00	Cambio automático via sistema	2026-06-02 22:28:51.481438	\N
81	2	SALIDA	48.00	49.00	1.00	Uso de material (-48)	2026-06-02 22:28:56.526477	\N
82	2	SALIDA	48.00	49.00	1.00	Cambio automático via sistema	2026-06-02 22:28:56.526751	\N
83	2	ENTRADA	1.00	1.00	2.00	Ingreso de material (+1)	2026-06-02 22:30:17.324327	\N
84	2	ENTRADA	1.00	1.00	2.00	Cambio automático via sistema	2026-06-02 22:30:17.324814	\N
85	2	ENTRADA	1.00	2.00	3.00	Ingreso de material (+1)	2026-06-02 22:30:17.551198	\N
86	2	ENTRADA	1.00	2.00	3.00	Cambio automático via sistema	2026-06-02 22:30:17.551199	\N
87	2	ENTRADA	46.00	3.00	49.00	Ingreso de material (+46)	2026-06-02 22:30:22.66834	\N
88	2	ENTRADA	46.00	3.00	49.00	Cambio automático via sistema	2026-06-02 22:30:22.668542	\N
89	2	ENTRADA	1.00	49.00	50.00	Ingreso de material (+1)	2026-06-02 22:30:24.80821	\N
90	2	ENTRADA	1.00	49.00	50.00	Cambio automático via sistema	2026-06-02 22:30:24.807858	\N
91	2	ENTRADA	1.00	50.00	51.00	Ingreso de material (+1)	2026-06-02 22:30:25.799338	\N
92	2	ENTRADA	1.00	50.00	51.00	Cambio automático via sistema	2026-06-02 22:30:25.799786	\N
93	5	SALIDA	1.00	50.00	49.00	Uso de material (-1)	2026-06-02 22:31:36.420666	\N
94	5	SALIDA	1.00	50.00	49.00	Cambio automático via sistema	2026-06-02 22:31:36.4205	\N
95	5	SALIDA	1.00	49.00	48.00	Uso de material (-1)	2026-06-02 22:31:37.094357	\N
96	5	SALIDA	1.00	49.00	48.00	Cambio automático via sistema	2026-06-02 22:31:37.093913	\N
97	5	SALIDA	43.00	48.00	5.00	Uso de material (-43)	2026-06-02 22:31:40.306729	\N
98	5	SALIDA	43.00	48.00	5.00	Cambio automático via sistema	2026-06-02 22:31:40.30702	\N
99	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-02 22:31:41.299973	\N
100	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-02 22:31:41.300324	\N
101	5	SALIDA	1.00	6.00	5.00	Uso de material (-1)	2026-06-02 22:42:06.854327	\N
102	5	SALIDA	1.00	6.00	5.00	Cambio automático via sistema	2026-06-02 22:42:06.854125	\N
103	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-03 23:50:24.534539	\N
104	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-04 04:50:23.005918	\N
105	5	SALIDA	1.00	6.00	5.00	Uso de material (-1)	2026-06-03 23:50:27.382588	\N
106	5	SALIDA	1.00	6.00	5.00	Cambio automático via sistema	2026-06-04 04:50:25.843497	\N
107	5	SALIDA	1.00	5.00	4.00	Uso de material (-1)	2026-06-04 19:28:15.670065	\N
108	5	SALIDA	1.00	5.00	4.00	Cambio automático via sistema	2026-06-04 19:28:15.636105	\N
109	5	ENTRADA	1.00	4.00	5.00	Ingreso de material (+1)	2026-06-04 19:28:18.459539	\N
110	5	ENTRADA	1.00	4.00	5.00	Cambio automático via sistema	2026-06-04 19:28:18.429128	\N
111	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-04 19:28:20.503729	\N
112	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-04 19:28:20.473366	\N
113	5	SALIDA	1.00	6.00	5.00	Uso de material (-1)	2026-06-04 19:28:22.764756	\N
114	5	SALIDA	1.00	6.00	5.00	Cambio automático via sistema	2026-06-04 19:28:22.734247	\N
115	2	SALIDA	1.00	51.00	50.00	Uso de material (-1)	2026-06-04 19:28:24.978232	\N
116	2	SALIDA	1.00	51.00	50.00	Cambio automático via sistema	2026-06-04 19:28:24.942651	\N
117	2	ENTRADA	1.00	50.00	51.00	Ingreso de material (+1)	2026-06-04 19:28:27.872027	\N
118	2	ENTRADA	1.00	50.00	51.00	Cambio automático via sistema	2026-06-04 19:28:27.836596	\N
119	1	SALIDA	1.00	1000.00	999.00	Uso de material (-1)	2026-06-04 19:46:31.438068	\N
120	1	SALIDA	1.00	1000.00	999.00	Cambio automático via sistema	2026-06-04 19:46:31.406532	\N
121	1	ENTRADA	1.00	999.00	1000.00	Ingreso de material (+1)	2026-06-04 19:46:32.963544	\N
122	1	ENTRADA	1.00	999.00	1000.00	Cambio automático via sistema	2026-06-04 19:46:32.934713	\N
123	1	SALIDA	20.00	1000.00	980.00	Uso de material (-20)	2026-06-04 19:46:57.694258	\N
124	1	SALIDA	20.00	1000.00	980.00	Cambio automático via sistema	2026-06-04 19:46:57.665441	\N
125	3	ENTRADA	1.00	800.00	801.00	Ingreso de material (+1)	2026-06-07 14:40:11.835676	\N
126	3	ENTRADA	1.00	800.00	801.00	Cambio automático via sistema	2026-06-07 19:39:31.330297	\N
127	3	AJUSTE	0.00	801.00	801.00	Ingreso de material (+1)	2026-06-07 14:40:12.493008	\N
128	3	ENTRADA	1.00	801.00	802.00	Ingreso de material (+1)	2026-06-07 14:40:13.9775	\N
129	3	ENTRADA	1.00	801.00	802.00	Cambio automático via sistema	2026-06-07 19:39:33.475208	\N
130	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-07 18:29:36.847506	\N
131	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-07 23:29:35.477036	\N
132	5	ENTRADA	1.00	6.00	7.00	Ingreso de material (+1)	2026-06-07 18:37:33.984022	\N
133	5	ENTRADA	1.00	6.00	7.00	Cambio automático via sistema	2026-06-07 23:37:32.606825	\N
134	5	ENTRADA	1.00	7.00	8.00	Ingreso de material (+1)	2026-06-07 18:39:12.24154	\N
135	5	ENTRADA	1.00	7.00	8.00	Cambio automático via sistema	2026-06-07 23:39:10.863329	\N
136	5	SALIDA	1.00	8.00	7.00	Uso en campo: Entrega de tres unidades para corte y engavillado manual a cargo de tres jornaleros	2026-06-07 18:43:18.18099	\N
137	5	SALIDA	1.00	8.00	7.00	Cambio automático via sistema	2026-06-07 23:43:16.799501	\N
138	5	SALIDA	2.00	7.00	5.00	Uso en campo: Entrega de dos unidades para corte y engavillado manual a cargo de dos jornaleros	2026-06-07 18:44:15.641304	\N
139	5	SALIDA	2.00	7.00	5.00	Cambio automático via sistema	2026-06-07 23:44:14.25956	\N
140	4	SALIDA	1.00	200.00	199.00	Uso de material (-1)	2026-06-07 18:50:41.754454	\N
141	4	SALIDA	1.00	200.00	199.00	Cambio automático via sistema	2026-06-07 23:50:40.367175	\N
142	5	SALIDA	1.00	5.00	4.00	Uso de material (-1)	2026-06-07 18:50:47.869028	\N
143	5	SALIDA	1.00	5.00	4.00	Cambio automático via sistema	2026-06-07 23:50:46.48126	\N
144	5	ENTRADA	1.00	4.00	5.00	Ingreso de material (+1)	2026-06-07 18:50:50.008059	\N
145	5	ENTRADA	1.00	4.00	5.00	Cambio automático via sistema	2026-06-07 23:50:48.621226	\N
146	5	SALIDA	1.00	5.00	4.00	Uso de material (-1)	2026-06-07 18:51:01.463923	\N
147	5	SALIDA	1.00	5.00	4.00	Cambio automático via sistema	2026-06-07 23:51:00.076517	\N
148	5	ENTRADA	1.00	4.00	5.00	Ingreso de material (+1)	2026-06-07 18:51:02.932387	\N
149	5	ENTRADA	1.00	4.00	5.00	Cambio automático via sistema	2026-06-07 23:51:01.545695	\N
150	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-07 18:51:46.691012	\N
151	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-07 23:51:45.30231	\N
152	5	SALIDA	1.00	6.00	5.00	Uso de material (-1)	2026-06-07 18:51:48.808766	\N
153	5	SALIDA	1.00	6.00	5.00	Cambio automático via sistema	2026-06-07 23:51:47.420801	\N
154	4	SALIDA	1.00	199.00	198.00	Uso de material (-1)	2026-06-07 18:56:02.811514	\N
155	4	SALIDA	1.00	199.00	198.00	Cambio automático via sistema	2026-06-07 23:56:01.41911	\N
156	4	SALIDA	1.00	198.00	197.00	Uso de material (-1)	2026-06-07 18:56:07.632156	\N
157	4	SALIDA	1.00	198.00	197.00	Cambio automático via sistema	2026-06-07 23:56:06.240359	\N
158	5	ENTRADA	1.00	5.00	6.00	Ingreso de material (+1)	2026-06-07 19:00:08.317577	\N
159	5	ENTRADA	1.00	5.00	6.00	Cambio automático via sistema	2026-06-08 00:00:06.921713	\N
160	5	SALIDA	1.00	6.00	5.00	Uso en campo: Entrega de una unidad para corte y engavillado manual a cargo de un jornalero	2026-06-07 19:07:02.838976	\N
161	5	SALIDA	1.00	6.00	5.00	Cambio automático via sistema	2026-06-08 00:07:01.433421	\N
162	4	SALIDA	1.00	197.00	196.00	Uso en campo: test	2026-06-07 19:13:08.165321	\N
163	4	SALIDA	1.00	197.00	196.00	Cambio automático via sistema	2026-06-08 00:13:06.757456	\N
164	5	SALIDA	1.00	5.00	4.00	Uso de material (-1)	2026-06-07 19:26:35.390401	\N
165	5	SALIDA	1.00	5.00	4.00	Cambio automático via sistema	2026-06-08 00:26:33.96817	\N
166	5	SALIDA	1.00	4.00	3.00	Uso de material (-1)	2026-06-07 19:26:51.012967	\N
167	5	SALIDA	1.00	4.00	3.00	Cambio automático via sistema	2026-06-08 00:26:49.590916	\N
168	5	SALIDA	1.00	3.00	2.00	Uso en campo: 	2026-06-07 19:33:17.416093	\N
169	5	SALIDA	1.00	3.00	2.00	Cambio automático via sistema	2026-06-08 00:33:15.987058	\N
170	5	ENTRADA	1.00	2.00	3.00	Ingreso de material (+1)	2026-06-07 19:56:30.324781	\N
171	5	ENTRADA	1.00	2.00	3.00	Ingreso de material (+1)	2026-06-07 19:56:30.482766	\N
172	5	ENTRADA	1.00	2.00	3.00	Cambio automático via sistema	2026-06-08 00:56:28.87347	\N
173	5	ENTRADA	1.00	2.00	3.00	Ingreso de material (+1)	2026-06-07 19:56:30.650762	\N
174	5	ENTRADA	1.00	2.00	3.00	Ingreso de material (+1)	2026-06-07 19:56:30.870557	\N
175	5	AJUSTE	0.00	3.00	3.00	Ingreso de material (+1)	2026-06-07 19:56:31.035674	\N
176	5	ENTRADA	2.00	3.00	5.00	Ingreso de material (+2)	2026-06-07 19:56:35.115599	\N
177	5	ENTRADA	2.00	3.00	5.00	Cambio automático via sistema	2026-06-08 00:56:33.666629	\N
\.


--
-- TOC entry 4616 (class 0 OID 17721)
-- Dependencies: 320
-- Data for Name: plagas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plagas (id_plaga, nombre_cientifico, nombre_comun, tipo) FROM stdin;
1	Tagosodes orizicolus	Sogata	Plaga
2	Magnaporthe oryzae	Pyricularia	Enfermedad
3	Spodoptera frugiperda	Gusano cogollero	Plaga
4	Oryza sativa var. sylvatica	Maleza arroz rojo	Maleza
\.


--
-- TOC entry 4618 (class 0 OID 17726)
-- Dependencies: 322
-- Data for Name: planilla_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.planilla_pago (id_planilla, id_trab, fecha_inicio, fecha_fin, total_sacos, total_dias, monto_total, estado, observacion, fecha_generacion, total_tareas, tipo_tarea_planilla) FROM stdin;
1	11	2026-05-01	2026-05-31	0	0	0.00	pendiente	\N	2026-05-28 14:24:36.517422	0	\N
2	25	2026-05-01	2026-05-31	0	0	60.00	pendiente	\N	2026-05-28 14:25:13.945775	1	CARGA
3	25	2026-05-01	2026-05-31	0	0	180.00	pendiente	\N	2026-05-28 14:38:10.940479	3	CARGA
4	25	2026-05-01	2026-05-31	0	0	180.00	pendiente	\N	2026-05-28 14:40:21.888501	3	CARGA
5	25	2026-05-01	2026-05-31	0	0	180.00	pendiente	\N	2026-05-28 14:41:32.737718	3	CARGA
6	25	2026-05-01	2026-05-31	0	0	180.00	pendiente	\N	2026-05-28 14:57:48.910015	3	CARGA
7	25	2026-05-01	2026-05-31	0	0	180.00	pendiente	\N	2026-05-28 14:59:36.845825	3	CARGA
46	5	2026-05-01	2026-06-30	0	3	360.00	pendiente	\N	2026-06-07 16:43:51.137528	0	\N
27	25	2026-05-03	2026-06-03	0	0	240.00	pagado	\N	2026-06-04 04:23:00.777529	4	CARGA
28	32	2026-05-01	2026-07-04	0	0	240.00	pagado	\N	2026-06-04 19:14:51.588392	4	CARGA
56	25	2026-04-30	2026-07-07	0	0	300.00	pendiente	\N	2026-06-07 21:00:54.348792	5	CARGA
15	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 16:43:51.591455	5	CARGA
24	26	2026-05-01	2026-06-30	0	0	150.00	pagado	\N	2026-06-07 16:43:52.044548	3	TRANSPLANTE
34	25	2026-05-01	2026-06-01	0	0	180.00	pendiente	\N	2026-06-05 19:59:51.790788	3	CARGA
35	26	2026-05-01	2026-06-01	0	0	0.00	pendiente	\N	2026-06-05 20:00:06.945942	0	TRANSPLANTE
36	29	2026-05-01	2026-06-01	0	0	0.00	pendiente	\N	2026-06-05 20:00:10.924268	0	RIEGO
37	32	2026-05-01	2026-06-01	0	0	0.00	pendiente	\N	2026-06-05 20:00:13.846504	0	CARGA
29	29	2026-06-01	2026-06-17	0	0	50.00	pagado	\N	2026-06-04 19:17:20.955219	1	RIEGO
57	26	2026-04-30	2026-07-07	0	0	150.00	pendiente	\N	2026-06-07 21:00:54.68499	3	TRANSPLANTE
42	11	2026-06-01	2026-06-30	0	0	0.00	pendiente	\N	2026-06-05 22:35:52.301136	0	\N
58	28	2026-04-30	2026-07-07	0	0	50.00	pendiente	\N	2026-06-07 21:00:55.021448	1	SACA
8	28	2026-05-01	2026-06-30	0	0	50.00	pendiente	\N	2026-06-07 16:43:52.498318	1	SACA
44	11	2026-05-01	2026-06-30	0	0	0.00	pendiente	\N	2026-06-05 23:55:48.822707	0	\N
59	32	2026-04-30	2026-07-07	0	0	300.00	pendiente	\N	2026-06-07 21:00:55.358989	5	CARGA
60	29	2026-04-30	2026-07-07	0	0	100.00	pendiente	\N	2026-06-07 21:00:55.761368	2	RIEGO
61	34	2026-04-30	2026-07-07	0	2	100.00	pendiente	\N	2026-06-07 21:00:56.163466	0	\N
38	32	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 16:43:53.251322	5	CARGA
25	28	2026-06-01	2026-06-30	0	0	100.00	pagado	\N	2026-06-07 19:37:05.46524	2	SACA
33	32	2026-06-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 19:37:05.927614	5	CARGA
47	29	2026-05-01	2026-06-30	0	0	100.00	pendiente	\N	2026-06-07 16:43:54.004585	2	RIEGO
45	34	2026-05-01	2026-06-30	0	2	100.00	pagado	\N	2026-06-07 16:43:54.757138	0	\N
62	31	2026-04-30	2026-07-07	0	2	100.00	pendiente	\N	2026-06-07 21:00:56.565185	0	\N
30	29	2026-06-01	2026-06-30	0	0	100.00	pagado	\N	2026-06-07 19:37:06.392083	2	RIEGO
50	34	2026-06-01	2026-06-30	0	2	100.00	pendiente	\N	2026-06-07 19:37:07.162012	0	\N
63	30	2026-04-30	2026-07-07	123	0	430.50	pendiente	\N	2026-06-07 21:00:56.967464	0	\N
51	31	2026-06-01	2026-06-30	0	2	100.00	pendiente	\N	2026-06-07 19:37:07.930271	0	\N
52	30	2026-06-01	2026-06-30	123	0	430.50	pagado	\N	2026-06-07 19:37:08.696233	0	\N
39	31	2026-05-01	2026-06-30	0	2	100.00	pagado	\N	2026-06-07 16:43:55.509708	0	\N
23	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-06 00:22:03.002044	5	CARGA
53	20	2026-06-01	2026-06-30	0	1	50.00	pagado	\N	2026-06-07 19:37:09.468133	0	\N
16	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-06 00:20:00.041781	5	CARGA
11	25	2026-05-01	2026-06-30	0	0	300.00	pendiente	\N	2026-06-06 00:29:00.108773	5	CARGA
41	6	2026-06-01	2026-06-30	0	1	100.00	pendiente	\N	2026-06-07 19:37:10.233612	0	\N
32	33	2026-06-01	2026-06-30	0	1	50.00	pendiente	\N	2026-06-07 19:37:10.999241	0	\N
22	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-06 06:22:15.865305	5	CARGA
64	20	2026-04-30	2026-07-07	0	1	50.00	pendiente	\N	2026-06-07 21:00:57.370075	0	\N
65	33	2026-04-30	2026-07-07	0	1	50.00	pendiente	\N	2026-06-07 21:00:57.773691	0	\N
12	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 20:59:21.742586	5	CARGA
13	25	2026-05-01	2026-06-30	0	0	300.00	pendiente	\N	2026-06-06 00:09:49.039605	5	CARGA
17	25	2026-05-01	2026-06-30	0	0	300.00	pendiente	\N	2026-06-06 00:20:26.219441	5	CARGA
43	30	2026-05-01	2026-06-30	123	0	430.50	pagado	\N	2026-06-07 16:43:56.309387	0	\N
48	20	2026-05-01	2026-06-30	0	1	50.00	pendiente	\N	2026-06-07 16:43:57.061582	0	\N
14	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-06 00:38:55.897207	5	CARGA
31	33	2026-05-01	2026-06-30	0	1	50.00	pagado	\N	2026-06-07 16:43:57.813454	0	\N
54	6	2026-04-30	2026-07-07	0	12	1200.00	pendiente	\N	2026-06-07 21:00:53.667909	0	\N
49	26	2026-06-01	2026-06-30	0	0	150.00	pagado	\N	2026-06-07 19:37:04.522045	3	TRANSPLANTE
9	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 12:25:35.365087	5	CARGA
55	5	2026-04-30	2026-07-07	0	3	360.00	pendiente	\N	2026-06-07 21:00:54.012499	0	\N
40	6	2026-05-01	2026-06-30	0	12	1200.00	pagado	\N	2026-06-07 16:43:50.668394	0	\N
26	25	2026-06-01	2026-06-30	0	0	120.00	pagado	\N	2026-06-07 19:37:04.999415	2	CARGA
10	25	2026-05-01	2026-06-30	0	0	300.00	pagado	\N	2026-06-07 16:01:45.454055	5	CARGA
\.


--
-- TOC entry 4620 (class 0 OID 17738)
-- Dependencies: 324
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (id_proveedor, ruc, razon_social, telefono, email, direccion) FROM stdin;
\.


--
-- TOC entry 4622 (class 0 OID 17744)
-- Dependencies: 326
-- Data for Name: regadio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regadio (id_reg, id_hect, fec_reg, hora_inicio, hora_fin, cantidad_agua_m3, id_responsable, id_trab_regador, observacion, estado_riego) FROM stdin;
\.


--
-- TOC entry 4624 (class 0 OID 17753)
-- Dependencies: 328
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_permisos (id_rol, nombre_rol, descripcion, nivel_acceso) FROM stdin;
1	Administrador	Acceso total	4
2	Supervisor	Gestión completa	3
3	Operador	Tareas diarias	2
\.


--
-- TOC entry 4626 (class 0 OID 17760)
-- Dependencies: 330
-- Data for Name: tipo_cosecha; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_cosecha (id_tipo_cosecha, nombre_tipo, descripcion, rendimiento_esperado_kg_ha, orden_ciclo) FROM stdin;
1	Primera cosecha	Cosecha principal del ciclo	8000.00	1
2	Segunda cosecha	Rebrote controlado	4500.00	2
3	Soca	Cosecha de retoños naturales	3000.00	3
\.


--
-- TOC entry 4628 (class 0 OID 17766)
-- Dependencies: 332
-- Data for Name: trabajadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trabajadores (id_trab, nom_trab, ape_trab, dni_trab, id_cargo, tipo_pago, sueldo_base_dia, pago_por_saco, fecha_contrato, activo, created_at, updated_at, pago_por_tarea) FROM stdin;
11	Admin	Sistema	00000001	1	tiempo	\N	\N	2026-05-25	t	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	\N
14	Operador	Sistema	00000003	3	tiempo	\N	\N	2026-05-25	t	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	\N
16	Supervisor	Sistema	0SYS0002	2	tiempo	\N	\N	2026-05-25	t	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	\N
17	Admin	Sistema	SYS00001	1	tiempo	\N	\N	2026-05-26	t	2026-05-26 02:43:24.957894	2026-05-26 02:43:24.957894	\N
5	Carlos	Gómez	12345678	1	tiempo	120.00	\N	2026-05-07	f	2026-05-26 02:13:45.907169	2026-05-26 02:52:59.366924	\N
21	Alexis	Marquez	17620174	2	jornal	\N	\N	2026-05-26	f	2026-05-26 02:54:08.907375	2026-05-26 02:55:52.248477	\N
22	Alexis	Marquez	78945612	3	destajo	\N	\N	2026-05-26	t	2026-05-26 03:01:58.075579	2026-05-26 03:01:58.075579	\N
23	kevin	Santamaria	72618223	2	destajo	\N	\N	2026-05-26	t	2026-05-26 03:02:27.299608	2026-05-26 03:02:27.299608	\N
24	Luis	Santamaria	72618224	3	destajo	\N	\N	2026-05-26	t	2026-05-26 03:02:52.041205	2026-05-26 03:02:52.041205	\N
7	Juan	Pérez	11112222	3	rendimiento	\N	3.50	2026-05-07	t	2026-05-26 02:13:45.907169	2026-05-26 03:28:33.225114	\N
8	Pedro	Ramírez	33334444	3	rendimiento	\N	3.50	2026-05-07	f	2026-05-26 02:13:45.907169	2026-05-26 03:28:33.225114	\N
26	miguel	velazques	88888888	1	transplante	\N	\N	2026-05-28	t	2026-05-28 14:02:50.307484	2026-05-28 14:02:50.307484	50.00
27	Raul	Gomez	45612378	1	jornal	50.00	\N	2026-06-02	f	2026-06-02 21:00:29.118792	2026-06-02 21:01:40.321671	\N
28	Rodrigo	Diaz	45612376	1	saca	\N	\N	2026-06-02	t	2026-06-02 21:02:17.78771	2026-06-02 21:02:17.78771	50.00
29	Juan	Martinez	12345679	1	riego	\N	\N	2026-06-02	t	2026-06-02 22:29:59.961516	2026-06-02 22:29:59.961516	50.00
30	Diego	Cardenas	45679714	1	por_saco	\N	3.50	2026-06-04	t	2026-06-03 22:31:39.262129	2026-06-03 22:31:39.262129	\N
31	Matias	Rodriguez	41234587	1	jornal	50.00	\N	2026-06-04	t	2026-06-04 03:49:06.398916	2026-06-04 03:49:06.398933	\N
32	Jhordan	Valencia	78978978	1	carga	\N	\N	2026-06-04	t	2026-06-04 03:52:51.832482	2026-06-04 03:52:51.832499	60.00
33	Mario	Jimenez	45678912	3	jornal	50.00	\N	2026-06-04	t	2026-06-04 19:59:03.361774	2026-06-04 19:59:03.361782	\N
34	Mario	Gutierrez	45678914	1	jornal	50.00	\N	2026-06-06	t	2026-06-05 22:41:20.479631	2026-06-05 22:41:20.479631	\N
20	Jose	Santamaria	72618225	1	jornal	50.00	\N	2026-05-26	t	2026-05-26 02:52:45.582354	2026-06-06 04:00:15.349152	\N
6	María	López	87654321	2	jornal	100.00	\N	2026-05-07	f	2026-05-26 02:13:45.907169	2026-06-06 05:09:31.286782	\N
25	juan	montalvan	17620194	1	carga	\N	\N	2026-05-26	f	2026-05-26 03:40:27.908507	2026-06-06 05:21:48.338152	60.00
\.


--
-- TOC entry 4630 (class 0 OID 17780)
-- Dependencies: 334
-- Data for Name: uso_materiales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uso_materiales (id_uso, id_mat, id_hect, fec_uso, hora_uso, cantidad, detalle_uso) FROM stdin;
2	5	1	2026-06-07	18:44:00	2.00	Entrega de dos unidades para corte y engavillado manual a cargo de dos jornaleros
3	5	1	2026-06-08	19:06:00	1.00	Entrega de una unidad para corte y engavillado manual a cargo de un jornalero
4	4	1	2026-06-08	19:13:00	1.00	test
5	5	1	2026-06-08	19:33:00	1.00	
\.


--
-- TOC entry 4632 (class 0 OID 17787)
-- Dependencies: 336
-- Data for Name: usuario_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_roles (id_usuario_rol, id_usuario, id_rol, fecha_asignacion) FROM stdin;
\.


--
-- TOC entry 4634 (class 0 OID 17792)
-- Dependencies: 338
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, id_trab, nombre_usuario, contrasena_hash, email, ultimo_login, intentos_fallidos, bloqueado, activo, fecha_creacion, created_at, updated_at, rol) FROM stdin;
1	5	cgómez	$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBpwTWVFAO5paO	\N	\N	0	f	t	2026-05-07 14:42:03.903053	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	TRABAJADOR
2	6	mlópez	$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi	\N	\N	0	f	t	2026-05-07 14:42:03.903053	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	TRABAJADOR
12	14	operador	$2a$10$QnSuYxVqYbMNEJ2Cwhwc6e3LsWWc3yOfIf2wdsIGMrO1V5EMX4LQy	\N	\N	0	f	t	2026-05-25 01:14:10.47666	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	TRABAJADOR
14	16	supervisor	$2a$10$lbkjOfCi2wSFw7EOm0dxZul4I6qisEz1CQlX/TCQU36KNUmBed5jW	\N	2026-05-28 14:53:15.481021	0	f	t	2026-05-25 22:26:57.840546	2026-05-26 02:13:45.907169	2026-05-26 02:13:45.907169	SUPERVISOR
15	17	admin	$2a$10$RQq9BQfPUy7ml331Be927.c.ijJNXhbc/HO2Rp0Gz4R1OVC4p.sC.	\N	2026-06-08 02:58:22.418556	0	f	t	2026-05-26 02:43:25.080185	2026-05-26 02:43:25.080185	2026-05-26 02:43:25.080185	ADMIN
\.


--
-- TOC entry 4565 (class 0 OID 17170)
-- Dependencies: 265
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-06-04 00:39:02
20211116045059	2026-06-04 00:39:02
20211116050929	2026-06-04 02:57:38
20211116051442	2026-06-04 02:57:39
20211116212300	2026-06-04 02:57:39
20211116213355	2026-06-04 02:57:39
20211116213934	2026-06-04 02:57:39
20211116214523	2026-06-04 02:57:40
20211122062447	2026-06-04 02:57:40
20211124070109	2026-06-04 02:57:40
20211202204204	2026-06-04 02:57:40
20211202204605	2026-06-04 02:57:40
20211210212804	2026-06-04 02:57:41
20211228014915	2026-06-04 02:57:41
20220107221237	2026-06-04 02:57:41
20220228202821	2026-06-04 02:57:42
20220312004840	2026-06-04 02:57:42
20220603231003	2026-06-04 02:57:42
20220603232444	2026-06-04 02:57:42
20220615214548	2026-06-04 02:57:43
20220712093339	2026-06-04 02:57:43
20220908172859	2026-06-04 02:57:43
20220916233421	2026-06-04 02:57:43
20230119133233	2026-06-04 02:57:43
20230128025114	2026-06-04 02:57:44
20230128025212	2026-06-04 02:57:44
20230227211149	2026-06-04 02:57:44
20230228184745	2026-06-04 02:57:44
20230308225145	2026-06-04 02:57:44
20230328144023	2026-06-04 02:57:45
20231018144023	2026-06-04 02:57:45
20231204144023	2026-06-04 02:57:45
20231204144024	2026-06-04 02:57:45
20231204144025	2026-06-04 02:57:46
20240108234812	2026-06-04 02:57:46
20240109165339	2026-06-04 02:57:46
20240227174441	2026-06-04 02:57:46
20240311171622	2026-06-04 02:57:47
20240321100241	2026-06-04 02:57:47
20240401105812	2026-06-04 02:57:48
20240418121054	2026-06-04 02:57:48
20240523004032	2026-06-04 02:57:49
20240618124746	2026-06-04 02:57:49
20240801235015	2026-06-04 02:57:49
20240805133720	2026-06-04 02:57:49
20240827160934	2026-06-04 02:57:49
20240919163303	2026-06-04 02:57:50
20240919163305	2026-06-04 02:57:50
20241019105805	2026-06-04 02:57:50
20241030150047	2026-06-04 02:57:51
20241108114728	2026-06-04 02:57:51
20241121104152	2026-06-04 02:57:51
20241130184212	2026-06-04 02:57:51
20241220035512	2026-06-04 02:57:52
20241220123912	2026-06-04 02:57:52
20241224161212	2026-06-04 02:57:52
20250107150512	2026-06-04 02:57:52
20250110162412	2026-06-04 02:57:52
20250123174212	2026-06-04 02:57:53
20250128220012	2026-06-04 02:57:53
20250506224012	2026-06-04 02:57:53
20250523164012	2026-06-04 02:57:53
20250714121412	2026-06-04 02:57:53
20250905041441	2026-06-04 02:57:54
20251103001201	2026-06-04 02:57:54
20251120212548	2026-06-04 02:57:54
20251120215549	2026-06-04 02:57:54
20260218120000	2026-06-04 02:57:54
20260326120000	2026-06-04 02:57:55
20260514120000	2026-06-04 02:57:55
20260527120000	2026-06-04 02:57:55
20260528120000	2026-06-04 02:57:56
20260603120000	2026-06-04 02:57:56
\.


--
-- TOC entry 4567 (class 0 OID 17193)
-- Dependencies: 268
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- TOC entry 4569 (class 0 OID 17215)
-- Dependencies: 270
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- TOC entry 4573 (class 0 OID 17334)
-- Dependencies: 274
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- TOC entry 4574 (class 0 OID 17347)
-- Dependencies: 275
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4568 (class 0 OID 17207)
-- Dependencies: 269
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-06-04 00:39:28.035504
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-06-04 00:39:28.071312
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-06-04 00:39:28.076388
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-06-04 00:39:28.099167
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-06-04 00:39:28.115436
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-06-04 00:39:28.120896
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-06-04 00:39:28.126746
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-06-04 00:39:28.132877
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-06-04 00:39:28.138878
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-06-04 00:39:28.145684
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-06-04 00:39:28.15288
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-06-04 00:39:28.160134
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-06-04 00:39:28.167654
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-06-04 00:39:28.173613
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-06-04 00:39:28.180153
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-06-04 00:39:28.206946
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-06-04 00:39:28.212528
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-06-04 00:39:28.218173
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-06-04 00:39:28.22342
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-06-04 00:39:28.230693
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-06-04 00:39:28.236227
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-06-04 00:39:28.244302
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-06-04 00:39:28.258626
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-06-04 00:39:28.270028
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-06-04 00:39:28.276034
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-06-04 00:39:28.281467
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-06-04 00:39:28.287624
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-06-04 00:39:28.292947
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-06-04 00:39:28.298291
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-06-04 00:39:28.30352
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-06-04 00:39:28.308934
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-06-04 00:39:28.314335
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-06-04 00:39:28.319887
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-06-04 00:39:28.325188
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-06-04 00:39:28.33041
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-06-04 00:39:28.337484
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-06-04 00:39:28.343396
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-06-04 00:39:28.349685
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-06-04 00:39:28.355745
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-06-04 00:39:28.365725
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-06-04 00:39:28.370999
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-06-04 00:39:28.376323
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-06-04 00:39:28.381546
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-06-04 00:39:28.386784
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-06-04 00:39:28.39236
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-06-04 00:39:28.399348
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-06-04 00:39:28.410495
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-06-04 00:39:28.416987
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-06-04 00:39:28.422718
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-06-04 00:39:28.44053
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-06-04 00:39:28.446514
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-06-04 00:39:28.482289
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-06-04 00:39:28.484583
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-06-04 00:39:28.495159
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-06-04 00:39:28.498485
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-06-04 00:39:28.500726
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-06-04 00:39:28.507005
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-06-04 00:39:28.513789
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-06-04 00:39:28.519376
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-06-04 00:39:28.526301
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-06-04 00:39:28.534892
\.


--
-- TOC entry 4570 (class 0 OID 17225)
-- Dependencies: 271
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- TOC entry 4571 (class 0 OID 17274)
-- Dependencies: 272
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- TOC entry 4572 (class 0 OID 17288)
-- Dependencies: 273
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 4575 (class 0 OID 17357)
-- Dependencies: 276
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3782 (class 0 OID 16612)
-- Dependencies: 245
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 240
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 281
-- Name: abono_id_abono_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.abono_id_abono_seq', 1, false);


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 283
-- Name: asistencia_id_asist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.asistencia_id_asist_seq', 49, true);


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 285
-- Name: cargos_id_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargos_id_cargo_seq', 8, true);


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 287
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ciclos_cultivo_id_ciclo_seq', 1, false);


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 289
-- Name: compras_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compras_id_compra_seq', 1, false);


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 291
-- Name: compras_material_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compras_material_id_compra_seq', 1, false);


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 293
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.control_calidad_id_calidad_seq', 1, false);


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 295
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cosechas_id_cosecha_seq', 1, false);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 297
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_compras_id_detalle_seq', 1, false);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 299
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_cosecha_id_detalle_seq', 1, false);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 301
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gasolina_id_gasolina_seq', 2, true);


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 303
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gestion_cultivos_id_gestion_seq', 1, false);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 305
-- Name: hectareas_id_hect_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hectareas_id_hect_seq', 3, true);


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 307
-- Name: incidencia_id_inc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incidencia_id_inc_seq', 3, true);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 309
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_sistema_id_log_seq', 1, false);


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 311
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maquinaria_id_maq_seq', 3, true);


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 313
-- Name: materiales_id_mat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materiales_id_mat_seq', 5, true);


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 315
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.monitoreo_plagas_id_monitoreo_seq', 1, false);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 317
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_caja_id_mov_seq', 22, true);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 319
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_material_id_movimiento_seq', 177, true);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 321
-- Name: plagas_id_plaga_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plagas_id_plaga_seq', 4, true);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 323
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planilla_pago_id_planilla_seq', 65, true);


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 325
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 1, false);


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 327
-- Name: regadio_id_reg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regadio_id_reg_seq', 1, false);


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 329
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_permisos_id_rol_seq', 3, true);


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 331
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_cosecha_id_tipo_cosecha_seq', 3, true);


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 333
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trabajadores_id_trab_seq', 34, true);


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 335
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uso_materiales_id_uso_seq', 5, true);


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 337
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_roles_id_usuario_rol_seq', 1, false);


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 339
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 15, true);


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 267
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 4094 (class 2606 OID 16789)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 4063 (class 2606 OID 16535)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 4149 (class 2606 OID 17121)
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- TOC entry 4151 (class 2606 OID 17119)
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4117 (class 2606 OID 16895)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 4072 (class 2606 OID 16913)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 4074 (class 2606 OID 16923)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 4061 (class 2606 OID 16528)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 4096 (class 2606 OID 16782)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 4092 (class 2606 OID 16770)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 4084 (class 2606 OID 16963)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 4086 (class 2606 OID 16757)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 4130 (class 2606 OID 17022)
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- TOC entry 4132 (class 2606 OID 17020)
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- TOC entry 4134 (class 2606 OID 17018)
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- TOC entry 4144 (class 2606 OID 17080)
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4127 (class 2606 OID 16982)
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4138 (class 2606 OID 17044)
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- TOC entry 4140 (class 2606 OID 17046)
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- TOC entry 4121 (class 2606 OID 16948)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4055 (class 2606 OID 16518)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4058 (class 2606 OID 16699)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 4106 (class 2606 OID 16829)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 4108 (class 2606 OID 16827)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4113 (class 2606 OID 16843)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4066 (class 2606 OID 16541)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4079 (class 2606 OID 16720)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4103 (class 2606 OID 16810)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 4098 (class 2606 OID 16801)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4048 (class 2606 OID 16883)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4050 (class 2606 OID 16505)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4159 (class 2606 OID 17158)
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 4155 (class 2606 OID 17141)
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 4197 (class 2606 OID 17874)
-- Name: abono abono_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abono
    ADD CONSTRAINT abono_pkey PRIMARY KEY (id_abono);


--
-- TOC entry 4199 (class 2606 OID 17876)
-- Name: asistencia asistencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_pkey PRIMARY KEY (id_asist);


--
-- TOC entry 4207 (class 2606 OID 17878)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id_cargo);


--
-- TOC entry 4209 (class 2606 OID 17880)
-- Name: ciclos_cultivo ciclos_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciclos_cultivo
    ADD CONSTRAINT ciclos_cultivo_pkey PRIMARY KEY (id_ciclo);


--
-- TOC entry 4214 (class 2606 OID 17882)
-- Name: compras_material compras_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT compras_material_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 4212 (class 2606 OID 17884)
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 4216 (class 2606 OID 17886)
-- Name: control_calidad control_calidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_pkey PRIMARY KEY (id_calidad);


--
-- TOC entry 4218 (class 2606 OID 17888)
-- Name: cosechas cosechas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_pkey PRIMARY KEY (id_cosecha);


--
-- TOC entry 4221 (class 2606 OID 17890)
-- Name: detalle_compras detalle_compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 4223 (class 2606 OID 17892)
-- Name: detalle_cosecha detalle_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cosecha
    ADD CONSTRAINT detalle_cosecha_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 4227 (class 2606 OID 17894)
-- Name: gasolina gasolina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasolina
    ADD CONSTRAINT gasolina_pkey PRIMARY KEY (id_gasolina);


--
-- TOC entry 4229 (class 2606 OID 17896)
-- Name: gestion_cultivos gestion_cultivos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_pkey PRIMARY KEY (id_gestion);


--
-- TOC entry 4231 (class 2606 OID 17898)
-- Name: hectareas hectareas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hectareas
    ADD CONSTRAINT hectareas_pkey PRIMARY KEY (id_hect);


--
-- TOC entry 4233 (class 2606 OID 17900)
-- Name: incidencia incidencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia
    ADD CONSTRAINT incidencia_pkey PRIMARY KEY (id_inc);


--
-- TOC entry 4237 (class 2606 OID 17902)
-- Name: logs_sistema logs_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs_sistema
    ADD CONSTRAINT logs_sistema_pkey PRIMARY KEY (id_log);


--
-- TOC entry 4239 (class 2606 OID 17904)
-- Name: maquinaria maquinaria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maquinaria
    ADD CONSTRAINT maquinaria_pkey PRIMARY KEY (id_maq);


--
-- TOC entry 4243 (class 2606 OID 17906)
-- Name: materiales materiales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materiales
    ADD CONSTRAINT materiales_pkey PRIMARY KEY (id_mat);


--
-- TOC entry 4245 (class 2606 OID 17908)
-- Name: monitoreo_plagas monitoreo_plagas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_pkey PRIMARY KEY (id_monitoreo);


--
-- TOC entry 4248 (class 2606 OID 17910)
-- Name: movimientos_caja movimientos_caja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_pkey PRIMARY KEY (id_mov);


--
-- TOC entry 4251 (class 2606 OID 17912)
-- Name: movimientos_material movimientos_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT movimientos_material_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 4253 (class 2606 OID 17914)
-- Name: plagas plagas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plagas
    ADD CONSTRAINT plagas_pkey PRIMARY KEY (id_plaga);


--
-- TOC entry 4257 (class 2606 OID 17916)
-- Name: planilla_pago planilla_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planilla_pago
    ADD CONSTRAINT planilla_pago_pkey PRIMARY KEY (id_planilla);


--
-- TOC entry 4259 (class 2606 OID 17918)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4261 (class 2606 OID 17920)
-- Name: proveedores proveedores_ruc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_ruc_key UNIQUE (ruc);


--
-- TOC entry 4264 (class 2606 OID 17922)
-- Name: regadio regadio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_pkey PRIMARY KEY (id_reg);


--
-- TOC entry 4266 (class 2606 OID 17924)
-- Name: roles_permisos roles_permisos_nombre_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_nombre_rol_key UNIQUE (nombre_rol);


--
-- TOC entry 4268 (class 2606 OID 17926)
-- Name: roles_permisos roles_permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4270 (class 2606 OID 17928)
-- Name: tipo_cosecha tipo_cosecha_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cosecha
    ADD CONSTRAINT tipo_cosecha_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- TOC entry 4272 (class 2606 OID 17930)
-- Name: tipo_cosecha tipo_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cosecha
    ADD CONSTRAINT tipo_cosecha_pkey PRIMARY KEY (id_tipo_cosecha);


--
-- TOC entry 4277 (class 2606 OID 17932)
-- Name: trabajadores trabajadores_dni_trab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_dni_trab_key UNIQUE (dni_trab);


--
-- TOC entry 4279 (class 2606 OID 17934)
-- Name: trabajadores trabajadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_pkey PRIMARY KEY (id_trab);


--
-- TOC entry 4205 (class 2606 OID 17936)
-- Name: asistencia unique_asistencia_dia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT unique_asistencia_dia UNIQUE (id_trab, fec_asist);


--
-- TOC entry 4281 (class 2606 OID 17938)
-- Name: trabajadores unique_dni; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT unique_dni UNIQUE (dni_trab);


--
-- TOC entry 4283 (class 2606 OID 17940)
-- Name: uso_materiales uso_materiales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_pkey PRIMARY KEY (id_uso);


--
-- TOC entry 4285 (class 2606 OID 17942)
-- Name: usuario_roles usuario_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_pkey PRIMARY KEY (id_usuario_rol);


--
-- TOC entry 4287 (class 2606 OID 17944)
-- Name: usuarios usuarios_id_trab_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_trab_key UNIQUE (id_trab);


--
-- TOC entry 4289 (class 2606 OID 17946)
-- Name: usuarios usuarios_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- TOC entry 4291 (class 2606 OID 17948)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4002 (class 2606 OID 17545)
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- TOC entry 4195 (class 2606 OID 17537)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4165 (class 2606 OID 17201)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 4162 (class 2606 OID 17174)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4186 (class 2606 OID 17380)
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 4173 (class 2606 OID 17223)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 4189 (class 2606 OID 17356)
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- TOC entry 4168 (class 2606 OID 17214)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 4170 (class 2606 OID 17212)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4179 (class 2606 OID 17235)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 4184 (class 2606 OID 17297)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4182 (class 2606 OID 17282)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4192 (class 2606 OID 17366)
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- TOC entry 4064 (class 1259 OID 16536)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 4034 (class 1259 OID 16709)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4145 (class 1259 OID 17125)
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- TOC entry 4146 (class 1259 OID 17124)
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- TOC entry 4147 (class 1259 OID 17122)
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- TOC entry 4152 (class 1259 OID 17123)
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- TOC entry 4035 (class 1259 OID 16711)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4036 (class 1259 OID 16712)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4082 (class 1259 OID 16791)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 4115 (class 1259 OID 16899)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 4070 (class 1259 OID 16879)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 4070
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 4075 (class 1259 OID 16706)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 4118 (class 1259 OID 16896)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 4142 (class 1259 OID 17081)
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- TOC entry 4119 (class 1259 OID 16897)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 4037 (class 1259 OID 17167)
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- TOC entry 4038 (class 1259 OID 17166)
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- TOC entry 4039 (class 1259 OID 17168)
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- TOC entry 4040 (class 1259 OID 17169)
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- TOC entry 4090 (class 1259 OID 16902)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 4087 (class 1259 OID 16763)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 4088 (class 1259 OID 16908)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 4128 (class 1259 OID 17033)
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- TOC entry 4125 (class 1259 OID 16986)
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- TOC entry 4135 (class 1259 OID 17059)
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4136 (class 1259 OID 17057)
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4141 (class 1259 OID 17058)
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- TOC entry 4122 (class 1259 OID 16955)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 4123 (class 1259 OID 16954)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 4124 (class 1259 OID 16956)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 4041 (class 1259 OID 16713)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4042 (class 1259 OID 16710)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4051 (class 1259 OID 16519)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 4052 (class 1259 OID 16520)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 4053 (class 1259 OID 16705)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 4056 (class 1259 OID 16793)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 4059 (class 1259 OID 16898)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 4109 (class 1259 OID 16835)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 4110 (class 1259 OID 16900)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 4111 (class 1259 OID 16850)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 4114 (class 1259 OID 16849)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 4076 (class 1259 OID 16901)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 4077 (class 1259 OID 17071)
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- TOC entry 4080 (class 1259 OID 16792)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 4101 (class 1259 OID 16817)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 4104 (class 1259 OID 16816)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 4099 (class 1259 OID 16802)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 4100 (class 1259 OID 16964)
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- TOC entry 4089 (class 1259 OID 16961)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 4081 (class 1259 OID 16790)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 4043 (class 1259 OID 16870)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 4043
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 4044 (class 1259 OID 16707)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 4045 (class 1259 OID 16509)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 4046 (class 1259 OID 16925)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4157 (class 1259 OID 17165)
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- TOC entry 4160 (class 1259 OID 17164)
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- TOC entry 4153 (class 1259 OID 17147)
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- TOC entry 4156 (class 1259 OID 17148)
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- TOC entry 4200 (class 1259 OID 17949)
-- Name: idx_asistencia_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asistencia_fecha ON public.asistencia USING btree (fec_asist);


--
-- TOC entry 4201 (class 1259 OID 17950)
-- Name: idx_asistencia_tipo_tarea; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asistencia_tipo_tarea ON public.asistencia USING btree (tipo_tarea, fec_asist);


--
-- TOC entry 4202 (class 1259 OID 17951)
-- Name: idx_asistencia_trab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asistencia_trab ON public.asistencia USING btree (id_trab);


--
-- TOC entry 4203 (class 1259 OID 17952)
-- Name: idx_asistencia_trab_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_asistencia_trab_fecha ON public.asistencia USING btree (id_trab, fec_asist);


--
-- TOC entry 4210 (class 1259 OID 17953)
-- Name: idx_ciclos_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ciclos_estado ON public.ciclos_cultivo USING btree (estado, fecha_siembra);


--
-- TOC entry 4224 (class 1259 OID 17954)
-- Name: idx_cosecha_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cosecha_fecha ON public.detalle_cosecha USING btree (fecha);


--
-- TOC entry 4225 (class 1259 OID 17955)
-- Name: idx_cosecha_trab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cosecha_trab ON public.detalle_cosecha USING btree (id_trab);


--
-- TOC entry 4219 (class 1259 OID 17956)
-- Name: idx_cosechas_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cosechas_fecha ON public.cosechas USING btree (fec_cosecha, id_hect);


--
-- TOC entry 4234 (class 1259 OID 17957)
-- Name: idx_logs_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_fecha ON public.logs_sistema USING btree (fecha);


--
-- TOC entry 4235 (class 1259 OID 17958)
-- Name: idx_logs_tabla; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_tabla ON public.logs_sistema USING btree (tabla);


--
-- TOC entry 4240 (class 1259 OID 17959)
-- Name: idx_mat_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mat_activo ON public.materiales USING btree (activo);


--
-- TOC entry 4241 (class 1259 OID 17960)
-- Name: idx_materiales_stock; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_materiales_stock ON public.materiales USING btree (stock_actual, stock_minimo);


--
-- TOC entry 4246 (class 1259 OID 17961)
-- Name: idx_movimientos_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movimientos_fecha ON public.movimientos_caja USING btree (fec_mov, tipo_mov);


--
-- TOC entry 4249 (class 1259 OID 17962)
-- Name: idx_movimientos_material; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movimientos_material ON public.movimientos_material USING btree (id_material);


--
-- TOC entry 4254 (class 1259 OID 17963)
-- Name: idx_planilla_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_planilla_fecha ON public.planilla_pago USING btree (fecha_inicio);


--
-- TOC entry 4255 (class 1259 OID 17964)
-- Name: idx_planilla_trab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_planilla_trab ON public.planilla_pago USING btree (id_trab);


--
-- TOC entry 4262 (class 1259 OID 17965)
-- Name: idx_regadio_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_regadio_fecha ON public.regadio USING btree (fec_reg, id_hect);


--
-- TOC entry 4273 (class 1259 OID 17966)
-- Name: idx_trab_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_trab_activo ON public.trabajadores USING btree (activo);


--
-- TOC entry 4274 (class 1259 OID 17967)
-- Name: idx_trab_dni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_trab_dni ON public.trabajadores USING btree (dni_trab);


--
-- TOC entry 4275 (class 1259 OID 17968)
-- Name: idx_trabajadores_nombre; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_trabajadores_nombre ON public.trabajadores USING btree (nom_trab, ape_trab);


--
-- TOC entry 4163 (class 1259 OID 17538)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 4193 (class 1259 OID 17539)
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4166 (class 1259 OID 17553)
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- TOC entry 4171 (class 1259 OID 17224)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 4174 (class 1259 OID 17241)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 4187 (class 1259 OID 17381)
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- TOC entry 4180 (class 1259 OID 17308)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 4175 (class 1259 OID 17273)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 4176 (class 1259 OID 17388)
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- TOC entry 4177 (class 1259 OID 17242)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4190 (class 1259 OID 17372)
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- TOC entry 4355 (class 2620 OID 17969)
-- Name: asistencia trig_updated_asistencia; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig_updated_asistencia BEFORE UPDATE ON public.asistencia FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 4356 (class 2620 OID 17970)
-- Name: materiales trig_updated_materiales; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig_updated_materiales BEFORE UPDATE ON public.materiales FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 4358 (class 2620 OID 17971)
-- Name: trabajadores trig_updated_trabajadores; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trig_updated_trabajadores BEFORE UPDATE ON public.trabajadores FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 4357 (class 2620 OID 17972)
-- Name: materiales trigger_movimiento_stock; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_movimiento_stock AFTER UPDATE OF stock_actual ON public.materiales FOR EACH ROW EXECUTE FUNCTION public.registrar_movimiento_stock();


--
-- TOC entry 4350 (class 2620 OID 17206)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4351 (class 2620 OID 17327)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 4352 (class 2620 OID 17390)
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- TOC entry 4353 (class 2620 OID 17391)
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- TOC entry 4354 (class 2620 OID 17261)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4293 (class 2606 OID 16693)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4298 (class 2606 OID 16783)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4297 (class 2606 OID 16771)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4296 (class 2606 OID 16758)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4304 (class 2606 OID 17023)
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4305 (class 2606 OID 17028)
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4306 (class 2606 OID 17052)
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4307 (class 2606 OID 17047)
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4303 (class 2606 OID 16949)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4292 (class 2606 OID 16726)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4300 (class 2606 OID 16830)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4301 (class 2606 OID 16903)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4302 (class 2606 OID 16844)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4294 (class 2606 OID 17066)
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4295 (class 2606 OID 16721)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4299 (class 2606 OID 16811)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4309 (class 2606 OID 17159)
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4308 (class 2606 OID 17142)
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4315 (class 2606 OID 17973)
-- Name: abono abono_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.abono
    ADD CONSTRAINT abono_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 4316 (class 2606 OID 17978)
-- Name: asistencia asistencia_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE CASCADE;


--
-- TOC entry 4317 (class 2606 OID 17983)
-- Name: ciclos_cultivo ciclos_cultivo_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciclos_cultivo
    ADD CONSTRAINT ciclos_cultivo_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 4318 (class 2606 OID 17988)
-- Name: compras compras_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON DELETE SET NULL;


--
-- TOC entry 4321 (class 2606 OID 17993)
-- Name: control_calidad control_calidad_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE CASCADE;


--
-- TOC entry 4322 (class 2606 OID 17998)
-- Name: cosechas cosechas_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 4323 (class 2606 OID 18003)
-- Name: cosechas cosechas_id_maq_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_maq_fkey FOREIGN KEY (id_maq) REFERENCES public.maquinaria(id_maq) ON DELETE SET NULL;


--
-- TOC entry 4324 (class 2606 OID 18008)
-- Name: cosechas cosechas_id_tipo_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_tipo_cosecha_fkey FOREIGN KEY (id_tipo_cosecha) REFERENCES public.tipo_cosecha(id_tipo_cosecha);


--
-- TOC entry 4325 (class 2606 OID 18013)
-- Name: detalle_compras detalle_compras_id_compra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_id_compra_fkey FOREIGN KEY (id_compra) REFERENCES public.compras(id_compra) ON DELETE CASCADE;


--
-- TOC entry 4326 (class 2606 OID 18018)
-- Name: detalle_compras detalle_compras_id_mat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_id_mat_fkey FOREIGN KEY (id_mat) REFERENCES public.materiales(id_mat) ON DELETE SET NULL;


--
-- TOC entry 4319 (class 2606 OID 18023)
-- Name: compras_material fk_compra_material; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT fk_compra_material FOREIGN KEY (id_material) REFERENCES public.materiales(id_mat);


--
-- TOC entry 4320 (class 2606 OID 18028)
-- Name: compras_material fk_compra_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON DELETE SET NULL;


--
-- TOC entry 4327 (class 2606 OID 18033)
-- Name: detalle_cosecha fk_cosecha_trab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_cosecha
    ADD CONSTRAINT fk_cosecha_trab FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE RESTRICT;


--
-- TOC entry 4338 (class 2606 OID 18038)
-- Name: movimientos_material fk_movimiento_material; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT fk_movimiento_material FOREIGN KEY (id_material) REFERENCES public.materiales(id_mat) ON DELETE RESTRICT;


--
-- TOC entry 4339 (class 2606 OID 18043)
-- Name: movimientos_material fk_movimiento_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT fk_movimiento_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 4340 (class 2606 OID 18048)
-- Name: planilla_pago fk_planilla_trab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planilla_pago
    ADD CONSTRAINT fk_planilla_trab FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE RESTRICT;


--
-- TOC entry 4328 (class 2606 OID 18053)
-- Name: gasolina gasolina_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasolina
    ADD CONSTRAINT gasolina_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 4329 (class 2606 OID 18058)
-- Name: gestion_cultivos gestion_cultivos_id_calidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_calidad_fkey FOREIGN KEY (id_calidad) REFERENCES public.control_calidad(id_calidad) ON DELETE SET NULL;


--
-- TOC entry 4330 (class 2606 OID 18063)
-- Name: gestion_cultivos gestion_cultivos_id_ciclo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_ciclo_fkey FOREIGN KEY (id_ciclo) REFERENCES public.ciclos_cultivo(id_ciclo) ON DELETE RESTRICT;


--
-- TOC entry 4331 (class 2606 OID 18068)
-- Name: gestion_cultivos gestion_cultivos_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE SET NULL;


--
-- TOC entry 4332 (class 2606 OID 18073)
-- Name: gestion_cultivos gestion_cultivos_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE RESTRICT;


--
-- TOC entry 4333 (class 2606 OID 18078)
-- Name: incidencia incidencia_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia
    ADD CONSTRAINT incidencia_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 4334 (class 2606 OID 18083)
-- Name: monitoreo_plagas monitoreo_plagas_id_ciclo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_id_ciclo_fkey FOREIGN KEY (id_ciclo) REFERENCES public.ciclos_cultivo(id_ciclo);


--
-- TOC entry 4335 (class 2606 OID 18088)
-- Name: monitoreo_plagas monitoreo_plagas_id_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_id_plaga_fkey FOREIGN KEY (id_plaga) REFERENCES public.plagas(id_plaga);


--
-- TOC entry 4336 (class 2606 OID 18093)
-- Name: movimientos_caja movimientos_caja_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE SET NULL;


--
-- TOC entry 4337 (class 2606 OID 18098)
-- Name: movimientos_caja movimientos_caja_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 4341 (class 2606 OID 18103)
-- Name: regadio regadio_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 4342 (class 2606 OID 18108)
-- Name: regadio regadio_id_responsable_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_responsable_fkey FOREIGN KEY (id_responsable) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 4343 (class 2606 OID 18113)
-- Name: regadio regadio_id_trab_regador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_trab_regador_fkey FOREIGN KEY (id_trab_regador) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 4344 (class 2606 OID 18118)
-- Name: trabajadores trabajadores_id_cargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_id_cargo_fkey FOREIGN KEY (id_cargo) REFERENCES public.cargos(id_cargo) ON DELETE RESTRICT;


--
-- TOC entry 4345 (class 2606 OID 18123)
-- Name: uso_materiales uso_materiales_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 4346 (class 2606 OID 18128)
-- Name: uso_materiales uso_materiales_id_mat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_id_mat_fkey FOREIGN KEY (id_mat) REFERENCES public.materiales(id_mat) ON DELETE CASCADE;


--
-- TOC entry 4347 (class 2606 OID 18133)
-- Name: usuario_roles usuario_roles_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.roles_permisos(id_rol) ON DELETE CASCADE;


--
-- TOC entry 4348 (class 2606 OID 18138)
-- Name: usuario_roles usuario_roles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4349 (class 2606 OID 18143)
-- Name: usuarios usuarios_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE CASCADE;


--
-- TOC entry 4310 (class 2606 OID 17236)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4311 (class 2606 OID 17283)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4312 (class 2606 OID 17303)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4313 (class 2606 OID 17298)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4314 (class 2606 OID 17367)
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- TOC entry 4518 (class 0 OID 16529)
-- Dependencies: 243
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4529 (class 0 OID 16889)
-- Dependencies: 256
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4520 (class 0 OID 16686)
-- Dependencies: 247
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4517 (class 0 OID 16522)
-- Dependencies: 242
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4524 (class 0 OID 16776)
-- Dependencies: 251
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4523 (class 0 OID 16764)
-- Dependencies: 250
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4522 (class 0 OID 16751)
-- Dependencies: 249
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4530 (class 0 OID 16939)
-- Dependencies: 257
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4516 (class 0 OID 16511)
-- Dependencies: 241
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4527 (class 0 OID 16818)
-- Dependencies: 254
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4528 (class 0 OID 16836)
-- Dependencies: 255
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4519 (class 0 OID 16537)
-- Dependencies: 244
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4521 (class 0 OID 16716)
-- Dependencies: 248
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4526 (class 0 OID 16803)
-- Dependencies: 253
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4525 (class 0 OID 16794)
-- Dependencies: 252
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4515 (class 0 OID 16499)
-- Dependencies: 239
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4539 (class 0 OID 17523)
-- Dependencies: 279
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4532 (class 0 OID 17215)
-- Dependencies: 270
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4536 (class 0 OID 17334)
-- Dependencies: 274
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4537 (class 0 OID 17347)
-- Dependencies: 275
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4531 (class 0 OID 17207)
-- Dependencies: 269
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4533 (class 0 OID 17225)
-- Dependencies: 271
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4534 (class 0 OID 17274)
-- Dependencies: 272
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4535 (class 0 OID 17288)
-- Dependencies: 273
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4538 (class 0 OID 17357)
-- Dependencies: 276
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4540 (class 6104 OID 16430)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 25
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 24
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 384
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 362
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 361
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 363
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 370
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4710 (class 0 OID 0)
-- Dependencies: 372
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4711 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4712 (class 0 OID 0)
-- Dependencies: 364
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4713 (class 0 OID 0)
-- Dependencies: 365
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4714 (class 0 OID 0)
-- Dependencies: 367
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4715 (class 0 OID 0)
-- Dependencies: 366
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4716 (class 0 OID 0)
-- Dependencies: 368
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4717 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4718 (class 0 OID 0)
-- Dependencies: 348
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4719 (class 0 OID 0)
-- Dependencies: 360
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- TOC entry 4720 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION actualizar_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.actualizar_updated_at() TO anon;
GRANT ALL ON FUNCTION public.actualizar_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.actualizar_updated_at() TO service_role;


--
-- TOC entry 4721 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION obtener_indicadores(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.obtener_indicadores() TO anon;
GRANT ALL ON FUNCTION public.obtener_indicadores() TO authenticated;
GRANT ALL ON FUNCTION public.obtener_indicadores() TO service_role;


--
-- TOC entry 4722 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION registrar_movimiento_stock(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.registrar_movimiento_stock() TO anon;
GRANT ALL ON FUNCTION public.registrar_movimiento_stock() TO authenticated;
GRANT ALL ON FUNCTION public.registrar_movimiento_stock() TO service_role;


--
-- TOC entry 4723 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4724 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4725 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4726 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4727 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4728 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4729 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- TOC entry 4730 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4731 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4732 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4733 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4734 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4735 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4736 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;
GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO dashboard_user;


--
-- TOC entry 4737 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4738 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4739 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4741 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4742 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- TOC entry 4744 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4747 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4749 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4751 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4753 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4756 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4757 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- TOC entry 4759 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- TOC entry 4760 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- TOC entry 4761 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- TOC entry 4762 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4764 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4766 (class 0 OID 0)
-- Dependencies: 240
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4768 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4770 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4772 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4777 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4779 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4782 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4785 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4786 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- TOC entry 4787 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- TOC entry 4788 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4789 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4790 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE abono; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.abono TO anon;
GRANT ALL ON TABLE public.abono TO authenticated;
GRANT ALL ON TABLE public.abono TO service_role;


--
-- TOC entry 4792 (class 0 OID 0)
-- Dependencies: 281
-- Name: SEQUENCE abono_id_abono_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.abono_id_abono_seq TO anon;
GRANT ALL ON SEQUENCE public.abono_id_abono_seq TO authenticated;
GRANT ALL ON SEQUENCE public.abono_id_abono_seq TO service_role;


--
-- TOC entry 4793 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE asistencia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.asistencia TO anon;
GRANT ALL ON TABLE public.asistencia TO authenticated;
GRANT ALL ON TABLE public.asistencia TO service_role;


--
-- TOC entry 4795 (class 0 OID 0)
-- Dependencies: 283
-- Name: SEQUENCE asistencia_id_asist_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.asistencia_id_asist_seq TO anon;
GRANT ALL ON SEQUENCE public.asistencia_id_asist_seq TO authenticated;
GRANT ALL ON SEQUENCE public.asistencia_id_asist_seq TO service_role;


--
-- TOC entry 4796 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE cargos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cargos TO anon;
GRANT ALL ON TABLE public.cargos TO authenticated;
GRANT ALL ON TABLE public.cargos TO service_role;


--
-- TOC entry 4798 (class 0 OID 0)
-- Dependencies: 285
-- Name: SEQUENCE cargos_id_cargo_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cargos_id_cargo_seq TO anon;
GRANT ALL ON SEQUENCE public.cargos_id_cargo_seq TO authenticated;
GRANT ALL ON SEQUENCE public.cargos_id_cargo_seq TO service_role;


--
-- TOC entry 4799 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE ciclos_cultivo; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ciclos_cultivo TO anon;
GRANT ALL ON TABLE public.ciclos_cultivo TO authenticated;
GRANT ALL ON TABLE public.ciclos_cultivo TO service_role;


--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 287
-- Name: SEQUENCE ciclos_cultivo_id_ciclo_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ciclos_cultivo_id_ciclo_seq TO anon;
GRANT ALL ON SEQUENCE public.ciclos_cultivo_id_ciclo_seq TO authenticated;
GRANT ALL ON SEQUENCE public.ciclos_cultivo_id_ciclo_seq TO service_role;


--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE compras; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.compras TO anon;
GRANT ALL ON TABLE public.compras TO authenticated;
GRANT ALL ON TABLE public.compras TO service_role;


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 289
-- Name: SEQUENCE compras_id_compra_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.compras_id_compra_seq TO anon;
GRANT ALL ON SEQUENCE public.compras_id_compra_seq TO authenticated;
GRANT ALL ON SEQUENCE public.compras_id_compra_seq TO service_role;


--
-- TOC entry 4805 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE compras_material; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.compras_material TO anon;
GRANT ALL ON TABLE public.compras_material TO authenticated;
GRANT ALL ON TABLE public.compras_material TO service_role;


--
-- TOC entry 4807 (class 0 OID 0)
-- Dependencies: 291
-- Name: SEQUENCE compras_material_id_compra_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.compras_material_id_compra_seq TO anon;
GRANT ALL ON SEQUENCE public.compras_material_id_compra_seq TO authenticated;
GRANT ALL ON SEQUENCE public.compras_material_id_compra_seq TO service_role;


--
-- TOC entry 4808 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE control_calidad; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.control_calidad TO anon;
GRANT ALL ON TABLE public.control_calidad TO authenticated;
GRANT ALL ON TABLE public.control_calidad TO service_role;


--
-- TOC entry 4810 (class 0 OID 0)
-- Dependencies: 293
-- Name: SEQUENCE control_calidad_id_calidad_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.control_calidad_id_calidad_seq TO anon;
GRANT ALL ON SEQUENCE public.control_calidad_id_calidad_seq TO authenticated;
GRANT ALL ON SEQUENCE public.control_calidad_id_calidad_seq TO service_role;


--
-- TOC entry 4811 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE cosechas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cosechas TO anon;
GRANT ALL ON TABLE public.cosechas TO authenticated;
GRANT ALL ON TABLE public.cosechas TO service_role;


--
-- TOC entry 4813 (class 0 OID 0)
-- Dependencies: 295
-- Name: SEQUENCE cosechas_id_cosecha_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cosechas_id_cosecha_seq TO anon;
GRANT ALL ON SEQUENCE public.cosechas_id_cosecha_seq TO authenticated;
GRANT ALL ON SEQUENCE public.cosechas_id_cosecha_seq TO service_role;


--
-- TOC entry 4814 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE detalle_compras; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detalle_compras TO anon;
GRANT ALL ON TABLE public.detalle_compras TO authenticated;
GRANT ALL ON TABLE public.detalle_compras TO service_role;


--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 297
-- Name: SEQUENCE detalle_compras_id_detalle_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.detalle_compras_id_detalle_seq TO anon;
GRANT ALL ON SEQUENCE public.detalle_compras_id_detalle_seq TO authenticated;
GRANT ALL ON SEQUENCE public.detalle_compras_id_detalle_seq TO service_role;


--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE detalle_cosecha; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.detalle_cosecha TO anon;
GRANT ALL ON TABLE public.detalle_cosecha TO authenticated;
GRANT ALL ON TABLE public.detalle_cosecha TO service_role;


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 299
-- Name: SEQUENCE detalle_cosecha_id_detalle_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.detalle_cosecha_id_detalle_seq TO anon;
GRANT ALL ON SEQUENCE public.detalle_cosecha_id_detalle_seq TO authenticated;
GRANT ALL ON SEQUENCE public.detalle_cosecha_id_detalle_seq TO service_role;


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE gasolina; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gasolina TO anon;
GRANT ALL ON TABLE public.gasolina TO authenticated;
GRANT ALL ON TABLE public.gasolina TO service_role;


--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 301
-- Name: SEQUENCE gasolina_id_gasolina_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.gasolina_id_gasolina_seq TO anon;
GRANT ALL ON SEQUENCE public.gasolina_id_gasolina_seq TO authenticated;
GRANT ALL ON SEQUENCE public.gasolina_id_gasolina_seq TO service_role;


--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE gestion_cultivos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gestion_cultivos TO anon;
GRANT ALL ON TABLE public.gestion_cultivos TO authenticated;
GRANT ALL ON TABLE public.gestion_cultivos TO service_role;


--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 303
-- Name: SEQUENCE gestion_cultivos_id_gestion_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.gestion_cultivos_id_gestion_seq TO anon;
GRANT ALL ON SEQUENCE public.gestion_cultivos_id_gestion_seq TO authenticated;
GRANT ALL ON SEQUENCE public.gestion_cultivos_id_gestion_seq TO service_role;


--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE hectareas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.hectareas TO anon;
GRANT ALL ON TABLE public.hectareas TO authenticated;
GRANT ALL ON TABLE public.hectareas TO service_role;


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 305
-- Name: SEQUENCE hectareas_id_hect_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.hectareas_id_hect_seq TO anon;
GRANT ALL ON SEQUENCE public.hectareas_id_hect_seq TO authenticated;
GRANT ALL ON SEQUENCE public.hectareas_id_hect_seq TO service_role;


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE incidencia; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.incidencia TO anon;
GRANT ALL ON TABLE public.incidencia TO authenticated;
GRANT ALL ON TABLE public.incidencia TO service_role;


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 307
-- Name: SEQUENCE incidencia_id_inc_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.incidencia_id_inc_seq TO anon;
GRANT ALL ON SEQUENCE public.incidencia_id_inc_seq TO authenticated;
GRANT ALL ON SEQUENCE public.incidencia_id_inc_seq TO service_role;


--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE logs_sistema; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.logs_sistema TO anon;
GRANT ALL ON TABLE public.logs_sistema TO authenticated;
GRANT ALL ON TABLE public.logs_sistema TO service_role;


--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 309
-- Name: SEQUENCE logs_sistema_id_log_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.logs_sistema_id_log_seq TO anon;
GRANT ALL ON SEQUENCE public.logs_sistema_id_log_seq TO authenticated;
GRANT ALL ON SEQUENCE public.logs_sistema_id_log_seq TO service_role;


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE maquinaria; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.maquinaria TO anon;
GRANT ALL ON TABLE public.maquinaria TO authenticated;
GRANT ALL ON TABLE public.maquinaria TO service_role;


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 311
-- Name: SEQUENCE maquinaria_id_maq_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.maquinaria_id_maq_seq TO anon;
GRANT ALL ON SEQUENCE public.maquinaria_id_maq_seq TO authenticated;
GRANT ALL ON SEQUENCE public.maquinaria_id_maq_seq TO service_role;


--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE materiales; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.materiales TO anon;
GRANT ALL ON TABLE public.materiales TO authenticated;
GRANT ALL ON TABLE public.materiales TO service_role;


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 313
-- Name: SEQUENCE materiales_id_mat_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.materiales_id_mat_seq TO anon;
GRANT ALL ON SEQUENCE public.materiales_id_mat_seq TO authenticated;
GRANT ALL ON SEQUENCE public.materiales_id_mat_seq TO service_role;


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE monitoreo_plagas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.monitoreo_plagas TO anon;
GRANT ALL ON TABLE public.monitoreo_plagas TO authenticated;
GRANT ALL ON TABLE public.monitoreo_plagas TO service_role;


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 315
-- Name: SEQUENCE monitoreo_plagas_id_monitoreo_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.monitoreo_plagas_id_monitoreo_seq TO anon;
GRANT ALL ON SEQUENCE public.monitoreo_plagas_id_monitoreo_seq TO authenticated;
GRANT ALL ON SEQUENCE public.monitoreo_plagas_id_monitoreo_seq TO service_role;


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 316
-- Name: TABLE movimientos_caja; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.movimientos_caja TO anon;
GRANT ALL ON TABLE public.movimientos_caja TO authenticated;
GRANT ALL ON TABLE public.movimientos_caja TO service_role;


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 317
-- Name: SEQUENCE movimientos_caja_id_mov_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.movimientos_caja_id_mov_seq TO anon;
GRANT ALL ON SEQUENCE public.movimientos_caja_id_mov_seq TO authenticated;
GRANT ALL ON SEQUENCE public.movimientos_caja_id_mov_seq TO service_role;


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 318
-- Name: TABLE movimientos_material; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.movimientos_material TO anon;
GRANT ALL ON TABLE public.movimientos_material TO authenticated;
GRANT ALL ON TABLE public.movimientos_material TO service_role;


--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 319
-- Name: SEQUENCE movimientos_material_id_movimiento_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.movimientos_material_id_movimiento_seq TO anon;
GRANT ALL ON SEQUENCE public.movimientos_material_id_movimiento_seq TO authenticated;
GRANT ALL ON SEQUENCE public.movimientos_material_id_movimiento_seq TO service_role;


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE plagas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.plagas TO anon;
GRANT ALL ON TABLE public.plagas TO authenticated;
GRANT ALL ON TABLE public.plagas TO service_role;


--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 321
-- Name: SEQUENCE plagas_id_plaga_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.plagas_id_plaga_seq TO anon;
GRANT ALL ON SEQUENCE public.plagas_id_plaga_seq TO authenticated;
GRANT ALL ON SEQUENCE public.plagas_id_plaga_seq TO service_role;


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE planilla_pago; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.planilla_pago TO anon;
GRANT ALL ON TABLE public.planilla_pago TO authenticated;
GRANT ALL ON TABLE public.planilla_pago TO service_role;


--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 323
-- Name: SEQUENCE planilla_pago_id_planilla_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.planilla_pago_id_planilla_seq TO anon;
GRANT ALL ON SEQUENCE public.planilla_pago_id_planilla_seq TO authenticated;
GRANT ALL ON SEQUENCE public.planilla_pago_id_planilla_seq TO service_role;


--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE proveedores; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.proveedores TO anon;
GRANT ALL ON TABLE public.proveedores TO authenticated;
GRANT ALL ON TABLE public.proveedores TO service_role;


--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 325
-- Name: SEQUENCE proveedores_id_proveedor_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.proveedores_id_proveedor_seq TO anon;
GRANT ALL ON SEQUENCE public.proveedores_id_proveedor_seq TO authenticated;
GRANT ALL ON SEQUENCE public.proveedores_id_proveedor_seq TO service_role;


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE regadio; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.regadio TO anon;
GRANT ALL ON TABLE public.regadio TO authenticated;
GRANT ALL ON TABLE public.regadio TO service_role;


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 327
-- Name: SEQUENCE regadio_id_reg_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.regadio_id_reg_seq TO anon;
GRANT ALL ON SEQUENCE public.regadio_id_reg_seq TO authenticated;
GRANT ALL ON SEQUENCE public.regadio_id_reg_seq TO service_role;


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE roles_permisos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.roles_permisos TO anon;
GRANT ALL ON TABLE public.roles_permisos TO authenticated;
GRANT ALL ON TABLE public.roles_permisos TO service_role;


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 329
-- Name: SEQUENCE roles_permisos_id_rol_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.roles_permisos_id_rol_seq TO anon;
GRANT ALL ON SEQUENCE public.roles_permisos_id_rol_seq TO authenticated;
GRANT ALL ON SEQUENCE public.roles_permisos_id_rol_seq TO service_role;


--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE tipo_cosecha; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tipo_cosecha TO anon;
GRANT ALL ON TABLE public.tipo_cosecha TO authenticated;
GRANT ALL ON TABLE public.tipo_cosecha TO service_role;


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 331
-- Name: SEQUENCE tipo_cosecha_id_tipo_cosecha_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq TO anon;
GRANT ALL ON SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq TO authenticated;
GRANT ALL ON SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq TO service_role;


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE trabajadores; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.trabajadores TO anon;
GRANT ALL ON TABLE public.trabajadores TO authenticated;
GRANT ALL ON TABLE public.trabajadores TO service_role;


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 333
-- Name: SEQUENCE trabajadores_id_trab_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.trabajadores_id_trab_seq TO anon;
GRANT ALL ON SEQUENCE public.trabajadores_id_trab_seq TO authenticated;
GRANT ALL ON SEQUENCE public.trabajadores_id_trab_seq TO service_role;


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE uso_materiales; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.uso_materiales TO anon;
GRANT ALL ON TABLE public.uso_materiales TO authenticated;
GRANT ALL ON TABLE public.uso_materiales TO service_role;


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 335
-- Name: SEQUENCE uso_materiales_id_uso_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.uso_materiales_id_uso_seq TO anon;
GRANT ALL ON SEQUENCE public.uso_materiales_id_uso_seq TO authenticated;
GRANT ALL ON SEQUENCE public.uso_materiales_id_uso_seq TO service_role;


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE usuario_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuario_roles TO anon;
GRANT ALL ON TABLE public.usuario_roles TO authenticated;
GRANT ALL ON TABLE public.usuario_roles TO service_role;


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 337
-- Name: SEQUENCE usuario_roles_id_usuario_rol_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.usuario_roles_id_usuario_rol_seq TO anon;
GRANT ALL ON SEQUENCE public.usuario_roles_id_usuario_rol_seq TO authenticated;
GRANT ALL ON SEQUENCE public.usuario_roles_id_usuario_rol_seq TO service_role;


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE usuarios; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.usuarios TO anon;
GRANT ALL ON TABLE public.usuarios TO authenticated;
GRANT ALL ON TABLE public.usuarios TO service_role;


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 339
-- Name: SEQUENCE usuarios_id_usuario_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.usuarios_id_usuario_seq TO anon;
GRANT ALL ON SEQUENCE public.usuarios_id_usuario_seq TO authenticated;
GRANT ALL ON SEQUENCE public.usuarios_id_usuario_seq TO service_role;


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE vista_alerta_stock; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_alerta_stock TO anon;
GRANT ALL ON TABLE public.vista_alerta_stock TO authenticated;
GRANT ALL ON TABLE public.vista_alerta_stock TO service_role;


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE vista_ciclos_activos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_ciclos_activos TO anon;
GRANT ALL ON TABLE public.vista_ciclos_activos TO authenticated;
GRANT ALL ON TABLE public.vista_ciclos_activos TO service_role;


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE vista_pagos_trabajadores; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_pagos_trabajadores TO anon;
GRANT ALL ON TABLE public.vista_pagos_trabajadores TO authenticated;
GRANT ALL ON TABLE public.vista_pagos_trabajadores TO service_role;


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE vista_reporte_riego; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_reporte_riego TO anon;
GRANT ALL ON TABLE public.vista_reporte_riego TO authenticated;
GRANT ALL ON TABLE public.vista_reporte_riego TO service_role;


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE vista_resumen_cosechas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_resumen_cosechas TO anon;
GRANT ALL ON TABLE public.vista_resumen_cosechas TO authenticated;
GRANT ALL ON TABLE public.vista_resumen_cosechas TO service_role;


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE vista_resumen_financiero; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_resumen_financiero TO anon;
GRANT ALL ON TABLE public.vista_resumen_financiero TO authenticated;
GRANT ALL ON TABLE public.vista_resumen_financiero TO service_role;


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE vista_resumen_tareas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vista_resumen_tareas TO anon;
GRANT ALL ON TABLE public.vista_resumen_tareas TO authenticated;
GRANT ALL ON TABLE public.vista_resumen_tareas TO service_role;


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE vw_login; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.vw_login TO anon;
GRANT ALL ON TABLE public.vw_login TO authenticated;
GRANT ALL ON TABLE public.vw_login TO service_role;


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 267
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2550 (class 826 OID 16557)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2551 (class 826 OID 16558)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2549 (class 826 OID 16556)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2560 (class 826 OID 16636)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2559 (class 826 OID 16635)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2558 (class 826 OID 16634)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2563 (class 826 OID 16591)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2562 (class 826 OID 16590)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2561 (class 826 OID 16589)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2555 (class 826 OID 16571)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2557 (class 826 OID 16570)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2556 (class 826 OID 16569)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2542 (class 826 OID 16494)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2543 (class 826 OID 16495)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2541 (class 826 OID 16493)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2545 (class 826 OID 16497)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2540 (class 826 OID 16492)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2544 (class 826 OID 16496)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2553 (class 826 OID 16561)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2554 (class 826 OID 16562)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2552 (class 826 OID 16560)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2548 (class 826 OID 16550)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2547 (class 826 OID 16549)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2546 (class 826 OID 16548)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3776 (class 3466 OID 16575)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3779 (class 3466 OID 16654)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3781 (class 3466 OID 16666)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3780 (class 3466 OID 16657)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 3777 (class 3466 OID 16576)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3778 (class 3466 OID 16577)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2026-06-07 22:02:53

--
-- PostgreSQL database dump complete
--

\unrestrict 9ztgAcGiCCi5x7Pe6HHwCpxUSK3GSqLs7RwlDI7jz1T1kmqf1VKRpzuCvyAOBWj

