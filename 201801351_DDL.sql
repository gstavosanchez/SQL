-----------------------DDL-------------------------------------------------------
CREATE DATABASE Restaurante;
GO
USE Restaurante;
GO
CREATE TABLE cliente(
	idCliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cui VARCHAR(20) NOT NULL,
	nombre VARCHAR(25) NOT NULL,
	apellido VARCHAR(25) NOT NULL,
	telefono VARCHAR(25) NULL,
	celular VARCHAR(25) NOT NULL,
	nit VARCHAR(25) NULL,
	tipo VARCHAR(25) NOT NULL,
	
);
GO
CREATE TABLE visita(
	idVisita INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	hora TIME null,
	idCliente INT NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);
GO
CREATE TABLE mesa(
	idMesa INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	noPersonas INT NOT NULL,
	estado VARCHAR(25) NOT NULL
);
GO
