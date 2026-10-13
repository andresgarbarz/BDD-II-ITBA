-- Consulta: mediciones de un sensor en un día, en orden cronológico.
-- Una partición = un sensor + un día. fecha_hora ordena las filas dentro de esa partición.

CREATE KEYSPACE sensores
WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE sensores;

-- A
-- Tabla mediciones_por_sensor_dia.
-- Cada fila es una medición. tipo, valor y ciudad van en la misma fila: la consulta los necesita y Cassandra no hace JOIN.

-- B
-- Partition key: (id_sensor, dia). Las dos van con igualdad en el WHERE y juntas ubican una sola partición: todas las mediciones de ese sensor en ese día.
-- Clustering key: fecha_hora ASC. Distingue cada medición y las deja en orden cronológico.

-- C
CREATE TABLE mediciones_por_sensor_dia (
    id_sensor text,
    dia date,
    fecha_hora timestamp,
    tipo text,
    valor double,
    ciudad text,
    PRIMARY KEY ((id_sensor, dia), fecha_hora)
) WITH CLUSTERING ORDER BY (fecha_hora ASC);

-- D
-- dia se guarda aparte de fecha_hora: es el bucket de la partición.
-- Si dos mediciones del mismo sensor comparten el mismo timestamp, el segundo INSERT pisa al primero.
INSERT INTO mediciones_por_sensor_dia (id_sensor, dia, fecha_hora, tipo, valor, ciudad)
VALUES ('S01', '2026-10-01', '2026-10-01 08:15:00+0000', 'temperatura', 22.5, 'Buenos Aires');

-- E
-- Igualdad sobre toda la partition key. El orden lo da el clustering (ASC).
SELECT id_sensor, dia, fecha_hora, tipo, valor, ciudad
FROM mediciones_por_sensor_dia
WHERE id_sensor = 'S01' AND dia = '2026-10-01'
ORDER BY fecha_hora ASC;

-- F
-- Un modelo normalizado (sensor en una tabla, medición en otra) exigiría un JOIN. Cassandra no tiene JOIN: cada lectura debe salir de una sola partición.
-- Un join distribuido leería varias particiones y varios nodos, con más latencia y sin garantía de que los datos relacionados estén juntos.