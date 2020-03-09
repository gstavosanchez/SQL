--------------------------DML---------------------------
USE Restaurante;
GO
EXEC sp_InsertarCliente 'Gustavo','Sanchez','3082398','','44879834','','normal';
EXEC sp_InsertarCliente 'Elmer','Garcia','4082398','','50998340','','normal';
GO
SELECT * FROM cliente;
GO
SELECT * FROM visita;
GO
EXEC sp_InsertarMesa 'Mesa para Dos',2,'activo';
EXEC sp_InsertarMesa 'Mesa para Tres',3,'activo';
EXEC sp_InsertarMesa 'Mesa para Cuatro',4,'activo';
EXEC sp_InsertarMesa 'Mesa para Cinco',5,'activo';
EXEC sp_InsertarMesa 'Mesa para Seis',6,'activo';
EXEC sp_InsertarMesa 'Mesa para Siete',7,'activo';
EXEC sp_InsertarMesa 'Mesa para Ocho',8,'activo';
EXEC sp_InsertarMesa 'Mesa para Nueve',9,'activo';
EXEC sp_InsertarMesa 'Mesa para Diez',10,'activo';
EXEC sp_InsertarMesa 'Mesa para Once',11,'activo';
EXEC sp_InsertarMesa 'Mesa para Doce',12,'activo';
GO
SELECT * FROM mesa;
GO
EXEC sp_reservacion 1,'2020-03-10','20:00:00','activo',3;
GO
SELECT * FROM reservacion;
GO
EXEC sp_reservacionEspecial 'Salon 3','2020-03-10','20:00:00','activo',4;
SELECT * FROM reservacionEspecial;
GO
EXEC sp_AgregarProveedor 'WALTMART','24658790','Majadas','Pedro';
SELECT * FROM proveedor;
GO
INSERT INTO tipoEmpleado(tipo) VALUES('Chef Ejecutico');
INSERT INTO tipoEmpleado(tipo) VALUES('Asistente');
INSERT INTO tipoEmpleado(tipo) VALUES('Chef De Partie');
INSERT INTO tipoEmpleado(tipo) VALUES('Primer Cocinero');
INSERT INTO tipoEmpleado(tipo) VALUES('Segundo Cocinero');
INSERT INTO tipoEmpleado(tipo) VALUES('Tercer Cocinero');
INSERT INTO tipoEmpleado(tipo) VALUES('Asistente De Cocinero');

Select * FROM tipoEmpleado;
GO
EXEC sp_AgregarEmpleado 'Ana','Morales','44217890','Ciudad','300487821901',4;
EXEC sp_AgregarEmpleado 'Pedro','Morales','52217890','Ciudad','300487821901',7;
SELECT * FROM empleado;
GO
INSERT INTO ingrediente(nombre) values ('Tomate');
INSERT INTO ingrediente(nombre) values ('Lechuga');
INSERT INTO ingrediente(nombre) values ('Papas');
INSERT INTO ingrediente(nombre) values ('Lomito');
INSERT INTO ingrediente(nombre) values ('Brocoli');
INSERT INTO ingrediente(nombre) values ('Pina');
INSERT INTO ingrediente(nombre) values ('Manzana');
INSERT INTO ingrediente(nombre) values ('Aguacate');
INSERT INTO ingrediente(nombre) values ('Pepino');
INSERT INTO ingrediente(nombre) values ('Frijol');
GO
SELECT * FROM ingrediente;
GO
EXEC sp_AgregarOrden '2020-03-08',1,1,'pendiente';
GO
SELECT * FROM Orden;
GO
INSERT INTO DetalleOrden(idOrden,idIngrediente) VALUES(1,1);
INSERT INTO DetalleOrden(idOrden,idIngrediente) VALUES(1,2);
INSERT INTO DetalleOrden(idOrden,idIngrediente) VALUES(1,3);
INSERT INTO DetalleOrden(idOrden,idIngrediente) VALUES(1,4);
GO
SELECT * From DetalleOrden;
GO
EXEC sp_AgregarPlatillo 'Caldo Res','Guatemala','Preparar con carne',2;
SELECT * FROM platillo;
GO
INSERT INTO detallePlatillo(idPlatillo,idIngrediente) values(3,1)
INSERT INTO detallePlatillo(idPlatillo,idIngrediente) values(3,2)
GO
EXEC sp_AgregarMenu 3,'Lunes',30
select * from menu;
EXEC sp_AgregarFactura 3,'';
SELECT * FROM factura;
INSERT INTO detalleFactura(idFactura,idMenu) values(1,1);
EXEC sp_ActualizarFactura 1;
select * from detalleFactura;
SELECT * FROM factura;
Go
CREATE VIEW verCliente 
	AS 
	SELECT c.nombre,c.apellido,c.celular,c.cui,visit.tipo
	from cliente as c
	inner join visita as visit on c.idCliente = visit.idCliente;
GO

CREATE VIEW clientesFrecuentes as
select * from verCliente where tipo like 'reservacion' and (select COUNT(tipo) from verCliente where tipo like '%reservacion%') >= 5 or tipo like 'consumo' and (select COUNT(tipo) from verCliente where tipo like '%consumo%') >= 10;
go
select * from clientesFrecuentes;