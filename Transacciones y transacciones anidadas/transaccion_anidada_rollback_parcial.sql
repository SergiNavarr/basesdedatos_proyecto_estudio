-- Declaración de variables
DECLARE @direccionID INT;
DECLARE @clienteID INT;
DECLARE @paqueteID INT;

PRINT '--- INICIO DEL PROCESO CON ROLLBACK PARCIAL ---';

BEGIN TRY

    -- TRANSACCIÓN PRINCIPAL
    BEGIN TRANSACTION ClientePaqueteProceso;

        -- 1) Insertar Dirección
        INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad)
        VALUES ('San Martin', '987', NULL, '3400', 1);
        SET @direccionID = SCOPE_IDENTITY();

        -- 2) Insertar Cliente
        INSERT INTO cliente (nombre, apellido, dni, email, id_direccion)
        VALUES ('Ana', 'Perez', '27555111', 'ana.p@example.com', @direccionID);
        SET @clienteID = SCOPE_IDENTITY();

        -- SAVEPOINT antes de la transacción anidada
        SAVE TRANSACTION SaveInterna;

        BEGIN TRY
            PRINT '--- INICIO TRANSACCIÓN INTERNA CON ERROR ---';

            -- 3) Insertar Paquete
            INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
            VALUES (3.2, '25x15x12', 800, 1, @clienteID, 2);
            SET @paqueteID = SCOPE_IDENTITY();

            -- ERROR CONTROLADO
            THROW 50001, 'Error intencional en transacción interna', 1;

            -- (Estas líneas no se ejecutan)
            INSERT INTO envio (fecha_registro, id_ruta, id_paquete, id_vehiculo, id_empleado_responsable, id_estado_actual)
            VALUES (GETDATE(), 1, @paqueteID, 3, 5, 1);

            -- Actualizar datos del paquete (ejemplo de operación adicional)
            UPDATE paquete
            SET valor_declarado = 900
            WHERE id_paquete = @paqueteID;

            -- Inserción en historial del envío (suponiendo que envío existe)
            INSERT INTO historial_envio (id_envio, id_estado, fecha_hora, observaciones)
            VALUES (SCOPE_IDENTITY(), 1, GETDATE(), 'Actualización interna');

        END TRY
        BEGIN CATCH
            PRINT '--- ERROR EN LA TRANSACCIÓN INTERNA ---';
            PRINT ERROR_MESSAGE();
            PRINT 'Revirtiendo SOLO la parte interna...';

            -- ROLLBACK parcial gracias al SAVEPOINT
            ROLLBACK TRANSACTION SaveInterna;

            PRINT '--- ROLLBACK PARCIAL COMPLETADO ---';
        END CATCH;

    -- Commit de la transacción principal
    COMMIT TRANSACTION ClientePaqueteProceso;
    PRINT '--- PROCESO FINALIZADO: CLIENTE Y DIRECCIÓN CONFIRMADOS ---';

END TRY
BEGIN CATCH

    PRINT 'ERROR GENERAL';
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION ClientePaqueteProceso;

    PRINT ERROR_MESSAGE();
END CATCH;
