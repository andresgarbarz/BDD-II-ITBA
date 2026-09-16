-- a
GRANT ALL
ON institucion
TO U1
WITH GRANT OPTION;

-- b
GRANT SELECT
ON voluntario
TO U2;

-- c
GRANT INSERT
ON VOLUNTARIO
TO U2
WITH GRANT OPTION;

-- d
GRANT INSERT, UPDATE
ON TAREA
TO U0, U1, U2, U3;
-- TO *.* (no funciona en MySQL)

-- Otra forma:
CREATE ROLE 'tarea_iu';
GRANT INSERT, UPDATE
ON TAREA
TO 'tarea_iu';
GRANT 'tarea_iu' TO U0, U1, U2, U3;

-- e
REVOKE DELETE
ON INSTITUCION
FROM U1;

-- f
REVOKE DELETE
ON TAREA
FROM 'tarea_iu';
-- Podria insertar solamente U0, el administrador

-- g
CREATE ROLE 'ins_vol';
GRANT INSERT (horas_pactadas)
ON VOLUNTARIO
TO 'ins_vol';

-- h
CREATE USER U4 IDENTIFIED BY 'mysecretpassword';
GRANT 'ins_vol' TO U4, U3;

-- i
GRANT UPDATE (nombre)
ON VOLUNTARIO
TO 'ins_vol';

-- j
DROP ROLE 'ins_vol';
-- U3 y U4 pierden solamente los permisos otorgados mediante ese rol.