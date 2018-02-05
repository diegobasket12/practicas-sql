CREATE TABLE puestos (
  cod_puesto NUMBER(2) CONSTRAINT puestos_pk PRIMARY KEY,
  titulo_puesto VARCHAR(25)
    CONSTRAINT puestos_uk1 UNIQUE
    CONSTRAINT puestos_nn1 NOT NULL,
  salario_minimo NUMBER(11,2),
  salario_maximo NUMBER(11,2)
);

CREATE TABLE empleados(
  cod_emp NUMBER(4) CONSTRAINT empleados_pk PRIMARY KEY,
  nombre VARCHAR(50) CONSTRAINT empleados_nn1 NOT NULL,
  apellido1 VARCHAR(50) CONSTRAINT empleados_nn2 NOT NULL,
  apellido2 VARCHAR(50) CONSTRAINT empleados_nn3 NOT NULL,
  telefono CHAR(9),
  direccion VARCHAR(50),
  email VARCHAR(50) CONSTRAINT empleados_uk UNIQUE,
  cod_jefe NUMBER(4) CONSTRAINT empleados_fk1 REFERENCES empleados (cod_emp),
  cod_dep NUMBER(3) CONSTRAINT empleados_fk2 REFERENCES departamentos
);

CREATE TABLE historial(
  cop_puesto NUMBER(2) CONSTRAINT historial_fk1 REFERENCES puestos,
  cop_emp NUMBER(4) CONSTRAINT historial_fk2 REFERENCES empleados,
  fecha_inicio DATE CONSTRAINT historial_nn1 NOT NULL,
  fecha_fin DATE,
  cod_dep NUMBER(3) CONSTRAINT historial_fk3 REFERENCES departamentos,
  salario NUMBER(11,2),
  CONSTRAINT historial_pk PRIMARY KEY (cop_emp,cop_puesto)
);

CREATE TABLE departamentos(
  cod_dep NUMBER(2) CONSTRAINT departamentos_pk PRIMARY KEY,
  nombre_dep VARCHAR(25)
    CONSTRAINT departamentos_uk1 UNIQUE
    CONSTRAINT departamentos_nn1 NOT NULL,
  cod_resp NUMBER(4) CONSTRAINT departamentos_fk1 REFERENCES empleados,
  cod_loc NUMBER(3) CONSTRAINT departamentos_fk2 REFERENCES localizaciones
);

CREATE TABLE localizaciones(
  cod_localizacion NUMBER(3) CONSTRAINT localizaciones_pk PRIMARY KEY,
  localidad VARCHAR(50) CONSTRAINT localizaciones_nn1 NOT NULL,
  direccion VARCHAR(50),
  cp CHAR(5),
  provincia VARCHAR(25)
);