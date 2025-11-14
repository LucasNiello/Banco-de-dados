-- ---
-- 1. CRIAÇÃO DO BANCO DE DADOS
-- ---
CREATE DATABASE IF NOT EXISTS oficina_mecanica
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

USE oficina_mecanica;

-- ---
-- 2. TABELAS PRINCIPAIS (Entidades Fortes)
-- ---

-- (Critério 3: Utilizar tipos de dados)
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(255),
    cpf VARCHAR(14) UNIQUE
);

CREATE TABLE Mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    especialidade VARCHAR(100)
);

CREATE TABLE Pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome_peca VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10, 2) NOT NULL, -- Ex: 150.50
    quantidade_estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE Servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    valor_mao_obra DECIMAL(10, 2) NOT NULL -- Ex: 100.00
);

-- ---
-- 3. TABELAS DEPENDENTES (Com Chaves Estrangeiras 1:N)
-- ---

-- (Critério 5: Utilizar relacionamentos entre tabelas)
CREATE TABLE Veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(8) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT,
    cor VARCHAR(30),
    
    -- Relacionamento: Um Veículo pertence a um Cliente (1:N)
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Ordens_Servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    status_os VARCHAR(30) NOT NULL DEFAULT 'Aberta',
    descricao_problema TEXT NOT NULL,
    diagnostico_tecnico TEXT,
    
    -- Relacionamento: Uma OS é aberta para um Veículo (1:N)
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);

-- ---
-- 4. TABELAS ASSOCIATIVAS (Relacionamentos N:M)
-- ---

CREATE TABLE OS_Mecanicos (
    -- Chaves que formam a ligação
    id_os INT NOT NULL,
    id_mecanico INT NOT NULL,
    
    -- Chaves Estrangeiras
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanicos(id_mecanico),
    
    -- Chave Primária Composta (Impede duplicatas)
    PRIMARY KEY (id_os, id_mecanico)
);

CREATE TABLE OS_Servicos (
    id_os_servico INT AUTO_INCREMENT PRIMARY KEY, -- Chave própria
    
    -- Chaves que formam a ligação
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    
    -- Chaves Estrangeiras
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
);

CREATE TABLE OS_Pecas (
    id_os_peca INT AUTO_INCREMENT PRIMARY KEY, -- Chave própria
    
    -- Chaves que formam a ligação
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    
    -- Atributo do relacionamento
    quantidade_utilizada INT NOT NULL DEFAULT 1, 
    
    -- Chaves Estrangeiras
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Pecas(id_peca)
);