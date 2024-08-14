CREATE DATABASE db_alunos;
USE db_alunos;
CREATE TABLE alunos (
	nome VARCHAR (100),
    matricula VARCHAR (10),
    email VARCHAR (60)
);

CREATE TABLE telefones (
	telefone VARCHAR (15)
);

ALTER TABLE telefones
ADD ddd VARCHAR(2);

ALTER TABLE telefones
RENAME COLUMN telefone to celular;

ALTER TABLE telefones
MODIFY COLUMN ddd char(2);

-- DROP TABLE telefones;
-- DROP DATABASE db_alunos;