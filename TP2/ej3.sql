-- Ej. 1

DROP TABLE IF EXISTS incluye;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS factura;
DROP TABLE IF EXISTS celular;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
	id INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	fecha_de_nac DATE NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	telefono BIGINT NOT NULL,
	telefono_alt BIGINT,
	CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE celular (
	id_cliente INT NOT NULL,
	celular BIGINT NOT NULL,
	CONSTRAINT pk_celular PRIMARY KEY (id_cliente),
	CONSTRAINT fk_celular_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE factura (
	tipo VARCHAR(100) NOT NULL,
	numero INT NOT NULL,
	fecha DATE NOT NULL,
	importe FLOAT NOT NULL,
	CONSTRAINT pk_factura PRIMARY KEY (tipo, numero)
);

CREATE TABLE producto (
	codigo INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT NOT NULL,
	CONSTRAINT pk_producto PRIMARY KEY (codigo)
);

CREATE TABLE incluye (
	tipo VARCHAR(100) NOT NULL,
	numero INT NOT NULL,
	codigo INT NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT pk_incluye PRIMARY KEY (tipo, numero, codigo),
	CONSTRAINT fk_incluye_factura FOREIGN KEY (tipo, numero) REFERENCES factura(tipo, numero),
	CONSTRAINT fk_incluye_producto FOREIGN KEY (codigo) REFERENCES producto(codigo)
);

-- Ej. 2:

DROP TABLE IF EXISTS suministra;
DROP TABLE IF EXISTS fabricante;
DROP TABLE IF EXISTS producto;
ALTER TABLE departamento DROP CONSTRAINT fk_depto_jefe;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS departamento;

CREATE TABLE departamento (
	nombre VARCHAR(100) NOT NULL,
	jefe_numero INT UNIQUE NOT NULL,
	CONSTRAINT pk_departamento PRIMARY KEY (nombre)
);

CREATE TABLE empleado (
	numero INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	calle VARCHAR(100) NOT NULL,
	puerta INT NOT NULL,
	piso INT NOT NULL,
	ciudad VARCHAR(100) NOT NULL,
	depto_nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_empleado PRIMARY KEY (numero),
	CONSTRAINT fk_empleado_depto FOREIGN KEY (depto_nombre) REFERENCES departamento(nombre)
);

ALTER TABLE departamento ADD CONSTRAINT fk_depto_jefe FOREIGN KEY (jefe_numero) REFERENCES empleado(numero);

CREATE TABLE producto (
	num_fab INT NOT NULL,
	num_dep INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	precio FLOAT,
	depto_nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_producto PRIMARY KEY (num_fab),
	CONSTRAINT fk_producto_depto FOREIGN KEY (depto_nombre) REFERENCES departamento(nombre)
);

CREATE TABLE fabricante (
	nombre VARCHAR(100) NOT NULL,
	calle VARCHAR(100) NOT NULL,
	puerta INT NOT NULL,
	piso INT NOT NULL,
	ciudad VARCHAR(100) NOT NULL,
	CONSTRAINT pk_fabricante PRIMARY KEY (nombre)
);

CREATE TABLE suministra (
	num_fab INT NOT NULL,
	nombre_fab VARCHAR(100) NOT NULL,
	CONSTRAINT pk_suministra PRIMARY KEY (num_fab, nombre_fab),
	CONSTRAINT fk_suministra_prod FOREIGN KEY (num_fab) REFERENCES producto(num_fab),
	CONSTRAINT fk_suministra_fab FOREIGN KEY (nombre_fab) REFERENCES fabricante(nombre)
);

-- Ej. 3:

DROP TABLE IF EXISTS conduce;
DROP TABLE IF EXISTS camion;
DROP TABLE IF EXISTS paquete;
DROP TABLE IF EXISTS camionero;
DROP TABLE IF EXISTS ciudad;

CREATE TABLE ciudad (
	codigo INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	CONSTRAINT pk_ciudad PRIMARY KEY (codigo)
);

CREATE TABLE camionero (
	dni INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	telefono BIGINT NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	salario FLOAT,
	codigo_ciudad INT NOT NULL,
	CONSTRAINT pk_camionero PRIMARY KEY (dni),
	CONSTRAINT fk_camionero_ciudad FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo)
);

CREATE TABLE paquete (
	codigo INT NOT NULL,
	descripcion VARCHAR(300) NOT NULL,
	destinatario VARCHAR(100) NOT NULL,
	direccion_dest VARCHAR(100) NOT NULL,
	codigo_ciudad INT NOT NULL,
	dni_camionero INT NOT NULL,
	CONSTRAINT pk_paquete PRIMARY KEY (codigo),
	CONSTRAINT fk_paquete_ciudad FOREIGN KEY (codigo_ciudad) REFERENCES ciudad(codigo),
	CONSTRAINT fk_paquete_camionero FOREIGN KEY (dni_camionero) REFERENCES camionero(dni)
);

CREATE TABLE camion (
	matricula VARCHAR(10) NOT NULL,
	modelo VARCHAR(100) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	potencia INT NOT NULL,
	CONSTRAINT pk_camion PRIMARY KEY (matricula)
);

CREATE TABLE conduce (
	dni_camionero INT NOT NULL,
	matricula_camion VARCHAR(100) NOT NULL,
	fecha DATE NOT NULL,
	CONSTRAINT pk_conduce PRIMARY KEY (dni_camionero, matricula_camion, fecha),
	CONSTRAINT fk_conduce_camionero FOREIGN KEY (dni_camionero) REFERENCES camionero(dni),
	CONSTRAINT fk_conduce_camion FOREIGN KEY (matricula_camion) REFERENCES camion(matricula)
);