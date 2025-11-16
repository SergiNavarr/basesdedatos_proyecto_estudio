/* Tema: Optimización de consultas a través de índices

Tareas: 

-- Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga 
un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.

-- Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor 
y los tiempos de respuesta.

-- Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. 
Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- Borrar el índice creado

-- Definir otro índice agrupado sobre la columna fecha pero que además incluya las 
columnas seleccionadas y repetir la consulta anterior. 
Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

-- Expresar las conclusiones en base a las pruebas realizadas.
*/

------------------------------------------------------------------------------------------------------
------------------------------| ELECCION TABLA ENVIO |------------------------------------------------
/* CREATE TABLE envio (
    id_envio INT NOT NULL IDENTITY(1,1),
    fecha_registro DATE NOT NULL,
    id_paquete INT NOT NULL,
    id_ruta INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_empleado_responsable INT NOT NULL,
    id_estado_actual INT NOT NULL,
    CONSTRAINT pk_envio PRIMARY KEY (id_envio),
    CONSTRAINT fk_envio_paquete FOREIGN KEY (id_paquete) REFERENCES paquete(id_paquete),
    CONSTRAINT fk_envio_ruta FOREIGN KEY (id_ruta) REFERENCES ruta(id_ruta),
    CONSTRAINT fk_envio_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    CONSTRAINT fk_envio_empleado FOREIGN KEY (id_empleado_responsable) REFERENCES empleado(id_empleado),
    CONSTRAINT fk_envio_estado FOREIGN KEY (id_estado_actual) REFERENCES estado_envio(id_estado),
    CONSTRAINT ck_envio_fecha CHECK (fecha_registro <= GETDATE())
);*/

-- 1) Realizar una carga masiva de por lo menos un millón de registro sobre alguna tabla que contenga un campo fecha (sin índice). Hacerlo con un script para poder automatizarlo.

SET NOCOUNT ON;

--Declaramos variables
DECLARE @i INT = 1;
DECLARE @max INT = 1000000; --Numero total de registros a insertar

-- Variables para los campos del INSERT
DECLARE @fecha DATE;
DECLARE @id_paquete INT;
DECLARE @id_ruta INT;
DECLARE @id_vehiculo INT;
DECLARE @id_empleado INT;
DECLARE @id_estado INT;

WHILE @i <= @max
BEGIN
   -- Genera una fecha aleatoria entre 2015 y 2025
    SET @fecha = DATEADD(
                    DAY, 
                    ABS(CHECKSUM(@i * RAND() * 3)) % 3650,
                    '2015-01-01'
                );
    -- Valores pseudoaleatorios para claves foraneas
    SET @id_paquete    = ((ABS(CHECKSUM(@i * 7     + RAND()*100)) % 50) + 1); -- 1-50
    SET @id_ruta       = ((ABS(CHECKSUM(@i * 11    + RAND()*200)) % 20) + 1); -- 1-20
    SET @id_vehiculo   = ((ABS(CHECKSUM(@i * 13    + RAND()*150)) % 10) + 1); -- 1-10
    SET @id_empleado   = ((ABS(CHECKSUM(@i * 17    + RAND()*90 )) % 20) + 1); -- 1-20
    SET @id_estado     = ((ABS(CHECKSUM(@i * 19    + RAND()*50 )) % 6 ) + 1); -- 1-6

    -- Insercion final
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (@fecha, @id_paquete, @id_ruta, @id_vehiculo, @id_empleado, @id_estado);

    -- Incremento del contador
    SET @i = @i + 1;
END;
SET NOCOUNT OFF;


-- Crea una nueva tabla "envio_2" como copia de "envio", sin indices
SELECT *
INTO envio_2
FROM envio;

-- 2) Realizar una búsqueda por periodo y registrar el plan de ejecución utilizado por el motor 
--y los tiempos de respuesta.


SET STATISTICS TIME ON;  -- Muestra tiempo de ejecucion (CPU y total)
SET STATISTICS IO ON;   -- Muestra operaciones de lectura/escritura

--Plan de ejecucion "Table Scan"
--Consulta por periodo tabla sin indice
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos):  CPU time = 1079 ms,  elapsed time = 4891 ms. // CPU time = 1063 ms,  elapsed time = 4561 ms. // CPU time = 563 ms,  elapsed time = 4890 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 4465

--Plan de ejecucion "Clustered Index Scan"
--Consulta por periodo tabla con indice
SELECT *
FROM envio
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos): CPU time = 953 ms,  elapsed time = 4633 ms. //  CPU time = 906 ms,  elapsed time = 4548 ms. //   CPU time = 875 ms,  elapsed time = 4667 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 4483


SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;

-- 3) Definir un índice agrupado sobre la columna fecha y repetir la consulta anterior. Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

SET STATISTICS TIME ON;  -- Muestra tiempo de ejecucion (CPU y total)
SET STATISTICS IO ON;   -- Muestra operaciones de lectura/escritura

--Tardo 00:00:05 en crear el indice 
--Aplicamos indice acumulado en la columna fecha_registro
CREATE CLUSTERED INDEX IX_fecha_registro
ON envio_2 (fecha_registro);

--Plan "Clustered Index Seek"
SELECT *
FROM envio_2
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 699.666 // Tiempos (3 intentos): CPU time = 844 ms,  elapsed time = 5289 ms. /   CPU time = 843 ms,  elapsed time = 4530 ms. /  CPU time = 719 ms,  elapsed time = 4537 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 3815

--Plan de ejecucion "Clustered Index Scan"
--Consulta por periodo tabla con indice
SELECT *
FROM envio
WHERE fecha_registro BETWEEN '2018-01-01' AND '2025-01-01';

-- 4) Borrar el índice creado
DROP INDEX IX_fecha_registro
ON envio_2;

-- 5) Definir otro índice agrupado sobre la columna fecha pero que además incluya las 
-- columnas seleccionadas y repetir la consulta anterior. 
-- Registrar el plan de ejecución utilizado por el motor y los tiempos de respuesta.

--Plan "Clustered Index Seek"
-- OPCION 1: Indice agrupado con las columnas definidas.
CREATE CLUSTERED INDEX IX_envio_fecha_estado_ruta
ON envio_2 ( fecha_registro, id_estado_actual, id_ruta);

--Consulta 1
SELECT fecha_registro, id_estado_actual, id_ruta
FROM envio_2
WHERE fecha_registro BETWEEN '2023-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 200.040 // Tiempos (3 intentos): CPU time = 171 ms,  elapsed time = 1418 ms. /  CPU time = 188 ms,  elapsed time = 1371 ms. /  CPU time = 203 ms,  elapsed time = 1153 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 1019

--Consulta 2
SELECT fecha_registro, id_ruta, id_estado_actual
FROM envio_2
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-12-31' AND id_ruta = 7;

--Resultados de la consulta:
--Columnas devueltas: 4.993 // Tiempos (3 intentos):  CPU time = 16 ms,  elapsed time = 105 ms. /   CPU time = 31 ms,  elapsed time = 82 ms. /  CPU time = 15 ms,  elapsed time = 86 ms.
--Lecturas logicas obtenidas:Table 'envio_2'. Scan count 1, logical reads 510

--Consulta 3
SELECT e.fecha_registro, es.nombre_estado, e.id_ruta
FROM envio_2 AS e
INNER JOIN estado_envio AS es ON e.id_estado_actual = es.id_estado
WHERE e.fecha_registro BETWEEN '2023-01-01' AND '2024-12-31' AND e.id_estado_actual IN (5, 6) AND id_ruta = 7 ;  

--Resultados de la consulta:
--Consultas devueltas: 3329 // Tiempos (3 intentos): CPU time = 47 ms,  elapsed time = 136 ms. / CPU time = 31 ms,  elapsed time = 132 ms. / CPU time = 62 ms,  elapsed time = 142 ms.
--Lecturas logicas obtenidas: Table 'envio_2'. Scan count 1, logical reads 1019


--Ejecutamos el siguiente codigo en el caso de querer eliminar el indice agrupado
--DROP INDEX  IX_envio_fecha_estado_ruta ON envio_2;

--Plan de ejecucion "Index Seek (NonClustered)"
--OPCION 2: Indice no agrupado con INCLUDE para las columnas
CREATE NONCLUSTERED INDEX IX_fecha_registro_estado_ruta
ON envio (fecha_registro)
INCLUDE (id_estado_actual, id_ruta);

--Consulta 1:
SELECT fecha_registro, id_estado_actual, id_ruta
FROM envio
WHERE fecha_registro BETWEEN '2023-01-01' AND '2025-01-01';

--Resultados de la consulta:
--Columnas devueltas: 200040 / Tiempos (3 intentos):  CPU time = 47 ms,  elapsed time = 1206 ms. /   CPU time = 203 ms,  elapsed time = 1073 ms. / CPU time = 0 ms,  elapsed time = 1257 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 525

--Consulta 2
SELECT fecha_registro, id_ruta, id_estado_actual
FROM envio
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-12-31' AND id_ruta = 7;

--Resultados de la consulta:
--Columnas devueltas: 4.993 // Tiempos (3 intentos): CPU time = 0 ms,  elapsed time = 72 ms./ CPU time = 15 ms,  elapsed time = 79 ms./  CPU time = 0 ms,  elapsed time = 82 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 264

--Consulta 3
SELECT e.fecha_registro, es.nombre_estado, e.id_ruta
FROM envio AS e
INNER JOIN estado_envio AS es ON e.id_estado_actual = es.id_estado
WHERE e.fecha_registro BETWEEN '2023-01-01' AND '2024-12-31' AND e.id_estado_actual IN (5, 6) AND id_ruta = 7 ; 

--Resultados de la consulta:
--Columnas devueltas: 3329 // Tiempos (3 intentos): CPU time = 63 ms,  elapsed time = 118 ms. /   CPU time = 32 ms,  elapsed time = 139 ms. /   CPU time = 47 ms,  elapsed time = 139 ms.
--Lecturas logicas obtenidas: Table 'envio'. Scan count 1, logical reads 525

 --En caso de querer eliminar el indice (NO acumulado), ejecutamos el siguiente codigo.
-- DROP INDEX IX_fecha_registro_estado_ruta ON envio;

--Nota: Estas pruebas de índices acumulados e índices NO acumulados fueron basicas, sin embargo los resultados muestran que el uso de
--los mismos mejora notablemente el rendimiento de las consultas. Los índices agrupados optimizan busquedas por rangos amplios, mientras que los no agrupados con columnas incluidas son mas eficientes en consultas especificas.
--En ambos casos, se reducen los tiempos de respuesta y el uso de recursos al evitar escaneos completos de la tabla.

--Tabla resumen
-- | Escenario (Indice aplicado)                                                               | Plan de ejecucion          | Consulta                                      | Logical Reads | CPU Time aprox  | Elapsed Time aprox. | Filas devueltas  
-- | 1. Sin índice (envio_2)                                                                   | Table Scan                 | Consulta por período (2018–2025)              | 4465          |  563 ms         |  4561 ms            | 699,666          
-- | 2. PK por defecto (Clustered por id_envio)                                                | Clustered Index Scan       | Consulta por período (2018–2025)              | 4483          |  875 ms         |  4548 ms            | 699,666          
-- | 3. Índice agrupado por fecha (fecha_registro)                                             | Clustered Index Seek       | Consulta por período (2018–2025)              | 3815          |  719 ms         |  4530 ms            | 699,666         
-- | 4. Índice agrupado compuesto (fecha_registro, id_estado_actual, id_ruta)                  | Clustered Index Seek       | Consulta columnas 1: Rango 2023–2025          | 1019          |  171–200 ms     | 1153–1400 ms        | 200,040          
-- |                                                                                           |                            | Consulta columnas 2: Rango + ruta=7           | 510           |  15–30 ms       | 80–105 ms           | 4,993            
-- |                                                                                           |                            | Consulta columnas 3: JOIN + filtros           | 1019          |  31–60 ms       | 130–142 ms          | 3,329            
-- | 5. Índice no agrupado con INCLUDE (fecha_registro INCLUDE estado, ruta)                   | Nonclustered Seek          | Consulta columnas 1: Rango 2023–2025          | 525           |  0–200 ms       | 1073–1250 ms        | 200,040          
-- |                                                                                           |                            | Consulta columnas 2: Rango + ruta=7           | 264           |  0–15 ms        | 72–82 ms            | 4,993            
-- |                                                                                           |                            | Consulta columnas 3: JOIN + filtros           | 525           |  30–60 ms       | 118–139 ms          | 3,329            





