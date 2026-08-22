CREATE VIEW Distribuidor_200 AS
SELECT id_distribuidor, nombre, tipo
FROM distribuidor
WHERE id_distribuidor > 200;

CREATE VIEW Departamento_dist_200 AS
SELECT id_departamento, nombre_departamento, id_ciudad, jefe_departamento
FROM departamento
WHERE id_distribuidor > 200;

-- a
-- Distribuidor_200 no es actualizable pues no tiene el campo direccion que es NOT NULL en la tabla de distribuidor

-- Departamento_dist_200 no es actualizable pues la PK de departamento es compuesta y esta vista solamente tiene una

-- b
-- Opción correcta: Falla porque si bien la vista es actualizable viola una restricción de integridad de unicidad
-- Justificación: id_distribuidor es la PK y se está intentando insertar otra tupla con la misma PK