# Análisis de Datos con Python, dbt y MySQL

Este proyecto utiliza **Python**, **dbt** y **MySQL** para realizar análisis de datos. La estructura incluye la integración de bases de datos, creación de modelos de datos, transformaciones y validaciones utilizando **dbt**

#### Author:
     Jean Colonia - jean.colonia@encora.com

## Estructura del Proyecto
dbt-mysql-demo/
├── models/              # Modelos de dbt
│   ├── schema.yml       # Configuración del source, modelos, columnas y pruebas (genericas, especificas, por default)
│   ├── raw/             # Datos crudos (raw)
│   ├── staging/         # Transformación de datos en staging
│   ├── marts/           # Modelos finales para análisis
├── seeds/                # Archivos de datos, CSV, etc.
├── tests/               # Pruebas de dbt
├── macros               # Pruebas genericas/reutilizables de dbt
│   ├── tests/           # Scripts de tipo test reutilizables en diferentes columnas y modelos
├── media/               # Archivos multimedia como evidencia de las ejecuciones del proyecto
│   ├── video/           # Videos de las ejecuciones (run and tests)
│   ├── img/             # Imagenes de la generación y visualización de la documentación del proyecto
├── dbt_project.yml      # Configuración del proyecto dbt
└── README.md            # Documentación del proyecto
└── bd-script.sql        # Archivo tipo scritp utilizado para el desarrollo de modelos, test, macros, etc.

### Explicación de cada carpeta

- **models/**: Contiene los modelos de dbt que se utilizan para transformar los datos. 
  - **raw/**: Modelos para cargar los datos sin ninguna transformación.
  - **staging/**: Datos parcialmente transformados que se usarán en las siguientes etapas de modelado.
  - **marts/**: Modelos listos para ser usados en análisis de datos, con transformaciones y agregaciones finales.

- **seeds/**: Contiene los archivos de datos (por ejemplo archivos CSV como products, customers y sales) que se utilizarán en los modelos de dbt.

- **tests/**: Aquí se definen y ejecutan las pruebas para los modelos de dbt (pruebas aplicadas de forma especifica para algunas columnas de tablas pero no declaradas dentro de un schema.yml ya que se ejecutan de forma automática)

- **dbt_project.yml**: Archivo de configuración del proyecto dbt, donde se definen parámetros como los nombres de las bases de datos, rutas y  configuraciones del modelo.

## Requisitos

1. Tener **Python** y **MySQL** instalados.
2. Tener **dbt** instalado. Si no lo tienes, puedes instalarlo con:
    Instalar dbt:
    ```bash
    pip install dbt

    Instalar mysql para dbt:
    ```
        ```bash
    pip install dbt-mysql

    ```

## Configuración Inicial

1. Descarga la carpeta que contiene el repositorio del proyecto desde Sharepoint:

2. Navega a la carpeta del proyecto:
    ```bash
    cd dbt-mysql-demo
    ```
    Para ejecutar los comandos asegure se ingresar a la carpeta ./dbt-mysql-demo/mysql/
    ```bash
    cd mysql
    ```

3. Configura tu conexión a la base de datos MySQL en el archivo `profiles.yml`. ubicado en la ruta C:\Users\< Tu usuario> \.dbt.\profile.yml

    mysql:
   target: dev
   outputs:
     dev:
       type: mysql 
       server: localhost 
       port:  3306 (opcional -> modificar de ser necesario)
       schema: dbt_db (Crear una base de datos con dicho nombre o cambiar según lo requiera)
       username: root (Ingresar usuario de MySQL según se configuró al instalar)
       password: admin (Ingresar pass de MySQL según se configuró al instalar)
       driver: MySQL ODBC 8.0 ANSI Driver (No cambiar)

4. Configurar archivos dbt_project.yml y schema.yml según sea requerido:
   - **Archivo dbt_project.yml**
      models:
        mysql:
          raw:
            materialized: view (Creación de vista para todo lo incluido en la carpeta raw)
          staging: 
            materialized: view (Creación de vista para todo lo incluido en la carpeta staging)
          marts:
            materialized: table (Creación de vista para todo lo incluido en la carpeta marts)
    - **Archivo dbt_project.yml**
        Modifcación de valores para la conexión a la BD
         sources:
           - name: dbt-demo (nombre genérico para conexión a BD)
             schema: dbt_db (nombre del schema o BD - debe ser el mismo que el creado en BD)
             tables: (Declaración de tablas en BD)
               - name: customers
               - name: products
               - name: sales

## Comandos de dbt

- **Construir el proyecto**:
    ```bash
    dbt build
    ```

- **Construir y ejecutar semillas** (si tienes archivos CSV):
    ```bash
    dbt seed
    ``` 

- **Ejecutar modelos**:
   Comando general: 
    ```bash
    dbt run
    ```

   Comando especifo: 
     ```bash
    dbt run --select nombre_archivo
    ```

- **Ejecutar pruebas**:
    Comando general:
    ```bash
    dbt test
    ```

    Comando especifico:
        ```bash
    dbt test --select nombre_archivo
    ```
- **Generar y visualizar documentación del proyecto**:
    Comando general:
    ```bash
    dbt docs generate
    ```

    Comando especifico:
        ```bash
    dbt docs serve
    ```

- **INFORMACIÓN DE PRUEBAS**:
    * Completeness Testing:
      DEFINED TEST
      - not_null

    * Accuracy Testing:
      MACRO/TEST
      - value_less_than_zero (testing positive values)
      DEFINED TEST
      - accepted_values (Valid category values from a predefined list )
      UNIT TEST
      - price_less_than_zero (Price values are positive numbers, Stock quantities are non-negative integers )
    
    * Validation Testing:
      MACRO/TEST
      - id_correct_format (IDs follow the correct format)
      UNIT TEST
      - standarized_color (Color values are standardized )
    
    * Uniqueness Testing:
      DEFINED TEST
      - unique (unique field values e.g. IDs are unique ) / no duplicated values
    
    *  Timeliness Testing:
      MACRO/TEST
      - date_later_than_today (Last updated dates are not in the future )