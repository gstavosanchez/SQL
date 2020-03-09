--------------------------DML---------------------------
USE Restaurante;
GO
EXEC sp_InsertarCliente 'Gustavo','Sanchez','3082398','','44879834','','normal';
EXEC sp_InsertarCliente 'Elmer','Garcia','4082398','','50998340','','normal';
GO
SELECT * FROM cliente;
GO
SELECT * FROM visita;
INSERT INTO visita(idCliente,tipo) values(3,'consumo')
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
GO
CREATE VIEW ventaPlatillo
	AS
	SELECT p.nombre,p.nacinalidad as nacionalidad,m.diaVenta as DiaVenta
	FROM platillo as p
	inner join menu as m on p.idPlatillo = m.idPlatillo
	inner join detalleFactura as detalle on m.idMenu = detalle.idMenu;
go


CREATE view topVentasPlatillos as
select nombre, COUNT(*) As Recuento
from ventaPlatillo
GROUP BY nombre
HAVING COUNT(*) > 1 
go
select top 3 * from topVentasPlatillos order by Recuento DESC;

go
CREATE VIEW ingredientesVendidos as
SELECT i.nombre,p.nombre as Proveedor,o.fechaOrden
from ingrediente as i
inner join DetalleOrden as detalle on i.idIngrediente = detalle.idIngrediente
inner join Orden as o on detalle.idOrden = o.idOrden
inner join proveedor as p on o.idProveedor = p.idProveedor
go

select * from ingredientesVendidos;
go
CREATE VIEW topIngredientesVendidos as
select nombre,COUNT(*) as Recuento
from ingredientesVendidos
GROUP BY nombre
HAVING COUNT(*) >= 1
go
select top 10 * from topIngredientesVendidos order by Recuento DESC;
go
CREATE VIEW proveedorPendiente as
SELECT p.nombre,o.idOrden,o.fechaOrden,o.estado
from Orden as o
inner join proveedor as p on  o.idProveedor = p.idProveedor where o.estado like '%pendiente%';
go
select * from proveedorPendiente;
GO
CREATE VIEW verClienteReservacionEspecial as 
SELECT c.idCliente,c.nombre,r.salon,r.fecha 
from cliente as c
inner join reservacionEspecial as r on c.idCliente = r.idCliente
GO

SELECT * from verClienteReservacionEspecial;
go
CREATE VIEW topClienteReservacionEspecial as
select nombre,COUNT(*) as Recuento
from verClienteReservacionEspecial
GROUP BY nombre
HAVING COUNT(*) >= 1
go
SElECT TOP 1 * from topClienteReservacionEspecial order by Recuento DESC;

go
CREATE VIEW verClienteCompras as 
SELECT c.idCliente,c.nombre,v.tipo 
from cliente as c
inner join visita as v on c.idCliente = v.idCliente where v.tipo like '%consumo%';
GO
SELECT * FROM verClienteCompras;
go
CREATE VIEW topClienteCompras as
select nombre,COUNT(*) as Recuento
from verClienteCompras
GROUP BY nombre
HAVING COUNT(*) >= 1
go
SElECT TOP 1 * from topClienteCompras order by Recuento DESC; 
GO
CREATE VIEW mesaReservacion as
SELECT m.nombre,m.noPersonas,r.fecha AS FechaReservacion
FROM mesa AS m
inner join reservacion as r on m.idMesa = r.idMesa
GO
CREATE VIEW topMesasReservadas as
select nombre,COUNT(*) as Recuento
from mesaReservacion
GROUP BY nombre
HAVING COUNT(*) >= 1
go
SElECT * from topMesasReservadas order by Recuento DESC; 
SElECT * from topMesasReservadas  where nombre like '%Mesa para Dos%' order by Recuento DESC; 



SELECT CONVERT(date,GETDATE(),105)  from factura 

SElECT SUM(total) AS TotalCobrar,COUNT(*) AS Cantidad,AVG(total)as Promedio
FROM factura ;