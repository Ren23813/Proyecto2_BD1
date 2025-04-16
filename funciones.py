import psycopg2
import random
import time
import threading

host = "localhost"  
dbname = "Proyecto2"  
user = "user_proyecto2"  
password = "proyecto2_2025"  

contador_global = {
    'exitos': 0,
    'fallos': 0,
    'sumatoria': 0
}

lock_global = threading.Lock()


def funcionPorHilos(lvl_aislamiento, id_thread, contador):
    inicio = time.time()
    exitos = 0
    fallos = 0
    #lock = threading.Lock()
    conn = psycopg2.connect(
        host=host,
        dbname=dbname,
        user=user,
        password=password)
    conn.set_isolation_level(lvl_aislamiento)
    cursor = conn.cursor()
    cantidadAsientos = random.randint(1, 4)
    asientoInicial = random.randint(1, 47)

    try: 
        cursor.execute("BEGIN;")
        cursor.execute("insert into reserva(id_cliente, estado_reserva) values(%s, 'en proceso');", (id_thread,)) 
#        time.sleep(0.5)            Se podría meter si se quisiera que existiera algo de secuencialización, y no solo paralelismo.  
        cursor.execute("select id from reserva where id_cliente = %s and estado_reserva = 'en proceso';", (id_thread,))
        idReservaCliente = cursor.fetchone()
        if idReservaCliente is None:
            print(f"hilo {id_thread} no encontró la reserva.")
            cursor.execute("ROLLBACK;")
            with lock_global:
                contador_global["fallos"] +=1
            #return
            return
      
        idReservaCliente2 = idReservaCliente[0]
        listaAsientos = []
        for i in range (cantidadAsientos):
            cursor.execute("select id from asientos where id_funcion = %s and ubicacion = %s;", (contador, asientoInicial,))
            
            idAsientoTemp = cursor.fetchone()
            if idAsientoTemp is None:
                print(f"hilo {id_thread} no encontró el asiento.")
                cursor.execute("ROLLBACK;")
                with lock_global:
                    contador_global["fallos"] +=1
            #return
                return

            idAsiento = idAsientoTemp[0]
            listaAsientos.append(idAsiento)
            cursor.execute("insert into detalles_reserva(id_reserva, id_asiento) values(%s, %s);",(idReservaCliente2,idAsiento,))
            asientoInicial += 1
               
        time.sleep(0.4)
        for j in listaAsientos:    
            cursor.execute("select ubicacion, estado from asientos where id = %s", (j,)) 
            selectTemp = cursor.fetchone()
            if selectTemp is None:
                print(f"hilo {id_thread} no encontró la ubicacion.")
                cursor.execute("ROLLBACK;")
                with lock_global:
                    contador_global["fallos"] +=1
                return
            
            if selectTemp[1] == 'reservado': 
                print(f"lo siento pa, ya está ese asiento reservado: {selectTemp[0]}")
                cursor.execute("ROLLBACK;")   
                with lock_global:
                    contador_global["fallos"] +=1     
                return
                            
        cursor.execute("insert into pagos(id_reserva, nit, total) values (%s, 'C/F', %s);", (idReservaCliente2, (cantidadAsientos*25),))
        for k in listaAsientos:        
            cursor.execute("update asientos set estado = 'reservado' where id = %s;",(k,))
        
        cursor.execute("update reserva set estado_reserva = 'completado' where id = %s;",(idReservaCliente2,))        

        print("transaccion completada")
        cursor.execute("COMMIT;")
        with lock_global:
                contador_global["exitos"] +=1

    except Exception as e:
        print(f"Hilo {id_thread} falló: {e}")
        cursor.execute("ROLLBACK;")
        with lock_global:
            contador_global["fallos"] +=1
    
    finally:
        cursor.close()
        conn.close()
        fin = time.time()
        contador_global["sumatoria"] += (fin-inicio)
        print(f"Hilo {id_thread} terminó en {fin - inicio:.2f} segundos")
