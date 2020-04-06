CREATE DATABASE ejemplo;
use ejemplo;

create table usuario(
	id int identity(1,1) primary key,
	nombre varchar(255) not null,
	correo varchar(255)not null,
	fechaNaciemineto datetime null
);

select * from usuario;
insert into usuario(nombre,correo,fechaNaciemineto) values ('Elmer Sachez','elmer.99@hotmail.com',CURRENT_TIMESTAMP)


create table Cliente(
	id int identity(1,1) primary key,
	nombre varchar(255) not null,
	correo varchar(255)not null,
	passw varchar(255) not null,
	fechaNaciemineto datetime null
);

insert into Cliente(nombre,correo,passw,fechaNaciemineto) values ('Elmer Sachez','elmer.99@hotmail.com','123',CURRENT_TIMESTAMP)