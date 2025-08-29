-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS REMOTER_C;

-- Usar o banco de dados
USE REMOTER_C;
/* ============================================================ */

-- Criar a tabela PRODUTOS
CREATE TABLE IF NOT EXISTS PRODUTOS (
    CProd INT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Peso VARCHAR(10),
    ValorUnit DECIMAL(10,2)
);

-- Inserir os itens
INSERT INTO PRODUTOS (CProd, Descricao, Peso, ValorUnit) VALUES
(1, 'Teclado', 'KG', 35.00),
(2, 'Mouse', 'KG', 25.00),
(3, 'HD', 'KG', 350.00);
/* ============================================================ */

-- Criar a tabela VENDEDOR
CREATE TABLE IF NOT EXISTS VENDEDOR (
    CVend INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Salario DECIMAL(10,2),
    FSalario INT
);

-- Inserir os itens
INSERT INTO VENDEDOR (CVend, Nome, Salario, FSalario) VALUES
(1, 'Ronaldo', 3512.00, 1),
(2, 'Robertson', 3225.00, 2),
(3, 'Clodoaldo', 4350.00, 3);
/* ============================================================ */

-- Criar a tabela CLIENTE
CREATE TABLE IF NOT EXISTS CLIENTE (
    CCli INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Cidade VARCHAR(100),
    UF CHAR(2)
);

-- Inserir os itens
INSERT INTO CLIENTE (CCli, Nome, Endereco, Cidade, UF) VALUES
(11, 'Bruno', 'Rua 1 456', 'Rio Claro', 'SP'),
(12, 'Cláudio', 'Rua Quadrada 234', 'Campinas', 'SP'),
(13, 'Cremilda', 'Rua das Flores 666', 'São Paulo', 'SP');


/* ============================================================
   0) PREPARO: usar (ou criar) o banco do exercício
   ============================================================ */
CREATE DATABASE IF NOT EXISTS REMOTER_C;
USE REMOTER_C;

/* ============================================================
   1) CRIAÇÃO DAS TABELAS (caso ainda não existam)
   ============================================================ */
CREATE TABLE IF NOT EXISTS PRODUTOS (
    CProd INT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Peso VARCHAR(10),
    ValorUnit DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS VENDEDOR (
    CVend INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL,
    FSalario INT NOT NULL   -- faixa salarial
);

CREATE TABLE IF NOT EXISTS CLIENTE (
    CCli INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Cidade VARCHAR(100),
    UF CHAR(2)
);

/* ============================================================
   2) CARGA INICIAL DE DADOS (exercícios anteriores)
   ------------------------------------------------------------
   Obs.: rode estes INSERTs se ainda não tiver os dados.
   ============================================================ */
INSERT INTO PRODUTOS (CProd, Descricao, Peso, ValorUnit) VALUES
(1, 'Teclado', 'KG', 35.00),
(2, 'Mouse',   'KG', 25.00),
(3, 'HD',      'KG', 350.00)
ON DUPLICATE KEY UPDATE
 Descricao=VALUES(Descricao), Peso=VALUES(Peso), ValorUnit=VALUES(ValorUnit);

INSERT INTO VENDEDOR (CVend, Nome, Salario, FSalario) VALUES
(1, 'Ronaldo',   3512.00, 1),
(2, 'Robertson', 3225.00, 2),
(3, 'Clodoaldo', 4350.00, 3)
ON DUPLICATE KEY UPDATE
 Nome=VALUES(Nome), Salario=VALUES(Salario), FSalario=VALUES(FSalario);

INSERT INTO CLIENTE (CCli, Nome, Endereco, Cidade, UF) VALUES
(11, 'Bruno',    'Rua 1 456',          'Rio Claro', 'SP'),
(12, 'Cláudio',  'Rua Quadrada 234',   'Campinas',  'SP'),
(13, 'Cremilda', 'Rua das Flores 666', 'São Paulo', 'SP')
ON DUPLICATE KEY UPDATE
 Nome=VALUES(Nome), Endereco=VALUES(Endereco), Cidade=VALUES(Cidade), UF=VALUES(UF);

/* Conferência inicial */
SELECT * FROM PRODUTOS;
SELECT * FROM VENDEDOR;
SELECT * FROM CLIENTE;

/* ============================================================
   3) UPDATE (ATUALIZAÇÃO DE DADOS) — SINTAXE
   ------------------------------------------------------------
   UPDATE <tabela>
   SET <coluna>=<novo_valor>[, <coluna2>=<novo_valor2>...]
   WHERE <condição>;
   (Sem WHERE, atualiza TODAS as linhas!)
   ============================================================ */

/* 3.1) Situação: alterar o valor de UMA coluna em linhas específicas
       Exemplo: mudar o valor do produto 'Teclado' de 35.00 para 32.00
*/
UPDATE PRODUTOS
SET ValorUnit = 32.00
WHERE UPPER(Descricao) = 'TECLADO';

SELECT * FROM PRODUTOS;

/* 3.2) Situação: alterar o valor de UMA coluna para TODAS as linhas
       Exemplo didático: aumentar salário fixo de TODOS os vendedores em 25%
       (Salario = Salario * 1.25)
*/
UPDATE VENDEDOR
SET Salario = Salario * 1.25;

SELECT * FROM VENDEDOR;

/* 3.3) Situação: alterar MAIS DE UMA coluna ao mesmo tempo
       Exemplo: produto de código 2 passa de 25.00 para 28.00
                e descrição de 'Mouse' para 'Mouse Branco'
*/
UPDATE PRODUTOS
SET ValorUnit = 28.00,
    Descricao = 'Mouse Branco'
WHERE CProd = 2;

SELECT * FROM PRODUTOS;

/* 3.4) Exemplos adicionais (registro único e múltiplo)
   - Registro único: alterar um campo de um cliente específico
*/
UPDATE CLIENTE
SET Endereco = 'Rua 1 999'
WHERE CCli = 11;

SELECT * FROM CLIENTE;

/*  - Registro múltiplo: reajustar TODOS os preços dos produtos em 10%  */
UPDATE PRODUTOS
SET ValorUnit = ValorUnit * 1.10;

SELECT * FROM PRODUTOS;

/* ============================================================
   4) UPDATE — DESAFIO
   ------------------------------------------------------------
   1) Salário dos vendedores da faixa 1 -> R$ 3150,00
   2) Aumento de 10% nos vendedores da faixa 2
   3) Salário dos vendedores da faixa 3 -> R$ 3500,00
   ============================================================ */
-- 4.1
UPDATE VENDEDOR
SET Salario = 3150.00
WHERE FSalario = 1;

-- 4.2
UPDATE VENDEDOR
SET Salario = Salario * 1.10
WHERE FSalario = 2;

-- 4.3
UPDATE VENDEDOR
SET Salario = 3500.00
WHERE FSalario = 3;

SELECT * FROM VENDEDOR;

/* ============================================================
   5) DELETE (EXCLUSÃO DE DADOS) — SINTAXE
   ------------------------------------------------------------
   DELETE FROM <tabela>
   WHERE <condição>;
   (Sem WHERE, apaga TODAS as linhas!)
   ============================================================ */

/* 5.1) Exemplo: excluir vendedores com salário menor que 2500.00
       Para demonstrar, vamos inserir temporariamente um vendedor
       com salário baixo e, na sequência, excluí-lo.
*/
INSERT INTO VENDEDOR (CVend, Nome, Salario, FSalario)
VALUES (99, 'Teste_Salario_Baixo', 2000.00, 1);

SELECT * FROM VENDEDOR;

DELETE FROM VENDEDOR
WHERE Salario < 2500.00;

SELECT * FROM VENDEDOR;

/* 5.2) Exemplo com intervalo (operador AND / BETWEEN)
       Apagar clientes com códigos entre 11 e 12
*/
DELETE FROM CLIENTE
WHERE CCli >= 11 AND CCli <= 12;
/* (equivalente) DELETE FROM CLIENTE WHERE CCli BETWEEN 11 AND 12; */

SELECT * FROM CLIENTE;

/* 5.3) Esvaziando a tabela inteira com DELETE (CUIDADO!)
       Exemplo: apagar TODAS as linhas de CLIENTE
*/
DELETE FROM CLIENTE;

SELECT * FROM CLIENTE;  -- deve retornar vazio

/* ============================================================
   6) TRUNCATE TABLE (EXCLUSÃO DE DADOS EM MASSA)
   ------------------------------------------------------------
   DDL que apaga TODAS as linhas da tabela (mais rápido que DELETE sem WHERE).
   Sintaxe:
   TRUNCATE TABLE <tabela>;
   ============================================================ */
TRUNCATE TABLE PRODUTOS;

SELECT * FROM PRODUTOS;  -- deve retornar vazio

/* ============================================================
   FIM DO SCRIPT
   - Você pode reexecutar a seção 2 para recarregar dados de teste.
   ============================================================ */

/*
   Curiosidade do dia: Você pode ter percebido que a forma de comentar no código mudou, 
   isso é porque em SQL existem 3 formas de se fazer um comentário. VEJA ABAIXO:
   */

-- 1) primeira:
-- Isso é um comentário em SQL;
 
 #2) Segunda forma:
 # Isso também é um comentário em SQL;
 
 /*
 3) Terceira:
Assim você pode fazer um comentário de bloco,
ou seja, pode ocupar varias linhas.
*/