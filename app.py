from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import pandas as pd
from functions.repetidos import ListaRepetidos

#Se instancia el modulo de FastAPI en app
app = FastAPI(
                title='Project Data Engineer_ETL+API',
                description='Construcción de API para lectura de datos',
                version = '1.0.0'
              )

# Startup: Al inicio del servidor se levanta la base de datos en un Dataframe como variable global
@app.on_event('startup')
def startup():
    global df_movies
    df_movies = pd.read_csv('./Data/movies_titles.csv')
        
# Index: Pagina de inicio
@app.get("/", response_class=HTMLResponse)
async def index():
    return """ 
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>FastAPI</title>
            </head>
            <body>
                <h1>Mi primer API</h1>
                
            </body>
            </html>
"""

# Get_max_duration: Retorna duración máxima de la película o serie
# params = {anio, plataforma, tipo}
@app.get('/get_max_duration/')
async def get_mas_duration(  
                        anio: int,
                        plataforma: str,
                        tipo: str):
    # Estandarizado de params
    plataforma = plataforma.capitalize()
    tipo = tipo.lower()
    if tipo == 'min': tipo = 'Movie'    # Determinamos si es pelicula o serie de acuerdo al parámetro
    elif tipo == 'season': tipo = 'TV Show'
    # Máscara del dataframe segun params
    df_filtered =  df_movies[(df_movies.Plataforma == plataforma) & (df_movies.Release_Year == anio) & (df_movies.Type == tipo)]
    # Asignación en una variable del título
    title_max_duration = df_movies.loc[df_filtered.Duration.idxmax()].Title
    duration = df_movies.loc[df_filtered.Duration.idxmax()].Duration
    #Retorno del título con máxima duración
    return { "titulo" : title_max_duration, "duracion":duration}    


# Get_count_platform: Retorna la máxima de apariciones del género de peliculas
# params = {plataforma}
@app.get('/get_count_plataform/')
async def get_count_plataform(plataforma:str):
    plataforma = plataforma.replace("'","")
    plataforma = plataforma.capitalize()
    df_filtered = df_movies[(df_movies.Plataforma == plataforma)]  # Aplicamos una máscara de acuerdo al parámetro
    movies = int(df_filtered[df_filtered.Type == 'Movie'].Type.value_counts()[0]) # Contamos la cantidad de ocurrencias
    series = int(df_filtered[df_filtered.Type == 'TV Show'].Type.value_counts()[0])
    # Retornamos el valor en formato str para poder aclarar a qué corresponde cada cantidad
    return {"cant_movies": movies, "cant_series": series}


# Get_listed_in: Retorna la máxima de apariciones del género de peliculas
# params = {genero}
@app.get('/get_listed_in/')
async def get_listed_in(genero:str):
    genero = genero.replace("'","")
    genero = genero.capitalize()
    # Filtro por genero y agrupo por plataforma con un conteo. Aplicamos un sort_values en forma descendente
    df_filtered = df_movies[df_movies.Listed_In.str.contains(genero, case=False)].groupby(by=['Plataforma']).Title.count().sort_values(ascending=False)
    # Asignamos la plataforma y la cantidad en variables
    plataforma = df_filtered.index[0]
    max_count_genero = int(df_filtered[0])
    print(plataforma, max_count_genero)
    
    # Retornamos la plataforma en la que el parámetro  más se repite y la cantidad
    return {"plataforma": plataforma, "cantidad_genero" : max_count_genero}

# Get_actor: Retorna el actor que mas se repite segun plataforma y año
# params = {plataforma, anio}
@app.get('/get_actor/')
async def get_actor(plataforma: str , anio: int):
    plataforma = plataforma.replace("'","")
    plataforma = plataforma.capitalize()
    
    # Filtro y dropeo de valores nulos
    df_filtered = df_movies[(df_movies.Plataforma == plataforma) & (df_movies.Release_Year == anio)].Cast.dropna()
    lista_actores =[]
    
    # Aplicación de split y strip a cada registro
    for i in df_filtered:
        lista_actores.extend(i.split(','))
    lista_actores = [i.strip() for i in lista_actores]
    
    # Aplico función de Lista repetidos definida en functions --> repetidos.py
    lista_repetidos = ListaRepetidos(lista_actores)
    
    return { "actor": lista_repetidos[0][0], "max_actuaciones": lista_repetidos[0][1]}
    
    

