CREATE DATABASE PYMES;
GO 
USE PYMES;
GO
CREATE TABLE Cliente(
	idCliente INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	NIT VARCHAR(100) NOT NULL,
	tipoEmpresa VARCHAR(100) NOT NULL,
	tamano INT NOT NULL,
	noTarjeta VARCHAR(100) NOT NULL,
	nombreTarjeta VARCHAR(100) NOT NULL,
	tipoTarjeta VARCHAR(100) NOT NULL,
	CRVTarjeta VARCHAR(100) NOT NULL
);
GO
CREATE TABLE contactoCliente(
	idContacto INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	tipoContacto VARCHAR(100) NOT NULL,
);
GO
CREATE TABLE asignacionContactoCliente(
	idAsignacion INT IDENTITY(1,1) PRIMARY KEY,
	idContacto INT NOT NULL,
	idCliente INT NOT NULL,
	FOREIGN KEY(idContacto) REFERENCES contactoCliente(idContacto),
	FOREIGN KEY(idCliente) REFERENCES Cliente(idCliente)
);
GO
CREATE TABLE TipoUsuario(
	idTipoUsuario INT IDENTITY(1,1) PRIMARY KEY,
	tipo VARCHAR(100) NOT NULL
);
GO
CREATE TABLE Usuario(
	idUsuario INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT  NULL,
	apellido VARCHAR(100) NOT NULL,
	nick VARCHAR(100) NOT NULL,
	contrasena VARCHAR(100) NOT NULL,
	idTipoUsuario INT NOT NULL,
	FOREIGN KEY(idTipoUsuario) REFERENCES tipoUsuario(idTipoUsuario)
);
GO
CREATE TABLE Modulo(
	idModulo INT IDENTITY (1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	abreviatura VARCHAR(50) NOT NULL,
	descripcion VARCHAR(250) NOT NULL,
);
CREATE TABLE asignacionModulo(
	idAsignacion INT IDENTITY(1,1) PRIMARY KEY,
	idModulo INT NOT NULL,
	idUsuario INT NOT NULL,
	FOREIGN KEY(idModulo) REFERENCES Modulo(idModulo),
	FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario)
);
GO
CREATE TABLE ListadoPrecioModulo(
	idLista INT IDENTITY(1,1) PRIMARY KEY,
	idModulo INT NOT NULL,
	fechaInicio DATE NOT NULL,
	fechaFin DATE NULL,
	suscripcion VARCHAR(255) NOT NULL,
	rangoUsuarios INT NOT NULL,
	precio decimal(5,2)
);
GO


INSERT INTO Cliente(nombre,NIT,tipoEmpresa,tamano,noTarjeta,nombreTarjeta,tipoTarjeta,CRVTarjeta) values ('Tigo','123','comercial',10,'2349sdf','adfsfd','mastercar','324234')

select * from Cliente;

GO
CREATE TABLE TipoEmpresa(
	idTipo int identity(1,1) primary key,
	nombre varchar(100) not null
);


INSERT INTO Modulo(nombre,abreviatura,descripcion) values('Modulo de Venta','Venta','Llevar el registro de las ventas');
INSERT INTO Modulo(nombre,abreviatura,descripcion) values('Modulo de Compra','Compra','Llevar el control de las compras');
INSERT INTO Modulo(nombre,abreviatura,descripcion) values('Modulo de Inventario','Inventario','Gestion de productos en bodega');
INSERT INTO Modulo(nombre,abreviatura,descripcion) VALUES('Modulo de Factura','Factura','Control de facturas realizadas por proveedores');