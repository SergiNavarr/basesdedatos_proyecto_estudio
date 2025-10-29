CREATE TABLE provincia (
    id_provincia INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_provincia PRIMARY KEY (id_provincia),
    CONSTRAINT uq_provincia_nombre UNIQUE (nombre)
);

CREATE TABLE ciudad (
    id_ciudad INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    id_provincia INT NOT NULL,
    CONSTRAINT pk_ciudad PRIMARY KEY (id_ciudad),
    CONSTRAINT fk_ciudad_provincia FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia),
    CONSTRAINT uq_ciudad_nombre UNIQUE (nombre, id_provincia)
);

CREATE TABLE direccion (
    id_direccion INT NOT NULL IDENTITY(1,1),
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    piso_depto VARCHAR(10),
    codigo_postal VARCHAR(10) NOT NULL,
    id_ciudad INT NOT NULL,
    CONSTRAINT pk_direccion PRIMARY KEY (id_direccion),
    CONSTRAINT fk_direccion_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad),
    CONSTRAINT ck_direccion_codigo_postal CHECK (LEN(codigo_postal) BETWEEN 4 AND 10)
);

CREATE TABLE cliente (
    id_cliente INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    id_direccion INT NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    CONSTRAINT uq_cliente_dni UNIQUE (dni),
    CONSTRAINT uq_cliente_email UNIQUE (email)
);

CREATE TABLE rol (
    id_rol INT NOT NULL IDENTITY(1,1),
    nombre_rol VARCHAR(50) NOT NULL,
    CONSTRAINT pk_rol PRIMARY KEY (id_rol),
    CONSTRAINT uq_rol_nombre UNIQUE (nombre_rol)
);

CREATE TABLE sucursal (
    id_sucursal INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    id_direccion INT NOT NULL,
    CONSTRAINT pk_sucursal PRIMARY KEY (id_sucursal),
    CONSTRAINT fk_sucursal_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    CONSTRAINT uq_sucursal_nombre UNIQUE (nombre)
);

CREATE TABLE empleado (
    id_empleado INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    fecha_contratacion DATE NOT NULL,
    id_rol INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_direccion INT NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT fk_empleado_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
    CONSTRAINT fk_empleado_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    CONSTRAINT uq_empleado_dni UNIQUE (dni),
    CONSTRAINT uq_empleado_email UNIQUE (email),
    CONSTRAINT ck_empleado_fecha_contratacion CHECK (fecha_contratacion <= GETDATE())
);

CREATE TABLE telefono (
    id_telefono INT NOT NULL IDENTITY(1,1),
    numero VARCHAR(20) NOT NULL,
    id_cliente INT,
    id_empleado INT,
    CONSTRAINT pk_telefono PRIMARY KEY (id_telefono),
    CONSTRAINT fk_telefono_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT ck_telefono_formato CHECK (numero LIKE '[0-9]%')
);

CREATE TABLE vehiculo (
    id_vehiculo INT NOT NULL IDENTITY(1,1),
    patente VARCHAR(20) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    capacidad DECIMAL(10,2) NOT NULL,
    id_empleado_asignado INT NOT NULL,
    CONSTRAINT pk_vehiculo PRIMARY KEY (id_vehiculo),
    CONSTRAINT fk_vehiculo_empleado FOREIGN KEY (id_empleado_asignado) REFERENCES empleado(id_empleado),
    CONSTRAINT uq_vehiculo_patente UNIQUE (patente),
    CONSTRAINT ck_vehiculo_anio CHECK (anio BETWEEN 1990 AND YEAR(GETDATE())),
    CONSTRAINT ck_vehiculo_capacidad CHECK (capacidad > 0)
);

CREATE TABLE ruta (
    id_ruta INT NOT NULL IDENTITY(1,1),
    descripcion VARCHAR(200),
    id_sucursal_origen INT NOT NULL,
    id_sucursal_destino INT NOT NULL,
    distancia_km DECIMAL(10,2) NOT NULL,
    tiempo_estimado INT NOT NULL,
    CONSTRAINT pk_ruta PRIMARY KEY (id_ruta),
    CONSTRAINT fk_ruta_origen FOREIGN KEY (id_sucursal_origen) REFERENCES sucursal(id_sucursal),
    CONSTRAINT fk_ruta_destino FOREIGN KEY (id_sucursal_destino) REFERENCES sucursal(id_sucursal),
    CONSTRAINT ck_ruta_distancia CHECK (distancia_km > 0),
    CONSTRAINT ck_ruta_tiempo CHECK (tiempo_estimado > 0),
    CONSTRAINT ck_ruta_diferente CHECK (id_sucursal_origen <> id_sucursal_destino)
);

CREATE TABLE tipo_paquete (
    id_tipo_paquete INT NOT NULL IDENTITY(1,1),
    descripcion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_tipo_paquete PRIMARY KEY (id_tipo_paquete),
    CONSTRAINT uq_tipo_paquete_descripcion UNIQUE (descripcion)
);

CREATE TABLE estado_envio (
    id_estado INT NOT NULL IDENTITY(1,1),
    nombre_estado VARCHAR(50) NOT NULL,
    CONSTRAINT pk_estado_envio PRIMARY KEY (id_estado),
    CONSTRAINT uq_estado_envio_nombre UNIQUE (nombre_estado)
);

CREATE TABLE paquete (
    id_paquete INT NOT NULL IDENTITY(1,1),
    peso DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50),
    valor_declarado DECIMAL(10,2),
    id_tipo_paquete INT NOT NULL,
    id_cliente_origen INT NOT NULL,
    id_cliente_destino INT NOT NULL,
    CONSTRAINT pk_paquete PRIMARY KEY (id_paquete),
    CONSTRAINT fk_paquete_tipo FOREIGN KEY (id_tipo_paquete) REFERENCES tipo_paquete(id_tipo_paquete),
    CONSTRAINT fk_paquete_origen FOREIGN KEY (id_cliente_origen) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_paquete_destino FOREIGN KEY (id_cliente_destino) REFERENCES cliente(id_cliente),
    CONSTRAINT ck_paquete_peso CHECK (peso > 0),
    CONSTRAINT ck_paquete_valor CHECK (valor_declarado >= 0),
    CONSTRAINT ck_paquete_clientes_diferentes CHECK (id_cliente_origen <> id_cliente_destino)
);

CREATE TABLE envio (
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
);

CREATE TABLE historial_envio (
    id_historial INT NOT NULL IDENTITY(1,1),
    id_envio INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    id_estado INT NOT NULL,
    observaciones TEXT,
    CONSTRAINT pk_historial_envio PRIMARY KEY (id_historial),
    CONSTRAINT fk_historial_envio FOREIGN KEY (id_envio) REFERENCES envio(id_envio),
    CONSTRAINT fk_historial_estado FOREIGN KEY (id_estado) REFERENCES estado_envio(id_estado),
    CONSTRAINT ck_historial_fecha CHECK (fecha_hora <= GETDATE())
);