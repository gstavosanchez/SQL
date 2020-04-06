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
	idCliente INT NOT NULL,
	tipo VARCHAR(50) NOT NULL
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
CREATE TABLE reservacion(
	idReservacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	estado VARCHAR(25) NOT NULL,
	idCliente INT NOT NULL,
	idMesa INT NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
	FOREIGN KEY (idMesa) REFERENCES mesa(idMesa)
);
GO
CREATE TABLE reservacionEspecial(
	idReservacionEspecial INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	estado VARCHAR(25) NOT NULL,
	idCliente INT NOT NULL,
	salon VARCHAR(50) NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
);
GO 
CREATE TABLE proveedor(
	idProveedor INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	dirrecion VARCHAR(25) NOT NULL,
	telefono VARCHAR(25) NOT NULL,
	encargado VARCHAR(25) NULL,
);
GO
CREATE TABLE tipoEmpleado(
	idTipoEmpleado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL
);
GO
CREATE TABLE empleado(
	idEmpleado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	apellido VARCHAR(25) NOT NULL,
	telefono VARCHAR(25) NULL,
	cui VARCHAR(20) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	idTipoEmpleado INT NOT NULL,
	FOREIGN KEY(idTipoEmpleado) REFERENCES tipoEmpleado(idTipoEmpleado)
);
GO
CREATE TABLE ingrediente(
	idIngrediente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,

);
GO
CREATE TABLE Orden(
	idOrden INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fechaOrden DATE NOT NULL,
	estado VARCHAR(50) NOT NULL,
	idEmpleado INT NOT NULL,
	idProveedor INT NOT NULL,
	FOREIGN KEY(idEmpleado) REFERENCES empleado(idEmpleado),
	FOREIGN KEY(idProveedor) REFERENCES proveedor(idProveedor),
);
GO
CREATE TABLE DetalleOrden(
	idDetalleOrden INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	idIngrediente INT NOT NULL,
	idOrden INT NOT NULL,
	FOREIGN KEY(idIngrediente) REFERENCES ingrediente(idIngrediente),
	FOREIGN KEY(idOrden) REFERENCES orden(idOrden),
);
GO
CREATE TABLE platillo(
	idPlatillo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	nacinalidad VARCHAR(25) NOT NULL,
	receta VARCHAR(25) NOT NULL,
	idEmpleado INT NOT NULL,
	FOREIGN KEY(idEmpleado) REFERENCES empleado(idEmpleado)
);
GO
CREATE TABLE detallePlatillo(
	idDetallePlatillo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	idPlatillo INT NOT NULL,
	idIngrediente INT NOT NULL,
	FOREIGN KEY(idIngrediente) REFERENCES ingrediente(idIngrediente),
	FOREIGN KEY(idPlatillo) REFERENCES platillo(idPlatillo)

);
GO
CREATE TABLE menu(
	idMenu INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	diaVenta VARCHAR(50) NOT NULL,
	precio INT,
	idPlatillo INT NOT NULL,
	FOREIGN KEY(idPlatillo) REFERENCES platillo(idPlatillo)
);
GO
CREATE TABLE factura(
	idFactura INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	total INT null,
	fechaHora DATETIME NOT NULL,
	idCliente INT NOT NULL,
	FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
);
GO
CREATE TABLE detalleFactura(
	idDetalleFactura INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	idFactura INT NOT NULL,
	idMenu INT NOT NULL
	FOREIGN KEY(idFactura) REFERENCES factura(idFactura),
	FOREIGN KEY(idMenu) REFERENCES menu(idMenu)
);
GO

CREATE PROCEDURE sp_InsertarCliente(
	@nombre varchar(50),
	@apellido varchar(50),
	@cui varchar(50),
	@telefono varchar(50),
	@celular varchar(50),
	@nit varchar(50),
	@tipo varchar(50)

)
AS
BEGIN
	INSERT INTO cliente(nombre,apellido,cui,telefono,celular,nit,tipo)
	VALUES(@nombre,@apellido,@cui,@telefono,@celular,@nit,@tipo)

	INSERT INTO visita(idCliente,tipo)
	VALUES((SELECT MAX(idCliente) from cliente),'consumo')
END;
GO
CREATE PROCEDURE sp_InsertarMesa(
	@nombre VARCHAR(50),
	@noPersona INT,
	@estado VARCHAR(50)
)
AS
BEGIN
	INSERT INTO mesa(nombre,noPersonas,estado)
	VALUES(@nombre,@noPersona,@estado)
END;
GO
CREATE PROCEDURE sp_reservacion(
	@idMesa INT,
	@fecha DATE,
	@hora TIME,
	@estado VARCHAR(50),
	@idCliente INT

)
AS
BEGIN
	INSERT INTO reservacion(idMesa,fecha,hora,estado,idCliente) VALUES(@idMesa,@fecha,@hora,@estado,@idCliente);
	INSERT INTO visita(idCliente,tipo) VALUES(@idCliente,'reservacion');
	UPDATE mesa set estado = 'ocupado' where idMesa = @idMesa;
END;
GO

CREATE PROCEDURE sp_reservacionEspecial(
	@salon varchar(50),
	@fecha DATE,
	@hora TIME,
	@estado VARCHAR(50),
	@idCliente INT

)
AS
BEGIN
	INSERT INTO reservacionEspecial(salon,fecha,hora,estado,idCliente) VALUES(@salon,@fecha,@hora,@estado,@idCliente);
	INSERT INTO visita(idCliente,tipo) VALUES(@idCliente,'reservacion');
END;
GO
CREATE PROCEDURE sp_AgregarProveedor(
	@nombre varchar(50),
	@telefono varchar(50),
	@direccion varchar(50),
	@encargado VARCHAR(50)

)
AS
BEGIN
	INSERT INTO proveedor(nombre,telefono,dirrecion,encargado) VALUES(@nombre,@telefono,@direccion,@encargado);
END;
GO
CREATE PROCEDURE sp_AgregarEmpleado(
	@nombre varchar(50),
	@apellido varchar(50),
	@telefono varchar(50),
	@direccion varchar(50),
	@cui VARCHAR(50),
	@idTipoEmpleado INT

)
AS
BEGIN
	INSERT INTO empleado(nombre,apellido,telefono,direccion,cui,idTipoEmpleado) VALUES(@nombre,@apellido,@telefono,@direccion,@cui,@idTipoEmpleado);
END;
GO
CREATE PROCEDURE sp_AgregarOrden(
	@fechaOrden DATE,
	@idEmpleado INT,
	@idProveedor INT,
	@estado varchar(50)

)
AS
BEGIN
	INSERT INTO Orden(fechaOrden,idEmpleado,idProveedor,estado) VALUES(@fechaOrden,@idEmpleado,@idProveedor,@estado)
END;
GO
CREATE PROCEDURE sp_AgregarPlatillo(
	@nombre VARCHAR(50),
	@nacionalidad VARCHAR(50),
	@receta VARCHAR(50),
	@idEmpleado INT

)
AS
BEGIN
	INSERT INTO platillo(nombre,nacinalidad,receta,idEmpleado) VALUES(@nombre,@nacionalidad,@receta,@idEmpleado)
END;
GO
CREATE PROCEDURE sp_AgregarMenu(
	@idPlatillo INT,
	@diaVenta VARCHAR(50),
	@precio INT

)
AS
BEGIN
	INSERT INTO menu(idPlatillo,diaVenta,precio) VALUES (@idPlatillo,@diaVenta,@precio)
END;
GO
CREATE PROCEDURE sp_AgregarFactura(
	@idCliente INT,
	@total INT

)
AS
BEGIN
	INSERT INTO factura(idCliente,total,fechaHora) VALUES(@idCliente,@total,CURRENT_TIMESTAMP)
END;


GO
CREATE PROCEDURE sp_ActualizarFactura(
	@idFactura INT
)
AS
BEGIN
	update factura set total = (SELECT sum(m.precio) from menu as m inner join detalleFactura as detalle on m.idMenu = detalle.idMenu where detalle.idFactura = @idFactura) where idFactura = @idFactura;
END;
GO


