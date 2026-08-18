DROP TABLE IF EXISTS contiene;
DROP TABLE IF EXISTS articulo;
DROP TABLE IF EXISTS palabra;

CREATE TABLE articulo (
        id_articulo INT NOT NULL,
        titulo VARCHAR(120) unique NOT NULL,
        autor VARCHAR(30) NOT NULL,
        fecha_pub DATE NOT NULL,
        CONSTRAINT articulo_pk PRIMARY KEY (id_articulo)
);

CREATE TABLE palabra (
        cod_p INT NOT NULL,     
        idioma CHAR(2),
        descrip VARCHAR(25),
        CONSTRAINT palabra_pk PRIMARY KEY (cod_p, idioma)
);

CREATE TABLE contiene (
        id_articulo INT NOT NULL,
        cod_p INT NOT NULL,
        idioma CHAR(2) NOT NULL,
        CONSTRAINT contiene_pk PRIMARY KEY (id_articulo, cod_p, idioma),
        CONSTRAINT contiene_fk1 FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo),
    CONSTRAINT contiene_fk2 FOREIGN KEY (cod_p, idioma) REFERENCES palabra(cod_p, idioma)
);