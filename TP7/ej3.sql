DROP TRIGGER IF EXISTS tr_cambio_dept_bu;
DROP TABLE IF EXISTS his_empleado;

-- a
ALTER TABLE empleado ADD COLUMN inicio_empresa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE empleado ADD COLUMN inicio_depto TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- b
CREATE TABLE his_empleado (
	id_empleado numeric(6,0) NOT NULL,
	id_departamento numeric(4,0) NOT NULL,
	id_distribuidor numeric(5,0) NOT NULL,
	inicio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fin TIMESTAMP,
	CONSTRAINT his_empleado_pk PRIMARY KEY (id_empleado, id_departamento, id_distribuidor, inicio),
	CONSTRAINT his_empleado_empleado_fk FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
	CONSTRAINT his_empleado_depto_fk FOREIGN KEY (id_distribuidor, id_departamento) REFERENCES departamento(id_distribuidor, id_departamento)
);

-- c
--/
CREATE TRIGGER tr_cambio_dept_bu
BEFORE UPDATE ON empleado
FOR EACH ROW
BEGIN
	IF OLD.id_distribuidor != NEW.id_distribuidor OR OLD.id_departamento != NEW.id_departamento THEN
		UPDATE his_empleado h SET fin = CURRENT_TIMESTAMP
		WHERE h.id_empleado = OLD.id_empleado
			AND h.id_departamento = OLD.id_departamento
			AND h.id_distribuidor = OLD.id_distribuidor
			AND h.inicio = OLD.inicio_depto;

		SET NEW.inicio_depto = CURRENT_TIMESTAMP;
		
		INSERT INTO his_empleado(id_empleado, id_departamento, 
		id_distribuidor)
		VALUES (OLD.id_empleado, NEW.id_departamento, NEW.id_distribuidor);
	END IF;
END
/