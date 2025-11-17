---------------------------------------------------------
--  STORED PROCEDURES
---------------------------------------------------------

-- 1️ Insert Cliente
CREATE OR ALTER PROCEDURE dbo.sp_InsertCliente
    @Nombre VARCHAR(100),
    @Apellido VARCHAR(100),
    @DNI VARCHAR(20),
    @Email VARCHAR(100) = NULL,
    @IdDireccion INT,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO cliente (nombre, apellido, dni, email, id_direccion)
        VALUES (@Nombre, @Apellido, @DNI, @Email, @IdDireccion);

        SET @NewId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO

-- 2️ Update Cliente
CREATE OR ALTER PROCEDURE dbo.sp_UpdateCliente
    @IdCliente INT,
    @Nombre VARCHAR(100) = NULL,
    @Apellido VARCHAR(100) = NULL,
    @DNI VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL,
    @IdDireccion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        UPDATE cliente
        SET nombre = COALESCE(@Nombre, nombre),
            apellido = COALESCE(@Apellido, apellido),
            dni = COALESCE(@DNI, dni),
            email = COALESCE(@Email, email),
            id_direccion = COALESCE(@IdDireccion, id_direccion)
        WHERE id_cliente = @IdCliente;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

-- 3 Insert Paquete
CREATE OR ALTER PROCEDURE dbo.sp_InsertPaquete
    @Peso DECIMAL(10,2),
    @Dimensiones VARCHAR(50) = NULL,
    @ValorDeclarado DECIMAL(10,2) = 0,
    @IdTipoPaquete INT,
    @IdClienteOrigen INT,
    @IdClienteDestino INT,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO paquete
            (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino)
        VALUES
            (@Peso, @Dimensiones, @ValorDeclarado, @IdTipoPaquete, @IdClienteOrigen, @IdClienteDestino);

        SET @NewId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO

-- 4 Insert Envío
CREATE OR ALTER PROCEDURE dbo.sp_InsertEnvio
    @IdPaquete INT,
    @IdRuta INT,
    @IdVehiculo INT,
    @IdEmpleadoResponsable INT,
    @IdEstadoActual INT,
    @FechaRegistro DATE = NULL,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @FechaRegistro IS NULL SET @FechaRegistro = GETDATE();

        BEGIN TRANSACTION;

        INSERT INTO envio (fecha_registro, id_paquete, id_ruta, id_vehiculo, id_empleado_responsable, id_estado_actual)
        VALUES (@FechaRegistro, @IdPaquete, @IdRuta, @IdVehiculo, @IdEmpleadoResponsable, @IdEstadoActual);

        SET @NewId = SCOPE_IDENTITY();

        INSERT INTO historial_envio (id_envio, fecha_hora, id_estado, observaciones)
        VALUES (@NewId, GETDATE(), @IdEstadoActual, 'Registro inicial');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @NewId = -1;
        THROW;
    END CATCH
END
GO

---------------------------------------------------------
-- FUNCIONES
---------------------------------------------------------

-- F1️ Antigüedad empleado
CREATE OR ALTER FUNCTION dbo.fn_TiempoContratacion(@IdEmpleado INT)
RETURNS INT
AS
BEGIN
    DECLARE @Fecha DATE;
    SELECT @Fecha = fecha_contratacion FROM empleado WHERE id_empleado=@IdEmpleado;

    IF @Fecha IS NULL RETURN NULL;

    RETURN DATEDIFF(YEAR,@Fecha,GETDATE()) -
           CASE WHEN DATEADD(YEAR,DATEDIFF(YEAR,@Fecha,GETDATE()),@Fecha) > GETDATE()
                THEN 1 ELSE 0 END;
END
GO

-- F2️ Peso volumétrico
CREATE OR ALTER FUNCTION dbo.fn_PesoVolumetrico
(
    @AltoCM DECIMAL(10,2),
    @AnchoCM DECIMAL(10,2),
    @LargoCM DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    IF @AltoCM IS NULL OR @AnchoCM IS NULL OR @LargoCM IS NULL
        RETURN NULL;

    RETURN ROUND((@AltoCM * @AnchoCM * @LargoCM) / 5000,2);
END
GO

-- F3️ Paquete de alto riesgo
CREATE OR ALTER FUNCTION dbo.fn_PaqueteEsAltoRiesgo(@ValorDeclarado DECIMAL(10,2))
RETURNS VARCHAR(2)
AS
BEGIN
    IF @ValorDeclarado IS NULL RETURN 0;
    RETURN CASE WHEN @ValorDeclarado >= 100000 THEN 'Si' ELSE 'NO' END;
END
GO


---------------------------------------------------------
-- EJEMPLOS: EJECUCIÓN DE SPs Y FUNCIONES
---------------------------------------------------------

--   Insertar Cliente
DECLARE @IdCli INT;
EXEC sp_InsertCliente 'Juan','Miño','1111111','juancitoMiño@outlook.com',1,@IdCli OUTPUT;
SELECT @IdCli AS Id_Cliente_Nuevo;

--   Actualizar Cliente

EXEC sp_UpdateCliente @IdCliente=56, @Email ='juancitu5@email.com';
SELECT id_cliente, nombre, email FROM cliente WHERE id_cliente = 56;

--   Insertar Paquete
DECLARE @IdPaq INT;
EXEC sp_InsertPaquete 2.5,'30x20x10',15000,2,1,2,@IdPaq OUTPUT;
SELECT @IdPaq AS NuevoPaquete;

--   Insertar Envío
DECLARE @IdEnv INT;
EXEC sp_InsertEnvio
     @IdPaquete=1,
     @IdRuta=1,
     @IdVehiculo=1,
     @IdEmpleadoResponsable=1,
     @IdEstadoActual=1,
     @NewId=@IdEnv OUTPUT;
SELECT @IdEnv AS NuevoEnvio;

---------------------------------------------------------
-- FUNCIONES: EJEMPLOS
---------------------------------------------------------

-- Tiempo de contratación
SELECT dbo.fn_TiempoContratacion(2) AS Antiguedad;

-- Peso volumétrico
SELECT dbo.fn_PesoVolumetrico(30,20,10) AS PesoVol; -- Esto devuelve peso en kg.


-- Alto riesgo
SELECT dbo.fn_PaqueteEsAltoRiesgo(150000) AS EsAltoRiesgo;