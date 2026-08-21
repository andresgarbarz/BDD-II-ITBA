-- a

DROP TABLE IF EXISTS DistribuidorNac;

CREATE TABLE DistribuidorNac (
	id_distribuidor numeric(5,0) NOT NULL,
	nombre character varying(80) NOT NULL,
	direccion character varying(120) NOT NULL,
	telefono character varying(20),
	nro_inscripcion numeric(8,0) NOT NULL,
	encargado character varying(60) NOT NULL,
	id_distrib_mayorista numeric(5,0),
	CONSTRAINT pk_distribuidorNac PRIMARY KEY (id_distribuidor)
);

INSERT INTO DistribuidorNac (id_distribuidor, nombre, direccion, telefono, nro_inscripcion, encargado, id_distrib_mayorista)
SELECT d.id_distribuidor, d.nombre, d.direccion, d.telefono, n.nro_inscripcion, n.encargado, n.id_distrib_mayorista
FROM distribuidor d
JOIN nacional n ON d.id_distribuidor = n.id_distribuidor;

-- b
ALTER TABLE DistribuidorNac
ADD COLUMN codigo_pais VARCHAR(5) NULL;

-- c
UPDATE DistribuidorNac dn
JOIN internacional i ON dn.id_distrib_mayorista = i.id_distribuidor
SET dn.codigo_pais = i.codigo_pais;