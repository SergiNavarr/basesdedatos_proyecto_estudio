/*
    Transacciones anidadas
*/

-- Declaración de variables
DECLARE @direccionID INT;
DECLARE @clienteID INT;
DECLARE @paqueteID INT;
DECLARE @envioID INT;

PRINT '--- INICIO DEL PROCESO EXITOSO ---';

BEGIN TRY

    -- TRANSACCIÓN PRINCIPAL
    BEGIN TRANSACTION ClientePaqueteProceso;

        -- 1) Insertar Dirección
        INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad)
        VALUES ('Calle Falsa', '123', NULL, '3400', 1);
        SET @direccionID = SCOPE_IDENTITY();

        -- 2) Insertar Cliente
        INSERT INTO cliente (nombre, apellido, dni, email, id_direccion)
        VALUES ('Carlos', 'Lopez', '30303030', 'carlos.l@example.com', @direccionID);
        SET @clienteID = SCOPE_IDENTITY();

        -- Crear SAVEPOINT para transacción interna
        SAVE TRANSACTION SaveInterna;

        BEGIN TRY
            -- TRANSACCIÓN ANIDADA (simulada con SAVEPOINT)
            PRINT '--- INICIO TRANSACCIÓN INTERNA EXITOSA ---';

            -- 3) Insertar Paquete
            INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
            VALUES (4.5, '30x20x10', 1000, 1, @clienteID, 2);
            SET @paqueteID = SCOPE_IDENTITY();

            -- 4) Insertar Envío
            INSERT INTO envio (fecha_registro, id_ruta, id_paquete, id_vehiculo, id_empleado_responsable, id_estado_actual)
            VALUES (GETDATE(), 1, @paqueteID, 1, 1, 1);
            SET @envioID = SCOPE_IDENTITY();

            -- 5) Insertar Historial del Envío (línea que faltaba)
            INSERT INTO historial_envio (id_envio, id_estado, fecha_hora, observaciones)
            VALUES (@envioID, 1, GETDATE(), 'Envío generado correctamente.');

        END TRY
        BEGIN CATCH
            PRINT 'ERROR INESPERADO EN TRANSACCIÓN INTERNA';
            PRINT ERROR_MESSAGE();
            ROLLBACK TRANSACTION SaveInterna;
        END CATCH;

    -- Commit de toda la transacción
    COMMIT TRANSACTION ClientePaqueteProceso;
    PRINT '--- PROCESO EXITOSO: TODO CONFIRMADO ---';

END TRY
BEGIN CATCH
    PRINT 'ERROR GENERAL';
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION ClientePaqueteProceso;

    PRINT ERROR_MESSAGE();
END CATCH;
