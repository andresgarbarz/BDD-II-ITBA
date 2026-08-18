DROP TABLE IF EXISTS compone;
DROP TABLE IF EXISTS envio;
DROP TABLE IF EXISTS pq_liquido;
DROP TABLE IF EXISTS pq_solido;
DROP TABLE IF EXISTS producto_quimico;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
	id_cliente INT NOT NULL,
	cuit BIGINT NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	calle VARCHAR(100) NOT NULL,
	puerta VARCHAR(2) NOT NULL,
	piso VARCHAR(2) NOT NULL,
	telefono BIGINT NOT NULL,
	e_mail VARCHAR(200),
	id_garante INT,
	CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
	CONSTRAINT fk_cliente_garante FOREIGN KEY (id_garante) REFERENCES cliente(id_cliente)
);

CREATE TABLE producto_quimico (
	id_prod_quim INT NOT NULL,
	nombre_prod_quim VARCHAR(100) NOT NULL,
	formula VARCHAR(50) NOT NULL,
	CONSTRAINT pk_prod_quim PRIMARY KEY (id_prod_quim)
);

CREATE TABLE pq_liquido (
	id_prod_quim INT NOT NULL,
	inflamable BOOL NOT NULL,
	tipo_envase VARCHAR(100) NOT NULL,
	cond_traslado VARCHAR(100),
	CONSTRAINT pk_pq_liquido PRIMARY KEY (id_prod_quim),
	CONSTRAINT FOREIGN KEY fk_pq_liquido_prod_quim (id_prod_quim) REFERENCES producto_quimico(id_prod_quim)
);

CREATE TABLE pq_solido (
	id_prod_quim INT NOT NULL,
	forma VARCHAR(100) NOT NULL,
	empaque_max INT NOT NULL,
	CONSTRAINT pk_pq_solido PRIMARY KEY (id_prod_quim),
	CONSTRAINT fk_pq_solido_prod_quim FOREIGN KEY (id_prod_quim) REFERENCES producto_quimico(id_prod_quim)
);

CREATE TABLE envio (
	nro_envio INT NOT NULL,
	cantidad INT NOT NULL,
	peso FLOAT NOT NULL,
	id_dueno INT,
	id_prod_quim INT,
	id_prod_quim_2 INT,
	CONSTRAINT pk_envio PRIMARY KEY (nro_envio),
	CONSTRAINT fk_cliente_dueno FOREIGN KEY (id_dueno) REFERENCES cliente(id_cliente),
	CONSTRAINT fk_envio_prod_quim FOREIGN KEY (id_prod_quim) REFERENCES producto_quimico(id_prod_quim)
);

CREATE TABLE compone (
	id_prod_quim INT NOT NULL,
	id_prod_quim_2 INT NOT NULL,
	porcentaje FLOAT NOT NULL,
	CONSTRAINT pk_compone PRIMARY KEY (id_prod_quim, id_prod_quim_2),
    CONSTRAINT fk_compone_prod_quim FOREIGN KEY (id_prod_quim) REFERENCES producto_quimico(id_prod_quim),
    CONSTRAINT fk_compone_prod_quim_2 FOREIGN KEY (id_prod_quim_2) REFERENCES producto_quimico(id_prod_quim)
);