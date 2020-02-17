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

CREATE TABLE 