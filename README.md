# Lakehouse Analítico para el Monitoreo de Anemia Infantil — Ayacucho 2023–2025

## Descripción del proyecto

Este proyecto consiste en el diseño e implementación de una solución analítica end-to-end en Databricks para el monitoreo de anemia infantil en provincias de Ayacucho durante los años 2023, 2024 y 2025.

La solución integra archivos CSV y JSON, aplica una arquitectura Medallion con capas Bronze, Silver y Gold, construye un modelo analítico tipo estrella y desarrolla consultas SQL para alimentar un dashboard ejecutivo en Databricks.

El objetivo principal es transformar archivos anuales dispersos en información organizada, confiable y visual, que permita analizar la anemia infantil por año, provincia, distrito y zona geográfica.

---

## Objetivo general

Diseñar e implementar una solución analítica end-to-end en Databricks para integrar, limpiar, transformar, modelar y visualizar datos de anemia infantil de los años 2023, 2024 y 2025, con el fin de generar indicadores confiables por año, provincia, distrito y zona, validados mediante una conciliación de resultados en Excel.

---

## Fuentes de datos

| Archivo | Formato | Registros | Descripción |
|---|---|---:|---|
| data_2023.csv | CSV | 549 | Datos de anemia infantil por distrito y zona del año 2023 |
| data_2024.csv | CSV | 549 | Datos de anemia infantil por distrito y zona del año 2024 |
| data_2025.csv | CSV | 549 | Datos de anemia infantil por distrito y zona del año 2025 |
| maestro_zonas.json | JSON | 9 | Tabla maestra de zonas geográficas |

La tabla principal integrada contiene 1 647 registros.

---

## Arquitectura de la solución

El proyecto utiliza una arquitectura Medallion en Databricks:

```text
Landing → Bronze → Silver → Gold → Queries SQL → Dashboard → Excel
