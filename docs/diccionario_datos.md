# Diccionario de Datos

## Proyecto
Lakehouse Analítico para el Monitoreo de Anemia Infantil — Ayacucho 2023–2025

## Descripción general

Este diccionario describe las principales tablas utilizadas en el proyecto, desde los archivos fuente hasta el modelo analítico de la capa Gold. El objetivo es documentar los campos usados para el análisis de anemia infantil por año, provincia, distrito y zona geográfica.

---

## Tabla: fact_anemia

Tabla principal del modelo estrella ubicada en la capa Gold. Contiene las métricas principales del análisis.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_registro | string | Identificador técnico generado mediante hash SHA-256 |
| id_tiempo | int | Clave foránea hacia la dimensión tiempo |
| id_ubicacion | int | Clave foránea hacia la dimensión ubicación |
| id_zona | int | Clave foránea hacia la dimensión zona |
| nro_evaluados | int | Número de niños evaluados |
| nro_ninos_anemia | int | Número de niños con anemia |
| tasa_anemia | decimal | Porcentaje de niños con anemia sobre el total evaluado |
| nivel_riesgo | string | Clasificación del riesgo: Alto, Medio o Bajo |
| fecha_carga | timestamp | Fecha y hora de carga del registro |
| archivo_fuente | string | Archivo original del cual proviene el registro |

---

## Tabla: dim_ubicacion

Dimensión territorial utilizada para analizar los datos por provincia y distrito.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_ubicacion | int | Identificador único de la ubicación |
| ubigeo_original | int | Código de ubicación proveniente del archivo fuente |
| provincia | string | Provincia de Ayacucho |
| distrito | string | Distrito analizado |

---

## Tabla: dim_zona

Dimensión de zonas geográficas construida a partir del archivo `maestro_zonas.json`.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_zona | int | Identificador único de la zona |
| zona | string | Nombre de la zona geográfica |
| abreviatura | string | Abreviatura de la zona |
| tipo_zona | string | Tipo de zona: Cardinal, Intercardinal o Central |
| orientacion | string | Orientación geográfica |
| descripcion | string | Descripción de la zona |
| orden_visualizacion | int | Orden usado para mostrar la zona en el dashboard |
| usar_en_dashboard | boolean | Indica si la zona se utiliza en el dashboard |

---

## Tabla: dim_tiempo

Dimensión temporal utilizada para analizar la evolución anual.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id_tiempo | int | Identificador del periodo |
| anio | int | Año del registro |
| periodo | string | Periodo de análisis |

---

## Tabla: resumen_dashboard

Tabla agregada ubicada en Gold y usada como base para el dashboard.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| anio | int | Año de análisis |
| provincia | string | Provincia |
| distrito | string | Distrito |
| zona | string | Zona geográfica |
| nivel_riesgo | string | Clasificación del riesgo |
| total_evaluados | int | Total de niños evaluados |
| total_ninos_anemia | int | Total de niños con anemia |
| tasa_anemia | decimal | Tasa de anemia calculada |

---

## Reglas de calidad aplicadas

| Regla | Descripción |
|---|---|
| Tratamiento de nulos | Se eliminaron registros con campos principales nulos |
| Conversión de tipos | Se convirtieron campos numéricos a tipo entero |
| Estandarización de columnas | Se renombraron columnas al formato snake_case |
| Eliminación de duplicados | Se eliminaron registros repetidos por ubigeo, provincia, distrito, año y zona |
| Validación de negocio | Se validó que niños con anemia no supere el número de evaluados |
| Cálculo de tasa | Se creó la columna tasa_anemia |
| Clasificación de riesgo | Se creó la columna nivel_riesgo |
