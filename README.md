## **_PROYECTO INDIVIDUAL 01 - DATA ENGINEER_**

---

## INTRODUCCI脫N

Hola!馃憢 Me llamo Nicol谩s Angel Lazarte, les presento mi proyecto individual realizado durante el Bootcamp de Data Science de SoyHenry.  
El proyecto consiste en realizar tareas b谩sicas del perfil de Data Engineer al aplicar diferentes t茅cnicas y conocimientos tales como conexi贸n a diferentes fuentes de datos, realizar los procesos de limpieza y transformaci贸n pertinentes y disponibilizar los mismos mediante alg煤n medio de consulta local o remoto. En este caso se ultiliza Pandas de Python para realizar un simple an谩lisis eploratorio, MySQL para el montaje de la base de datos y procesos de ETL y por ultimo FastAPI para la construcci贸n de una API de consultas a trav茅s de un entorno de Docker.

## Objetivo

Construir una API para realizar consultas en el navegador que se obtienen a trav茅s de una fuente don datos de t铆tulos de plataforma de streaming y a su vez embebido en un ambiente de Docker.

## Directorios y archivos del repositorio

- [**Data**:](./Data/) Directorio donde se disponibilizan las fuentes de datos no sin procesar y la base de datos ya procesadas en sql llamada _movies_titles_
- [**ETL**:](./ETL/) Directorio que aloja los scripts de sql para la ingesti贸n y transformaci贸n de datos en el database movies. Contiene tambi茅n un archivo `.ipynb` con el [Proceso de EDA y ETL detallado](./ETL/ProcesoETL.ipynb)
- [**functions**:](./functions/) Directorio con una funci贸n de ListaRepetidos que se utiliza en la query `get_actor` de la API dentro del decorador
- [**main.py**:](/main.py) Script de para la instanciaci贸n de FastAPI y desarrollo de las funciones de consulta
- [**Dockerfile**:](./Dockerfile) Script con las dependencias para el levantamiento de la imagen y levantamiento del contenedor de Docker

## Links de Consignas y Explicaci贸n del Proyecto

|                  Descripci贸n                  |                          Link                           | Plataforma |
| :-------------------------------------------: | :-----------------------------------------------------: | :--------: |
|    Consignas del proyecto de Data Engineer    | [Repositorio](https://github.com/HX-FAshur/PI01_DATA05) |   Github   |
| Video explicativo del desarrollo del proyecto |                  [Video](youtube.com)                   |  YouTube   |

## ETAPAS DEL PROYECTO

---

### **1) Estudio de la fuente de datos y EDA (Exploratory Data Analysis)**

En primer lugar se realiza un estudio de las fuentes de datos disponibilizadas en archivos `.csv` y `.json` de pel铆culas y tv shows de las plataformas de Amazon, Disney, Hulu y Netflix.
Se hace una exploraci贸n de datos con pandas, revision de duplicados, tipos de datos y valores faltantes tomando las acciones necesarias. Se sacan las primeras conclusiones para la ingesti贸n a la base de datos. El an谩lisis se hace a trav茅s del jupyter notebook mencionado anteriormente

### **2) ETL (Extract, Transform and Load)**

Se elaboraron dos scripts de sql, uno para la ingesta y otro para la transformaci贸n de datos. Durante el proceso de carga se tiene en cuenta los tipos de datos. En el proceso de transformaci贸n se obtiene una tabla unificada y se realizan las transformaciones de limpieza m铆nimas pero suficientes para el alcance del proyecto. Luego de la transformaci贸n se guarda en un archivo `.csv` dicha tabla maestra utilizando el conector `pymysql` y `pandas` para la conexi贸n, ejecutar la query de toda la tabla y guardar el Dataframe en csv en la carpeta Data

### **3) Creaci贸n de una API con FastAPI y Queries (M茅todo `GET`)**

Se utiliza el framework FastAPI para la creaci贸n de dicha aplicaci贸n en el script `app.py`. En la etapa de desarrollo y prueba se realizaron las funciones necesarias para ejecutar las consultas y testeos de manera local. Las responses de la API son en formato `.JSON`
Las funciones (M茅todo `GET`) con las que cuenta la API son:

- **startup:** funci贸n de arranque donde la API pone a disposici贸n la fuente de datos ya transformado para la aplicaci贸n de las consultas

- **index:** funci贸n de bienvenida con un HTML response

- **get_max_duration:** Consulta de t铆tulo con m谩s duraci贸n de acuerdo a la plataforma y a帽o

  - params = (a帽o, plataforma, [min o season])
  - response = t铆tulo de la pel铆cula o tv show con mas duraci贸n

- **get_count_platform:** Consulta la cantidad de t铆tulos por plataforma, separado por pel铆culas y series

  - params = (plataforma)
  - response = cantidad de movies y cantidad de series para la plataforma pasada como par谩metro

- **get_listed_in:** Consulta la m谩xima cantidad de apariciones del g茅nero en el t铆tulo

  - params = (genero)
  - response = plataforma y la m谩xima cantidad titulos del genero pasado como par谩metro

- **get_actor:** Consulta del actor que m谩s se repite seg煤n plataforma y a帽o
  - params = (plataforma, a帽o)
  - response = nombre del actor con mas actuaciones y la cantidad de veces que actu贸 seg煤n la plataforma y a帽o

**Se probaron las consultas de manera local con con la ruta `localhost:8000/docs` en el navegador luego de levantar el servidor de uvicorn con el comando en la terminal `uvicorn app:app --reload` devolviendo en formato JSON las responses**

### **4) Docker**

Se realiza levanta un contenedor de docker a trav茅s de un Dockerfile que contiene los servicios y dependencias necesarias junto con las instrucciones para llevar la aplicaci贸n al entorno de Docker. Se construyen las imagenes y el contenedor a trav茅s de las siguientes l铆neas de c贸digo

```
docker build -t fastapi .
docker run -it -p 8000:8000 -v cd:/usr/src/app
```

Se utiliza Docker Desktop en Windows para visualizar la imagen y el contenedor junto con su estado de ejecuci贸n

### **4) Deploy del proyecto en Mogenius**

Se decide utilizar Mogenius que permite realizar el deploy de un proyecto en la nube para que se pueda consumir en forma remota con el domain que entrega al crear el servicio. Se cre贸 un espacio de trabajo en dicho ambiente y se vincul贸 el repositorio de GitHub para poder hacer el deploy junto al archivo Dockerfile para construir la API.

- Link al deploy en Mogenius (click en la imagen):

[<img src="https://www.cloudflare.com/static/90073b1e5bd8a0765640a20febb3dc22/mogenius_logo_quer.png" width=200px />](https://pi-fastapi-doc-prod-fast-api-project-data-engineer-3ouxq3.mo6.mogenius.io/docs)

## PROPUESTAS DE MEJORA

---

Se puede seguir mejorando el proyecto dando un mayor dinamismo e interacci贸n con el usuario a trav茅s del Frontend. En un futuro se pretende incorporar archivos `css`, `javascript` o bien con el framwork `jinja2` para armado de los templates e interacci贸n con el backend

## STACK TECNOL脫GICO

---

- MySQL
- Jupyter notebook
- Python
- Pandas
- FastAPI
- Docker
- HTML

<div>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" width=50px height=50px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/jupyter/jupyter-original-wordmark.svg" width=40px height=40px/>             
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/pandas/pandas-original.svg" width=40px height=40px/> 
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/fastapi/fastapi-original.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-plain.svg" width=40px height=40px/>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width=40px height=40px/>
</div>
