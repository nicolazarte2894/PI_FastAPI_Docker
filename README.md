## **_PROYECTO INDIVIDUAL 01 - DATA ENGINEER_**

## INTRODUCCIÓN

---

Hola!👋 Me llamo Nicolás Angel Lazarte, les presento mi proyecto individual realizado durante el Bootcamp de Data Science de SoyHenry
El proyecto consiste en realizar tareas básicas del perfil de Data Engineer al aplicar diferentes técnicas y conocimientos tales como conexión a diferentes fuentes de datos, realizar los procesos de limpieza y transformación pertinentes y disponibilizar los mismos mediante algún medio de consulta local o remoto. En este caso se ultiliza Pandas de Python para realizar un simple análisis eploratorio, MySQL para el montaje de la base de datos y procesos de ETL y por ultimo FastAPI para la construcción de una API de consultas a través de un entorno de Docker.

## Objetivo

---

Construir una API para realizar consultas en el navegador que se obtienen a través de una fuente don datos de títulos de plataforma de streaming y a su vez embebido en un ambiente de Docker.

## Directorios y archivos del repositorio

---

- [**Data**:](./Data/) Directorio donde se disponibilizan las fuentes de datos no sin procesar y la base de datos ya procesadas en sql llamada _movies_titles_
- [**ETL**:](./ETL/) Directorio que aloja los scripts de sql para la ingestión y transformación de datos en el database movies. Contiene también un archivo `.ipynb` con el [Proceso de EDA y ETL detallado](./ETL/ProcesoETL.ipynb)
- [**functions**:](./functions/) Directorio con una función de ListaRepetidos que se utiliza en la query `get_actor` de la API dentro del decorador
- [**app.py**:](/app.py) Script de para la instanciación de FastAPI y desarrollo de las funciones de consulta
- [**Dockerfile**:](./Dockerfile) Script con las dependencias para el levantamiento de la imagen y levantamiento del contenedor de Docker

## Links de Consignas y Explicación del Proyecto

---

|                  Descripción                  |                          Link                           | Plataforma |
| :-------------------------------------------: | :-----------------------------------------------------: | :--------: |
|    Consignas del proyecto de Data Engineer    | [Repositorio](https://github.com/HX-FAshur/PI01_DATA05) |   Github   |
| Video explicativo del desarrollo del proyecto |                  [Video](youtube.com)                   |  YouTube   |

## ETAPAS DEL PROYECTO

---

### **1) Estudio de la fuente de datos y EDA (Exploratory Data Analysis)**

En primer lugar se realiza un estudio de las fuentes de datos disponibilizadas en archivos `.csv` y `.json` de películas y tv shows de las plataformas de Amazon, Disney, Hulu y Netflix.
Se hace una exploración de datos con pandas, revision de duplicados, tipos de datos y valores faltantes tomando las acciones necesarias. Se sacan las primeras conclusiones para la ingestión a la base de datos. El análisis se hace a través del jupyter notebook mencionado anteriormente

### **2) ETL (Extract, Transform and Load)**

Se elaboraron dos scripts de sql, uno para la ingesta y otro para la transformación de datos. Durante el proceso de carga se tiene en cuenta los tipos de datos. En el proceso de transformación se obtiene una tabla unificada y se realizan las transformaciones de limpieza mínimas pero suficientes para el alcance del proyecto. Luego de la transformación se guarda en un archivo `.csv` dicha tabla maestra utilizando el conector `pymysql` y `pandas` para la conexión, ejecutar la query de toda la tabla y guardar el Dataframe en csv en la carpeta Data

### **3) Creación de una API con FastAPI y Queries (Método `GET`)**

Se utiliza el framework FastAPI para la creación de dicha aplicación en el script `app.py`. En la etapa de desarrollo y prueba se realizaron las funciones necesarias para ejecutar las consultas y testeos de manera local. Las responses de la API son en formato `.JSON`
Las funciones (Método `GET`) con las que cuenta la API son:

- **startup:** función de arranque donde la API pone a disposición la fuente de datos ya transformado para la aplicación de las consultas

- **index:** función de bienvenida con un HTML response

- **get_max_duration:** Consulta de título con más duración de acuerdo a la plataforma y año

  - params = (año, plataforma, [min o season])
  - response = título de la película o tv show con mas duración

- **get_count_platform:** Consulta la cantidad de títulos por plataforma, separado por películas y series

  - params = (plataforma)
  - response = cantidad de movies y cantidad de series para la plataforma pasada como parámetro

- **get_listed_in:** Consulta la máxima cantidad de apariciones del género en el título

  - params = (genero)
  - response = plataforma y la máxima cantidad titulos del genero pasado como parámetro

- **get_actor:** Consulta del actor que más se repite según plataforma y año
  - params = (plataforma, año)
  - response = nombre del actor con mas actuaciones y la cantidad de veces que actuó según la plataforma y año

**Se probaron las consultas de manera local con con la ruta `localhost:8000/docs` en el navegador luego de levantar el servidor de uvicorn con el comando en la terminal `uvicorn app:app --reload` devolviendo en formato JSON las responses**

### **4) Docker**

Se realiza levanta un contenedor de docker a través de un Dockerfile que contiene los servicios y dependencias necesarias junto con las instrucciones para llevar la aplicación al entorno de Docker. Se construyen las imagenes y el contenedor a través de las siguientes líneas de código

```
docker build -t fastapi .
docker run -it -p 8000:8000 -v cd:/usr/src/app
```

Se utiliza Docker Desktop en Windows para visualizar la imagen y el contenedor junto con su estado de ejecución

## Stack Tecnológico

---

- MySQL
- Python
- Pandas
- FastAPI
- Docker
- HTML

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" width=50px height=50px/>         
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/pandas/pandas-original.svg" width=40px height=40px/> 
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-plain.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width=40px height=40px/>
