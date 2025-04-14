import threading
import psycopg2
import time
import funciones as fn

concurrencia = [5,10,20,30]
def correrHilos(lvl_aislamiento):
    for i in concurrencia:
        hilos = []
        print(f"\nEjecutando prueba con {i} usuarios:\n")
        for j in range(i):
                t = threading.Thread(target=fn.funcionPorHilos, args=(lvl_aislamiento,j))
                hilos.append(t)
                t.start()
                
        for t in hilos:
            t.join()


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


main()