--DROPS
DROP TABLE IF EXISTS Renglon;
DROP TABLE IF EXISTS Otros;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Factura;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS Caja;


--CREACION DE TABLAS
CREATE TABLE Empleado (
    id_empleado serial,
    firstname varchar(50) NOT NULL,
    lastname varchar(50) DEFAULT NULL,
CONSTRAINT PK_Users PRIMARY KEY (id_empleado));

CREATE TABLE Factura (
    id_factura serial,
	id_caja int NOT NULL,
    id_empleado int,
	fecha timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	precio float NOT NULL,
    comentarioBaja varchar DEFAULT NULL,
 CONSTRAINT PK_Factura PRIMARY KEY (id_factura));

CREATE TABLE Cliente (
    id_factura int NOT NULL,
    descuento float,
    formaDePago int NOT NULL,
CONSTRAINT PK_Cliente PRIMARY KEY (id_factura)); 

CREATE TABLE Otros (
    id_factura int NOT NULL,
    comentario varchar NOT NULL,
CONSTRAINT PK_Otros PRIMARY KEY (id_factura)); 

CREATE TABLE Renglon (
    id_renglon serial,
    id_producto int,
	id_factura int NOT NULL,
	cantidad int NOT NULL, 
	precio float NOT NULL,
    descuento float NOT NULL,
CONSTRAINT PK_Renglon PRIMARY KEY (id_renglon));

CREATE TABLE Producto ( 
	id_producto serial,
    id_categoria int NOT NULL,
    nombre varchar(50) NOT NULL,
	precio float NOT NULL,
    imagen varchar NOT NULL,
CONSTRAINT PK_Producto PRIMARY KEY (id_producto));

CREATE TABLE Categoria (
    id_categoria serial,
    nombre varchar(50) NOT NULL,
CONSTRAINT PK_Categoria PRIMARY KEY (id_categoria));

CREATE TABLE Caja (
	id_caja serial,
	inicio float NOT NULL,
	fin float DEFAULT NULL,
    horaInicio timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    horaFin timestamp
CONSTRAINT PK_Caja PRIMARY KEY (id_caja));

--FOREIGN KEYS
ALTER TABLE Factura ADD CONSTRAINT FK_Caja
    FOREIGN KEY (id_caja)
    REFERENCES Caja (id_caja)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

ALTER TABLE Factura ADD CONSTRAINT FK_Empleado
    FOREIGN KEY (id_empleado)
    REFERENCES Empleado (id_empleado) ON DELETE SET NULL
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

ALTER TABLE Cliente ADD CONSTRAINT FK_Factura
    FOREIGN KEY (id_factura)
    REFERENCES Factura (id_factura)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

ALTER TABLE Otros ADD CONSTRAINT FK_Factura
    FOREIGN KEY (id_factura)
    REFERENCES Factura (id_factura)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

ALTER TABLE Renglon ADD CONSTRAINT FK_Producto
    FOREIGN KEY (id_producto)
    REFERENCES Producto (id_producto) ON DELETE SET NULL 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;


ALTER TABLE Renglon ADD CONSTRAINT FK_Factura
    FOREIGN KEY (id_factura)
    REFERENCES Factura (id_factura)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE;

ALTER TABLE Producto ADD CONSTRAINT FK_Producto
    FOREIGN KEY (id_categoria)
    REFERENCES Categoria (id_categoria)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

------------------------------------------------------------------------------------------------------------------------
-----------------------------------------VERSION 1.1--------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Login (
	id_login serial,
	usuario varchar(50) NOT NULL,
	password varchar NOT NULL,
CONSTRAINT PK_Login PRIMARY KEY (id_login));

ALTER TABLE Caja 
	ADD COLUMN cierreReal float, 
	ADD COLUMN cierreFiscal float;

ALTER TABLE Empleado
	ADD COLUMN fechaBaja timestamp,
	ADD COLUMN id_login int;

ALTER TABLE Empleado
	ADD CONSTRAINT FK_Login
	FOREIGN KEY (id_login)
	REFERENCES Login (id_login)
	NOT DEFERRABLE
	INITIALLY IMMEDIATE;

ALTER TABLE Renglon 
		DROP CONSTRAINT PK_Renglon,
		ADD CONSTRAINT PK_Factura_Renglon
		PRIMARY KEY (id_factura, id_renglon);

ALTER TABLE Producto
	ADD COLUMN activo boolean NOT NULL;

CREATE TABLE Prioridad (
	prioridad int);

ALTER TABLE Prioridad
	ADD CONSTRAINT PK_Producto
	PRIMARY KEY (id_producto)
	REFERENCES Producto (id_producto),

	ADD CONSTRAINT PK_Categoria
	PRIMARY KEY (id_categoria)
	REFERENCES Categoria (id_categoria),

	ADD CONSTRAINT FK_Producto
	FOREIGN KEY (id_producto)
	REFERENCES Producto (id_producto)
	NOT DEFERRABLE
	INITIALLY IMMEDIATE,

	ADD CONSTRAINT FK_Categoria
	FOREIGN KEY (id_categoria)
	REFERENCES Categoria (id_categoria)
	NOT DEFERRABLE
	INITIALLY IMMEDIATE;