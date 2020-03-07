----------------DDL--------------------------------------------------
CREATE DATABASE Hospital;
USE  Hospital;
CREATE TABLE medicina(
	idMEdicina INT IDENTITY (1,1) NOT NULL,
	nombreComercial VARCHAR(50) NOT NULL,
	formula VARCHAR(50) NOT NULL,
	PRIMARY KEY(idMEdicina)
);
GO
CREATE TABLE doctor(
	idDoctor INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	especialidad VARCHAR(50) NOT NULL,
	anosExperiencia INT NULL,
	salario INT NOT NULL
);
GO

CREATE TABLE pasciente(
	idPasciente INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	fechaNacimiento DATE NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	idDoctor INT NULL,
	FOREIGN KEY (idDoctor) REFERENCES doctor(idDoctor)

);
GO
CREATE TABLE prescripcion(
	idPrescripcion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	cantidad INT NOT NULL,
	idMedicina INT NOT NULL,
	idPasciente INT NOT NULL,
	idDoctor INT NOT NULL,
	FOREIGN KEY(idMedicina) REFERENCES medicina(idMEdicina),
	FOREIGN KEY(idPasciente) REFERENCES pasciente(idPasciente),
	FOREIGN KEY(idDoctor) REFERENCES doctor(idDoctor)
);
GO
CREATE PROCEDURE sp_AgregarMedicina(
	@nombre VARCHAR(50),
	@formula VARCHAR(50)
)
AS 
Begin
INSERT INTO medicina(nombreComercial,formula)
VALUES (@nombre,@formula)
END;
GO
CREATE PROCEDURE sp_AgregarDoctor(
	@nombre VARCHAR(50),
	@especialidad VARCHAR(50),
	@experiencia int,
	@salario int
)
AS
BEGIN
INSERT INTO doctor(nombre,especialidad,anosExperiencia,salario)
VALUES (@nombre,@especialidad,@experiencia,@salario)
END;
GO
CREATE PROCEDURE sp_AgregarPasciente(
	@fecha DATE,
	@nombre VARCHAR(50),
	@telefono VARCHAR(50),
	@direccion VARCHAR(50)
) 
AS 
BEGIN
INSERT INTO pasciente(fechaNacimiento,nombre,telefono,direccion) 
VALUES(@fecha,@nombre,@telefono,@direccion) 
END;
GO
CREATE PROCEDURE sp_ModificarPasciente(
	@telefono VARCHAR(50),
	@idPasciente INT
)
AS
BEGiN
UPDATE pasciente SET telefono = @telefono where idPasciente = @idPasciente;
END;
GO

------------------------DML-------------------------------------

EXEC sp_AgregarMedicina 'Acetaminofe','LSD+2';
EXEC sp_AgregarMedicina 'Ibuprofeno','RTS9';
EXEC sp_AgregarMedicina 'IRS','JNMD3';
EXEC sp_AgregarMedicina 'PeptoBismol','MDSN3';
EXEC sp_AgregarMedicina 'Vitamina B12','B12';
EXEC sp_AgregarMedicina 'Alegra','FKS32';
GO
SELECT * FROM medicina where nombreComercial LIKE'a%';
GO

EXEC sp_AgregarDoctor 'Gustavo','Cardiologia',5,13000;
EXEC sp_AgregarDoctor 'Maria Garcia','Pediatria',10,13000;
EXEC sp_AgregarDoctor 'Elmer Sanchez','',10,13000;
EXEC sp_AgregarDoctor 'Jaquelin Cifuentes','Gastro',10,13000;
EXEC sp_AgregarDoctor 'Maria Jose Garcia','Pediatria',10,20000;
EXEC sp_AgregarDoctor 'Jennifer Gonzales','General',10,25000;
EXEC sp_AgregarDoctor 'Manuel Alegria','Traumatología',5,5000;
EXEC sp_AgregarDoctor 'Daniel Ramirez','Urología',5,15000;
EXEC sp_AgregarDoctor 'Marielos Guerra','Otorrinolaringología',1,1500;
SELECT * FROM doctor ORDER BY salario DESC;



SELECT D.nombre,D.especialidad ,D.salario
FROM doctor as D
where D.salario = (SELECT MAX(salario) from doctor);



GO
SELECT D.nombre,D.especialidad ,D.salario
FROM doctor as D
where D.salario BETWEEN 1000 AND 5000 ORDER BY D.salario ASC;
GO

EXEC sp_AgregarPasciente '1998-08-27','Juan Perez','23423423','Ciudad Guatemala';
EXEC sp_AgregarPasciente '1999-10-27','Ana Morales','23423423','Ciudad Mexico';
EXEC sp_AgregarPasciente '2000-09-12','Marta Garcia','4343343','Nueva York';
EXEC sp_AgregarPasciente '2001-04-30','Stafany Juarez','53423423','Ciudad Guatemala';
EXEC sp_AgregarPasciente '1998-08-27','Ramon Gonsalez','43423423','Ciudad Mexico';
SELECT * FROM pasciente ORDER BY nombre ASC;

EXEC sp_ModificarPasciente '44396565',1;
EXEC sp_ModificarPasciente '1230296563',2;
EXEC sp_ModificarPasciente '555296523',3;