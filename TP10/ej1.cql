-- I
CREATE KEYSPACE demo_cql_music WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

-- II
USE demo_cql_music;

-- III
CREATE TABLE canciones (
    id uuid PRIMARY KEY,
    titulo text,
    album text,
    artista text,
    data blob
);

-- IV
INSERT INTO canciones (id, titulo, album, artista) VALUES (7db1a490-5878-11e2-bcfd-0800200c9a66, 'Asilo', 'Salvavidas de Hielo', 'Jorge Drexler');

-- V
CREATE TABLE lista_reproduccion (
    id uuid,
    nro_cancion int,
    cancion_id uuid,
    titulo text,
    album text,
    artista text,
    PRIMARY KEY (id, nro_cancion)
);

-- VI
INSERT INTO lista_reproduccion (id, nro_cancion, cancion_id, titulo, album, artista) VALUES (
    62c36092-82a1-3a00-93d1-46196ee77204,
    1,
    7db1a490-5878-11e2-bcfd-0800200c9a66,
    'Asilo',
    'Salvavidas de Hielo',
    'Jorge Drexler'
);

-- VII
INSERT INTO canciones (id, titulo, album, artista)
VALUES (now(), 'De Música Ligera', 'Canción Animal', 'Soda Stereo');
-- af4285d0-c121-11f1-9236-c3a75854b8b1

INSERT INTO canciones (id, titulo, album, artista)
VALUES (now(), 'Flaca', 'Alta Suciedad', 'Andrés Calamaro');
-- af42acea-c121-11f1-9236-c3a75854b8b1

INSERT INTO canciones (id, titulo, album, artista)
VALUES (now(), 'Siguiendo la Luna', 'Rocanrol', 'Los Fabulosos Cadillacs');
-- af42acf4-c121-11f1-9236-c3a75854b8b1

-- Ids generados por now(), más el de Asilo.
SELECT id, titulo, album, artista FROM canciones;

-- cancion_id copiados de ese SELECT. now() no se puede repetir: cada llamada genera otro id.
INSERT INTO lista_reproduccion (id, nro_cancion, cancion_id, titulo, album, artista)
VALUES (
    62c36092-82a1-3a00-93d1-46196ee77204,
    2,
    af4285d0-c121-11f1-9236-c3a75854b8b1,
    'De Música Ligera',
    'Canción Animal',
    'Soda Stereo'
);

INSERT INTO lista_reproduccion (id, nro_cancion, cancion_id, titulo, album, artista)
VALUES (
    62c36092-82a1-3a00-93d1-46196ee77204,
    3,
    af42acea-c121-11f1-9236-c3a75854b8b1,
    'Flaca',
    'Alta Suciedad',
    'Andrés Calamaro'
);

INSERT INTO lista_reproduccion (id, nro_cancion, cancion_id, titulo, album, artista)
VALUES (
    62c36092-82a1-3a00-93d1-46196ee77204,
    4,
    af42acf4-c121-11f1-9236-c3a75854b8b1,
    'Siguiendo la Luna',
    'Rocanrol',
    'Los Fabulosos Cadillacs'
);

-- 8
SELECT * FROM lista_reproduccion
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204
ORDER BY nro_cancion DESC;

-- 9
-- SELECT * FROM lista_reproduccion WHERE artista = 'Jorge Drexler';
-- InvalidRequest: Cannot execute this query as it might involve data filtering and thus may have unpredictable performance. If you want to execute this query despite the performance unpredictability, use ALLOW FILTERING.

-- 10 
SELECT * FROM lista_reproduccion
WHERE artista = 'Jorge Drexler'
ALLOW FILTERING;

-- 11
CREATE INDEX indice_artista ON lista_reproduccion (artista);

SELECT * FROM lista_reproduccion WHERE artista = 'Jorge Drexler';

-- 12
ALTER TABLE lista_reproduccion ADD etiquetas set<text>;

-- 13
UPDATE lista_reproduccion
SET etiquetas = etiquetas + {'2017'}
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204 AND nro_cancion = 1;

UPDATE lista_reproduccion
SET etiquetas = etiquetas + {'guitarra'}
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204 AND nro_cancion = 1;

UPDATE lista_reproduccion
SET etiquetas = etiquetas + {'Mon Laferte'}
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204 AND nro_cancion = 1;

-- 14
CREATE INDEX indice_etiquetas ON lista_reproduccion (etiquetas);

SELECT * FROM lista_reproduccion WHERE etiquetas CONTAINS 'guitarra';

-- 15
DELETE FROM lista_reproduccion
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204 AND nro_cancion = 1;

-- 16
DELETE FROM lista_reproduccion
WHERE id = 62c36092-82a1-3a00-93d1-46196ee77204;

-- 17
DROP TABLE lista_reproduccion;

-- 18
DROP KEYSPACE demo_cql_music;