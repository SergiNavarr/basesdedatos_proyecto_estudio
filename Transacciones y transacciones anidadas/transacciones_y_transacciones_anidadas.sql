/*
-	1) Escribir el código Transact SQL que permita definir una transacción consistente en:
	Insertar un registro en alguna tabla, luego otro registro en otra tabla y por último la actualización de uno o más registros en otra tabla. 
	Actualizar los datos solamente si toda la operación es completada con éxito. 

-	2) Sobre el código escrito anteriormente provocar intencionalmente un error luego del insert y 
	verificar que los datos queden consistentes (No se debería realizar ningún insert). 

-	3) Expresar las conclusiones en base a las pruebas realizadas.
*/

-- 1)

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1) Insertar nueva ruta
    INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
    VALUES ('Ruta 10 a 2', 10, 2, 10.5, 25);

    DECLARE @idRuta INT = SCOPE_IDENTITY();

    -- 2) Insertar nuevo envío usando esa ruta
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), 1, @idRuta, 1, 5, 1);

    DECLARE @idEnvio INT = SCOPE_IDENTITY();

    -- 3) Actualizar estado del envío
    UPDATE envio
    SET id_estado_actual = 2
    WHERE id_envio = @idEnvio;

    COMMIT;
    PRINT 'Transacción completada correctamente.';

END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Se revertieron todos los cambios.';
    PRINT ERROR_MESSAGE();
END CATCH;

-- 2)

BEGIN TRY
    BEGIN TRANSACTION;

    -- 1) Insertar nueva ruta
    INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
    VALUES ('Ruta 10 a 3', 10, 3, 10.5, 25);

    DECLARE @idRuta2 INT = SCOPE_IDENTITY();

    -- 2) ERROR INTENCIONAL: Insertar envío con vehículo inexistente
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), 1, @idRuta2, 9999, 5, 1);
    --                       vehículo inválido provoca error FK

    DECLARE @idEnvio2 INT = SCOPE_IDENTITY();

    -- 3) Actualizar envío (nunca se ejecuta porque ya falló antes)
    UPDATE envio
    SET id_estado_actual = 2
    WHERE id_envio = @idEnvio2;

    COMMIT;
    PRINT 'Todo se guardó correctamente.';

END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error detectado: Se ejecutó ROLLBACK.';
    PRINT ERROR_MESSAGE();
END CATCH;


/* 3) Conclusiones
Durante las pruebas se implementó una transacción que incluía tres operaciones secuenciales: 
inserción de una ruta, inserción de un envío relacionado y actualización del estado de ese envío. 
Cuando todas las operaciones se realizaron correctamente, la transacción llegó al COMMIT y los cambios quedaron
guardados de forma permanente, cumpliendo el objetivo de atomicidad.

Luego se repitió la prueba provocando un error intencional al intentar insertar un envío con un valor inválido
en una clave foránea (vehículo inexistente). SQL Server detectó el error y ejecutó el bloque CATCH, 
realizando un ROLLBACK. Como resultado, ninguna de las operaciones dentro de la transacción quedó registrada
en la base de datos: ni la ruta, ni el envío, ni la actualización.

Esto demuestra que la transacción garantiza la integridad y consistencia del modelo relacional. 
Los datos solo se guardan si todas las operaciones se ejecutan correctamente. 
Si ocurre cualquier fallo en una parte del proceso, el sistema revierte todo automáticamente y evita la existencia
de registros incompletos o huérfanos.
*/