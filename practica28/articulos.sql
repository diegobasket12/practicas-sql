CREATE TABLE articulos(
  cod_art CHAR(7) CONSTRAINT articulos_pk PRIMARY KEY,
  nombre VARCHAR(40) CONSTRAINT articulos_nn1 NOT NULL,
  marca VARCHAR(20) CONSTRAINT articulos_nn2 NOT NULL,
  modelo VARCHAR(15) CONSTRAINT articulos_nn3 NOT NULL
);

CREATE TABLE secciones(
  id_sec NUMBER(3) CONSTRAINT secciones_pk PRIMARY KEY,
  id_supersec NUMBER(3) CONSTRAINT secciones_fk1 REFERENCES secciones,
  nombre VARCHAR(40)
    CONSTRAINT secciones_uk1 UNIQUE
    CONSTRAINT secciones_nn1 NOT NULL
);

CREATE TABLE precios(
  fecha_inicio DATE,
  fecha_fin DATE,
  cod_art CHAR(7) CONSTRAINT precios_fk1 REFERENCES articulos ON DELETE CASCADE,
  precio NUMBER(7,2) CONSTRAINT precios_ch CHECK (precio>0),
  CONSTRAINT precios_pk PRIMARY KEY (fecha_inicio,cod_art),
  CONSTRAINT precios_ch1 CHECK (fecha_inicio<fecha_fin)
  );

CREATE TABLE pertenecer(
  cod_art CHAR(7) CONSTRAINT pertenecer_fk1 REFERENCES articulos,
  id_sec NUMBER(3) CONSTRAINT pertenecer_fk2 REFERENCES secciones,
    CONSTRAINT pertenecer_pk PRIMARY KEY (cod_art,id_sec)
);