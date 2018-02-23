CREATE TABLE tipos_apli(
  id_tipo NUMBER(2) CONSTRAINT tipos_pk PRIMARY KEY,
  tipo VARCHAR(25) CONSTRAINT tipos_uk1 UNIQUE
                  CONSTRAINT tipos_nn1 NOT NULL
);

CREATE TABLE aplicaciones(
  n_aplicacion NUMBER(4) CONSTRAINT aplicaciones_pk PRIMARY KEY,
  nombre VARCHAR(25) CONSTRAINT aplicaciones_uk1 UNIQUE
                    CONSTRAINT aplicaciones_nn1 NOT NULL,
  id_tipo NUMBER(11,2) CONSTRAINT aplicaciones_fk1 REFERENCES tipos_apli ON DELETE CASCADE
                      CONSTRAINT aplicaciones_nn2 NOT NULL
);

CREATE TABLE procesos(
  n_aplicacion NUMBER(4)  CONSTRAINT procesos_fk1 REFERENCES aplicaciones ON DELETE CASCADE ,
  id_proceso NUMBER(3),
  nombre VARCHAR(25) CONSTRAINT procesos_uk1 UNIQUE
                      CONSTRAINT procesos_nn1 NOT NULL ,
  mem_minima NUMBER(5,1) CONSTRAINT procesos_ck CHECK (mem_minima>0),
  id_proceso_lanz NUMBER(3),
  n_aplicacion_lanz NUMBER(4),
    CONSTRAINT procesos_pk PRIMARY KEY (n_aplicacion,id_proceso),
    CONSTRAINT procesos_fk2 FOREIGN KEY (id_proceso_lanz, n_aplicacion_lanz) REFERENCES procesos ON DELETE SET NULL
);

CREATE TABLE maquinas(
  n_maquina NUMBER(3) CONSTRAINT maquinas_pk PRIMARY KEY,
  ip1 NUMBER(3) CONSTRAINT maquinas_nn1 NOT NULL
                CONSTRAINT maquinas_ck1 CHECK (ip1>=0 and ip1<=255),
  ip2 NUMBER(3) CONSTRAINT maquinas_nn2 NOT NULL
                CONSTRAINT maquinas_ck2 CHECK (ip2>=0 AND ip2<=255),
  ip3 NUMBER(3) CONSTRAINT maquinas_nn3 NOT NULL
                CONSTRAINT maquinas_ck3 CHECK (ip3>=0 AND ip3<=255),
  ip4 NUMBER(3) CONSTRAINT maquinas_nn4 NOT NULL
                CONSTRAINT maquinas_ck4 CHECK (ip4>=0 AND ip4<=255),
  nombre VARCHAR(45) CONSTRAINT maquinas_uk2 UNIQUE
                      CONSTRAINT maquinas_nn5 NOT NULL,
  memoria NUMBER(5,1),
    CONSTRAINT maquinas_uk1 UNIQUE (ip1,ip2,ip3,ip4)
);

CREATE TABLE procesos_lanzados(
  n_aplicacion NUMBER(4),
  id_proceso NUMBER(3),
  fecha_lanz TIMESTAMP,
  fecha_termino TIMESTAMP,
  bloqueado NUMBER(1) CONSTRAINT lanzados_ck CHECK (bloqueado=0 OR bloqueado=1),
  n_maquina NUMBER(3) CONSTRAINT lanzados_fk2 REFERENCES maquinas
                      CONSTRAINT lanzados_nn1 NOT NULL,
    CONSTRAINT lanzados_pk PRIMARY KEY (n_aplicacion,id_proceso,fecha_lanz),
    CONSTRAINT lanzados_fk1 FOREIGN KEY (n_aplicacion,id_proceso) REFERENCES procesos ON DELETE CASCADE
);

ALTER TABLE maquinas ADD hd NUMBER(5,2);
ALTER TABLE maquinas ADD tipo VARCHAR(1) CONSTRAINT maquinas_ck5 CHECK (tipo='S' or tipo='C');
ALTER TABLE aplicaciones ADD extension VARCHAR(10);

/*introducción de datos*/

INSERT INTO tipos_apli VALUES ('1','Procesador de texto');
INSERT INTO aplicaciones (n_aplicacion, nombre, id_tipo,extension) VALUES ('1','Multiword','1','multi');
INSERT INTO maquinas VALUES ('1','212','34','56','7','ELECTRO','512','250','S');
INSERT INTO maquinas VALUES ('2','212','34','56','27','MAGNUS','256','128','C');
INSERT INTO maquinas VALUES ('3','97','23','45','6','GREGOR','1024','512','S');
INSERT INTO procesos VALUES ('1','1','WRD','250',NULL,'1');
INSERT INTO procesos VALUES ('1','2','WRHELP','250','1','1');
INSERT INTO procesos_lanzados VALUES ('1','1',TO_DATE('30/5/16'),TO_DATE('1/6/16'),'0','3');
INSERT INTO procesos_lanzados VALUES ('1','1',TO_DATE('31/5/16'),TO_DATE('1/6/16'),'0','1');
INSERT INTO procesos_lanzados VALUES ('1','1',TO_DATE('2/6/16'),TO_DATE('1/6/16'),'1','1');
INSERT INTO procesos_lanzados VALUES ('1','1',TO_DATE('1/6/16'),NULL ,'0','2');







