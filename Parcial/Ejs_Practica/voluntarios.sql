-- Considere que la tabla tarea del esquema de Voluntarios posee 20 tuplas y suponga que en todas ellas el atributo min_horas es nulo. ¿Cuál sería el resultado de la siguiente consulta? Seleccione una única opción.

-- SELECT sum(min_horas), count(*), count(min_horas) FROM tarea;

-- A. Una tabla con la tupla (null, null, null)
-- B. Una tabla con la tupla (0, 20, 0)
-- C. Una tabla con la tupla (0, 20, 20)
-- D. Una tabla con la tupla (null, 20, 0)
-- E. Ninguna de las opciones

-- Opción Correcta: D

-- sum de nulls = null.
-- count(*) cuenta las tuplas = 20
-- count cuenta los campos que no son null = 0