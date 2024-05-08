CREATE DATABASE IF NOT EXISTS agendabd;
USE agendabd;

CREATE TABLE IF NOT EXISTS contato (
  ID_cont INT PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(100) NOT NULL,
  SOBRENOME VARCHAR(100),
  DATA_NASCIMENTO DATE
);

INSERT INTO contato(NOME, SOBRENOME, DATA_NASCIMENTO) 
VALUES('Italo', 'Nunes', '1989-03-24'),
      ('Gessica', 'Miron', '1991-05-22');

CREATE TABLE IF NOT EXISTS telefone(
  ID_tel INT PRIMARY KEY AUTO_INCREMENT,
  NUMERO VARCHAR(20) NOT NULL,
  TIPO VARCHAR(20) NOT NULL,
  ID_cont INT,
  FOREIGN KEY(ID_cont) REFERENCES contato(ID_cont)
);

INSERT INTO telefone(NUMERO, TIPO, ID_CONT)
values('1234567', 'CELULAR', 1),
('1234567', 'CELULAR', 1);

CREATE TABLE IF NOT EXISTS email (
  ID_ema INT PRIMARY KEY AUTO_INCREMENT,
  ENDERECO VARCHAR(100) NOT NULL,
  PROVEDOR VARCHAR(20) NOT NULL,
  fk_ID_cont INT,
  FOREIGN KEY(fk_ID_cont) REFERENCES contato(ID_cont)
);

INSERT INTO email(ENDERECO, PROVEDOR, fk_ID_cont)
values('italo@gmail.com', 'Gmail', 1),
('1234567', 'CELULAR', 1);

/* Usando Inner Join nas tabelas */   
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
INNER JOIN telefone t ON c.ID_cont = t.ID_cont;

/* Usando left Join nas tabelas */
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
LEFT JOIN telefone t ON c.ID_cont = t.ID_cont;

/* Usando rigth Join nas tabelas */
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
RIGHT JOIN telefone t ON c.ID_cont = t.ID_cont;

/* Usando cross Join nas tabelas */
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
CROSS JOIN telefone t;

/* Unindo tabelas usando UNION */
SELECT ID_cont FROM contato
UNION
SELECT ID_ema FROM email;

/* Usando UNION nos Joins nas tabelas */
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
CROSS JOIN telefone t
UNION
SELECT c.ID_cont, c.NOME, c.SOBRENOME, t.NUMERO 
FROM contato c
LEFT JOIN telefone t ON c.ID_cont = t.ID_cont;

SELECT SOBRENOME AS SEGUNDO_NOME
FROM contato;

SELECT SOBRENOME AS SEGUNDO_NOME, NOME AS APELIDO
FROM contato; 

SELECT SOBRENOME AS SEGUNDO_NOME, NOME AS APELIDO
FROM contato WHERE ID_cont = 1;
      
CREATE FUNCTION fn_valor (a DECIMAL(10,2), b INT)
RETURNS INT
RETURN a * b;

SELECT fn_valor(2.5,4) AS RESULTADO;

-- Crie outras funções que execute as operações matemáticas

CREATE TABLE IF NOT EXISTS salario (
  Id INT PRIMARY KEY AUTO_INCREMENT,
  salario DECIMAL(10,2)
);

INSERT INTO salario (salario) VALUES (100), (200), (300);

SELECT salario, fn_valor(salario,4) AS NOVO_SALARIO
FROM salario WHERE Id = 3;

CREATE PROCEDURE verSalario (varValor INT)

SELECT CONCAT('O salário é: ', salario) AS Novo_Salario
FROM salario
WHERE Id = varValor;

CALL verSalario(2);

DROP PROCEDURE IF EXISTS verSalario;

SHOW INDEX FROM contato;

EXPLAIN SELECT * FROM contato WHERE ID_cont=1;
EXPLAIN SELECT * FROM contato WHERE nome='Italo';

