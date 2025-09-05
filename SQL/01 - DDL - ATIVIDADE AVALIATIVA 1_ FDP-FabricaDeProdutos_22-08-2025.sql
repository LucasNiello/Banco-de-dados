-- CRIAÇÃO DO BANCO DE DADOS
	CREATE DATABASE IF NOT EXISTS FDP_FabricaDeProdutos;  -- Cria o banco de dados caso ele não exista
    USE FDP_FabricaDeProdutos;  -- Define o banco de dados a ser utilizado
    -- Sempre que abrir o banco de dados execute USE "data base".
    
    -- --------------------------------------------------
-- Tabela Cidade

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY AUTO_INCREMENT,  -- Código único da cidade, chave primária, gerado automaticamente (AUTO_INCREMENT)
    Cnome VARCHAR(100),                   -- Nome da cidade, até 100 caracteres
    UF CHAR(2)                            -- Unidade Federativa (estado), com 2 caracteres (ex: SP, RJ)
);
    
    -- --------------------------------------------------
    -- Tabela Fornecedor
-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    Fcod INT PRIMARY KEY AUTO_INCREMENT,  -- Código único do fornecedor, chave primária, gerado automaticamente
    Fnome VARCHAR(100),                   -- Nome do fornecedor
    Status VARCHAR(10) DEFAULT 'Ativo',   -- Situação do fornecedor, padrão é 'Ativo'
    Fone VARCHAR(15),                     -- Telefone do fornecedor, até 15 caracteres
    Ccod INT,                             -- Código da cidade (chave estrangeira)
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)  -- Relaciona fornecedor à tabela Cidade
    );
    
    -- --------------------------------------------------
    -- Tabela Peca
    
CREATE TABLE Peca (
    Pcod INT PRIMARY KEY AUTO_INCREMENT,  -- Código único da peça, chave primária, gerado automaticamente
    Pnome VARCHAR(100) NOT NULL,          -- Nome da peça, obrigatório (NOT NULL = não pode ficar em branco)
    Cor VARCHAR(50) NOT NULL,             -- Cor da peça, obrigatório
    Peso DECIMAL(10,2) NOT NULL,          -- Peso da peça, obrigatório, com 10 dígitos no total e 2 casas decimais
    Ccod INT NOT NULL,                    -- Código da cidade, obrigatório
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)  -- Relaciona peça à tabela Cidade
);
    -- --------------------------------------------------
    -- Tabela Projeto
CREATE TABLE Projeto (
    PRcod INT PRIMARY KEY AUTO_INCREMENT, -- Código único do projeto, chave primária, gerado automaticamente
    PRnome VARCHAR(100),                  -- Nome do projeto
    Ccod INT,                             -- Código da cidade
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)  -- Relaciona projeto à tabela Cidade
);
    
    -- --------------------------------------------------
    -- Tabela fornecimento
    
CREATE TABLE Fornecimento (
    Fcod INT,                             -- Código do fornecedor (chave estrangeira)
    Pcod INT,                             -- Código da peça (chave estrangeira)
    PRcod INT,                            -- Código do projeto (chave estrangeira)
    Quantidade INT,                       -- Quantidade fornecida
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcod),  -- Relaciona com Fornecedor
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcod),        -- Relaciona com Peça
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod)    -- Relaciona com Projeto
);
-- cod = codigo
    
    -- --------------------------------------------------
    -- EXERCICIO 3
    -- INSERINDO COISAS
    
    -- Inserindo cidades
INSERT INTO Cidade (Cnome, UF) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG');

-- Inserindo fornecedores
INSERT INTO Fornecedor (Fnome, Fone, Ccod) VALUES
('Fornecedor Alfa', '1111-2222', 1),
('Fornecedor Beta', '3333-4444', 2),
('Fornecedor Gama', '5555-6666', 3);

-- Inserindo peças
INSERT INTO Peca (Pnome, Cor, Peso, Ccod) VALUES
('Parafuso', 'Prata', 0.05, 1),
('Porca', 'Preta', 0.03, 2),
('Arruela', 'Cinza', 0.02, 3);

-- Inserindo projetos
INSERT INTO Projeto (PRnome, Ccod) VALUES
('Projeto A', 1),
('Projeto B', 2),
('Projeto C', 3);

-- Inserindo fornecimentos
INSERT INTO Fornecimento (Fcod, Pcod, PRcod, Quantidade) VALUES
(1, 1, 1, 1000),
(2, 2, 2, 2000),
(3, 3, 3, 1500);

-- --------------------------------------------------
-- Exercício 4 - CRIANDO ÍNDICES PARA CONSULTAS RÁPIDAS

-- Índices em campos importantes
CREATE INDEX idx_fornecedor_nome ON Fornecedor(Fnome);        -- Índice para buscas rápidas por nome do fornecedor
CREATE INDEX idx_peca_cidade ON Peca(Ccod);                   -- Índice para facilitar buscas de peças por cidade
CREATE INDEX idx_projeto_cidade ON Projeto(Ccod);             -- Índice para facilitar buscas de projetos por cidade
CREATE INDEX idx_fornecimento ON Fornecimento(Fcod, Pcod, PRcod); -- Índice composto para consultas rápidas no fornecimento

-- --------------------------------------------------
-- Sempre que abrir o banco de dados execute USE "data base".
-- --------------------------------------------------
-- atividades de alteração das tabelas:

-- Alterações parte 2
SHOW TABLES;

-- Consulta de tabelas especificas
SELECT Fnome FROM Fornecedor;

/*==============================================================
  ==============================================================*/
-- Formas de comentários

-- Este é um comentário de linha (vai até o fim da linha)

# Também pode usar hashtag em MySQL (mas não é padrão em todos os SGBDs)

 /* 
   Este é um comentário de múltiplas linhas.
   Pode ocupar várias linhas seguidas.
 */

/*
ALTER TABLE Fornecedor
	ADD COLUMN Ccod INT NOT NULL;
    
ALTER TABLE Fornecedor
	ADD CONSTRAINT FK_Ccod_Fornecedor
    FOREIGN KEY (Ccod) REFERENCES Cidade (Ccod);
    
    SHOW CREATE TABLE Fornecedor;
*/

-- ==============================================================
-- Inserir informações:
-- ==============================================================
    
-- Tabela cidade (sem AUTO INCREMENT)
INSERT INTO cidade
VALUES (11, 'Limeira', 'SP'), (12, 'Cordeirópolis', 'SP'), (14, 'Santa Gertrudes', 'SP');

-- Tabela cidade (com AUTO INCREMENT)
INSERT INTO cidade (Cnome, UF)  -- Aqui vc seleciona a coluna que vc vai alterar na tabela,
VALUES ('Americana', 'SP'), ('Rio Claro', 'SP'), ('Cosmópolis', 'SP');
-- Agora o MySQL sabe que você quer que ele gere o Ccod automaticamente.

-- ==============================================================
-- INSERIR INFORMAÇÕES COMPLETAS COM AUTO_INCREMENT
-- ==============================================================

-- Tabela Cidade
INSERT INTO Cidade (Cnome, UF)
VALUES 
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Limeira', 'SP'),
('Cordeirópolis', 'SP'),
('Santa Gertrudes', 'SP'),
('Americana', 'SP'),
('Rio Claro', 'SP'),
('Cosmópolis', 'SP');

-- --------------------------------------------------
-- Tabela Fornecedor
INSERT INTO Fornecedor (Fnome, Fone, Ccod)
VALUES
('Fornecedor Alfa', '1111-2222', 1),
('Fornecedor Beta', '3333-4444', 2),
('Fornecedor Gama', '5555-6666', 3),
('Fornecedor Delta', '7777-8888', 4),
('Fornecedor Épsilon', '9999-0000', 5),
('Fornecedor Zeta', '2222-3333', 6);

-- --------------------------------------------------
-- Tabela Peca
INSERT INTO Peca (Pnome, Cor, Peso, Ccod)
VALUES
('Parafuso', 'Prata', 0.05, 1),
('Porca', 'Preta', 0.03, 2),
('Arruela', 'Cinza', 0.02, 3),
('Engrenagem', 'Prata', 0.15, 1),
('Rolamento', 'Cinza', 0.20, 2),
('Eixo', 'Preto', 0.50, 3);

-- --------------------------------------------------
-- Tabela Projeto
INSERT INTO Projeto (PRnome, Ccod)
VALUES
('Projeto A', 1),
('Projeto B', 2),
('Projeto C', 3),
('Projeto D', 4),
('Projeto E', 5),
('Projeto F', 6);

-- --------------------------------------------------
-- Tabela Fornecimento
INSERT INTO Fornecimento (Fcod, Pcod, PRcod, Quantidade)
VALUES
(1, 1, 1, 1000),
(2, 2, 2, 2000),
(3, 3, 3, 1500),
(4, 4, 4, 500),
(5, 5, 5, 800),
(6, 6, 6, 1200);

-- ==============================================================
-- Verificar o ultimo valor inserido de id (por causa do NOT NULL):
SELECT last_insert_id();


