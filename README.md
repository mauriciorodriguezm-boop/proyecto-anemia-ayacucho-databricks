# Lakehouse Analítico para el Monitoreo de Anemia Infantil — Ayacucho 2023–2025

## Integrantes

- Chavez Calderon Evelyn  
- Coronado Saavedra Noria  
- Robles Lázaro Jesus  
- Rodriguez Mancisidor Mauricio  

---

## Descripción del proyecto

Este proyecto consiste en el diseño e implementación de una solución analítica end-to-end en Databricks para el monitoreo de anemia infantil en Ayacucho durante los años 2023, 2024 y 2025.

La solución permite integrar archivos CSV y JSON, aplicar procesos de limpieza y transformación, construir un modelo analítico en la capa Gold y visualizar los principales indicadores mediante un dashboard ejecutivo.

El propósito principal es convertir archivos anuales separados en información ordenada, confiable y útil para analizar la anemia infantil por año, provincia, distrito y zona geográfica.

---

## Objetivo general

Diseñar e implementar una solución analítica end-to-end en Databricks para integrar, limpiar, transformar, modelar y visualizar datos de anemia infantil de los años 2023, 2024 y 2025, con el fin de generar indicadores confiables por año, provincia, distrito y zona, validados mediante una conciliación de resultados en Excel.

---

## Objetivos específicos

- Ingestar archivos fuente CSV y JSON en Databricks y almacenarlos como tablas Delta en la capa Bronze.
- Aplicar procesos de limpieza y calidad de datos en la capa Silver.
- Construir un modelo analítico tipo estrella en la capa Gold.
- Desarrollar consultas SQL para responder preguntas analíticas del proyecto.
- Diseñar un dashboard ejecutivo en Databricks con KPIs, gráficos y filtros.
- Validar los resultados mediante una conciliación entre Databricks y Excel.
- Documentar la arquitectura, el modelo de datos y los resultados principales del proyecto.

---

## Caso de análisis

La anemia infantil es un problema de salud pública que afecta el desarrollo físico y cognitivo de los niños. En este proyecto se analizan datos de anemia infantil en Ayacucho, considerando información por año, provincia, distrito y zona.

El análisis permite identificar la evolución de la anemia, las provincias con mayor cantidad de casos, las zonas con mayor concentración y los distritos con mayor tasa de anemia, con el fin de apoyar la toma de decisiones basada en datos.

---

## Fuentes de datos

| Archivo | Formato | Descripción |
|---|---|---|
| data_2023.csv | CSV | Datos de anemia infantil del año 2023 |
| data_2024.csv | CSV | Datos de anemia infantil del año 2024 |
| data_2025.csv | CSV | Datos de anemia infantil del año 2025 |
| maestro_zonas.json | JSON | Tabla maestra de zonas geográficas |

Los archivos CSV contienen información como provincia, distrito, número de niños evaluados, número de niños con anemia, año y zona.

---

## Herramientas utilizadas

- Databricks Free Edition
- Apache Spark
- Spark SQL
- Delta Lake
- GitHub
- Excel
- Markdown
- Databricks SQL Dashboard

---

## Arquitectura de la solución

El proyecto utiliza una arquitectura Medallion, organizada en capas:

```text
Fuentes CSV / JSON
        ↓
Landing
        ↓
Bronze
        ↓
Silver
        ↓
Gold
        ↓
Vistas SQL
        ↓
Dashboard en Databricks
        ↓
Conciliación en Excel
```

### Landing

Zona donde se almacenan los archivos originales dentro del volumen de Databricks.

Ruta utilizada:

```text
/Volumes/anemia_ayacucho/landing/fuentes/input
```

### Bronze

Capa donde se cargan los datos crudos en formato Delta. En esta etapa se conservan las columnas originales y se agregan metadatos de trazabilidad como la fecha de carga y el archivo fuente.

### Silver

Capa donde se aplican procesos de limpieza, estandarización y validación de datos. En esta etapa se renombran columnas, se convierten tipos de datos, se eliminan duplicados y se calculan campos importantes como la tasa de anemia.

### Gold

Capa analítica final. En esta etapa se construye el modelo estrella, las tablas finales y las vistas SQL utilizadas para el dashboard.

---

## Estructura del repositorio

```text
proyecto-anemia-ayacucho-databricks/
│
├── README.md
├── .gitignore
│
├── notebooks/
│   ├── 01_configuracion_proyecto.py
│   ├── 02_ingesta_bronze.py
│   ├── 03_limpieza_silver.py
│   ├── 04_modelo_gold.py
│   ├── 05_queries_dashboard.py
│   └── 06_conciliacion_excel.py
│
├── sql/
│   ├── 01_creacion_catalogo_schemas.sql
│   ├── 02_vistas_gold.sql
│   └── 03_queries_analiticas.sql
│
├── docs/
│   ├── diccionario_datos.md
│   ├── arquitectura_solucion.png
│   ├── modelo_estrella.png
│   └── presentacion_final.pdf
│
├── data_sample/
│   ├── data_2023.csv
│   ├── data_2024.csv
│   ├── data_2025.csv
│   └── maestro_zonas.json
│
├── dashboard/
│   ├── captura_dashboard.png
│   └── descripcion_dashboard.md
│
└── conciliacion/
    ├── conciliacion_excel.xlsx
    └── resumen_conciliacion.md
```

---

## Descripción de carpetas

| Carpeta | Descripción |
|---|---|
| notebooks | Contiene los notebooks desarrollados en Databricks |
| sql | Contiene scripts SQL para crear vistas y consultas analíticas |
| docs | Contiene documentación técnica, arquitectura, modelo estrella y presentación |
| data_sample | Contiene los archivos fuente utilizados en el proyecto |
| dashboard | Contiene capturas y descripción del dashboard ejecutivo |
| conciliacion | Contiene la validación de resultados entre Databricks y Excel |

---

## Notebooks desarrollados

| Notebook | Descripción |
|---|---|
| 01_configuracion_proyecto.py | Configura el catálogo, schemas, volumen y rutas del proyecto |
| 02_ingesta_bronze.py | Carga los archivos CSV y JSON hacia tablas Delta en Bronze |
| 03_limpieza_silver.py | Limpia, transforma y valida los datos en Silver |
| 04_modelo_gold.py | Construye el modelo estrella en la capa Gold |
| 05_queries_dashboard.py | Desarrolla consultas y vistas para el dashboard |
| 06_conciliacion_excel.py | Genera indicadores para validar resultados con Excel |

---

## Modelo de datos

El modelo analítico se construyó bajo un esquema estrella en la capa Gold.

### Tabla de hechos

- fact_anemia

### Dimensiones

- dim_ubicacion
- dim_zona
- dim_tiempo

La tabla `fact_anemia` contiene las métricas principales del análisis:

- Número de niños evaluados
- Número de niños con anemia
- Tasa de anemia
- Nivel de riesgo
- Archivo fuente
- Fecha de carga

Este modelo permite analizar la anemia infantil por año, provincia, distrito y zona geográfica.

---

## Preguntas analíticas respondidas

El proyecto responde las siguientes preguntas:

1. ¿Cuál es el total de niños evaluados, niños con anemia y tasa general de anemia?
2. ¿Cómo evolucionó la anemia infantil entre 2023, 2024 y 2025?
3. ¿Qué provincias concentran mayor cantidad de niños con anemia?
4. ¿Qué zonas presentan mayor cantidad de niños con anemia?
5. ¿Qué distritos tienen mayor tasa de anemia y requieren prioridad?
6. ¿Qué provincia lidera el ranking de anemia por cada año?
7. ¿La tasa de anemia aumentó o disminuyó respecto al año anterior?

---

## Indicadores principales

| Indicador | Resultado |
|---|---:|
| Total de registros integrados | 1,647 |
| Total de niños evaluados | 60,557 |
| Total de niños con anemia | 17,366 |
| Tasa general de anemia | 28.68% |
| Distritos analizados | 62 |
| Provincias analizadas | 6 |
| Zonas analizadas | 9 |

---

## Dashboard ejecutivo

Se diseñó un dashboard ejecutivo en Databricks para visualizar los principales resultados del análisis.

El dashboard incluye:

- Total de niños evaluados
- Total de niños con anemia
- Tasa general de anemia
- Distritos analizados
- Evolución anual de la tasa de anemia
- Casos de anemia por provincia
- Casos de anemia por zona geográfica
- Ranking de distritos críticos
- Filtros por año, provincia y zona

Este dashboard permite analizar la situación de forma más rápida y visual, evitando revisar manualmente cada archivo anual.

---

## Conciliación con Excel

Se realizó una conciliación entre los resultados obtenidos en Databricks y los cálculos realizados en Excel.

Indicadores validados:

- Total de registros
- Total de niños evaluados
- Total de niños con anemia
- Tasa general de anemia
- Cantidad de provincias
- Cantidad de distritos
- Cantidad de zonas

La conciliación permitió comprobar que los resultados obtenidos en Databricks coinciden con los cálculos realizados de forma externa en Excel.

---

## Instrucciones para ejecutar el proyecto

1. Crear el catálogo principal en Databricks:

```sql
CREATE CATALOG IF NOT EXISTS anemia_ayacucho;
```

2. Crear los schemas necesarios:

```sql
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.landing;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.bronze;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.silver;
CREATE SCHEMA IF NOT EXISTS anemia_ayacucho.gold;
```

3. Subir los archivos fuente al volumen:

```text
/Volumes/anemia_ayacucho/landing/fuentes/input
```

4. Ejecutar los notebooks en el siguiente orden:

```text
01_configuracion_proyecto.py
02_ingesta_bronze.py
03_limpieza_silver.py
04_modelo_gold.py
05_queries_dashboard.py
06_conciliacion_excel.py
```

5. Crear o actualizar las vistas SQL de la carpeta `sql`.

6. Construir el dashboard en Databricks SQL usando las vistas de la capa Gold.

7. Validar los resultados mediante la conciliación en Excel.

---

## Resultados principales

El proyecto permitió integrar información de tres años en una sola solución analítica. A partir de los datos procesados, se obtuvo una tasa general de anemia de 28.68% sobre un total de 60,557 niños evaluados.

También se identificaron los distritos y zonas con mayores niveles de anemia, lo cual permite priorizar mejor el análisis y la toma de decisiones.

Además, el uso de Databricks permitió organizar el trabajo por capas, mejorar la trazabilidad de los datos y reducir el análisis manual de archivos separados.

---

## Conclusiones

La implementación de una arquitectura Medallion permitió organizar el procesamiento de datos en etapas claras: Bronze, Silver y Gold.

La capa Silver permitió mejorar la calidad de los datos mediante limpieza, estandarización, validación de reglas y cálculo de indicadores.

La capa Gold facilitó la construcción de un modelo estrella, permitiendo consultar la información de manera más ordenada y eficiente.

El dashboard ejecutivo permitió visualizar los indicadores principales de anemia infantil y detectar zonas o distritos con mayor prioridad.

La conciliación en Excel permitió validar que los resultados generados en Databricks sean consistentes y confiables.

---

## Mejoras futuras

- Automatizar la carga de nuevos archivos anuales.
- Agregar más variables de salud, edad o sexo si la fuente de datos lo permite.
- Conectar el dashboard con Power BI para una visualización más avanzada.
- Implementar alertas para distritos con tasas de anemia elevadas.
- Documentar nuevas reglas de calidad conforme se incorporen más datos.

---

## Estado del proyecto

Proyecto desarrollado como parte del curso de Sistemas de Gestión de Datos, utilizando Databricks, Delta Lake, SQL y Excel para construir una solución analítica orientada al monitoreo de anemia infantil en Ayacucho.
