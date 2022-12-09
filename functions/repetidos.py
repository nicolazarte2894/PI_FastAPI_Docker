# Funcion ListaRepetidos
# Devuelve una lista ordenada de tuplas cuyo primer elemento es el valor unico y el segundo es la cantidad de repeticiones en la lista dada
# El primer elemento es el que mas se repite
def ListaRepetidos(lista):
    lista_unicos=[]
    lista_cantidad=[]
    if(type(lista)!=list):
        return None
    for elem in lista:
        if(not(elem in lista_unicos)):
            lista_unicos.append(elem)
            cantidad = lista.count(elem)
            lista_cantidad.append(cantidad)
        else:
            continue
    lista_tuplas = list(zip(lista_unicos,lista_cantidad))
    lista_tuplas.sort(key = lambda x : x[1], reverse = True)
    return lista_tuplas