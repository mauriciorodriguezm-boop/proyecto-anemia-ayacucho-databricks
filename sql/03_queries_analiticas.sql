-- ============================================================
-- 03_queries_analiticas.sql
-- Proyecto: Lakehouse Analítico para Anemia Infantil - Ayacucho
-- Descripción: Consultas principales que responden a la problemática
-- ============================================================

USE CATALOG anemia_ayacucho;
USE SCHEMA gold;

-- 1. ¿Cuál es el total de niños evaluados, niños con anemia y tasa general?
SELECT *
FROM vw_kpi_general;

-- 2. ¿Cómo evolucionó la anemia infantil entre 2023, 2024 y 2025?
SELECT *
FROM vw_evolucion_anual;

-- 3. ¿Qué provincias concentran mayor cantidad de niños con anemia?
SELECT *
FROM vw_anemia_provincia
ORDER BY total_ninos_anemia DESC;

-- 4. ¿Qué zonas presentan mayor cantidad de niños con anemia?
SELECT *
FROM vw_anemia_zona
ORDER BY total_ninos_anemia DESC;

-- 5. ¿Qué distritos tienen mayor tasa de anemia y requieren prioridad?
SELECT *
FROM vw_ranking_distritos_criticos
ORDER BY tasa_anemia DESC, total_ninos_anemia DESC
LIMIT 15;

-- 6. Ranking anual de provincias por cantidad de niños con anemia
SELECT
    anio,
    provincia,
    total_ninos_anemia,
    tasa_anemia,
    DENSE_RANK() OVER (
        PARTITION BY anio
        ORDER BY total_ninos_anemia DESC
    ) AS ranking_provincia
FROM (
    SELECT
        t.anio,
        u.provincia,
        SUM(f.nro_ninos_anemia) AS total_ninos_anemia,
        ROUND((SUM(f.nro_ninos_anemia) / SUM(f.nro_evaluados)) * 100, 2) AS tasa_anemia
    FROM fact_anemia f
    INNER JOIN dim_tiempo t
        ON f.id_tiempo = t.id_tiempo
    INNER JOIN dim_ubicacion u
        ON f.id_ubicacion = u.id_ubicacion
    GROUP BY t.anio, u.provincia
)
ORDER BY anio, ranking_provincia;

-- 7. Variación anual de la tasa de anemia
SELECT
    anio,
    tasa_anemia,
    LAG(tasa_anemia) OVER (ORDER BY anio) AS tasa_anterior,
    ROUND(tasa_anemia - LAG(tasa_anemia) OVER (ORDER BY anio), 2) AS variacion_puntos
FROM vw_evolucion_anual
ORDER BY anio;
