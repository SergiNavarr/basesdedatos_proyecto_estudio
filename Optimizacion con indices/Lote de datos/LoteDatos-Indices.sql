CREATE DATABASE PaqueExpress2;

USE PaqueExpress2;

--Tabla provincia
INSERT INTO provincia (nombre) VALUES ('Buenos Aires');
INSERT INTO provincia (nombre) VALUES ('Catamarca');
INSERT INTO provincia (nombre) VALUES ('Chaco');
INSERT INTO provincia (nombre) VALUES ('Chubut');
INSERT INTO provincia (nombre) VALUES ('Córdoba');
INSERT INTO provincia (nombre) VALUES ('Corrientes');
INSERT INTO provincia (nombre) VALUES ('Entre Ríos');
INSERT INTO provincia (nombre) VALUES ('Formosa');
INSERT INTO provincia (nombre) VALUES ('Jujuy');
INSERT INTO provincia (nombre) VALUES ('La Pampa');
INSERT INTO provincia (nombre) VALUES ('La Rioja');
INSERT INTO provincia (nombre) VALUES ('Mendoza');
INSERT INTO provincia (nombre) VALUES ('Misiones');
INSERT INTO provincia (nombre) VALUES ('Neuquén');
INSERT INTO provincia (nombre) VALUES ('Río Negro');
INSERT INTO provincia (nombre) VALUES ('Salta');
INSERT INTO provincia (nombre) VALUES ('San Juan');
INSERT INTO provincia (nombre) VALUES ('San Luis');
INSERT INTO provincia (nombre) VALUES ('Santa Cruz');
INSERT INTO provincia (nombre) VALUES ('Santa Fe');
INSERT INTO provincia (nombre) VALUES ('Santiago del Estero');
INSERT INTO provincia (nombre) VALUES ('Tierra del Fuego');
INSERT INTO provincia (nombre) VALUES ('Tucumán');

--Tabla ciudad
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_1', 1);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_2', 2);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_3', 3);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_4', 4);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_5', 5);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_6', 6);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_7', 7);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_8', 8);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_9', 9);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_10', 10);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_11', 11);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_12', 12);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_13', 13);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_14', 14);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_15', 15);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_16', 16);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_17', 17);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_18', 18);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_19', 19);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_20', 20);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_21', 21);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_22', 22);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_23', 23);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_24', 1);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_25', 2);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_26', 3);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_27', 4);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_28', 5);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_29', 6);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_30', 7);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_31', 8);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_32', 9);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_33', 10);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_34', 11);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_35', 12);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_36', 13);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_37', 14);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_38', 15);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_39', 16);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_40', 17);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_41', 18);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_42', 19);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_43', 20);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_44', 21);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_45', 22);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_46', 23);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_47', 1);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_48', 2);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_49', 3);
INSERT INTO ciudad (nombre, id_provincia) VALUES ('Ciudad_50', 4);

--Tabla direccion
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 1', '101', 'P1', '10001', 1);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 2', '102', 'P2', '10002', 2);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 3', '103', 'P3', '10003', 3);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 4', '104', 'P4', '10004', 4);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 5', '105', 'P5', '10005', 5);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 6', '106', NULL, '10006', 6);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 7', '107', NULL, '10007', 7);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 8', '108', 'P1', '10008', 8);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 9', '109', 'P2', '10009', 9);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 10', '110', 'P3', '10010', 10);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 11', '111', 'P1', '10011', 11);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 12', '112', 'P2', '10012', 12);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 13', '113', 'P3', '10013', 13);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 14', '114', 'P4', '10014', 14);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 15', '115', 'P5', '10015', 15);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 16', '116', NULL, '10016', 16);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 17', '117', NULL, '10017', 17);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 18', '118', 'P1', '10018', 18);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 19', '119', 'P2', '10019', 19);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 20', '120', 'P3', '10020', 20);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 21', '121', 'P1', '10021', 21);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 22', '122', 'P2', '10022', 22);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 23', '123', 'P3', '10023', 23);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 24', '124', 'P4', '10024', 24);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 25', '125', 'P5', '10025', 25);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 26', '126', NULL, '10026', 26);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 27', '127', NULL, '10027', 27);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 28', '128', 'P1', '10028', 28);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 29', '129', 'P2', '10029', 29);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 30', '130', 'P3', '10030', 30);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 31', '131', 'P1', '10031', 31);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 32', '132', 'P2', '10032', 32);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 33', '133', 'P3', '10033', 33);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 34', '134', 'P4', '10034', 34);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 35', '135', 'P5', '10035', 35);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 36', '136', NULL, '10036', 36);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 37', '137', NULL, '10037', 37);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 38', '138', 'P1', '10038', 38);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 39', '139', 'P2', '10039', 39);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 40', '140', 'P3', '10040', 40);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 41', '141', 'P1', '10041', 41);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 42', '142', 'P2', '10042', 42);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 43', '143', 'P3', '10043', 43);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 44', '144', 'P4', '10044', 44);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 45', '145', 'P5', '10045', 45);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 46', '146', NULL, '10046', 46);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 47', '147', NULL, '10047', 47);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 48', '148', 'P1', '10048', 48);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 49', '149', 'P2', '10049', 49);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 50', '150', 'P3', '10050', 50);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 51', '151', 'P1', '10051', 1);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 52', '152', 'P2', '10052', 2);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 53', '153', 'P3', '10053', 3);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 54', '154', 'P4', '10054', 4);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 55', '155', 'P5', '10055', 5);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 56', '156', NULL, '10056', 6);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 57', '157', NULL, '10057', 7);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 58', '158', 'P1', '10058', 8);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 59', '159', 'P2', '10059', 9);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 60', '160', 'P3', '10060', 10);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 61', '161', 'P1', '10061', 11);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 62', '162', 'P2', '10062', 12);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 63', '163', 'P3', '10063', 13);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 64', '164', 'P4', '10064', 14);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 65', '165', 'P5', '10065', 15);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 66', '166', NULL, '10066', 16);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 67', '167', NULL, '10067', 17);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 68', '168', 'P1', '10068', 18);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 69', '169', 'P2', '10069', 19);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 70', '170', 'P3', '10070', 20);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 71', '171', 'P1', '10071', 21);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 72', '172', 'P2', '10072', 22);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 73', '173', 'P3', '10073', 23);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 74', '174', 'P4', '10074', 24);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 75', '175', 'P5', '10075', 25);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 76', '176', NULL, '10076', 26);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 77', '177', NULL, '10077', 27);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 78', '178', 'P1', '10078', 28);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 79', '179', 'P2', '10079', 29);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 80', '180', 'P3', '10080', 30);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 81', '181', 'P1', '10081', 31);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 82', '182', 'P2', '10082', 32);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 83', '183', 'P3', '10083', 33);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 84', '184', 'P4', '10084', 34);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 85', '185', 'P5', '10085', 35);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 86', '186', NULL, '10086', 36);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 87', '187', NULL, '10087', 37);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 88', '188', 'P1', '10088', 38);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 89', '189', 'P2', '10089', 39);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 90', '190', 'P3', '10090', 40);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 91', '191', 'P1', '10091', 41);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 92', '192', 'P2', '10092', 42);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 93', '193', 'P3', '10093', 43);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 94', '194', 'P4', '10094', 44);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 95', '195', 'P5', '10095', 45);

INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 96', '196', NULL, '10096', 46);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 97', '197', NULL, '10097', 47);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 98', '198', 'P1', '10098', 48);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 99', '199', 'P2', '10099', 49);
INSERT INTO direccion (calle, numero, piso_depto, codigo_postal, id_ciudad) VALUES ('Calle 100', '200', 'P3', '10100', 50);

--------------------------
--Tabla rol
INSERT INTO rol (nombre_rol) VALUES ('Administrador');
INSERT INTO rol (nombre_rol) VALUES ('Recepcionista');
INSERT INTO rol (nombre_rol) VALUES ('Chofer');
INSERT INTO rol (nombre_rol) VALUES ('Supervisor');
INSERT INTO rol (nombre_rol) VALUES ('Encargado de Deposito');

------
--Tabla sucursal

INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Centro', 1);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Norte', 2);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Sur', 3);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Este', 4);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Oeste', 5);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Terminal', 6);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Aeropuerto', 7);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Puerto', 8);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Parque Industrial', 9);
INSERT INTO sucursal (nombre, id_direccion) VALUES ('Sucursal Centro II', 10);

---------------
--Tabla cliente
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Juan', 'Pérez', '30000001', 'cliente1@example.com', 1);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('María', 'Gómez', '30000002', 'cliente2@example.com', 2);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Lucía', 'Fernández', '30000003', 'cliente3@example.com', 3);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Carlos', 'Rodríguez', '30000004', 'cliente4@example.com', 4);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Ana', 'López', '30000005', 'cliente5@example.com', 5);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Sofía', 'Martínez', '30000006', 'cliente6@example.com', 6);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Diego', 'Sánchez', '30000007', 'cliente7@example.com', 7);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Martín', 'Romero', '30000008', 'cliente8@example.com', 8);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Paula', 'Torres', '30000009', 'cliente9@example.com', 9);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Jorge', 'Flores', '30000010', 'cliente10@example.com', 10);

INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Fabián', 'Silva', '30000011', 'cliente11@example.com', 11);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Camila', 'Rojas', '30000012', 'cliente12@example.com', 12);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Valentina', 'Acosta', '30000013', 'cliente13@example.com', 13);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Federico', 'Molina', '30000014', 'cliente14@example.com', 14);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Carolina', 'Franco', '30000015', 'cliente15@example.com', 15);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Agustín', 'Vera', '30000016', 'cliente16@example.com', 16);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Noelia', 'Domínguez', '30000017', 'cliente17@example.com', 17);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Tomás', 'Benítez', '30000018', 'cliente18@example.com', 18);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Victoria', 'Campos', '30000019', 'cliente19@example.com', 19);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Hernán', 'Ferreyra', '30000020', 'cliente20@example.com', 20);

INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Pedro', 'Herrera', '30000021', 'cliente21@example.com', 21);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Andrea', 'Ibáñez', '30000022', 'cliente22@example.com', 22);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Gabriel', 'Saavedra', '30000023', 'cliente23@example.com', 23);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Florencia', 'Ponce', '30000024', 'cliente24@example.com', 24);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Mario', 'Cardozo', '30000025', 'cliente25@example.com', 25);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Daniela', 'Luna', '30000026', 'cliente26@example.com', 26);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Nicolás', 'Medina', '30000027', 'cliente27@example.com', 27);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Julieta', 'Soria', '30000028', 'cliente28@example.com', 28);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Ricardo', 'Quiroga', '30000029', 'cliente29@example.com', 29);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Pilar', 'Montenegro', '30000030', 'cliente30@example.com', 30);

INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Elena', 'Correa', '30000031', 'cliente31@example.com', 31);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Samuel', 'Navarro', '30000032', 'cliente32@example.com', 32);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Julia', 'Peralta', '30000033', 'cliente33@example.com', 33);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Axel', 'Méndez', '30000034', 'cliente34@example.com', 34);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Rocío', 'Godoy', '30000035', 'cliente35@example.com', 35);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Benjamín', 'Soto', '30000036', 'cliente36@example.com', 36);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Sabrina', 'Escobar', '30000037', 'cliente37@example.com', 37);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Ezequiel', 'Maidana', '30000038', 'cliente38@example.com', 38);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Aylén', 'Páez', '30000039', 'cliente39@example.com', 39);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Gustavo', 'Roldán', '30000040', 'cliente40@example.com', 40);

INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Brenda', 'Ojeda', '30000041', 'cliente41@example.com', 41);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Lautaro', 'Rey', '30000042', 'cliente42@example.com', 42);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Milagros', 'Segovia', '30000043', 'cliente43@example.com', 43);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Iván', 'Bustos', '30000044', 'cliente44@example.com', 44);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Carla', 'Aguirre', '30000045', 'cliente45@example.com', 45);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Franco', 'Villalba', '30000046', 'cliente46@example.com', 46);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Melina', 'Rivas', '30000047', 'cliente47@example.com', 47);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Sebastián', 'Saucedo', '30000048', 'cliente48@example.com', 48);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Nadia', 'Toledo', '30000049', 'cliente49@example.com', 49);
INSERT INTO cliente (nombre, apellido, dni, email, id_direccion) VALUES ('Gastón', 'Mansilla', '30000050', 'cliente50@example.com', 50);

-----------------
--Tabla empleado
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Roberto', 'Martínez', '40000001', 'empleado1@example.com', '2019-03-10', 1, 1, 51);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Carina', 'Ramírez', '40000002', 'empleado2@example.com', '2020-02-15', 2, 2, 52);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Leandro', 'Gutiérrez', '40000003', 'empleado3@example.com', '2021-01-20', 3, 3, 53);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Mariela', 'Suárez', '40000004', 'empleado4@example.com', '2022-05-12', 4, 4, 54);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Pablo', 'Ledesma', '40000005', 'empleado5@example.com', '2018-11-08', 5, 5, 55);

INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Eliana', 'Montiel', '40000006', 'empleado6@example.com', '2020-06-02', 2, 6, 56);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Sergio', 'Gómez', '40000007', 'empleado7@example.com', '2019-07-19', 3, 7, 57);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Camila', 'Juárez', '40000008', 'empleado8@example.com', '2021-08-11', 4, 8, 58);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Matías', 'Soria', '40000009', 'empleado9@example.com', '2022-03-25', 5, 9, 59);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Ariadna', 'Toledo', '40000010', 'empleado10@example.com', '2019-10-10', 1, 10, 60);

INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Nicolás', 'Franco', '40000011', 'empleado11@example.com', '2020-12-01', 3, 1, 61);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Daniela', 'Roldán', '40000012', 'empleado12@example.com', '2018-04-14', 4, 2, 62);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Tomás', 'Benavídez', '40000013', 'empleado13@example.com', '2021-09-30', 5, 3, 63);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Rocío', 'Ibarra', '40000014', 'empleado14@example.com', '2023-01-01', 2, 4, 64);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Gustavo', 'Coronel', '40000015', 'empleado15@example.com', '2020-03-27', 1, 5, 65);

INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Micaela', 'Villalba', '40000016', 'empleado16@example.com', '2022-07-18', 3, 6, 66);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Ramiro', 'Salazar', '40000017', 'empleado17@example.com', '2019-01-05', 4, 7, 67);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Aylén', 'Carrizo', '40000018', 'empleado18@example.com', '2018-08-22', 2, 8, 68);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Julián', 'Ferrer', '40000019', 'empleado19@example.com', '2021-04-30', 5, 9, 69);
INSERT INTO empleado (nombre, apellido, dni, email, fecha_contratacion, id_rol, id_sucursal, id_direccion) VALUES ('Melina', 'Ojeda', '40000020', 'empleado20@example.com', '2023-02-10', 1, 10, 70);

------------------------
--Tabla vehiculo
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA100AA', 'Ford', 'Transit', 2019, 1200.50, 3);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA101AB', 'Fiat', 'Ducato', 2020, 1300.00, 5);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA102AC', 'Volkswagen', 'Crafter', 2018, 1500.75, 7);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA103AD', 'Renault', 'Master', 2021, 1400.20, 9);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA104AE', 'Mercedes-Benz', 'Sprinter', 2022, 1600.00, 11);

INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA105AF', 'Ford', 'Transit', 2017, 1200.00, 2);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA106AG', 'Fiat', 'Ducato', 2016, 1250.30, 4);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA107AH', 'Volkswagen', 'Crafter', 2015, 1450.10, 6);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA108AI', 'Renault', 'Master', 2014, 1350.55, 8);
INSERT INTO vehiculo (patente, marca, modelo, anio, capacidad, id_empleado_asignado) VALUES ('AA109AJ', 'Mercedes-Benz', 'Sprinter', 2013, 1550.00, 10);

----------------
--Tabla ruta
INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Centro a Norte', 1, 2, 12.5, 25);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Centro a Sur', 1, 3, 15.8, 30);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Centro a Este', 1, 4, 10.2, 22);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Centro a Oeste', 1, 5, 14.7, 28);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Norte a Terminal', 2, 6, 20.3, 35);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Sur a Aeropuerto', 3, 7, 18.9, 32);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Este a Puerto', 4, 8, 22.4, 40);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Oeste a Parque Industrial', 5, 9, 16.3, 29);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Terminal a Centro II', 6, 10, 25.0, 45);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Aeropuerto a Centro', 7, 1, 14.0, 26);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Puerto a Norte', 8, 2, 30.0, 50);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Parque Industrial a Sur', 9, 3, 21.5, 38);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Centro II a Este', 10, 4, 19.8, 33);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Norte a Sur', 2, 3, 28.0, 48);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Sur a Oeste', 3, 5, 24.3, 42);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Este a Aeropuerto', 4, 7, 17.4, 31);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Oeste a Puerto', 5, 8, 29.6, 52);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Terminal a Parque Industrial', 6, 9, 26.2, 46);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Aeropuerto a Centro II', 7, 10, 23.9, 44);

INSERT INTO ruta (descripcion, id_sucursal_origen, id_sucursal_destino, distancia_km, tiempo_estimado)
VALUES ('Puerto a Sur', 8, 3, 32.7, 55);

-----------------
--Tabla tipo_paquete
INSERT INTO tipo_paquete (descripcion) VALUES ('Documento');
INSERT INTO tipo_paquete (descripcion) VALUES ('Caja Pequeña');
INSERT INTO tipo_paquete (descripcion) VALUES ('Caja Mediana');
INSERT INTO tipo_paquete (descripcion) VALUES ('Caja Grande');
INSERT INTO tipo_paquete (descripcion) VALUES ('Paquete Fragil');
INSERT INTO tipo_paquete (descripcion) VALUES ('Electrónico');
INSERT INTO tipo_paquete (descripcion) VALUES ('Ropa');
INSERT INTO tipo_paquete (descripcion) VALUES ('Alimento No Perecedero');
INSERT INTO tipo_paquete (descripcion) VALUES ('Paquete Premium');
INSERT INTO tipo_paquete (descripcion) VALUES ('Sobres Variados');

-----
--Tabla estado_envio

INSERT INTO estado_envio (nombre_estado) VALUES ('Registrado');
INSERT INTO estado_envio (nombre_estado) VALUES ('En Depósito');
INSERT INTO estado_envio (nombre_estado) VALUES ('En Tránsito');
INSERT INTO estado_envio (nombre_estado) VALUES ('Demorado');
INSERT INTO estado_envio (nombre_estado) VALUES ('Entregado');
INSERT INTO estado_envio (nombre_estado) VALUES ('Cancelado');

----Tabla paquete
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES (1.20, '20x15x10', 1500, 1, 1, 2);
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES (2.50, '30x20x15', 3000, 2, 2, 3);
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES (0.80, '15x10x5', 500, 3, 3, 4);
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES (5.00, '40x30x20', 8000, 4, 4, 5);
INSERT INTO paquete (peso, dimensiones, valor_declarado, id_tipo_paquete, id_cliente_origen, id_cliente_destino) VALUES (3.40, '35x25x15', 5200, 5, 5, 6);

INSERT INTO paquete VALUES (1.10, '25x20x10', 2200, 6, 6, 7);
INSERT INTO paquete VALUES (4.75, '45x35x20', 10000, 7, 7, 8);
INSERT INTO paquete VALUES (2.95, '30x25x12', 3500, 8, 8, 9);
INSERT INTO paquete VALUES (1.60, '25x18x12', 1800, 9, 9, 10);
INSERT INTO paquete VALUES (6.80, '55x40x35', 15000, 10, 10, 11);

INSERT INTO paquete VALUES (2.20, '28x20x12', 2800, 1, 11, 12);
INSERT INTO paquete VALUES (1.40, '22x18x10', 1300, 2, 12, 13);
INSERT INTO paquete VALUES (3.60, '40x28x18', 6500, 3, 13, 14);
INSERT INTO paquete VALUES (0.95, '18x14x9', 700, 4, 14, 15);
INSERT INTO paquete VALUES (5.30, '48x32x25', 9500, 5, 15, 16);

INSERT INTO paquete VALUES (2.45, '32x24x16', 4200, 6, 16, 17);
INSERT INTO paquete VALUES (1.75, '26x20x15', 2100, 7, 17, 18);
INSERT INTO paquete VALUES (6.10, '60x45x35', 16000, 8, 18, 19);
INSERT INTO paquete VALUES (3.15, '38x22x18', 5000, 9, 19, 20);
INSERT INTO paquete VALUES (4.50, '42x30x25', 7800, 10, 20, 21);

INSERT INTO paquete VALUES (1.95, '28x22x14', 2500, 1, 21, 22);
INSERT INTO paquete VALUES (0.70, '16x12x8', 600, 2, 22, 23);
INSERT INTO paquete VALUES (3.85, '36x28x20', 6300, 3, 23, 24);
INSERT INTO paquete VALUES (2.30, '30x24x18', 3500, 4, 24, 25);
INSERT INTO paquete VALUES (5.60, '50x35x30', 11000, 5, 25, 26);

INSERT INTO paquete VALUES (4.10, '44x30x28', 9000, 6, 26, 27);
INSERT INTO paquete VALUES (1.25, '20x15x12', 1400, 7, 27, 28);
INSERT INTO paquete VALUES (0.90, '18x12x10', 800, 8, 28, 29);
INSERT INTO paquete VALUES (2.90, '34x22x15', 3600, 9, 29, 30);
INSERT INTO paquete VALUES (3.20, '38x26x20', 4700, 10, 30, 31);

INSERT INTO paquete VALUES (1.15, '22x16x12', 1500, 1, 31, 32);
INSERT INTO paquete VALUES (2.55, '30x22x18', 3300, 2, 32, 33);
INSERT INTO paquete VALUES (5.95, '52x38x30', 12500, 3, 33, 34);
INSERT INTO paquete VALUES (3.70, '40x28x22', 6800, 4, 34, 35);
INSERT INTO paquete VALUES (2.05, '25x20x15', 2400, 5, 35, 36);

INSERT INTO paquete VALUES (1.85, '28x20x13', 2300, 6, 36, 37);
INSERT INTO paquete VALUES (0.65, '15x10x8', 500, 7, 37, 38);
INSERT INTO paquete VALUES (4.25, '45x32x28', 8800, 8, 38, 39);
INSERT INTO paquete VALUES (6.50, '60x48x40', 17000, 9, 39, 40);
INSERT INTO paquete VALUES (3.55, '38x26x19', 4900, 10, 40, 41);

INSERT INTO paquete VALUES (1.48, '24x18x12', 1700, 1, 41, 42);
INSERT INTO paquete VALUES (2.65, '32x24x16', 3400, 2, 42, 43);
INSERT INTO paquete VALUES (5.10, '48x35x28', 12000, 3, 43, 44);
INSERT INTO paquete VALUES (3.00, '34x26x18', 4400, 4, 44, 45);
INSERT INTO paquete VALUES (4.90, '50x30x25', 7600, 5, 45, 46);

INSERT INTO paquete VALUES (1.88, '28x18x14', 1850, 6, 46, 47);
INSERT INTO paquete VALUES (2.75, '36x25x20', 4200, 7, 47, 48);
INSERT INTO paquete VALUES (3.95, '40x28x22', 6200, 8, 48, 49);
INSERT INTO paquete VALUES (0.85, '15x12x10', 650, 9, 49, 50);
INSERT INTO paquete VALUES (6.25, '55x45x38', 18000, 10, 50, 1);

-----------------

