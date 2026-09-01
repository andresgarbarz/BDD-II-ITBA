DROP TRIGGER IF EXISTS tr_entrega_ai;
DROP TRIGGER IF EXISTS tr_entrega_au;
DROP TRIGGER IF EXISTS tr_entrega_del;
DROP TRIGGER IF EXISTS tr_renglon_entrega_ai;
DROP TRIGGER IF EXISTS tr_renglon_entrega_au;
DROP TRIGGER IF EXISTS tr_renglon_entrega_del;
DROP TABLE IF EXISTS his_entrega;

-- a
CREATE TABLE his_entrega(
	id_log INT NOT NULL AUTO_INCREMENT,
	fecha_operacion DATE NOT NULL DEFAULT (CURRENT_DATE),
	operacion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
	usuario VARCHAR(100) NOT NULL,
	CONSTRAINT his_entrega_pk PRIMARY KEY (id_log)
);

-- b
--/
CREATE TRIGGER tr_entrega_ai
AFTER INSERT ON entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('INSERT', CURRENT_USER());
END
/

--/
CREATE TRIGGER tr_entrega_au
AFTER UPDATE ON entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('UPDATE', CURRENT_USER());
END
/

--/
CREATE TRIGGER tr_entrega_del
AFTER DELETE ON entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('DELETE', CURRENT_USER());
END
/

--/
CREATE TRIGGER tr_renglon_entrega_ai
AFTER INSERT ON renglon_entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('INSERT', CURRENT_USER());
END
/

--/
CREATE TRIGGER tr_renglon_entrega_au
AFTER UPDATE ON renglon_entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('UPDATE', CURRENT_USER());
END
/

--/
CREATE TRIGGER tr_renglon_entrega_del
AFTER DELETE ON renglon_entrega
FOR EACH ROW
BEGIN
	INSERT INTO his_entrega(operacion, usuario)
	VALUES ('DELETE', CURRENT_USER());
END
/

-- c
-- FOR EACH ROW se triggerea potencialmente más veces que FOR EACH STATEMENT, dado que un statement afecte más de una row.