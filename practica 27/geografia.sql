CREATE TABLE localidades(
  id_localidad NUMBER (5) CONSTRAINT loc_id_pk PRIMARY KEY,
  nombre VARCHAR(50) CONSTRAINT loc_nom_nn NOT NULL,
  poblacion NUMBER(8),
  n_provincia NUMBER(2)
      CONSTRAINT loc_npro_nn NOT NULL
      CONSTRAINT loc_npro_fk REFERENCES provincias
);

CREATE TABLE provincias(
  n_provincia NUMBER(2) CONSTRAINT pro_npro_pk PRIMARY KEY,
  nombre VARCHAR(25)
    CONSTRAINT pro_nom_uk UNIQUE
    CONSTRAINT pro_nom_nn NOT NULL,
  superficie NUMBER(5),
  id_capital NUMBER(5)
    CONSTRAINT pro_idcap_uk UNIQUE
    CONSTRAINT pro_idcap_nn NOT NULL
    CONSTRAINT pro_idcap_fk REFERENCES localidades,
  id_comunidad NUMBER(2)
    CONSTRAINT pro_idcom_fk REFERENCES comunidades
    CONSTRAINT pro_idcom_nn NOT NULL
);

CREATE TABLE comunidades (
  id_comunidad NUMBER(2) CONSTRAINT com_idcom_pk PRIMARY KEY,
  nombre VARCHAR(25)
    CONSTRAINT com_nom_uk UNIQUE
    CONSTRAINT com_nom_nn NOT NULL,
  id_capital NUMBER(5)
    CONSTRAINT com_idcap_fk REFERENCES localidades
    CONSTRAINT com_idcap_uk UNIQUE
    CONSTRAINT com_idcap_nn NOT NULL,
  max_provincias NUMBER(1)
);

