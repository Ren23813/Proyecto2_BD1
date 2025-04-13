
--Funcion encargada de crea 50 asientos cada vez que se crea una función
--esto mejora la creación de la data inicial.
CREATE OR REPLACE FUNCTION crear_asientos()
RETURNS trigger AS $$
-- declarar una variable?
DECLARE 
	i INTEGER;
BEGIN
	FOR	i in 1..50 LOOP
		insert into asientos (ubicacion, id_funcion, estado)
		VALUES (i, NEW.id, 'disponible');
	End loop;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger que llama a la funcion.
CREATE TRIGGER after_insert_funciones
AFTER INSERT ON funciones
FOR EACH ROW 
EXECUTE FUNCTION crear_asientos();


-- Tabla de peliculas
INSERT INTO peliculas (nombre, productor, sinopsis, duracion, fecha_estreno, fecha_salida)
VALUES
-- id 1
('5 READ COMMITTED', 'Estudio Esquizofrenia', 'Una historia de bases de datos que no saben qué hacer con sus transacciones.', 120.00, '2025-05-01', '2025-06-01'),
-- id 2
('10 READ COMMITTED', 'Team Isolation', 'El caos que surge cuando 10 usuarios simultáneos se pelean por la misma fila de datos.', 110.00, '2025-06-01', '2025-07-01'),
-- id 3
('20 READ COMMITTED', 'SQL Productions', 'Cuando 20 usuarios comienzan a leer datos sin bloquear nada y el servidor grita pidiendo ayuda.', 115.00, '2025-07-01', '2025-08-01'),
-- id 4
('30 READ COMMITTED', 'Big Data Studios', 'Más de 30 usuarios luchando por una transacción. La base de datos no sabe si reír o llorar.', 130.00, '2025-08-01', '2025-09-01'),
-- id 5
('5 REPEATABLE READ', 'Atomic Records', 'Cinco usuarios que no pueden cambiar los datos de otros. ¡Ni uno puede hacer un UPDATE tranquilo!', 100.00, '2025-05-15', '2025-06-15'),
-- id 6
('10 REPEATABLE READ', 'SQL Safe Studios', 'Diez usuarios que piensan que pueden ver el mismo dato todo el tiempo, pero uno de ellos está convencido de que es un fantasma.', 105.00, '2025-06-15', '2025-07-15'),
-- id 7
('20 REPEATABLE READ', 'Database Universe', 'Veinte usuarios, una lectura consistente. Pero cuando cambian la base de datos, nadie se entera hasta que es demasiado tarde.', 125.00, '2025-07-15', '2025-08-15'),
-- id 8
('30 REPEATABLE READ', 'Concurrency Creations', 'Treinta usuarios, todos convencidos de que tienen su copia privada de los datos. ¡Hasta que llega el bloqueo!', 135.00, '2025-08-15', '2025-09-15'),
-- id 9
('5 SERIALIZABLE', 'Full Isolation Studios', 'Cinco usuarios que creen que son los únicos en la base de datos, pero la base de datos tiene sus propios secretos.', 140.00, '2025-05-30', '2025-06-30'),
-- id 10
('10 SERIALIZABLE', 'Transaction Masterminds', 'Diez usuarios buscando la verdad absoluta en sus datos, pero la base de datos les tiene un par de sorpresas.', 150.00, '2025-06-30', '2025-07-30'),
-- id 11
('20 SERIALIZABLE', 'Isolation Architects', 'Veinte usuarios, cero conflictos. Solo que la base de datos está demasiado aislada para que alguien vea algo.', 155.00, '2025-07-30', '2025-08-30'),
-- id 12
('30 SERIALIZABLE', 'Parallel Universe Studios', 'Treinta usuarios, todos con una transacción seria. El problema es que nadie está dispuesto a esperar.', 160.00, '2025-08-30', '2025-09-30');

-- Tabla salas
INSERT INTO salas (filas, asientos_filas, cupo_maximo, precio_asiento)
VALUES
-- id 1
(5, 10, 50, 25.00),
-- id 2
(10, 5, 50, 25.00),
-- id 3
(2, 25, 50, 25.00),
-- id 4
(6, 9, 50, 25.00),
-- id 5
(5, 10, 50, 25.00);


-- tabla funciones
INSERT INTO funciones (id_sala, id_pelicula, horario_inicio, horario_salida)
VALUES
-- id 1
(1, 1, now(), now() + INTERVAL '2 hours'),
-- id 2
(2, 2, now() + INTERVAL '15 minutes', now() + INTERVAL '2 hours 15 minutes'),
-- id 3
(3, 3, now() + INTERVAL '30 minutes', now() + INTERVAL '2 hours 30 minutes'),
-- id 4
(4, 4, now() + INTERVAL '45 minutes', now() + INTERVAL '2 hours 45 minutes'),
-- id 5
(5, 5, now() + INTERVAL '1 hour', now() + INTERVAL '3 hours'),
-- id 6
(1, 6, now() + INTERVAL '1 hour 15 minutes', now() + INTERVAL '3 hours 15 minutes'),
-- id 7
(2, 7, now() + INTERVAL '1 hour 30 minutes', now() + INTERVAL '3 hours 30 minutes'),
-- id 8
(3, 8, now() + INTERVAL '1 hour 45 minutes', now() + INTERVAL '3 hours 45 minutes'),
-- id 9
(4, 9, now() + INTERVAL '2 hours', now() + INTERVAL '4 hours'),
-- id 10
(5, 10, now() + INTERVAL '2 hours 15 minutes', now() + INTERVAL '4 hours 15 minutes'),
-- id 11
(1, 11, now() + INTERVAL '2 hours 30 minutes', now() + INTERVAL '4 hours 30 minutes'),
-- id 12
(2, 12, now() + INTERVAL '2 hours 45 minutes', now() + INTERVAL '4 hours 45 minutes');



-- Tabla de clientes
INSERT INTO clientes (nombre, correo) VALUES 
('María González', 'maria.gonzalez@email.com'),
('Carlos Pérez', 'carlos.perez@email.com'),
('Lucía Ramírez', 'lucia.ramirez@email.com'),
('José Martínez', 'jose.martinez@email.com'),
('Ana Torres', 'ana.torres@email.com'),
('Miguel Sánchez', 'miguel.sanchez@email.com'),
('Laura Herrera', 'laura.herrera@email.com'),
('Pedro Díaz', 'pedro.diaz@email.com'),
('Carmen López', 'carmen.lopez@email.com'),
('Luis Castro', 'luis.castro@email.com'),
('Sandra Vega', 'sandra.vega@email.com'),
('Jorge Romero', 'jorge.romero@email.com'),
('Claudia Méndez', 'claudia.mendez@email.com'),
('Andrés Navarro', 'andres.navarro@email.com'),
('Sofía Morales', 'sofia.morales@email.com'),
('Ricardo León', 'ricardo.leon@email.com'),
('Daniela Pineda', 'daniela.pineda@email.com'),
('Héctor Ruiz', 'hector.ruiz@email.com'),
('Valeria Silva', 'valeria.silva@email.com'),
('Francisco Ortega', 'francisco.ortega@email.com'),
('Isabel Castro', 'isabel.castro@email.com'),
('Diego Flores', 'diego.flores@email.com'),
('Paula Cordero', 'paula.cordero@email.com'),
('Manuel Reyes', 'manuel.reyes@email.com'),
('Natalia Aguirre', 'natalia.aguirre@email.com'),
('Emilio Vázquez', 'emilio.vazquez@email.com'),
('Fernanda Soto', 'fernanda.soto@email.com'),
('Sebastián Ríos', 'sebastian.rios@email.com'),
('Gabriela Campos', 'gabriela.campos@email.com'),
('Raúl Mendoza', 'raul.mendoza@email.com'),
('Elena Fuentes', 'elena.fuentes@email.com'),
('Tomás Bravo', 'tomas.bravo@email.com'),
('Rosa Delgado', 'rosa.delgado@email.com'),
('Iván Cabrera', 'ivan.cabrera@email.com'),
('Patricia Núñez', 'patricia.nunez@email.com');
