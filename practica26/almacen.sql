CREATE TABLE tipos_pieza (
  tipo CHAR(2) CONSTRAINT tip_tip_pk PRIMARY KEY,
  descripcion VARCHAR(25) CONSTRAINT tip_des_nn NOT NULL
);

  CREATE TABLE suministros (
    tipo CHAR(2),
    modelo NUMBER(2),
    cif CHAR(9) CONSTRAINT sum_cif_fk REFERENCES empresas,
    precio_compra NUMBER(11,4)
      CONSTRAINT sum_pre_nn NOT NULL
      CONSTRAINT sum_pre_ck CHECK(suministros.precio_compra>0),
    CONSTRAINT suministros_pk PRIMARY KEY (tipo,modelo,cif),
    CONSTRAINT suministros_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas
  );

CREATE TABLE empresas (
  cif CHAR(9) CONSTRAINT emp_cif_pk PRIMARY KEY,
  nombre VARCHAR(50)
    CONSTRAINT emp_nom_uk UNIQUE
    CONSTRAINT emp_nom_nn NOT NULL,
  telefono CHAR(9),
  direccion VARCHAR(50),
  localidad VARCHAR(50),
  provincia VARCHAR(50)
);

CREATE TABLE piezas (
  tipo CHAR(2)
    CONSTRAINT pie_tip_fk REFERENCES tipos_pieza,
  modelo NUMBER(2),
  precio_venta NUMBER(11,4),
  CONSTRAINT piezas_pk PRIMARY KEY (tipo,modelo)
);

CREATE TABLE pedidos (
  n_pedido NUMBER(4) CONSTRAINT ped_num_pk PRIMARY KEY,
  cif CHAR(9)
    CONSTRAINT ped_cif_nn NOT NULL
    CONSTRAINT ped_cif_fk REFERENCES empresas,
  fecha DATE CONSTRAINT ped_fec_nn NOT NULL
);

CREATE TABLE existencias (
  tipo CHAR(2),
  modelo NUMBER(2),
  n_almacen NUMBER(2) CONSTRAINT exi_num_fk REFERENCES almacenes,
  cantidad NUMBER(9)
    CONSTRAINT exi_can_ck CHECK (cantidad>0)
    CONSTRAINT exi_can_nn NOT NULL,
    CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
    CONSTRAINT existencia_fk FOREIGN KEY (tipo,modelo) REFERENCES piezas
);

CREATE TABLE almacenes (
  n_almacen NUMBER(2) CONSTRAINT alm_num_pk PRIMARY KEY,
  descripcion VARCHAR(1000) CONSTRAINT alm_des_nn NOT NULL,
  direccion VARCHAR(100)
);

CREATE TABLE lineas_pedido (
  tipo CHAR(2) CONSTRAINT lin_tip_nn NOT NULL,
  modelo NUMBER(2) CONSTRAINT lin_mod_nn NOT NULL,
  n_pedido NUMBER(4) CONSTRAINT lin_num_fk REFERENCES pedidos,
  n_linea NUMBER(2),
  cantidad NUMBER(5),
  precio NUMBER(11,4),
    CONSTRAINT lineas_pedido_fk2 FOREIGN KEY (tipo, modelo) REFERENCES piezas,
    CONSTRAINT lineas_pedido_pk PRIMARY KEY (n_linea,n_pedido)
);






