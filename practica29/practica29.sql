CREATE TABLE equipos (
  id_equipo NUMBER(2) CONSTRAINT equipos_pk PRIMARY KEY,
  nombre VARCHAR(50)
    CONSTRAINT equipos_uk1 UNIQUE
    CONSTRAINT equipos_nn1 NOT NULL,
  estadio VARCHAR(50) CONSTRAINT equipos_uk2 UNIQUE,
  aforo NUMBER(6),
  ano_fundacion NUMBER(4),
  ciudad VARCHAR(50) CONSTRAINT equipos_nn2 NOT NULL
);

CREATE TABLE jugadores (
  id_jugador NUMBER(3) CONSTRAINT jugadores_pk PRIMARY KEY,
  nombre VARCHAR(50) CONSTRAINT jugadores_nn NOT NULL,
  fecha_nac DATE,
  id_equipo NUMBER(2) CONSTRAINT jugadores_fk REFERENCES equipos ON DELETE SET NULL
);

CREATE TABLE partidos(
  id_equipo_casa NUMBER(2) CONSTRAINT partidos_fk1 REFERENCES equipos ON DELETE CASCADE ,
  id_equipo_fuera NUMBER(2) CONSTRAINT partidos_fk2 REFERENCES equipos ON DELETE CASCADE ,
  fecha TIMESTAMP,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR(1000),
  CONSTRAINT partidos_pk PRIMARY KEY (id_equipo_casa, id_equipo_fuera),
  CONSTRAINT partidos_ck CHECK (id_equipo_fuera <> id_equipo_casa)
);

CREATE TABLE goles(
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  minuto INTERVAL DAY TO SECOND,
  descripcion VARCHAR(2000),
  id_jugador NUMBER(3) CONSTRAINT golas_fk2 REFERENCES jugadores ON DELETE CASCADE,
  CONSTRAINT goles_pk PRIMARY KEY (id_equipo_fuera, id_equipo_casa, minuto),
  CONSTRAINT goles_fk1 FOREIGN KEY (id_equipo_casa, id_equipo_fuera) REFERENCES partidos ON DELETE CASCADE
 );

ALTER TABLE equipos MODIFY aforo CONSTRAINT equipos_nn3 NOT NULL;

ALTER TABLE equipos MODIFY estadio CONSTRAINT equipos_nn4 NOT NULL;

ALTER TABLE equipos MODIFY ano_fundacion DATE;

ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn;