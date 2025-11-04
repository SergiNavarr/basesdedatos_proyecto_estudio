# Uso de Transacciones y Transacciones Anidadas en SQL Server

## Introducción

Este documento describe el procedimiento seguido para implementar una transacción en SQL Server con el objetivo de asegurar la **consistencia y atomicidad** de los datos durante el proceso de registro de un nuevo envío en el sistema logístico.

La transacción agrupa tres operaciones dependientes:

1.  Inserción de un nuevo registro en la tabla **`paquete`**
2.  Inserción de un registro asociado en la tabla **`envio`**
3.  Registro del historial del estado inicial en **`historial_envio`**

De esta forma, se garantiza que los datos solo se actualicen si todas las operaciones se completan correctamente.
También se incluye una simulación de error intencional para verificar el comportamiento del **ROLLBACK** y demostrar la integridad del modelo de datos.

---

## Objetivo

El propósito de este procedimiento es demostrar el uso de **transacciones simples y anidadas** para garantizar la integridad de los datos dentro del sistema.

En particular, se busca asegurar que si ocurre algún error durante la creación del envío (por ejemplo, una referencia inexistente en alguna clave foránea), **ningún registro parcial quede almacenado**, preservando la coherencia del sistema.

---

## Requisitos Previos

-   Base de datos con las tablas `paquete`, `envio`, `historial_envio` y sus relaciones de clave externa correctamente definidas.
-   Permisos para ejecutar transacciones y manipular datos en SQL Server.
-   Configuración adecuada del esquema de relaciones (cliente, ruta, vehículo, empleado, estado_envio).

---

## Procedimiento

A continuación, se presentan los tres pasos (transacción exitosa, transacción fallida y transacción anidada) dentro de un único script.


## PASO 1: CREACIÓN DE LA TRANSACCIÓN PRINCIPAL (ÉXITO)

Primero se define una transacción principal con BEGIN TRANSACTION.
En esta transacción se realiza la inserción del paquete, la
creación del envío asociado y el registro del historial inicial.
*/
BEGIN TRANSACTION

BEGIN TRY
    -- 1️⃣ Inserción del nuevo paquete
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (3.75, '40x30x25', 2500.00, 1, 2, 3);

    DECLARE @idPaquete INT = SCOPE_IDENTITY();

    -- 2️⃣ Inserción del nuevo envío asociado
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @idPaquete, 1, 1, 5, 1);

    DECLARE @idEnvio INT = SCOPE_IDENTITY();

    -- 3️⃣ Registro del estado inicial en el historial
    INSERT INTO historial_envio (id_envio, fecha_hora, id_estado, observaciones)
    VALUES (@idEnvio, GETDATE(), 1, 'Envío creado correctamente.');

    COMMIT TRANSACTION;
    PRINT '✅ (Paso 1) Transacción completada correctamente.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT '❌ (Paso 1) Error detectado. Se revirtió toda la transacción.';
    PRINT ERROR_MESSAGE();
END CATCH;

## PASO 2: SIMULACIÓN DE ERROR Y VERIFICACIÓN DE ROLLBACK
Para comprobar el funcionamiento del control de errores, se
provoca intencionalmente un error entre la inserción del 
paquete y la del envío, introduciendo un valor de clave
foránea inválido (id_ruta = 9999)

BEGIN TRANSACTION

BEGIN TRY
    -- 1️⃣ Inserción del paquete
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (2.10, '20x20x20', 900.00, 1, 2, 3);

    DECLARE @idPaquetePaso2 INT = SCOPE_IDENTITY();

    -- 2️⃣ Inserción con error intencional (ruta inexistente)
    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @idPaquetePaso2, 9999, 1, 5, 1);

    COMMIT TRANSACTION;
    PRINT '✅ (Paso 2) Transacción completada.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT '❌ (Paso 2) Error detectado. Se ejecutó ROLLBACK.';
    PRINT ERROR_MESSAGE();
END CATCH;



### Verificación (Manual):
Al consultar la tabla paquete después de ejecutar este paso, 
se observa que no quedó insertado ningún registro, 
confirmando que la transacción se revirtió correctamente.



## PASO 3: USO DE TRANSACCIONES ANIDADAS (OPCIONAL)

Para mayor granularidad, puede implementarse una transacción
anidada donde el registro en historial_envio se maneja como
subtransacción.
BEGIN TRANSACTION
BEGIN TRY
    -- Transacción principal
    INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
    VALUES (5.00, '50x40x30', 3200.00, 1, 2, 3);
    DECLARE @idPaquetePaso3 INT = SCOPE_IDENTITY();

    INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
    VALUES (GETDATE(), @idPaquetePaso3, 1, 1, 5, 1);
    DECLARE @idEnvioPaso3 INT = SCOPE_IDENTITY();

    -- Subtransacción
    SAVE TRANSACTION SubHistorial;
    BEGIN TRY
        INSERT INTO historial_envio (id_envio, fecha_hora, id_estado, observaciones)
        VALUES (@idEnvioPaso3, GETDATE(), 1, 'Transacción anidada completada.');
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION SubHistorial;
        PRINT '⚠️ (Paso 3) Error dentro de la transacción anidada.';
    END CATCH

    COMMIT TRANSACTION;
    PRINT '✅ (Paso 3) Transacción principal confirmada.';

END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT '❌ (Paso 3) Error general. Se revirtió todo.';
    PRINT ERROR_MESSAGE();
END CATCH;