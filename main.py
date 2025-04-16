import threading
import psycopg2
import time
import funciones as fn

ola = {
             'exitosTot' :0,
             'fallosTot' : 0 }
contador = 1
concurrencia = [5,10,20,30]
def correrHilos(lvl_aislamiento, contador = contador):
    for i in concurrencia:
        hilos = []
        print(f"\nEjecutando prueba con {i} usuarios:\n")
        for j in range(1,i+1):
                t = threading.Thread(target=fn.funcionPorHilos, args=(lvl_aislamiento,j,contador))
                hilos.append(t)
                t.start()
                
        for t in hilos:
            t.join()

        print(f"Resumen para {i} hilos:")
        print(f"Éxitos: {fn.contador_global['exitos']}")
        print(f"Fallos: {fn.contador_global['fallos']}")  

        ola["exitosTot"]+=fn.contador_global['exitos']
        ola['fallosTot']+=fn.contador_global['fallos']

        print(f"Promedio de tiempo: {(fn.contador_global['sumatoria'])/i}")
        fn.contador_global["exitos"] = 0
        fn.contador_global["fallos"] = 0  
        fn.contador_global["sumatoria"] = 0
        contador += 1
        


def main():
    aislamientos = [
        (psycopg2.extensions.ISOLATION_LEVEL_READ_COMMITTED, "Read Committed"),
        (psycopg2.extensions.ISOLATION_LEVEL_REPEATABLE_READ, "Repeatable Read"),
        (psycopg2.extensions.ISOLATION_LEVEL_SERIALIZABLE, "Serializable")
    ]
    
    for nivel, nombre in aislamientos:
        print(f"\n--- Experimentando con nivel de aislamiento: {nombre} ---")
        correrHilos(nivel)
        time.sleep(3)  # Segundos de espera entre experimentos  
    print("\nExitos Totales:",ola['exitosTot'],"Fallos Totales:",ola['fallosTot'])


main()