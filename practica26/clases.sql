CREATE TABLE empresas (
  cif CHAR(9) CONSTRAINT emp_cif_PK PRIMARY KEY,
  nombre VARCHAR(25)
    CONSTRAINT emp_nom_uk UNIQUE
    CONSTRAINT emp_nom_nn NOT NULL,
  telefono CHAR(9),
  direccion VARCHAR(50)
);

CREATE TABLE alumnos (
  dni CHAR(9) CONSTRAINT alu_dni_pk PRIMARY KEY,
  nombre VARCHAR(50) CONSTRAINT alu_nom_nn NOT NULL,
  apellido1 VARCHAR(50) CONSTRAINT alu_ap1_nn NOT NULL,
  apellido2 VARCHAR(50) CONSTRAINT alu_ap2_nn NOT NULL,
  direccion VARCHAR(50),
  telefono CHAR(9),
  edad NUMBER(2),
  cif CHAR(9) CONSTRAINT alu_cif_fk references empresas
  );

CREATE TABLE asistir (
  dni CHAR(9) CONSTRAINT asi_dni_fk REFERENCES alumnos,
  n_curso NUMBER(3) CONSTRAINT asi_ncu_fk REFERENCES cursos,
  nota NUMBER(4,2),
    CONSTRAINT asistir_pk PRIMARY KEY (dni,n_curso)
);

CREATE TABLE cursos (
  n_curso NUMBER(3) CONSTRAINT cur_ncu_pk PRIMARY KEY,
  fecha_inicio TIMESTAMP,
  fecha_fin TIMESTAMP,
  cod_curso CHAR(8) CONSTRAINT cur_cod_fk REFERENCES tipos_curso,
  dni_profesor CHAR(9) CONSTRAINT cur_dni_fk REFERENCES profesores
);

CREATE TABLE tipos_curso (
  cod_curso CHAR(8) CONSTRAINT tip_cod_pk PRIMARY KEY,
  titulo VARCHAR(50) CONSTRAINT tip_tit_uk UNIQUE,
  duracion NUMBER(3),
  temario CLOB
);

CREATE TABLE profesores (
  dni CHAR(9) CONSTRAINT pro_dni_pk PRIMARY KEY,
  nombre VARCHAR(50) CONSTRAINT pro_nom_nn NOT NULL,
  apellido1 VARCHAR(50) CONSTRAINT pro_ap1_nn NOT NULL,
  apellido2 VARCHAR(50) CONSTRAINT pro_ap2_nn NOT NULL,
  direccion VARCHAR(50),
  telefono CHAR(9)
  );












