-- ============================================================
-- 02_vistas_gold.sql
-- Proyecto: Lakehouse Analítico para Anemia Infantil - Ayacucho
-- Descripción: Vistas SQL de la capa Gold para dashboard
-- ============================================================

USE CATALOG anemia_ayacucho;
USE SCHEMA gold;

-- Vista 1: KPIs generales
CREATE OR REPLACE VIEW vw_kpi_general AS
SELECT
    SUM(nro_evaluados) AS total_evaluados,
    SUM(nro_ninos_anemia) AS total_ninos_anemia,
    ROUND((SUM(nro_ninos_anemia) / SUM(nro_evaluados)) * 100, 2) AS tasa_anemia_general,
    COUNT(*) AS total_registros,
    COUNT(DISTINCT id_ubicacion) AS total_ubicaciones,
    COUNT(DISTINCT id_zona) AS total_zonas,
    COUNT(DISTINCT id_tiempo) AS total_periodos
FROM fact_anemia;

-- Vista 2: Evolución anual
CREATE OR REPLACE VIEW vw_evolucion_anual AS
SELECT
    t.anio,
    SUM(f.nro_evaluados) AS total_evaluados,
    SUM(f.nro_ninos_anemia) AS total_ninos_anemia,
    ROUND((SUM(f.nro_ninos_anemia) / SUM(f.nro_evaluados)) * 100, 2) AS tasa_anemia
FROM fact_anemia f
INNER JOIN dim_tiempo t
    ON f.id_tiempo = t.id_tiempo
GROUP BY t.anio
ORDER BY t.anio;

-- Vista 3: Anemia por provincia
CREATE OR REPLACE VIEW vw_anemia_provincia AS
SELECT
    u.provincia,
    SUM(f.nro_evaluados) AS total_evaluados,
    SUM(f.nro_ninos_anemia) AS total_ninos_anemia,
    ROUND((SUM(f.nro_ninos_anemia) / SUM(f.nro_evaluados)) * 100, 2) AS tasa_anemia
FROM fact_anemia f
INNER JOIN dim_ubicacion u
    ON f.id_ubicacion = u.id_ubicacion
GROUP BY u.provincia
ORDER BY total_ninos_anemia DESC;

-- Vista 4: Anemia por zona
CREATE OR REPLACE VIEW vw_anemia_zona AS
SELECT
    z.zona,
    SUM(f.nro_evaluados) AS total_evaluados,
    SUM(f.nro_ninos_anemia) AS total_ninos_anemia,
    ROUND((SUM(f.nro_ninos_anemia) / SUM(f.nro_evaluados)) * 100, 2) AS tasa_anemia
FROM fact_anemia f
INNER JOIN dim_zona z
    ON f.id_zona = z.id_zona
GROUP BY z.zona
ORDER BY total_ninos_anemia DESC;

-- Vista 5: Ranking de distritos críticos
CREATE OR REPLACE VIEW vw_ranking_distritos_criticos AS
SELECT
    u.provincia,
    u.distrito,
    SUM(f.nro_evaluados) AS total_evaluados,
    SUM(f.nro_ninos_anemia) AS total_ninos_anemia,
    ROUND((SUM(f.nro_ninos_anemia) / SUM(f.nro_evaluados)) * 100, 2) AS tasa_anemia
FROM fact_anemia f
INNER JOIN dim_ubicacion u
    ON f.id_ubicacion = u.id_ubicacion
GROUP BY u.provincia, u.distrito
ORDER BY tasa_anemia DESC, total_ninos_anemia DESC;
