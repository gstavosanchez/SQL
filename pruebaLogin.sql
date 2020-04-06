Create database loginAsp;
go
use loginAsp
Create table Usuario(
	idUsuario int identity(1,1) primary key not null,
	nombre varchar(255) not null,
	apellido varchar(255) not null,
	email varchar(255) not null,
	contrasena varchar(255) not null,


);
insert into Usuario(nombre,apellido,email,contrasena) values ('Gustavo','Sanchez','gustavo@gmail.com','12345')

Select * from Usuario;