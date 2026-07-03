-- ============================================================
-- 01_creacion_catalogo_schemas.sql
-- Proyecto: Lakehouse Analítico para Anemia Infantil - Ayacucho
-- Descripción: Creación del catálogo y schemas principales
-- ============================================================

CREATE CATALOG IF NOT EXISTS anemia_ayacucho;

CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.landing;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.bronze;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.silver;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.gold;

SHOW SCHEMAS IN anemia_ayacucho;
