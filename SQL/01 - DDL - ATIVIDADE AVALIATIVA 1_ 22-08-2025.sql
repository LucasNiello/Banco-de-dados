-- CRIAÇÃO DO BANCO
	CREATE DATABASE IF NOT EXISTS FDP_FabricaDeProdutos;
    USE FDP_FabricaDeProdutos;
    
    -- --------------------------------------------------
-- Tabela Cidade

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY AUTO_INCREMENT,
    Cnome VARCHAR(100),
    UF CHAR(2)
);
    
    -- --------------------------------------------------
    -- Tabela Fornecedor
-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    Fcod INT PRIMARY KEY AUTO_INCREMENT,
    Fnome VARCHAR(100),
    Status VARCHAR(10) DEFAULT 'Ativo',
    Fone VARCHAR(15),
    Ccod INT,
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)
    );
    
    -- --------------------------------------------------
    -- Tabela Peca
    
CREATE TABLE Peca (
    Pcod INT PRIMARY KEY AUTO_INCREMENT,
    Pnome VARCHAR(100) NOT NULL,
    Cor VARCHAR(50) NOT NULL,
    Peso DECIMAL(10,2) NOT NULL,
    Ccod INT NOT NULL,
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)
);
    -- --------------------------------------------------
    -- Tabela Projeto
CREATE TABLE Projeto (
    PRcod INT PRIMARY KEY AUTO_INCREMENT,
    PRnome VARCHAR(100),
    Ccod INT,
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod)
);
    
    -- --------------------------------------------------
    -- Tabela fornecimento
    
CREATE TABLE Fornecimento (
    Fcod INT,
    Pcod INT,
    PRcod INT,
    Quantidade INT,
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcod),
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcod),
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod)
);
    
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
CREATE INDEX idx_fornecedor_nome ON Fornecedor(Fnome);
CREATE INDEX idx_peca_cidade ON Peca(Ccod);
CREATE INDEX idx_projeto_cidade ON Projeto(Ccod);
CREATE INDEX idx_fornecimento ON Fornecimento(Fcod, Pcod, PRcod);


