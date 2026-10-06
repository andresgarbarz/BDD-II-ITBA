-- 1
-- Una tabla por consulta. La partition key es lo que se filtra; el clustering ordena.

CREATE KEYSPACE blog_noticias
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};

USE blog_noticias;

-- a
-- Búsqueda por nombre de usuario: una partición por username.
CREATE TABLE usuarios_por_username (
    username text PRIMARY KEY,
    nombre text,
    cuenta_x text,
    descripcion text
);

-- Búsqueda por cuenta de X: los mismos datos, con otra partition key.
CREATE TABLE usuarios_por_cuenta_x (
    cuenta_x text PRIMARY KEY,
    username text,
    nombre text,
    descripcion text
);

-- Noticias de un usuario, de la más nueva a la más vieja.
-- la data de la noticia va en cada fila porque la consulta la pide y no hay join.
CREATE TABLE noticias_por_usuario (
    username text,
    fecha_publicacion timestamp,
    noticia_id uuid,
    titulo text,
    cuerpo text,
    descripcion text,
    tags set<text>,
    PRIMARY KEY (username, fecha_publicacion, noticia_id)
) WITH CLUSTERING ORDER BY (fecha_publicacion DESC, noticia_id ASC);

-- Comentarios en un rango de fechas, junto con el título y quien comentó.
-- bucket = año-mes: rangos de fechas entran en menos particiones pero permite un mes en cada nodo.
CREATE TABLE comentarios_por_fecha (
    bucket text,
    fecha timestamp,
    comentario_id uuid,
    titulo_noticia text,
    username text,
    comentario text,
    PRIMARY KEY (bucket, fecha, comentario_id)
) WITH CLUSTERING ORDER BY (fecha DESC, comentario_id ASC);

-- b
INSERT INTO usuarios_por_username (username, nombre, cuenta_x, descripcion)
VALUES ('jdrexler', 'Jorge Drexler', '@drexler', 'Cantautor uruguayo');

INSERT INTO usuarios_por_username (username, nombre, cuenta_x, descripcion)
VALUES ('mfernanda', 'María Fernanda', '@mfer', 'Cronista de recitales');

INSERT INTO usuarios_por_username (username, nombre, cuenta_x, descripcion)
VALUES ('acalamaro', 'Andrés Calamaro', '@calamaro', 'Músico y compositor');

INSERT INTO usuarios_por_cuenta_x (cuenta_x, username, nombre, descripcion)
VALUES ('@drexler', 'jdrexler', 'Jorge Drexler', 'Cantautor uruguayo');

INSERT INTO usuarios_por_cuenta_x (cuenta_x, username, nombre, descripcion)
VALUES ('@mfer', 'mfernanda', 'María Fernanda', 'Cronista de recitales');

INSERT INTO usuarios_por_cuenta_x (cuenta_x, username, nombre, descripcion)
VALUES ('@calamaro', 'acalamaro', 'Andrés Calamaro', 'Músico y compositor');

INSERT INTO noticias_por_usuario (username, fecha_publicacion, noticia_id, titulo, cuerpo, descripcion, tags)
VALUES (
    'jdrexler',
    '2026-10-01 10:00:00+0000',
    11111111-1111-4111-8111-111111111111,
    'Asilo en el estudio',
    'Grabamos una versión nueva de Asilo.',
    'Cantautor uruguayo',
    {'musica', '2026'}
);

-- Sin tags: la columna puede no estar.
INSERT INTO noticias_por_usuario (username, fecha_publicacion, noticia_id, titulo, cuerpo, descripcion)
VALUES (
    'jdrexler',
    '2026-09-15 18:00:00+0000',
    22222222-2222-4222-8222-222222222222,
    'Gira de octubre',
    'Fechas confirmadas para octubre.',
    'Cantautor uruguayo'
);

INSERT INTO noticias_por_usuario (username, fecha_publicacion, noticia_id, titulo, cuerpo, descripcion, tags)
VALUES (
    'mfernanda',
    '2026-10-03 09:00:00+0000',
    33333333-3333-4333-8333-333333333333,
    'Crónica del recital',
    'El teatro estaba lleno.',
    'Cronista de recitales',
    {'recital'}
);

INSERT INTO comentarios_por_fecha (bucket, fecha, comentario_id, titulo_noticia, username, comentario)
VALUES (
    '2026-10',
    '2026-10-02 12:00:00+0000',
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa1,
    'Asilo en el estudio',
    'mfernanda',
    'La quería escuchar así.'
);

INSERT INTO comentarios_por_fecha (bucket, fecha, comentario_id, titulo_noticia, username, comentario)
VALUES (
    '2026-10',
    '2026-10-04 18:30:00+0000',
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa2,
    'Asilo en el estudio',
    'acalamaro',
    'Quedó muy bien.'
);

INSERT INTO comentarios_por_fecha (bucket, fecha, comentario_id, titulo_noticia, username, comentario)
VALUES (
    '2026-10',
    '2026-10-05 09:00:00+0000',
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa3,
    'Crónica del recital',
    'jdrexler',
    'Gracias por la crónica.'
);

INSERT INTO comentarios_por_fecha (bucket, fecha, comentario_id, titulo_noticia, username, comentario)
VALUES (
    '2026-09',
    '2026-09-20 11:00:00+0000',
    aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaa4,
    'Gira de octubre',
    'acalamaro',
    'Ahí estaré.'
);

-- c
-- Usuarios por nombre de usuario
SELECT * FROM usuarios_por_username WHERE username = 'jdrexler';

-- Usuarios por cuenta de X
SELECT * FROM usuarios_por_cuenta_x WHERE cuenta_x = '@calamaro';

-- Noticias de un usuario, con su descripción, ordenadas por fecha
SELECT titulo, cuerpo, fecha_publicacion, descripcion, tags
FROM noticias_por_usuario
WHERE username = 'jdrexler';

-- Comentarios entre el 2 y el 4 de octubre, del más nuevo al más viejo.
-- El del 5 queda afuera del rango. El de septiembre está en otro bucket.
SELECT fecha, titulo_noticia, username, comentario
FROM comentarios_por_fecha
WHERE bucket = '2026-10'
  AND fecha >= '2026-10-02 00:00:00+0000'
  AND fecha <= '2026-10-04 23:59:59+0000';
