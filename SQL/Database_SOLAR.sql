
-- ==============================================================
-- CRIANDO O BANCO DE DADOS
-- ==============================================================
CREATE DATABASE IF NOT EXISTS solar;
USE solar;

-- ==============================================================
-- TABELA CLIENTES
-- ==============================================================
CREATE TABLE IF NOT EXISTS CLIENTES (
    COD_CLIENTE INT NOT NULL AUTO_INCREMENT,   -- CÓDIGO DO CLIENTE
    NOME_CLIENTE VARCHAR(100),                 -- NOME DO CLIENTE
    CPF VARCHAR(14) NOT NULL,                  -- CPF DO CLIENTE
    ENDERECO VARCHAR(100),                     -- ENDEREÇO DO CLIENTE
    CELULAR VARCHAR(19),                       -- CELULAR DO CLIENTE
    PRIMARY KEY (COD_CLIENTE)                  -- CHAVE PRIMÁRIA
);

-- ==============================================================
-- TABELA FORNECEDOR
-- ==============================================================
CREATE TABLE IF NOT EXISTS FORNECEDORES (
    COD_FORNECEDOR INT NOT NULL AUTO_INCREMENT, -- CÓDIGO DO FORNECEDOR
    NOME_FORNECEDOR VARCHAR(100),               -- NOME DO FORNECEDOR
    CNPJ VARCHAR(18) NOT NULL,                  -- CNPJ DO FORNECEDOR
    ENDERECO VARCHAR(100),                      -- ENDEREÇO DO FORNECEDOR
    CELULAR VARCHAR(19),                        -- CELULAR DO FORNECEDOR
    PRIMARY KEY (COD_FORNECEDOR)                -- CHAVE PRIMÁRIA
);

-- ==============================================================
-- TABELA PRODUTOS
-- ==============================================================
CREATE TABLE IF NOT EXISTS PRODUTOS (
    COD_PRODUTO INT NOT NULL AUTO_INCREMENT,    -- CÓDIGO DO PRODUTO
    NOME_PRODUTO VARCHAR(100),                  -- NOME DO PRODUTO
    VALOR DECIMAL(10,2),                        -- VALOR DO PRODUTO
    DESCRICAO VARCHAR(100),                     -- DESCRIÇÃO DO PRODUTO
    QUANTIDADE_PRODUTO INT,                     -- QUANTIDADE EM ESTOQUE
    COD_FORNECEDOR INT NOT NULL,                -- CÓDIGO DO FORNECEDOR
    PRIMARY KEY (COD_PRODUTO),                  -- CHAVE PRIMÁRIA
    FOREIGN KEY (COD_FORNECEDOR) REFERENCES FORNECEDORES(COD_FORNECEDOR)
);

-- ==============================================================
-- TABELA VENDAS
-- ==============================================================
CREATE TABLE IF NOT EXISTS VENDAS (
    COD_VENDA INT NOT NULL AUTO_INCREMENT,      -- CÓDIGO DA VENDA
    COD_PRODUTO INT NOT NULL,                   -- PRODUTO VENDIDO
    COD_FORNECEDOR INT NOT NULL,                -- FORNECEDOR DO PRODUTO
    PRIMARY KEY (COD_VENDA),                    -- CHAVE PRIMÁRIA
    FOREIGN KEY (COD_PRODUTO) REFERENCES PRODUTOS(COD_PRODUTO),
    FOREIGN KEY (COD_FORNECEDOR) REFERENCES FORNECEDORES(COD_FORNECEDOR)
);

-- ==============================================================
-- TABELA DEPARTAMENTOS
-- ==============================================================
CREATE TABLE IF NOT EXISTS DEPARTAMENTOS (
    COD_DEPARTAMENTO INT NOT NULL AUTO_INCREMENT,  -- CÓDIGO DO DEPARTAMENTO
    NOME_DEPARTAMENTO VARCHAR(100) NOT NULL,       -- NOME DO DEPARTAMENTO
    PRIMARY KEY (COD_DEPARTAMENTO)                 -- CHAVE PRIMÁRIA
);

-- ==============================================================
-- TABELA FUNCIONÁRIOS
-- ==============================================================
CREATE TABLE IF NOT EXISTS FUNCIONARIOS (
    COD_FUNCIONARIO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- CÓDIGO DO FUNCIONÁRIO
    NOME_FUNCIONARIO VARCHAR(100) NOT NULL,                    -- NOME DO FUNCIONÁRIO
    CARGO VARCHAR(100),                                        -- CARGO DO FUNCIONÁRIO
    CPF_FUNCIONARIO VARCHAR(14),
    ENDERECO_FUNCIONARIO VARCHAR(100),
    DATA_NASCIMENTO DATETIME NOT NULL,
    DATA_ADMISSAO DATETIME NOT NULL,
    DATA_RESCISAO DATETIME NOT NULL,
    SALARIO DECIMAL(10,2),                                     -- SALÁRIO DO FUNCIONÁRIO
    COD_DEPARTAMENTO INT NOT NULL,                              -- CÓDIGO DO DEPARTAMENTO
    FOREIGN KEY (COD_DEPARTAMENTO) REFERENCES DEPARTAMENTOS(COD_DEPARTAMENTO)
);

-- ==============================================================
-- ALTERAÇÕES NA TABELA FUNCIONÁRIOS
-- ==============================================================
-- Adiciona coluna ESTADO com valor padrão
ALTER TABLE FUNCIONARIOS
ADD COLUMN ESTADO CHAR(2) DEFAULT 'MG';

-- --------------------------------------------------------------
-- ALTERAÇÕES OPCIONAIS DE CHAVE PRIMÁRIA
-- --------------------------------------------------------------
-- Exemplo de chave composta (COD_FUNCIONARIO, CPF_FUNCIONARIO)
ALTER TABLE FUNCIONARIOS MODIFY COD_FUNCIONARIO INT NOT NULL;
ALTER TABLE FUNCIONARIOS MODIFY CPF_FUNCIONARIO VARCHAR(14) NOT NULL;
ALTER TABLE FUNCIONARIOS DROP PRIMARY KEY;
ALTER TABLE FUNCIONARIOS ADD PRIMARY KEY (COD_FUNCIONARIO, CPF_FUNCIONARIO);

-- ==============================================================
-- TABELA TIPO_PRODUTOS
-- ==============================================================
CREATE TABLE IF NOT EXISTS TIPO_PRODUTOS (
    COD_TIPO_PRODUTO INT AUTO_INCREMENT NOT NULL,
    TIPO_PRODUTO VARCHAR(225) NOT NULL,
    PRIMARY KEY (COD_TIPO_PRODUTO),
    INDEX IDX_TIPO_PRODUTO (TIPO_PRODUTO)
);

-- ==============================================================
-- ==============================================================
-- ==============================================================
-- MODELO FÍSICO PARA COMPRAS from BR MODELO**


CREATE TABLE IF NOT EXISTS CLIENTE (
    ID_CLIENTE INT AUTO_INCREMENT PRIMARY KEY,
    NOME_CLIENTE VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUTO (
    ID_PRODUTO INT AUTO_INCREMENT PRIMARY KEY,
    NOME_PRODUTO VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS COMPRA (
    ID_COMPRA INT AUTO_INCREMENT PRIMARY KEY,
    ID_PRODUTO INT NOT NULL,
    ID_CLIENTE INT NOT NULL,
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO),
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
);

-- ==============================================================
-- INSERÇÕES DE TESTE
-- ==============================================================
INSERT INTO CLIENTE (NOME_CLIENTE) VALUES ('Otavio');
INSERT INTO PRODUTO (NOME_PRODUTO) VALUES ('Teclado');
INSERT INTO COMPRA (ID_PRODUTO, ID_CLIENTE) VALUES (1, 1);

-- ==============================================================
-- TABELA VENDEDORES
-- ==============================================================
CREATE TABLE IF NOT EXISTS VENDEDORE (
    ID_VENDEDOR INT AUTO_INCREMENT PRIMARY KEY,
    NOME_VENDEDOR VARCHAR(100),
    SALARIO DECIMAL(10,2),
    FSALARIAL CHAR(1)
);


INSERT INTO VENDEDORES (NOME_VENDEDOR, SALARIO, FSALARIAL)
VALUES 
('Carlos Silva', 2500.00, 1),
('Ana Pereira', 3200.50, 2),
('João Santos', 2800.75, 1);

UPDATE VENDEDORES
SET SALARIO = 3150.00,
    FSALARIAL = 1;

UPDATE VENDEDORES
SET SALARIO = SALARIO * 1.10
WHERE FSALARIAL = 1;

UPDATE VENDEDORES
SET SALARIO = 3500.00
WHERE FSALARIAL = 3;


SELECT * FROM VENDEDORES;
	UPDATE VENDEDORES
SET SALARIO = 10000.00,
    FSALARIAL = 3
WHERE NOME_VENDEDOR = 'João Santos';



SELECT * FROM VENDEDORES WHERE NOME_VENDEDOR = 'João Santos';

TRUNCATE TABLE PRODUTO; -- APAGA A TABEA TODA

DELETE FROM PRODUTO WHERE ID_PRODUTO = 1;
DELETE FROM CLIENTES WHERE NOME_CLIENTE = 'BRUNO'
DELETE FROM VENDEDORES WHERE ID_VENDEDOR <=1; AND ID_VENDEDOR >=20