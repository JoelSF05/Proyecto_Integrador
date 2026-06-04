--
-- PostgreSQL database dump
--

\restrict maYEgMdus2v2AVe4jzbbhEu2FrZ2xeW4rDmMYmJMzkPPaXs15y04YQeTktwmsLy

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-06-03 20:13:09

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
-- TOC entry 287 (class 1255 OID 34647)
-- Name: actualizar_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


--
-- TOC entry 288 (class 1255 OID 34648)
-- Name: obtener_indicadores(); Type: FUNCTION; Schema: public; Owner: -
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


--
-- TOC entry 289 (class 1255 OID 34649)
-- Name: registrar_movimiento_stock(); Type: FUNCTION; Schema: public; Owner: -
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 34650)
-- Name: abono; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 220 (class 1259 OID 34661)
-- Name: abono_id_abono_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.abono_id_abono_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 220
-- Name: abono_id_abono_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.abono_id_abono_seq OWNED BY public.abono.id_abono;


--
-- TOC entry 221 (class 1259 OID 34662)
-- Name: asistencia; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 222 (class 1259 OID 34677)
-- Name: asistencia_id_asist_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.asistencia_id_asist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 222
-- Name: asistencia_id_asist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.asistencia_id_asist_seq OWNED BY public.asistencia.id_asist;


--
-- TOC entry 223 (class 1259 OID 34678)
-- Name: cargos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cargos (
    id_cargo integer NOT NULL,
    nom_cargo character varying(50) NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 224 (class 1259 OID 34685)
-- Name: cargos_id_cargo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cargos_id_cargo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 224
-- Name: cargos_id_cargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cargos_id_cargo_seq OWNED BY public.cargos.id_cargo;


--
-- TOC entry 225 (class 1259 OID 34686)
-- Name: ciclos_cultivo; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 226 (class 1259 OID 34695)
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ciclos_cultivo_id_ciclo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 226
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ciclos_cultivo_id_ciclo_seq OWNED BY public.ciclos_cultivo.id_ciclo;


--
-- TOC entry 227 (class 1259 OID 34696)
-- Name: compras; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 228 (class 1259 OID 34705)
-- Name: compras_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compras_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 228
-- Name: compras_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compras_id_compra_seq OWNED BY public.compras.id_compra;


--
-- TOC entry 229 (class 1259 OID 34706)
-- Name: compras_material; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 230 (class 1259 OID 34718)
-- Name: compras_material_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compras_material_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 230
-- Name: compras_material_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compras_material_id_compra_seq OWNED BY public.compras_material.id_compra;


--
-- TOC entry 231 (class 1259 OID 34719)
-- Name: control_calidad; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 232 (class 1259 OID 34729)
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.control_calidad_id_calidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 232
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.control_calidad_id_calidad_seq OWNED BY public.control_calidad.id_calidad;


--
-- TOC entry 233 (class 1259 OID 34730)
-- Name: cosechas; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 234 (class 1259 OID 34743)
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cosechas_id_cosecha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 234
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cosechas_id_cosecha_seq OWNED BY public.cosechas.id_cosecha;


--
-- TOC entry 235 (class 1259 OID 34744)
-- Name: detalle_compras; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detalle_compras (
    id_detalle integer NOT NULL,
    id_compra integer NOT NULL,
    id_mat integer,
    cantidad numeric(10,2) NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 34751)
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.detalle_compras_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 236
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.detalle_compras_id_detalle_seq OWNED BY public.detalle_compras.id_detalle;


--
-- TOC entry 237 (class 1259 OID 34752)
-- Name: detalle_cosecha; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detalle_cosecha (
    id_detalle integer NOT NULL,
    id_trab integer NOT NULL,
    fecha date NOT NULL,
    cantidad_sacos integer DEFAULT 0 NOT NULL,
    observacion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 238 (class 1259 OID 34763)
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.detalle_cosecha_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 238
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.detalle_cosecha_id_detalle_seq OWNED BY public.detalle_cosecha.id_detalle;


--
-- TOC entry 239 (class 1259 OID 34764)
-- Name: gasolina; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 240 (class 1259 OID 34774)
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gasolina_id_gasolina_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 240
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gasolina_id_gasolina_seq OWNED BY public.gasolina.id_gasolina;


--
-- TOC entry 241 (class 1259 OID 34775)
-- Name: gestion_cultivos; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 242 (class 1259 OID 34785)
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gestion_cultivos_id_gestion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 242
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gestion_cultivos_id_gestion_seq OWNED BY public.gestion_cultivos.id_gestion;


--
-- TOC entry 243 (class 1259 OID 34786)
-- Name: hectareas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hectareas (
    id_hect integer NOT NULL,
    ubi_hect character varying(100),
    tam_hect numeric(8,2),
    variedad_arroz character varying(50) NOT NULL,
    activo boolean DEFAULT true,
    CONSTRAINT hectareas_tam_hect_check CHECK ((tam_hect > (0)::numeric))
);


--
-- TOC entry 244 (class 1259 OID 34793)
-- Name: hectareas_id_hect_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hectareas_id_hect_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 244
-- Name: hectareas_id_hect_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hectareas_id_hect_seq OWNED BY public.hectareas.id_hect;


--
-- TOC entry 286 (class 1259 OID 42840)
-- Name: incidencia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.incidencia (
    id_inc integer NOT NULL,
    id_trab integer,
    fecha date,
    tipo character varying(60),
    descripcion text,
    estado character varying(30) DEFAULT 'PENDIENTE'::character varying
);


--
-- TOC entry 285 (class 1259 OID 42839)
-- Name: incidencia_id_inc_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.incidencia_id_inc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 285
-- Name: incidencia_id_inc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.incidencia_id_inc_seq OWNED BY public.incidencia.id_inc;


--
-- TOC entry 245 (class 1259 OID 34794)
-- Name: logs_sistema; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 246 (class 1259 OID 34804)
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.logs_sistema_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 246
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.logs_sistema_id_log_seq OWNED BY public.logs_sistema.id_log;


--
-- TOC entry 247 (class 1259 OID 34805)
-- Name: maquinaria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.maquinaria (
    id_maq integer NOT NULL,
    nom_maq character varying(50) NOT NULL,
    tipo_maq character varying(50) NOT NULL,
    costo_alquiler_hora numeric(10,2),
    activo boolean DEFAULT true,
    CONSTRAINT maquinaria_costo_alquiler_hora_check CHECK ((costo_alquiler_hora >= (0)::numeric))
);


--
-- TOC entry 248 (class 1259 OID 34813)
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.maquinaria_id_maq_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 248
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.maquinaria_id_maq_seq OWNED BY public.maquinaria.id_maq;


--
-- TOC entry 249 (class 1259 OID 34814)
-- Name: materiales; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 250 (class 1259 OID 34826)
-- Name: materiales_id_mat_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.materiales_id_mat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 250
-- Name: materiales_id_mat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.materiales_id_mat_seq OWNED BY public.materiales.id_mat;


--
-- TOC entry 251 (class 1259 OID 34827)
-- Name: monitoreo_plagas; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 252 (class 1259 OID 34838)
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.monitoreo_plagas_id_monitoreo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 252
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.monitoreo_plagas_id_monitoreo_seq OWNED BY public.monitoreo_plagas.id_monitoreo;


--
-- TOC entry 253 (class 1259 OID 34839)
-- Name: movimientos_caja; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 254 (class 1259 OID 34854)
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movimientos_caja_id_mov_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 254
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movimientos_caja_id_mov_seq OWNED BY public.movimientos_caja.id_mov;


--
-- TOC entry 255 (class 1259 OID 34855)
-- Name: movimientos_material; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 256 (class 1259 OID 34866)
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movimientos_material_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 256
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movimientos_material_id_movimiento_seq OWNED BY public.movimientos_material.id_movimiento;


--
-- TOC entry 257 (class 1259 OID 34867)
-- Name: plagas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plagas (
    id_plaga integer NOT NULL,
    nombre_cientifico character varying(100),
    nombre_comun character varying(60) NOT NULL,
    tipo character varying(20),
    CONSTRAINT plagas_tipo_check CHECK (((tipo)::text = ANY (ARRAY[('Plaga'::character varying)::text, ('Enfermedad'::character varying)::text, ('Maleza'::character varying)::text])))
);


--
-- TOC entry 258 (class 1259 OID 34873)
-- Name: plagas_id_plaga_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plagas_id_plaga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 258
-- Name: plagas_id_plaga_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.plagas_id_plaga_seq OWNED BY public.plagas.id_plaga;


--
-- TOC entry 259 (class 1259 OID 34874)
-- Name: planilla_pago; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 260 (class 1259 OID 34889)
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.planilla_pago_id_planilla_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 260
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.planilla_pago_id_planilla_seq OWNED BY public.planilla_pago.id_planilla;


--
-- TOC entry 261 (class 1259 OID 34890)
-- Name: proveedores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    ruc character(11),
    razon_social character varying(100) NOT NULL,
    telefono character varying(15),
    email character varying(100),
    direccion text
);


--
-- TOC entry 262 (class 1259 OID 34897)
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 262
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;


--
-- TOC entry 263 (class 1259 OID 34898)
-- Name: regadio; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 264 (class 1259 OID 34909)
-- Name: regadio_id_reg_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.regadio_id_reg_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 264
-- Name: regadio_id_reg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.regadio_id_reg_seq OWNED BY public.regadio.id_reg;


--
-- TOC entry 265 (class 1259 OID 34910)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles_permisos (
    id_rol integer NOT NULL,
    nombre_rol character varying(30) NOT NULL,
    descripcion text,
    nivel_acceso integer DEFAULT 1
);


--
-- TOC entry 266 (class 1259 OID 34918)
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_permisos_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 266
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_permisos_id_rol_seq OWNED BY public.roles_permisos.id_rol;


--
-- TOC entry 267 (class 1259 OID 34919)
-- Name: tipo_cosecha; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_cosecha (
    id_tipo_cosecha integer NOT NULL,
    nombre_tipo character varying(30) NOT NULL,
    descripcion text,
    rendimiento_esperado_kg_ha numeric(10,2),
    orden_ciclo integer
);


--
-- TOC entry 268 (class 1259 OID 34926)
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 268
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_cosecha_id_tipo_cosecha_seq OWNED BY public.tipo_cosecha.id_tipo_cosecha;


--
-- TOC entry 269 (class 1259 OID 34927)
-- Name: trabajadores; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 270 (class 1259 OID 34945)
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trabajadores_id_trab_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 270
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trabajadores_id_trab_seq OWNED BY public.trabajadores.id_trab;


--
-- TOC entry 271 (class 1259 OID 34946)
-- Name: uso_materiales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uso_materiales (
    id_uso integer NOT NULL,
    id_mat integer NOT NULL,
    id_hect integer NOT NULL,
    fec_uso date DEFAULT CURRENT_DATE NOT NULL,
    hora_uso time without time zone DEFAULT CURRENT_TIME,
    cantidad numeric(10,2),
    CONSTRAINT uso_materiales_cantidad_check CHECK ((cantidad > (0)::numeric))
);


--
-- TOC entry 272 (class 1259 OID 34956)
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uso_materiales_id_uso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 272
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uso_materiales_id_uso_seq OWNED BY public.uso_materiales.id_uso;


--
-- TOC entry 273 (class 1259 OID 34957)
-- Name: usuario_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario_roles (
    id_usuario_rol integer NOT NULL,
    id_usuario integer NOT NULL,
    id_rol integer NOT NULL,
    fecha_asignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 274 (class 1259 OID 34964)
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_roles_id_usuario_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 274
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_roles_id_usuario_rol_seq OWNED BY public.usuario_roles.id_usuario_rol;


--
-- TOC entry 275 (class 1259 OID 34965)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 276 (class 1259 OID 34979)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 276
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 277 (class 1259 OID 34980)
-- Name: vista_alerta_stock; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 278 (class 1259 OID 34984)
-- Name: vista_ciclos_activos; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 279 (class 1259 OID 34989)
-- Name: vista_pagos_trabajadores; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 280 (class 1259 OID 34994)
-- Name: vista_reporte_riego; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 281 (class 1259 OID 34999)
-- Name: vista_resumen_cosechas; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 282 (class 1259 OID 35004)
-- Name: vista_resumen_financiero; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 283 (class 1259 OID 35008)
-- Name: vista_resumen_tareas; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 284 (class 1259 OID 35013)
-- Name: vw_login; Type: VIEW; Schema: public; Owner: -
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


--
-- TOC entry 5036 (class 2604 OID 35018)
-- Name: abono id_abono; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abono ALTER COLUMN id_abono SET DEFAULT nextval('public.abono_id_abono_seq'::regclass);


--
-- TOC entry 5040 (class 2604 OID 35019)
-- Name: asistencia id_asist; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia ALTER COLUMN id_asist SET DEFAULT nextval('public.asistencia_id_asist_seq'::regclass);


--
-- TOC entry 5047 (class 2604 OID 35020)
-- Name: cargos id_cargo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cargos ALTER COLUMN id_cargo SET DEFAULT nextval('public.cargos_id_cargo_seq'::regclass);


--
-- TOC entry 5050 (class 2604 OID 35021)
-- Name: ciclos_cultivo id_ciclo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciclos_cultivo ALTER COLUMN id_ciclo SET DEFAULT nextval('public.ciclos_cultivo_id_ciclo_seq'::regclass);


--
-- TOC entry 5052 (class 2604 OID 35022)
-- Name: compras id_compra; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras ALTER COLUMN id_compra SET DEFAULT nextval('public.compras_id_compra_seq'::regclass);


--
-- TOC entry 5054 (class 2604 OID 35023)
-- Name: compras_material id_compra; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras_material ALTER COLUMN id_compra SET DEFAULT nextval('public.compras_material_id_compra_seq'::regclass);


--
-- TOC entry 5058 (class 2604 OID 35024)
-- Name: control_calidad id_calidad; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.control_calidad ALTER COLUMN id_calidad SET DEFAULT nextval('public.control_calidad_id_calidad_seq'::regclass);


--
-- TOC entry 5060 (class 2604 OID 35025)
-- Name: cosechas id_cosecha; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cosechas ALTER COLUMN id_cosecha SET DEFAULT nextval('public.cosechas_id_cosecha_seq'::regclass);


--
-- TOC entry 5061 (class 2604 OID 35026)
-- Name: detalle_compras id_detalle; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_compras ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_compras_id_detalle_seq'::regclass);


--
-- TOC entry 5062 (class 2604 OID 35027)
-- Name: detalle_cosecha id_detalle; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_cosecha ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_cosecha_id_detalle_seq'::regclass);


--
-- TOC entry 5065 (class 2604 OID 35028)
-- Name: gasolina id_gasolina; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gasolina ALTER COLUMN id_gasolina SET DEFAULT nextval('public.gasolina_id_gasolina_seq'::regclass);


--
-- TOC entry 5068 (class 2604 OID 35029)
-- Name: gestion_cultivos id_gestion; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos ALTER COLUMN id_gestion SET DEFAULT nextval('public.gestion_cultivos_id_gestion_seq'::regclass);


--
-- TOC entry 5071 (class 2604 OID 35030)
-- Name: hectareas id_hect; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hectareas ALTER COLUMN id_hect SET DEFAULT nextval('public.hectareas_id_hect_seq'::regclass);


--
-- TOC entry 5123 (class 2604 OID 42843)
-- Name: incidencia id_inc; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia ALTER COLUMN id_inc SET DEFAULT nextval('public.incidencia_id_inc_seq'::regclass);


--
-- TOC entry 5073 (class 2604 OID 35031)
-- Name: logs_sistema id_log; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs_sistema ALTER COLUMN id_log SET DEFAULT nextval('public.logs_sistema_id_log_seq'::regclass);


--
-- TOC entry 5075 (class 2604 OID 35032)
-- Name: maquinaria id_maq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maquinaria ALTER COLUMN id_maq SET DEFAULT nextval('public.maquinaria_id_maq_seq'::regclass);


--
-- TOC entry 5077 (class 2604 OID 35033)
-- Name: materiales id_mat; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materiales ALTER COLUMN id_mat SET DEFAULT nextval('public.materiales_id_mat_seq'::regclass);


--
-- TOC entry 5083 (class 2604 OID 35034)
-- Name: monitoreo_plagas id_monitoreo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitoreo_plagas ALTER COLUMN id_monitoreo SET DEFAULT nextval('public.monitoreo_plagas_id_monitoreo_seq'::regclass);


--
-- TOC entry 5085 (class 2604 OID 35035)
-- Name: movimientos_caja id_mov; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_caja ALTER COLUMN id_mov SET DEFAULT nextval('public.movimientos_caja_id_mov_seq'::regclass);


--
-- TOC entry 5088 (class 2604 OID 35036)
-- Name: movimientos_material id_movimiento; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_material ALTER COLUMN id_movimiento SET DEFAULT nextval('public.movimientos_material_id_movimiento_seq'::regclass);


--
-- TOC entry 5090 (class 2604 OID 35037)
-- Name: plagas id_plaga; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plagas ALTER COLUMN id_plaga SET DEFAULT nextval('public.plagas_id_plaga_seq'::regclass);


--
-- TOC entry 5091 (class 2604 OID 35038)
-- Name: planilla_pago id_planilla; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planilla_pago ALTER COLUMN id_planilla SET DEFAULT nextval('public.planilla_pago_id_planilla_seq'::regclass);


--
-- TOC entry 5097 (class 2604 OID 35039)
-- Name: proveedores id_proveedor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);


--
-- TOC entry 5098 (class 2604 OID 35040)
-- Name: regadio id_reg; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regadio ALTER COLUMN id_reg SET DEFAULT nextval('public.regadio_id_reg_seq'::regclass);


--
-- TOC entry 5101 (class 2604 OID 35041)
-- Name: roles_permisos id_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id_rol SET DEFAULT nextval('public.roles_permisos_id_rol_seq'::regclass);


--
-- TOC entry 5103 (class 2604 OID 35042)
-- Name: tipo_cosecha id_tipo_cosecha; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_cosecha ALTER COLUMN id_tipo_cosecha SET DEFAULT nextval('public.tipo_cosecha_id_tipo_cosecha_seq'::regclass);


--
-- TOC entry 5104 (class 2604 OID 35043)
-- Name: trabajadores id_trab; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajadores ALTER COLUMN id_trab SET DEFAULT nextval('public.trabajadores_id_trab_seq'::regclass);


--
-- TOC entry 5110 (class 2604 OID 35044)
-- Name: uso_materiales id_uso; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uso_materiales ALTER COLUMN id_uso SET DEFAULT nextval('public.uso_materiales_id_uso_seq'::regclass);


--
-- TOC entry 5113 (class 2604 OID 35045)
-- Name: usuario_roles id_usuario_rol; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_roles ALTER COLUMN id_usuario_rol SET DEFAULT nextval('public.usuario_roles_id_usuario_rol_seq'::regclass);


--
-- TOC entry 5115 (class 2604 OID 35046)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5446 (class 0 OID 34650)
-- Dependencies: 219
-- Data for Name: abono; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5448 (class 0 OID 34662)
-- Dependencies: 221
-- Data for Name: asistencia; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.asistencia VALUES (3, 6, '2026-05-25', '15:00:00', '16:00:00', true, 11, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL, NULL, 0, NULL, 'PENDIENTE');
INSERT INTO public.asistencia VALUES (4, 5, '2026-05-14', '06:00:00', '02:00:00', true, 3, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL, NULL, 0, NULL, 'PENDIENTE');
INSERT INTO public.asistencia VALUES (6, 25, '2026-05-26', '09:30:00', '12:30:00', true, 0, '2026-05-26 03:41:44.25085', '2026-05-26 03:41:44.25085', NULL, 'RIEGO', 1, 'no lleno el 4 cajon', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (7, 25, '2026-05-28', '14:05:00', '23:37:00', true, 0, '2026-05-28 14:36:08.62982', '2026-05-28 14:36:08.62982', NULL, 'RIEGO', 1, '', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (10, 25, '2026-05-29', '14:37:00', '20:42:00', true, 0, '2026-05-28 14:37:17.707479', '2026-05-28 14:37:17.707479', NULL, 'RIEGO', 1, 'asd', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (11, 26, '2026-06-03', NULL, NULL, true, 0, '2026-06-02 20:37:34.26605', '2026-06-02 20:37:34.26605', NULL, 'TRANSPLANTE', 1, 'Lote A – Zona Norte', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (12, 25, '2026-06-03', NULL, NULL, true, 0, '2026-06-02 20:43:25.537512', '2026-06-02 20:43:25.537512', NULL, 'CARGA', 1, 'Lote A – Zona Norte', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (14, 28, '2026-06-03', NULL, NULL, true, 0, '2026-06-02 22:50:31.375961', '2026-06-02 22:50:31.375961', NULL, 'SACA', 1, 'Lote A – Zona Norte', 'PENDIENTE');
INSERT INTO public.asistencia VALUES (15, 26, '2026-06-04', NULL, NULL, true, 0, '2026-06-03 19:35:43.225359', '2026-06-03 20:11:24.320023', NULL, 'TRANSPLANTE', 1, 'Lote A – Zona Norte', 'APROBADO');
INSERT INTO public.asistencia VALUES (16, 25, '2026-06-04', NULL, NULL, true, 0, '2026-06-03 20:12:07.232895', '2026-06-03 20:12:07.232895', NULL, 'CARGA', 1, 'Lote A – Zona Norte', 'PENDIENTE');


--
-- TOC entry 5450 (class 0 OID 34678)
-- Dependencies: 223
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cargos VALUES (1, 'Administrador', true, '2026-05-26 02:13:45.907169');
INSERT INTO public.cargos VALUES (2, 'Supervisor', true, '2026-05-26 02:13:45.907169');
INSERT INTO public.cargos VALUES (3, 'Operario', true, '2026-05-26 02:13:45.907169');
INSERT INTO public.cargos VALUES (4, 'Jornalero', true, '2026-05-26 02:13:45.907169');


--
-- TOC entry 5452 (class 0 OID 34686)
-- Dependencies: 225
-- Data for Name: ciclos_cultivo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5454 (class 0 OID 34696)
-- Dependencies: 227
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5456 (class 0 OID 34706)
-- Dependencies: 229
-- Data for Name: compras_material; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5458 (class 0 OID 34719)
-- Dependencies: 231
-- Data for Name: control_calidad; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5460 (class 0 OID 34730)
-- Dependencies: 233
-- Data for Name: cosechas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5462 (class 0 OID 34744)
-- Dependencies: 235
-- Data for Name: detalle_compras; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5464 (class 0 OID 34752)
-- Dependencies: 237
-- Data for Name: detalle_cosecha; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5466 (class 0 OID 34764)
-- Dependencies: 239
-- Data for Name: gasolina; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.gasolina VALUES (1, '2026-05-29', 'TRANSPORTE_PERSONAL', 'Carguera ROJA', NULL, 2.00, 'Peralta', 'Luis Santamaria', NULL, 'Recojo de personal ', '2026-05-29 00:07:11.934889');
INSERT INTO public.gasolina VALUES (2, '2026-05-29', 'FUMIGACION', 'C', 'Mochila Honda', 1.00, 'Paico', 'juan montalvan', NULL, NULL, '2026-05-29 00:08:19.0211');


--
-- TOC entry 5468 (class 0 OID 34775)
-- Dependencies: 241
-- Data for Name: gestion_cultivos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5470 (class 0 OID 34786)
-- Dependencies: 243
-- Data for Name: hectareas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.hectareas VALUES (1, 'Lote A - Zona Norte', 5.50, 'IR-43', true);
INSERT INTO public.hectareas VALUES (2, 'Lote B - Zona Sur', 3.20, 'Jabalí', true);
INSERT INTO public.hectareas VALUES (3, 'Lote C - Zona Este', 7.00, 'Amazonas', true);


--
-- TOC entry 5505 (class 0 OID 42840)
-- Dependencies: 286
-- Data for Name: incidencia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5472 (class 0 OID 34794)
-- Dependencies: 245
-- Data for Name: logs_sistema; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5474 (class 0 OID 34805)
-- Dependencies: 247
-- Data for Name: maquinaria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.maquinaria VALUES (1, 'Tractor John Deere', 'Tractor', 50.00, true);
INSERT INTO public.maquinaria VALUES (2, 'Cosechadora New Holland', 'Cosechadora', 80.00, true);
INSERT INTO public.maquinaria VALUES (3, 'Rastra de discos', 'Implemento', 30.00, true);


--
-- TOC entry 5476 (class 0 OID 34814)
-- Dependencies: 249
-- Data for Name: materiales; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.materiales VALUES (1, 'Urea', 'Fertilizante', 1000.00, 100.00, 'kg', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169');
INSERT INTO public.materiales VALUES (3, 'Cloruro de potasio', 'Fertilizante', 800.00, 80.00, 'kg', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169');
INSERT INTO public.materiales VALUES (4, 'Glifosato', 'Herbicida', 200.00, 20.00, 'litros', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169');
INSERT INTO public.materiales VALUES (2, 'Fosfato diamónico', 'Fertilizante', 51.00, 50.00, 'kg', true, '2026-05-26 02:13:45.907169', '2026-06-02 22:30:25.799786');
INSERT INTO public.materiales VALUES (5, 'Hoz', 'Herramienta', 5.00, 5.00, 'unidad', true, '2026-06-02 22:31:30.834829', '2026-06-02 22:42:06.854125');


--
-- TOC entry 5478 (class 0 OID 34827)
-- Dependencies: 251
-- Data for Name: monitoreo_plagas; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5480 (class 0 OID 34839)
-- Dependencies: 253
-- Data for Name: movimientos_caja; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.movimientos_caja VALUES (3, '2026-06-03', '22:10:33.506695', 'Egreso', 'General', 240.00, NULL, NULL, NULL, 'Pago planilla 16 · juan montalvan');
INSERT INTO public.movimientos_caja VALUES (4, '2026-06-03', '22:20:24.646693', 'Egreso', 'General', 240.00, NULL, NULL, NULL, 'Pago planilla 22 · juan montalvan');
INSERT INTO public.movimientos_caja VALUES (5, '2026-06-03', '22:20:53.296037', 'Egreso', 'General', 240.00, NULL, NULL, NULL, 'Pago planilla 23 · juan montalvan');
INSERT INTO public.movimientos_caja VALUES (6, '2026-06-03', '22:23:20.306536', 'Egreso', 'General', 50.00, NULL, NULL, NULL, 'Pago planilla 24 · miguel velazques');
INSERT INTO public.movimientos_caja VALUES (7, '2026-06-04', '20:11:46.254812', 'Egreso', 'General', 50.00, NULL, NULL, NULL, 'Pago planilla 25 · Rodrigo Diaz');


--
-- TOC entry 5482 (class 0 OID 34855)
-- Dependencies: 255
-- Data for Name: movimientos_material; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.movimientos_material VALUES (1, 2, 'SALIDA', 1.00, 500.00, 499.00, 'Uso de material (-1)', '2026-06-02 22:27:36.569241', NULL);
INSERT INTO public.movimientos_material VALUES (2, 2, 'SALIDA', 1.00, 500.00, 499.00, 'Cambio automático via sistema', '2026-06-02 22:27:36.566515', NULL);
INSERT INTO public.movimientos_material VALUES (3, 2, 'SALIDA', 390.00, 499.00, 109.00, 'Uso de material (-390)', '2026-06-02 22:27:45.645014', NULL);
INSERT INTO public.movimientos_material VALUES (4, 2, 'SALIDA', 390.00, 499.00, 109.00, 'Cambio automático via sistema', '2026-06-02 22:27:45.644162', NULL);
INSERT INTO public.movimientos_material VALUES (5, 2, 'SALIDA', 100.00, 109.00, 9.00, 'Uso de material (-100)', '2026-06-02 22:27:50.347215', NULL);
INSERT INTO public.movimientos_material VALUES (6, 2, 'SALIDA', 100.00, 109.00, 9.00, 'Cambio automático via sistema', '2026-06-02 22:27:50.347555', NULL);
INSERT INTO public.movimientos_material VALUES (7, 2, 'ENTRADA', 1.00, 9.00, 10.00, 'Ingreso de material (+1)', '2026-06-02 22:28:39.727121', NULL);
INSERT INTO public.movimientos_material VALUES (8, 2, 'ENTRADA', 1.00, 9.00, 10.00, 'Cambio automático via sistema', '2026-06-02 22:28:39.726679', NULL);
INSERT INTO public.movimientos_material VALUES (9, 2, 'ENTRADA', 1.00, 10.00, 11.00, 'Ingreso de material (+1)', '2026-06-02 22:28:40.232029', NULL);
INSERT INTO public.movimientos_material VALUES (10, 2, 'ENTRADA', 1.00, 10.00, 11.00, 'Cambio automático via sistema', '2026-06-02 22:28:40.232281', NULL);
INSERT INTO public.movimientos_material VALUES (11, 2, 'ENTRADA', 1.00, 11.00, 12.00, 'Ingreso de material (+1)', '2026-06-02 22:28:40.387433', NULL);
INSERT INTO public.movimientos_material VALUES (12, 2, 'ENTRADA', 1.00, 11.00, 12.00, 'Cambio automático via sistema', '2026-06-02 22:28:40.386995', NULL);
INSERT INTO public.movimientos_material VALUES (13, 2, 'ENTRADA', 1.00, 12.00, 13.00, 'Ingreso de material (+1)', '2026-06-02 22:28:40.547328', NULL);
INSERT INTO public.movimientos_material VALUES (14, 2, 'ENTRADA', 1.00, 12.00, 13.00, 'Cambio automático via sistema', '2026-06-02 22:28:40.54743', NULL);
INSERT INTO public.movimientos_material VALUES (15, 2, 'ENTRADA', 1.00, 13.00, 14.00, 'Ingreso de material (+1)', '2026-06-02 22:28:40.689486', NULL);
INSERT INTO public.movimientos_material VALUES (16, 2, 'ENTRADA', 1.00, 13.00, 14.00, 'Cambio automático via sistema', '2026-06-02 22:28:40.689688', NULL);
INSERT INTO public.movimientos_material VALUES (17, 2, 'ENTRADA', 1.00, 14.00, 15.00, 'Ingreso de material (+1)', '2026-06-02 22:28:40.84756', NULL);
INSERT INTO public.movimientos_material VALUES (18, 2, 'ENTRADA', 1.00, 14.00, 15.00, 'Cambio automático via sistema', '2026-06-02 22:28:40.846894', NULL);
INSERT INTO public.movimientos_material VALUES (19, 2, 'ENTRADA', 1.00, 15.00, 16.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.003139', NULL);
INSERT INTO public.movimientos_material VALUES (20, 2, 'ENTRADA', 1.00, 15.00, 16.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.002433', NULL);
INSERT INTO public.movimientos_material VALUES (21, 2, 'ENTRADA', 1.00, 16.00, 17.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.163536', NULL);
INSERT INTO public.movimientos_material VALUES (22, 2, 'ENTRADA', 1.00, 16.00, 17.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.162362', NULL);
INSERT INTO public.movimientos_material VALUES (23, 2, 'ENTRADA', 1.00, 17.00, 18.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.31626', NULL);
INSERT INTO public.movimientos_material VALUES (24, 2, 'ENTRADA', 1.00, 17.00, 18.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.315735', NULL);
INSERT INTO public.movimientos_material VALUES (25, 2, 'ENTRADA', 1.00, 18.00, 19.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.473709', NULL);
INSERT INTO public.movimientos_material VALUES (26, 2, 'ENTRADA', 1.00, 18.00, 19.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.473663', NULL);
INSERT INTO public.movimientos_material VALUES (27, 2, 'ENTRADA', 1.00, 19.00, 20.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.627255', NULL);
INSERT INTO public.movimientos_material VALUES (28, 2, 'ENTRADA', 1.00, 19.00, 20.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.627054', NULL);
INSERT INTO public.movimientos_material VALUES (29, 2, 'ENTRADA', 1.00, 20.00, 21.00, 'Ingreso de material (+1)', '2026-06-02 22:28:41.782671', NULL);
INSERT INTO public.movimientos_material VALUES (30, 2, 'ENTRADA', 1.00, 20.00, 21.00, 'Cambio automático via sistema', '2026-06-02 22:28:41.78284', NULL);
INSERT INTO public.movimientos_material VALUES (31, 2, 'ENTRADA', 1.00, 21.00, 22.00, 'Ingreso de material (+1)', '2026-06-02 22:28:42.219466', NULL);
INSERT INTO public.movimientos_material VALUES (32, 2, 'ENTRADA', 1.00, 21.00, 22.00, 'Cambio automático via sistema', '2026-06-02 22:28:42.219004', NULL);
INSERT INTO public.movimientos_material VALUES (33, 2, 'ENTRADA', 1.00, 22.00, 23.00, 'Ingreso de material (+1)', '2026-06-02 22:28:42.423026', NULL);
INSERT INTO public.movimientos_material VALUES (34, 2, 'ENTRADA', 1.00, 22.00, 23.00, 'Cambio automático via sistema', '2026-06-02 22:28:42.423618', NULL);
INSERT INTO public.movimientos_material VALUES (35, 2, 'ENTRADA', 1.00, 23.00, 24.00, 'Ingreso de material (+1)', '2026-06-02 22:28:42.626752', NULL);
INSERT INTO public.movimientos_material VALUES (36, 2, 'ENTRADA', 1.00, 23.00, 24.00, 'Cambio automático via sistema', '2026-06-02 22:28:42.626916', NULL);
INSERT INTO public.movimientos_material VALUES (37, 2, 'ENTRADA', 1.00, 24.00, 25.00, 'Ingreso de material (+1)', '2026-06-02 22:28:42.836334', NULL);
INSERT INTO public.movimientos_material VALUES (38, 2, 'ENTRADA', 1.00, 24.00, 25.00, 'Cambio automático via sistema', '2026-06-02 22:28:42.836152', NULL);
INSERT INTO public.movimientos_material VALUES (39, 2, 'ENTRADA', 1.00, 25.00, 26.00, 'Ingreso de material (+1)', '2026-06-02 22:28:43.039468', NULL);
INSERT INTO public.movimientos_material VALUES (40, 2, 'ENTRADA', 1.00, 25.00, 26.00, 'Cambio automático via sistema', '2026-06-02 22:28:43.039207', NULL);
INSERT INTO public.movimientos_material VALUES (41, 2, 'ENTRADA', 1.00, 26.00, 27.00, 'Ingreso de material (+1)', '2026-06-02 22:28:43.245676', NULL);
INSERT INTO public.movimientos_material VALUES (42, 2, 'ENTRADA', 1.00, 26.00, 27.00, 'Cambio automático via sistema', '2026-06-02 22:28:43.245318', NULL);
INSERT INTO public.movimientos_material VALUES (43, 2, 'ENTRADA', 1.00, 27.00, 28.00, 'Ingreso de material (+1)', '2026-06-02 22:28:43.451339', NULL);
INSERT INTO public.movimientos_material VALUES (44, 2, 'ENTRADA', 1.00, 27.00, 28.00, 'Cambio automático via sistema', '2026-06-02 22:28:43.451612', NULL);
INSERT INTO public.movimientos_material VALUES (45, 2, 'ENTRADA', 1.00, 28.00, 29.00, 'Ingreso de material (+1)', '2026-06-02 22:28:43.654626', NULL);
INSERT INTO public.movimientos_material VALUES (46, 2, 'ENTRADA', 1.00, 28.00, 29.00, 'Cambio automático via sistema', '2026-06-02 22:28:43.655046', NULL);
INSERT INTO public.movimientos_material VALUES (47, 2, 'ENTRADA', 1.00, 29.00, 30.00, 'Ingreso de material (+1)', '2026-06-02 22:28:43.862794', NULL);
INSERT INTO public.movimientos_material VALUES (48, 2, 'ENTRADA', 1.00, 29.00, 30.00, 'Cambio automático via sistema', '2026-06-02 22:28:43.862968', NULL);
INSERT INTO public.movimientos_material VALUES (49, 2, 'ENTRADA', 1.00, 30.00, 31.00, 'Ingreso de material (+1)', '2026-06-02 22:28:44.065776', NULL);
INSERT INTO public.movimientos_material VALUES (50, 2, 'ENTRADA', 1.00, 30.00, 31.00, 'Cambio automático via sistema', '2026-06-02 22:28:44.065766', NULL);
INSERT INTO public.movimientos_material VALUES (51, 2, 'ENTRADA', 1.00, 31.00, 32.00, 'Ingreso de material (+1)', '2026-06-02 22:28:44.272505', NULL);
INSERT INTO public.movimientos_material VALUES (52, 2, 'ENTRADA', 1.00, 31.00, 32.00, 'Cambio automático via sistema', '2026-06-02 22:28:44.271629', NULL);
INSERT INTO public.movimientos_material VALUES (53, 2, 'ENTRADA', 1.00, 32.00, 33.00, 'Ingreso de material (+1)', '2026-06-02 22:28:44.47736', NULL);
INSERT INTO public.movimientos_material VALUES (54, 2, 'ENTRADA', 1.00, 32.00, 33.00, 'Cambio automático via sistema', '2026-06-02 22:28:44.476909', NULL);
INSERT INTO public.movimientos_material VALUES (55, 2, 'ENTRADA', 1.00, 33.00, 34.00, 'Ingreso de material (+1)', '2026-06-02 22:28:44.683209', NULL);
INSERT INTO public.movimientos_material VALUES (56, 2, 'ENTRADA', 1.00, 33.00, 34.00, 'Cambio automático via sistema', '2026-06-02 22:28:44.68321', NULL);
INSERT INTO public.movimientos_material VALUES (57, 2, 'ENTRADA', 26.00, 34.00, 60.00, 'Ingreso de material (+26)', '2026-06-02 22:28:48.035537', NULL);
INSERT INTO public.movimientos_material VALUES (58, 2, 'ENTRADA', 26.00, 34.00, 60.00, 'Cambio automático via sistema', '2026-06-02 22:28:48.035513', NULL);
INSERT INTO public.movimientos_material VALUES (59, 2, 'SALIDA', 1.00, 60.00, 59.00, 'Uso de material (-1)', '2026-06-02 22:28:49.196644', NULL);
INSERT INTO public.movimientos_material VALUES (60, 2, 'SALIDA', 1.00, 60.00, 59.00, 'Cambio automático via sistema', '2026-06-02 22:28:49.197037', NULL);
INSERT INTO public.movimientos_material VALUES (61, 2, 'SALIDA', 1.00, 59.00, 58.00, 'Uso de material (-1)', '2026-06-02 22:28:49.431299', NULL);
INSERT INTO public.movimientos_material VALUES (62, 2, 'SALIDA', 1.00, 59.00, 58.00, 'Cambio automático via sistema', '2026-06-02 22:28:49.431068', NULL);
INSERT INTO public.movimientos_material VALUES (63, 2, 'SALIDA', 1.00, 58.00, 57.00, 'Uso de material (-1)', '2026-06-02 22:28:49.839187', NULL);
INSERT INTO public.movimientos_material VALUES (64, 2, 'SALIDA', 1.00, 58.00, 57.00, 'Cambio automático via sistema', '2026-06-02 22:28:49.839575', NULL);
INSERT INTO public.movimientos_material VALUES (65, 2, 'SALIDA', 1.00, 57.00, 56.00, 'Uso de material (-1)', '2026-06-02 22:28:50.042572', NULL);
INSERT INTO public.movimientos_material VALUES (66, 2, 'SALIDA', 1.00, 57.00, 56.00, 'Cambio automático via sistema', '2026-06-02 22:28:50.043027', NULL);
INSERT INTO public.movimientos_material VALUES (67, 2, 'SALIDA', 1.00, 56.00, 55.00, 'Uso de material (-1)', '2026-06-02 22:28:50.251144', NULL);
INSERT INTO public.movimientos_material VALUES (68, 2, 'SALIDA', 1.00, 56.00, 55.00, 'Cambio automático via sistema', '2026-06-02 22:28:50.251393', NULL);
INSERT INTO public.movimientos_material VALUES (69, 2, 'SALIDA', 1.00, 55.00, 54.00, 'Uso de material (-1)', '2026-06-02 22:28:50.453886', NULL);
INSERT INTO public.movimientos_material VALUES (70, 2, 'SALIDA', 1.00, 55.00, 54.00, 'Cambio automático via sistema', '2026-06-02 22:28:50.453905', NULL);
INSERT INTO public.movimientos_material VALUES (71, 2, 'SALIDA', 1.00, 54.00, 53.00, 'Uso de material (-1)', '2026-06-02 22:28:50.657247', NULL);
INSERT INTO public.movimientos_material VALUES (72, 2, 'SALIDA', 1.00, 54.00, 53.00, 'Cambio automático via sistema', '2026-06-02 22:28:50.657732', NULL);
INSERT INTO public.movimientos_material VALUES (73, 2, 'SALIDA', 1.00, 53.00, 52.00, 'Uso de material (-1)', '2026-06-02 22:28:50.864027', NULL);
INSERT INTO public.movimientos_material VALUES (74, 2, 'SALIDA', 1.00, 53.00, 52.00, 'Cambio automático via sistema', '2026-06-02 22:28:50.86442', NULL);
INSERT INTO public.movimientos_material VALUES (75, 2, 'SALIDA', 1.00, 52.00, 51.00, 'Uso de material (-1)', '2026-06-02 22:28:51.067461', NULL);
INSERT INTO public.movimientos_material VALUES (76, 2, 'SALIDA', 1.00, 52.00, 51.00, 'Cambio automático via sistema', '2026-06-02 22:28:51.067329', NULL);
INSERT INTO public.movimientos_material VALUES (77, 2, 'SALIDA', 1.00, 51.00, 50.00, 'Uso de material (-1)', '2026-06-02 22:28:51.273266', NULL);
INSERT INTO public.movimientos_material VALUES (78, 2, 'SALIDA', 1.00, 51.00, 50.00, 'Cambio automático via sistema', '2026-06-02 22:28:51.272896', NULL);
INSERT INTO public.movimientos_material VALUES (79, 2, 'SALIDA', 1.00, 50.00, 49.00, 'Uso de material (-1)', '2026-06-02 22:28:51.481288', NULL);
INSERT INTO public.movimientos_material VALUES (80, 2, 'SALIDA', 1.00, 50.00, 49.00, 'Cambio automático via sistema', '2026-06-02 22:28:51.481438', NULL);
INSERT INTO public.movimientos_material VALUES (81, 2, 'SALIDA', 48.00, 49.00, 1.00, 'Uso de material (-48)', '2026-06-02 22:28:56.526477', NULL);
INSERT INTO public.movimientos_material VALUES (82, 2, 'SALIDA', 48.00, 49.00, 1.00, 'Cambio automático via sistema', '2026-06-02 22:28:56.526751', NULL);
INSERT INTO public.movimientos_material VALUES (83, 2, 'ENTRADA', 1.00, 1.00, 2.00, 'Ingreso de material (+1)', '2026-06-02 22:30:17.324327', NULL);
INSERT INTO public.movimientos_material VALUES (84, 2, 'ENTRADA', 1.00, 1.00, 2.00, 'Cambio automático via sistema', '2026-06-02 22:30:17.324814', NULL);
INSERT INTO public.movimientos_material VALUES (85, 2, 'ENTRADA', 1.00, 2.00, 3.00, 'Ingreso de material (+1)', '2026-06-02 22:30:17.551198', NULL);
INSERT INTO public.movimientos_material VALUES (86, 2, 'ENTRADA', 1.00, 2.00, 3.00, 'Cambio automático via sistema', '2026-06-02 22:30:17.551199', NULL);
INSERT INTO public.movimientos_material VALUES (87, 2, 'ENTRADA', 46.00, 3.00, 49.00, 'Ingreso de material (+46)', '2026-06-02 22:30:22.66834', NULL);
INSERT INTO public.movimientos_material VALUES (88, 2, 'ENTRADA', 46.00, 3.00, 49.00, 'Cambio automático via sistema', '2026-06-02 22:30:22.668542', NULL);
INSERT INTO public.movimientos_material VALUES (89, 2, 'ENTRADA', 1.00, 49.00, 50.00, 'Ingreso de material (+1)', '2026-06-02 22:30:24.80821', NULL);
INSERT INTO public.movimientos_material VALUES (90, 2, 'ENTRADA', 1.00, 49.00, 50.00, 'Cambio automático via sistema', '2026-06-02 22:30:24.807858', NULL);
INSERT INTO public.movimientos_material VALUES (91, 2, 'ENTRADA', 1.00, 50.00, 51.00, 'Ingreso de material (+1)', '2026-06-02 22:30:25.799338', NULL);
INSERT INTO public.movimientos_material VALUES (92, 2, 'ENTRADA', 1.00, 50.00, 51.00, 'Cambio automático via sistema', '2026-06-02 22:30:25.799786', NULL);
INSERT INTO public.movimientos_material VALUES (93, 5, 'SALIDA', 1.00, 50.00, 49.00, 'Uso de material (-1)', '2026-06-02 22:31:36.420666', NULL);
INSERT INTO public.movimientos_material VALUES (94, 5, 'SALIDA', 1.00, 50.00, 49.00, 'Cambio automático via sistema', '2026-06-02 22:31:36.4205', NULL);
INSERT INTO public.movimientos_material VALUES (95, 5, 'SALIDA', 1.00, 49.00, 48.00, 'Uso de material (-1)', '2026-06-02 22:31:37.094357', NULL);
INSERT INTO public.movimientos_material VALUES (96, 5, 'SALIDA', 1.00, 49.00, 48.00, 'Cambio automático via sistema', '2026-06-02 22:31:37.093913', NULL);
INSERT INTO public.movimientos_material VALUES (97, 5, 'SALIDA', 43.00, 48.00, 5.00, 'Uso de material (-43)', '2026-06-02 22:31:40.306729', NULL);
INSERT INTO public.movimientos_material VALUES (98, 5, 'SALIDA', 43.00, 48.00, 5.00, 'Cambio automático via sistema', '2026-06-02 22:31:40.30702', NULL);
INSERT INTO public.movimientos_material VALUES (99, 5, 'ENTRADA', 1.00, 5.00, 6.00, 'Ingreso de material (+1)', '2026-06-02 22:31:41.299973', NULL);
INSERT INTO public.movimientos_material VALUES (100, 5, 'ENTRADA', 1.00, 5.00, 6.00, 'Cambio automático via sistema', '2026-06-02 22:31:41.300324', NULL);
INSERT INTO public.movimientos_material VALUES (101, 5, 'SALIDA', 1.00, 6.00, 5.00, 'Uso de material (-1)', '2026-06-02 22:42:06.854327', NULL);
INSERT INTO public.movimientos_material VALUES (102, 5, 'SALIDA', 1.00, 6.00, 5.00, 'Cambio automático via sistema', '2026-06-02 22:42:06.854125', NULL);


--
-- TOC entry 5484 (class 0 OID 34867)
-- Dependencies: 257
-- Data for Name: plagas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.plagas VALUES (1, 'Tagosodes orizicolus', 'Sogata', 'Plaga');
INSERT INTO public.plagas VALUES (2, 'Magnaporthe oryzae', 'Pyricularia', 'Enfermedad');
INSERT INTO public.plagas VALUES (3, 'Spodoptera frugiperda', 'Gusano cogollero', 'Plaga');
INSERT INTO public.plagas VALUES (4, 'Oryza sativa var. sylvatica', 'Maleza arroz rojo', 'Maleza');


--
-- TOC entry 5486 (class 0 OID 34874)
-- Dependencies: 259
-- Data for Name: planilla_pago; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.planilla_pago VALUES (1, 11, '2026-05-01', '2026-05-31', 0, 0, 0.00, 'pendiente', NULL, '2026-05-28 14:24:36.517422', 0, NULL);
INSERT INTO public.planilla_pago VALUES (2, 25, '2026-05-01', '2026-05-31', 0, 0, 60.00, 'pendiente', NULL, '2026-05-28 14:25:13.945775', 1, 'CARGA');
INSERT INTO public.planilla_pago VALUES (3, 25, '2026-05-01', '2026-05-31', 0, 0, 180.00, 'pendiente', NULL, '2026-05-28 14:38:10.940479', 3, 'CARGA');
INSERT INTO public.planilla_pago VALUES (4, 25, '2026-05-01', '2026-05-31', 0, 0, 180.00, 'pendiente', NULL, '2026-05-28 14:40:21.888501', 3, 'CARGA');
INSERT INTO public.planilla_pago VALUES (5, 25, '2026-05-01', '2026-05-31', 0, 0, 180.00, 'pendiente', NULL, '2026-05-28 14:41:32.737718', 3, 'CARGA');
INSERT INTO public.planilla_pago VALUES (6, 25, '2026-05-01', '2026-05-31', 0, 0, 180.00, 'pendiente', NULL, '2026-05-28 14:57:48.910015', 3, 'CARGA');
INSERT INTO public.planilla_pago VALUES (7, 25, '2026-05-01', '2026-05-31', 0, 0, 180.00, 'pendiente', NULL, '2026-05-28 14:59:36.845825', 3, 'CARGA');
INSERT INTO public.planilla_pago VALUES (8, 28, '2026-05-01', '2026-06-30', 0, 0, 0.00, 'pendiente', NULL, '2026-06-02 21:13:43.860218', 0, 'SACA');
INSERT INTO public.planilla_pago VALUES (9, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 21:13:51.650593', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (10, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 21:24:36.171485', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (11, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pendiente', NULL, '2026-06-02 21:25:01.305411', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (12, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 21:34:12.444883', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (13, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pendiente', NULL, '2026-06-02 21:39:42.760387', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (14, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 21:39:57.502888', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (15, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 21:43:58.848928', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (16, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 22:10:31.099945', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (17, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pendiente', NULL, '2026-06-02 22:10:45.918255', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (22, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 22:20:20.81429', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (23, 25, '2026-05-01', '2026-06-30', 0, 0, 240.00, 'pagado', NULL, '2026-06-02 22:20:47.709464', 4, 'CARGA');
INSERT INTO public.planilla_pago VALUES (24, 26, '2026-05-01', '2026-06-30', 0, 0, 50.00, 'pagado', NULL, '2026-06-02 22:23:18.099747', 1, 'TRANSPLANTE');
INSERT INTO public.planilla_pago VALUES (25, 28, '2026-06-01', '2026-06-30', 0, 0, 50.00, 'pagado', NULL, '2026-06-03 20:11:44.173826', 1, 'SACA');


--
-- TOC entry 5488 (class 0 OID 34890)
-- Dependencies: 261
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5490 (class 0 OID 34898)
-- Dependencies: 263
-- Data for Name: regadio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5492 (class 0 OID 34910)
-- Dependencies: 265
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roles_permisos VALUES (1, 'Administrador', 'Acceso total', 4);
INSERT INTO public.roles_permisos VALUES (2, 'Supervisor', 'Gestión completa', 3);
INSERT INTO public.roles_permisos VALUES (3, 'Operador', 'Tareas diarias', 2);


--
-- TOC entry 5494 (class 0 OID 34919)
-- Dependencies: 267
-- Data for Name: tipo_cosecha; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipo_cosecha VALUES (1, 'Primera cosecha', 'Cosecha principal del ciclo', 8000.00, 1);
INSERT INTO public.tipo_cosecha VALUES (2, 'Segunda cosecha', 'Rebrote controlado', 4500.00, 2);
INSERT INTO public.tipo_cosecha VALUES (3, 'Soca', 'Cosecha de retoños naturales', 3000.00, 3);


--
-- TOC entry 5496 (class 0 OID 34927)
-- Dependencies: 269
-- Data for Name: trabajadores; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.trabajadores VALUES (6, 'María', 'López', '87654321', 2, 'tiempo', 100.00, NULL, '2026-05-07', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL);
INSERT INTO public.trabajadores VALUES (11, 'Admin', 'Sistema', '00000001', 1, 'tiempo', NULL, NULL, '2026-05-25', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL);
INSERT INTO public.trabajadores VALUES (14, 'Operador', 'Sistema', '00000003', 3, 'tiempo', NULL, NULL, '2026-05-25', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL);
INSERT INTO public.trabajadores VALUES (16, 'Supervisor', 'Sistema', '0SYS0002', 2, 'tiempo', NULL, NULL, '2026-05-25', true, '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', NULL);
INSERT INTO public.trabajadores VALUES (17, 'Admin', 'Sistema', 'SYS00001', 1, 'tiempo', NULL, NULL, '2026-05-26', true, '2026-05-26 02:43:24.957894', '2026-05-26 02:43:24.957894', NULL);
INSERT INTO public.trabajadores VALUES (20, 'Jose', 'Santamaria', '72618225', 1, 'jornal', NULL, NULL, '2026-05-26', true, '2026-05-26 02:52:45.582354', '2026-05-26 02:52:45.582354', NULL);
INSERT INTO public.trabajadores VALUES (5, 'Carlos', 'Gómez', '12345678', 1, 'tiempo', 120.00, NULL, '2026-05-07', false, '2026-05-26 02:13:45.907169', '2026-05-26 02:52:59.366924', NULL);
INSERT INTO public.trabajadores VALUES (21, 'Alexis', 'Marquez', '17620174', 2, 'jornal', NULL, NULL, '2026-05-26', false, '2026-05-26 02:54:08.907375', '2026-05-26 02:55:52.248477', NULL);
INSERT INTO public.trabajadores VALUES (22, 'Alexis', 'Marquez', '78945612', 3, 'destajo', NULL, NULL, '2026-05-26', true, '2026-05-26 03:01:58.075579', '2026-05-26 03:01:58.075579', NULL);
INSERT INTO public.trabajadores VALUES (23, 'kevin', 'Santamaria', '72618223', 2, 'destajo', NULL, NULL, '2026-05-26', true, '2026-05-26 03:02:27.299608', '2026-05-26 03:02:27.299608', NULL);
INSERT INTO public.trabajadores VALUES (24, 'Luis', 'Santamaria', '72618224', 3, 'destajo', NULL, NULL, '2026-05-26', true, '2026-05-26 03:02:52.041205', '2026-05-26 03:02:52.041205', NULL);
INSERT INTO public.trabajadores VALUES (7, 'Juan', 'Pérez', '11112222', 3, 'rendimiento', NULL, 3.50, '2026-05-07', true, '2026-05-26 02:13:45.907169', '2026-05-26 03:28:33.225114', NULL);
INSERT INTO public.trabajadores VALUES (8, 'Pedro', 'Ramírez', '33334444', 3, 'rendimiento', NULL, 3.50, '2026-05-07', false, '2026-05-26 02:13:45.907169', '2026-05-26 03:28:33.225114', NULL);
INSERT INTO public.trabajadores VALUES (25, 'juan', 'montalvan', '17620194', 1, 'carga', NULL, NULL, '2026-05-26', true, '2026-05-26 03:40:27.908507', '2026-05-26 03:40:27.908507', 60.00);
INSERT INTO public.trabajadores VALUES (26, 'miguel', 'velazques', '88888888', 1, 'transplante', NULL, NULL, '2026-05-28', true, '2026-05-28 14:02:50.307484', '2026-05-28 14:02:50.307484', 50.00);
INSERT INTO public.trabajadores VALUES (27, 'Raul', 'Gomez', '45612378', 1, 'jornal', 50.00, NULL, '2026-06-02', false, '2026-06-02 21:00:29.118792', '2026-06-02 21:01:40.321671', NULL);
INSERT INTO public.trabajadores VALUES (28, 'Rodrigo', 'Diaz', '45612376', 1, 'saca', NULL, NULL, '2026-06-02', true, '2026-06-02 21:02:17.78771', '2026-06-02 21:02:17.78771', 50.00);
INSERT INTO public.trabajadores VALUES (29, 'Juan', 'Martinez', '12345679', 1, 'riego', NULL, NULL, '2026-06-02', true, '2026-06-02 22:29:59.961516', '2026-06-02 22:29:59.961516', 50.00);


--
-- TOC entry 5498 (class 0 OID 34946)
-- Dependencies: 271
-- Data for Name: uso_materiales; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5500 (class 0 OID 34957)
-- Dependencies: 273
-- Data for Name: usuario_roles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5502 (class 0 OID 34965)
-- Dependencies: 275
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.usuarios VALUES (1, 5, 'cgómez', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBpwTWVFAO5paO', NULL, NULL, 0, false, true, '2026-05-07 14:42:03.903053', '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', 'TRABAJADOR');
INSERT INTO public.usuarios VALUES (2, 6, 'mlópez', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, 0, false, true, '2026-05-07 14:42:03.903053', '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', 'TRABAJADOR');
INSERT INTO public.usuarios VALUES (12, 14, 'operador', '$2a$10$QnSuYxVqYbMNEJ2Cwhwc6e3LsWWc3yOfIf2wdsIGMrO1V5EMX4LQy', NULL, NULL, 0, false, true, '2026-05-25 01:14:10.47666', '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', 'TRABAJADOR');
INSERT INTO public.usuarios VALUES (14, 16, 'supervisor', '$2a$10$lbkjOfCi2wSFw7EOm0dxZul4I6qisEz1CQlX/TCQU36KNUmBed5jW', NULL, '2026-05-28 14:53:15.481021', 0, false, true, '2026-05-25 22:26:57.840546', '2026-05-26 02:13:45.907169', '2026-05-26 02:13:45.907169', 'SUPERVISOR');
INSERT INTO public.usuarios VALUES (15, 17, 'admin', '$2a$10$RQq9BQfPUy7ml331Be927.c.ijJNXhbc/HO2Rp0Gz4R1OVC4p.sC.', NULL, '2026-06-03 20:10:56.361909', 0, false, true, '2026-05-26 02:43:25.080185', '2026-05-26 02:43:25.080185', '2026-05-26 02:43:25.080185', 'ADMIN');


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 220
-- Name: abono_id_abono_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.abono_id_abono_seq', 1, false);


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 222
-- Name: asistencia_id_asist_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.asistencia_id_asist_seq', 16, true);


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 224
-- Name: cargos_id_cargo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cargos_id_cargo_seq', 8, true);


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 226
-- Name: ciclos_cultivo_id_ciclo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ciclos_cultivo_id_ciclo_seq', 1, false);


--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 228
-- Name: compras_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.compras_id_compra_seq', 1, false);


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 230
-- Name: compras_material_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.compras_material_id_compra_seq', 1, false);


--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 232
-- Name: control_calidad_id_calidad_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.control_calidad_id_calidad_seq', 1, false);


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 234
-- Name: cosechas_id_cosecha_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cosechas_id_cosecha_seq', 1, false);


--
-- TOC entry 5549 (class 0 OID 0)
-- Dependencies: 236
-- Name: detalle_compras_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.detalle_compras_id_detalle_seq', 1, false);


--
-- TOC entry 5550 (class 0 OID 0)
-- Dependencies: 238
-- Name: detalle_cosecha_id_detalle_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.detalle_cosecha_id_detalle_seq', 1, false);


--
-- TOC entry 5551 (class 0 OID 0)
-- Dependencies: 240
-- Name: gasolina_id_gasolina_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gasolina_id_gasolina_seq', 2, true);


--
-- TOC entry 5552 (class 0 OID 0)
-- Dependencies: 242
-- Name: gestion_cultivos_id_gestion_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gestion_cultivos_id_gestion_seq', 1, false);


--
-- TOC entry 5553 (class 0 OID 0)
-- Dependencies: 244
-- Name: hectareas_id_hect_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.hectareas_id_hect_seq', 3, true);


--
-- TOC entry 5554 (class 0 OID 0)
-- Dependencies: 285
-- Name: incidencia_id_inc_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.incidencia_id_inc_seq', 1, false);


--
-- TOC entry 5555 (class 0 OID 0)
-- Dependencies: 246
-- Name: logs_sistema_id_log_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.logs_sistema_id_log_seq', 1, false);


--
-- TOC entry 5556 (class 0 OID 0)
-- Dependencies: 248
-- Name: maquinaria_id_maq_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.maquinaria_id_maq_seq', 3, true);


--
-- TOC entry 5557 (class 0 OID 0)
-- Dependencies: 250
-- Name: materiales_id_mat_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.materiales_id_mat_seq', 5, true);


--
-- TOC entry 5558 (class 0 OID 0)
-- Dependencies: 252
-- Name: monitoreo_plagas_id_monitoreo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.monitoreo_plagas_id_monitoreo_seq', 1, false);


--
-- TOC entry 5559 (class 0 OID 0)
-- Dependencies: 254
-- Name: movimientos_caja_id_mov_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movimientos_caja_id_mov_seq', 7, true);


--
-- TOC entry 5560 (class 0 OID 0)
-- Dependencies: 256
-- Name: movimientos_material_id_movimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.movimientos_material_id_movimiento_seq', 102, true);


--
-- TOC entry 5561 (class 0 OID 0)
-- Dependencies: 258
-- Name: plagas_id_plaga_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plagas_id_plaga_seq', 4, true);


--
-- TOC entry 5562 (class 0 OID 0)
-- Dependencies: 260
-- Name: planilla_pago_id_planilla_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.planilla_pago_id_planilla_seq', 25, true);


--
-- TOC entry 5563 (class 0 OID 0)
-- Dependencies: 262
-- Name: proveedores_id_proveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 1, false);


--
-- TOC entry 5564 (class 0 OID 0)
-- Dependencies: 264
-- Name: regadio_id_reg_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.regadio_id_reg_seq', 1, false);


--
-- TOC entry 5565 (class 0 OID 0)
-- Dependencies: 266
-- Name: roles_permisos_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_permisos_id_rol_seq', 3, true);


--
-- TOC entry 5566 (class 0 OID 0)
-- Dependencies: 268
-- Name: tipo_cosecha_id_tipo_cosecha_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipo_cosecha_id_tipo_cosecha_seq', 3, true);


--
-- TOC entry 5567 (class 0 OID 0)
-- Dependencies: 270
-- Name: trabajadores_id_trab_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trabajadores_id_trab_seq', 29, true);


--
-- TOC entry 5568 (class 0 OID 0)
-- Dependencies: 272
-- Name: uso_materiales_id_uso_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.uso_materiales_id_uso_seq', 1, false);


--
-- TOC entry 5569 (class 0 OID 0)
-- Dependencies: 274
-- Name: usuario_roles_id_usuario_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_roles_id_usuario_rol_seq', 1, false);


--
-- TOC entry 5570 (class 0 OID 0)
-- Dependencies: 276
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 15, true);


--
-- TOC entry 5157 (class 2606 OID 35048)
-- Name: abono abono_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abono
    ADD CONSTRAINT abono_pkey PRIMARY KEY (id_abono);


--
-- TOC entry 5159 (class 2606 OID 35050)
-- Name: asistencia asistencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_pkey PRIMARY KEY (id_asist);


--
-- TOC entry 5167 (class 2606 OID 35052)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id_cargo);


--
-- TOC entry 5169 (class 2606 OID 35054)
-- Name: ciclos_cultivo ciclos_cultivo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciclos_cultivo
    ADD CONSTRAINT ciclos_cultivo_pkey PRIMARY KEY (id_ciclo);


--
-- TOC entry 5174 (class 2606 OID 35056)
-- Name: compras_material compras_material_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT compras_material_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 5172 (class 2606 OID 35058)
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 5176 (class 2606 OID 35060)
-- Name: control_calidad control_calidad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_pkey PRIMARY KEY (id_calidad);


--
-- TOC entry 5178 (class 2606 OID 35062)
-- Name: cosechas cosechas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_pkey PRIMARY KEY (id_cosecha);


--
-- TOC entry 5181 (class 2606 OID 35064)
-- Name: detalle_compras detalle_compras_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 5183 (class 2606 OID 35066)
-- Name: detalle_cosecha detalle_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_cosecha
    ADD CONSTRAINT detalle_cosecha_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 5187 (class 2606 OID 35068)
-- Name: gasolina gasolina_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gasolina
    ADD CONSTRAINT gasolina_pkey PRIMARY KEY (id_gasolina);


--
-- TOC entry 5189 (class 2606 OID 35070)
-- Name: gestion_cultivos gestion_cultivos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_pkey PRIMARY KEY (id_gestion);


--
-- TOC entry 5191 (class 2606 OID 35072)
-- Name: hectareas hectareas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hectareas
    ADD CONSTRAINT hectareas_pkey PRIMARY KEY (id_hect);


--
-- TOC entry 5251 (class 2606 OID 42849)
-- Name: incidencia incidencia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia
    ADD CONSTRAINT incidencia_pkey PRIMARY KEY (id_inc);


--
-- TOC entry 5195 (class 2606 OID 35074)
-- Name: logs_sistema logs_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs_sistema
    ADD CONSTRAINT logs_sistema_pkey PRIMARY KEY (id_log);


--
-- TOC entry 5197 (class 2606 OID 35076)
-- Name: maquinaria maquinaria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maquinaria
    ADD CONSTRAINT maquinaria_pkey PRIMARY KEY (id_maq);


--
-- TOC entry 5201 (class 2606 OID 35078)
-- Name: materiales materiales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materiales
    ADD CONSTRAINT materiales_pkey PRIMARY KEY (id_mat);


--
-- TOC entry 5203 (class 2606 OID 35080)
-- Name: monitoreo_plagas monitoreo_plagas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_pkey PRIMARY KEY (id_monitoreo);


--
-- TOC entry 5206 (class 2606 OID 35082)
-- Name: movimientos_caja movimientos_caja_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_pkey PRIMARY KEY (id_mov);


--
-- TOC entry 5209 (class 2606 OID 35084)
-- Name: movimientos_material movimientos_material_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT movimientos_material_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 5211 (class 2606 OID 35086)
-- Name: plagas plagas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plagas
    ADD CONSTRAINT plagas_pkey PRIMARY KEY (id_plaga);


--
-- TOC entry 5215 (class 2606 OID 35088)
-- Name: planilla_pago planilla_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planilla_pago
    ADD CONSTRAINT planilla_pago_pkey PRIMARY KEY (id_planilla);


--
-- TOC entry 5217 (class 2606 OID 35090)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 5219 (class 2606 OID 35092)
-- Name: proveedores proveedores_ruc_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_ruc_key UNIQUE (ruc);


--
-- TOC entry 5222 (class 2606 OID 35094)
-- Name: regadio regadio_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_pkey PRIMARY KEY (id_reg);


--
-- TOC entry 5224 (class 2606 OID 35096)
-- Name: roles_permisos roles_permisos_nombre_rol_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_nombre_rol_key UNIQUE (nombre_rol);


--
-- TOC entry 5226 (class 2606 OID 35098)
-- Name: roles_permisos roles_permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 5228 (class 2606 OID 35100)
-- Name: tipo_cosecha tipo_cosecha_nombre_tipo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_cosecha
    ADD CONSTRAINT tipo_cosecha_nombre_tipo_key UNIQUE (nombre_tipo);


--
-- TOC entry 5230 (class 2606 OID 35102)
-- Name: tipo_cosecha tipo_cosecha_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_cosecha
    ADD CONSTRAINT tipo_cosecha_pkey PRIMARY KEY (id_tipo_cosecha);


--
-- TOC entry 5235 (class 2606 OID 35104)
-- Name: trabajadores trabajadores_dni_trab_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_dni_trab_key UNIQUE (dni_trab);


--
-- TOC entry 5237 (class 2606 OID 35106)
-- Name: trabajadores trabajadores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_pkey PRIMARY KEY (id_trab);


--
-- TOC entry 5165 (class 2606 OID 35108)
-- Name: asistencia unique_asistencia_dia; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT unique_asistencia_dia UNIQUE (id_trab, fec_asist);


--
-- TOC entry 5239 (class 2606 OID 35110)
-- Name: trabajadores unique_dni; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT unique_dni UNIQUE (dni_trab);


--
-- TOC entry 5241 (class 2606 OID 35112)
-- Name: uso_materiales uso_materiales_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_pkey PRIMARY KEY (id_uso);


--
-- TOC entry 5243 (class 2606 OID 35114)
-- Name: usuario_roles usuario_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_pkey PRIMARY KEY (id_usuario_rol);


--
-- TOC entry 5245 (class 2606 OID 35116)
-- Name: usuarios usuarios_id_trab_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_trab_key UNIQUE (id_trab);


--
-- TOC entry 5247 (class 2606 OID 35118)
-- Name: usuarios usuarios_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- TOC entry 5249 (class 2606 OID 35120)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 5160 (class 1259 OID 35121)
-- Name: idx_asistencia_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_asistencia_fecha ON public.asistencia USING btree (fec_asist);


--
-- TOC entry 5161 (class 1259 OID 35122)
-- Name: idx_asistencia_tipo_tarea; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_asistencia_tipo_tarea ON public.asistencia USING btree (tipo_tarea, fec_asist);


--
-- TOC entry 5162 (class 1259 OID 35123)
-- Name: idx_asistencia_trab; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_asistencia_trab ON public.asistencia USING btree (id_trab);


--
-- TOC entry 5163 (class 1259 OID 35124)
-- Name: idx_asistencia_trab_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_asistencia_trab_fecha ON public.asistencia USING btree (id_trab, fec_asist);


--
-- TOC entry 5170 (class 1259 OID 35125)
-- Name: idx_ciclos_estado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ciclos_estado ON public.ciclos_cultivo USING btree (estado, fecha_siembra);


--
-- TOC entry 5184 (class 1259 OID 35126)
-- Name: idx_cosecha_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cosecha_fecha ON public.detalle_cosecha USING btree (fecha);


--
-- TOC entry 5185 (class 1259 OID 35127)
-- Name: idx_cosecha_trab; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cosecha_trab ON public.detalle_cosecha USING btree (id_trab);


--
-- TOC entry 5179 (class 1259 OID 35128)
-- Name: idx_cosechas_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cosechas_fecha ON public.cosechas USING btree (fec_cosecha, id_hect);


--
-- TOC entry 5192 (class 1259 OID 35129)
-- Name: idx_logs_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_logs_fecha ON public.logs_sistema USING btree (fecha);


--
-- TOC entry 5193 (class 1259 OID 35130)
-- Name: idx_logs_tabla; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_logs_tabla ON public.logs_sistema USING btree (tabla);


--
-- TOC entry 5198 (class 1259 OID 35131)
-- Name: idx_mat_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mat_activo ON public.materiales USING btree (activo);


--
-- TOC entry 5199 (class 1259 OID 35132)
-- Name: idx_materiales_stock; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_materiales_stock ON public.materiales USING btree (stock_actual, stock_minimo);


--
-- TOC entry 5204 (class 1259 OID 35133)
-- Name: idx_movimientos_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_movimientos_fecha ON public.movimientos_caja USING btree (fec_mov, tipo_mov);


--
-- TOC entry 5207 (class 1259 OID 35134)
-- Name: idx_movimientos_material; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_movimientos_material ON public.movimientos_material USING btree (id_material);


--
-- TOC entry 5212 (class 1259 OID 35135)
-- Name: idx_planilla_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_planilla_fecha ON public.planilla_pago USING btree (fecha_inicio);


--
-- TOC entry 5213 (class 1259 OID 35136)
-- Name: idx_planilla_trab; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_planilla_trab ON public.planilla_pago USING btree (id_trab);


--
-- TOC entry 5220 (class 1259 OID 35137)
-- Name: idx_regadio_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regadio_fecha ON public.regadio USING btree (fec_reg, id_hect);


--
-- TOC entry 5231 (class 1259 OID 35138)
-- Name: idx_trab_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trab_activo ON public.trabajadores USING btree (activo);


--
-- TOC entry 5232 (class 1259 OID 35139)
-- Name: idx_trab_dni; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trab_dni ON public.trabajadores USING btree (dni_trab);


--
-- TOC entry 5233 (class 1259 OID 35140)
-- Name: idx_trabajadores_nombre; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trabajadores_nombre ON public.trabajadores USING btree (nom_trab, ape_trab);


--
-- TOC entry 5287 (class 2620 OID 35141)
-- Name: asistencia trig_updated_asistencia; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trig_updated_asistencia BEFORE UPDATE ON public.asistencia FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 5288 (class 2620 OID 35142)
-- Name: materiales trig_updated_materiales; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trig_updated_materiales BEFORE UPDATE ON public.materiales FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 5290 (class 2620 OID 35143)
-- Name: trabajadores trig_updated_trabajadores; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trig_updated_trabajadores BEFORE UPDATE ON public.trabajadores FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();


--
-- TOC entry 5289 (class 2620 OID 35144)
-- Name: materiales trigger_movimiento_stock; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_movimiento_stock AFTER UPDATE OF stock_actual ON public.materiales FOR EACH ROW EXECUTE FUNCTION public.registrar_movimiento_stock();


--
-- TOC entry 5252 (class 2606 OID 35145)
-- Name: abono abono_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.abono
    ADD CONSTRAINT abono_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 5253 (class 2606 OID 35150)
-- Name: asistencia asistencia_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE CASCADE;


--
-- TOC entry 5254 (class 2606 OID 35155)
-- Name: ciclos_cultivo ciclos_cultivo_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ciclos_cultivo
    ADD CONSTRAINT ciclos_cultivo_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 5255 (class 2606 OID 35160)
-- Name: compras compras_id_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_id_proveedor_fkey FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON DELETE SET NULL;


--
-- TOC entry 5258 (class 2606 OID 35165)
-- Name: control_calidad control_calidad_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.control_calidad
    ADD CONSTRAINT control_calidad_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE CASCADE;


--
-- TOC entry 5259 (class 2606 OID 35170)
-- Name: cosechas cosechas_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 5260 (class 2606 OID 35175)
-- Name: cosechas cosechas_id_maq_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_maq_fkey FOREIGN KEY (id_maq) REFERENCES public.maquinaria(id_maq) ON DELETE SET NULL;


--
-- TOC entry 5261 (class 2606 OID 35180)
-- Name: cosechas cosechas_id_tipo_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cosechas
    ADD CONSTRAINT cosechas_id_tipo_cosecha_fkey FOREIGN KEY (id_tipo_cosecha) REFERENCES public.tipo_cosecha(id_tipo_cosecha);


--
-- TOC entry 5262 (class 2606 OID 35185)
-- Name: detalle_compras detalle_compras_id_compra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_id_compra_fkey FOREIGN KEY (id_compra) REFERENCES public.compras(id_compra) ON DELETE CASCADE;


--
-- TOC entry 5263 (class 2606 OID 35190)
-- Name: detalle_compras detalle_compras_id_mat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_compras
    ADD CONSTRAINT detalle_compras_id_mat_fkey FOREIGN KEY (id_mat) REFERENCES public.materiales(id_mat) ON DELETE SET NULL;


--
-- TOC entry 5256 (class 2606 OID 35195)
-- Name: compras_material fk_compra_material; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT fk_compra_material FOREIGN KEY (id_material) REFERENCES public.materiales(id_mat);


--
-- TOC entry 5257 (class 2606 OID 35200)
-- Name: compras_material fk_compra_proveedor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compras_material
    ADD CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) ON DELETE SET NULL;


--
-- TOC entry 5264 (class 2606 OID 35205)
-- Name: detalle_cosecha fk_cosecha_trab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_cosecha
    ADD CONSTRAINT fk_cosecha_trab FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE RESTRICT;


--
-- TOC entry 5274 (class 2606 OID 35210)
-- Name: movimientos_material fk_movimiento_material; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT fk_movimiento_material FOREIGN KEY (id_material) REFERENCES public.materiales(id_mat) ON DELETE RESTRICT;


--
-- TOC entry 5275 (class 2606 OID 35215)
-- Name: movimientos_material fk_movimiento_usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_material
    ADD CONSTRAINT fk_movimiento_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE SET NULL;


--
-- TOC entry 5276 (class 2606 OID 35220)
-- Name: planilla_pago fk_planilla_trab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planilla_pago
    ADD CONSTRAINT fk_planilla_trab FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE RESTRICT;


--
-- TOC entry 5265 (class 2606 OID 35225)
-- Name: gasolina gasolina_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gasolina
    ADD CONSTRAINT gasolina_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 5266 (class 2606 OID 35230)
-- Name: gestion_cultivos gestion_cultivos_id_calidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_calidad_fkey FOREIGN KEY (id_calidad) REFERENCES public.control_calidad(id_calidad) ON DELETE SET NULL;


--
-- TOC entry 5267 (class 2606 OID 35235)
-- Name: gestion_cultivos gestion_cultivos_id_ciclo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_ciclo_fkey FOREIGN KEY (id_ciclo) REFERENCES public.ciclos_cultivo(id_ciclo) ON DELETE RESTRICT;


--
-- TOC entry 5268 (class 2606 OID 35240)
-- Name: gestion_cultivos gestion_cultivos_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE SET NULL;


--
-- TOC entry 5269 (class 2606 OID 35245)
-- Name: gestion_cultivos gestion_cultivos_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gestion_cultivos
    ADD CONSTRAINT gestion_cultivos_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE RESTRICT;


--
-- TOC entry 5286 (class 2606 OID 42850)
-- Name: incidencia incidencia_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia
    ADD CONSTRAINT incidencia_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab);


--
-- TOC entry 5270 (class 2606 OID 35250)
-- Name: monitoreo_plagas monitoreo_plagas_id_ciclo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_id_ciclo_fkey FOREIGN KEY (id_ciclo) REFERENCES public.ciclos_cultivo(id_ciclo);


--
-- TOC entry 5271 (class 2606 OID 35255)
-- Name: monitoreo_plagas monitoreo_plagas_id_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitoreo_plagas
    ADD CONSTRAINT monitoreo_plagas_id_plaga_fkey FOREIGN KEY (id_plaga) REFERENCES public.plagas(id_plaga);


--
-- TOC entry 5272 (class 2606 OID 35260)
-- Name: movimientos_caja movimientos_caja_id_cosecha_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_id_cosecha_fkey FOREIGN KEY (id_cosecha) REFERENCES public.cosechas(id_cosecha) ON DELETE SET NULL;


--
-- TOC entry 5273 (class 2606 OID 35265)
-- Name: movimientos_caja movimientos_caja_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimientos_caja
    ADD CONSTRAINT movimientos_caja_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 5277 (class 2606 OID 35270)
-- Name: regadio regadio_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 5278 (class 2606 OID 35275)
-- Name: regadio regadio_id_responsable_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_responsable_fkey FOREIGN KEY (id_responsable) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 5279 (class 2606 OID 35280)
-- Name: regadio regadio_id_trab_regador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regadio
    ADD CONSTRAINT regadio_id_trab_regador_fkey FOREIGN KEY (id_trab_regador) REFERENCES public.trabajadores(id_trab) ON DELETE SET NULL;


--
-- TOC entry 5280 (class 2606 OID 35285)
-- Name: trabajadores trabajadores_id_cargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trabajadores
    ADD CONSTRAINT trabajadores_id_cargo_fkey FOREIGN KEY (id_cargo) REFERENCES public.cargos(id_cargo) ON DELETE RESTRICT;


--
-- TOC entry 5281 (class 2606 OID 35290)
-- Name: uso_materiales uso_materiales_id_hect_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_id_hect_fkey FOREIGN KEY (id_hect) REFERENCES public.hectareas(id_hect) ON DELETE CASCADE;


--
-- TOC entry 5282 (class 2606 OID 35295)
-- Name: uso_materiales uso_materiales_id_mat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uso_materiales
    ADD CONSTRAINT uso_materiales_id_mat_fkey FOREIGN KEY (id_mat) REFERENCES public.materiales(id_mat) ON DELETE CASCADE;


--
-- TOC entry 5283 (class 2606 OID 35300)
-- Name: usuario_roles usuario_roles_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.roles_permisos(id_rol) ON DELETE CASCADE;


--
-- TOC entry 5284 (class 2606 OID 35305)
-- Name: usuario_roles usuario_roles_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 5285 (class 2606 OID 35310)
-- Name: usuarios usuarios_id_trab_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_id_trab_fkey FOREIGN KEY (id_trab) REFERENCES public.trabajadores(id_trab) ON DELETE CASCADE;


-- Completed on 2026-06-03 20:13:09

--
-- PostgreSQL database dump complete
--

\unrestrict maYEgMdus2v2AVe4jzbbhEu2FrZ2xeW4rDmMYmJMzkPPaXs15y04YQeTktwmsLy

