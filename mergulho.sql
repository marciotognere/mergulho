CREATE TABLE instrutor(
  cod_instrutor  INTEGER     NOT NULL,
  nome_instrutor VARCHAR(20) NOT NULL,
  CONSTRAINT pk_instrutor
    PRIMARY KEY (cod_instrutor)
);

CREATE TABLE tipo_mergulho(
  cod_tipo_mergulho  INTEGER     NOT NULL,
  nome_tipo_mergulho VARCHAR(20) NOT NULL,
  CONSTRAINT pk_tipo_mergulho
    PRIMARY KEY(cod_tipo_mergulho)
);

CREATE TABLE local_mergulho(
  cod_local  INTEGER     NOT NULL,
  nome_local VARCHAR(20) NOT NULL,
  CONSTRAINT pk_local_mergulho
    PRIMARY KEY(cod_local)
);

CREATE TABLE pacote(
  cod_pacote     INTEGER     NOT NULL,
  hora_saida     TIMESTAMP   NOT NULL,
  hora_chegada   TIMESTAMP   NOT NULL,
  desc_pacote    VARCHAR(20) NOT NULL,
  tempo_total    INTEGER     NOT NULL,
  local_chegada  INTEGER     NOT NULL,
  local_saida    INTEGER     NOT NULL,
  local_mergulho INTEGER     NOT NULL,
  CONSTRAINT pk_pacote
    PRIMARY KEY(cod_pacote),
  CONSTRAINT fk_pacote_local_chegada
    FOREIGN KEY (local_chegada)
    REFERENCES local_mergulho(cod_local),
  CONSTRAINT fk_pacote_local_saida
    FOREIGN KEY (local_saida)
    REFERENCES local_mergulho(cod_local),
  CONSTRAINT fk_pacote_local_mergulho
    FOREIGN KEY (local_mergulho)
    REFERENCES local_mergulho(cod_local)
);

CREATE TABLE cliente(
  cod_cliente    INTEGER     NOT NULL,
  nome_cliente   VARCHAR(20) NOT NULL,
  genero_cliente CHAR(1)     NOT NULL,
  rua_cliente    VARCHAR(25) NOT NULL,
  bairro_cliente VARCHAR(20) NOT NULL,
  cidade_cliente VARCHAR(20) NOT NULL,
  uf_cliente     CHAR(2)     NOT NULL,
  CONSTRAINT pk_cliente
    PRIMARY KEY(cod_cliente)
);

CREATE TABLE telefone(
  telefone            CHAR(10) NOT NULL,
  cliente_cod_cliente INTEGER  NOT NULL,
  CONSTRAINT pk_telefone
    PRIMARY KEY(telefone,cliente_cod_cliente),
  CONSTRAINT fk_cliente_cod_cliente
    FOREIGN KEY(cliente_cod_cliente)
    REFERENCES cliente(cod_cliente)
);

CREATE TABLE mergulho(
  pacote_cod_pacote INTEGER NOT NULL,
  data_mergulho     DATE    NOT NULL,
  hora_mergulho     TIME    NOT NULL,
  CONSTRAINT pk_mergulho
    PRIMARY KEY(pacote_cod_pacote,data_mergulho,hora_mergulho),
  CONSTRAINT fk_mergulho_pacote
    FOREIGN KEY (pacote_cod_pacote)
    REFERENCES pacote(cod_pacote)
);

CREATE TABLE participante(
  cliente_cod_cliente        INTEGER NOT NULL,
  mergulho_mergulho_hora     TIME    NOT NULL,
  mergulho_mergulho_data     DATE    NOT NULL,
  mergulho_pacote_cod_pacote INTEGER NOT NULL,
  CONSTRAINT pk_participante
    PRIMARY KEY(cliente_cod_cliente,mergulho_mergulho_hora,mergulho_mergulho_data,mergulho_pacote_cod_pacote),
  CONSTRAINT fk_participante_cliente
    FOREIGN KEY(cliente_cod_cliente)
    REFERENCES cliente(cod_cliente),
  CONSTRAINT fk_participante_mergulho
    FOREIGN KEY(mergulho_mergulho_hora,mergulho_mergulho_data,mergulho_pacote_cod_pacote)
    REFERENCES mergulho(hora_mergulho,data_mergulho,pacote_cod_pacote)
);

CREATE TABLE acompanha(
  mergulha_hora              TIME    NOT NULL,
  mergulha_data              DATE    NOT NULL,
  instrutor_cod_instrutor    INTEGER NOT NULL,
  mergulho_pacote_cod_pacote INTEGER NOT NULL,
  CONSTRAINT pk_acompanha
    PRIMARY KEY(mergulha_hora,mergulha_data,instrutor_cod_instrutor,mergulho_pacote_cod_pacote),
  CONSTRAINT fk_acompanha_instrutor
    FOREIGN KEY(instrutor_cod_instrutor)
    REFERENCES instrutor(cod_instrutor),
  CONSTRAINT fk_acompanha_mergulho
    FOREIGN KEY(mergulha_hora,mergulha_data,mergulho_pacote_cod_pacote)
    REFERENCES mergulho(hora_mergulho,data_mergulho,pacote_cod_pacote)
);