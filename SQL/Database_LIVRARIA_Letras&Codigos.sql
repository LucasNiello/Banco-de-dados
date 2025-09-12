-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

-- Geração de Modelo Físico - MySQL

-- Passo 1: Criar e selecionar o banco de dados com um nome válido
CREATE DATABASE IF NOT EXISTS Livraria_Letras_E_Codigos;
USE Livraria_Letras_E_Codigos;

-- Passo 2: Criar as tabelas com os tipos de dados e relacionamentos corretos

-- Tabela de Autores
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- Tabela de Editoras
CREATE TABLE Editoras (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    cnpj VARCHAR(18) UNIQUE,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    contato_nome VARCHAR(100),
    telefone VARCHAR(20)
);

-- Tabela de Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_nascimento DATE
);

-- Tabela de Livros (com as chaves estrangeiras para Autores e Editoras)
CREATE TABLE Livros (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    id_autor_fk INT NOT NULL,
    id_editora_fk INT NOT NULL,
    genero VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    FOREIGN KEY (id_autor_fk) REFERENCES Autores(id_autor),
    FOREIGN KEY (id_editora_fk) REFERENCES Editoras(id_editora)
);

-- Tabela de Vendas (com a chave estrangeira para Clientes)
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente_fk INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente_fk) REFERENCES Clientes(id_cliente)
);

-- Tabela de Itens da Venda (com as chaves estrangeiras para Vendas e Livros)
CREATE TABLE ItensVenda (
    id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda_fk INT NOT NULL,
    id_livro_fk INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venda_fk) REFERENCES Vendas(id_venda),
    FOREIGN KEY (id_livro_fk) REFERENCES Livros(id_livro)
);


-- Passo 3: Comandos de manipulação de dados (DML) e consulta (DQL)

-- Inserindo dados iniciais (População do Banco)
INSERT INTO Autores (nome, nacionalidade, data_nascimento) VALUES
('Machado de Assis', 'Brasileiro', '1839-06-21'),
('J.K. Rowling', 'Britânica', '1965-07-31'),
('George Orwell', 'Britânico', '1903-06-25');

INSERT INTO Editoras (nome, cnpj, endereco, cidade, contato_nome, telefone) VALUES
('Rocco', '12.345.678/0001-99', 'Rua dos Bobos, 0', 'Rio de Janeiro', 'Carlos', '21-9999-8888'),
('Companhia das Letras', '98.765.432/0001-11', 'Av. Paulista, 2073', 'São Paulo', 'Ana', '11-8888-7777');

INSERT INTO Clientes (nome, cpf, email, telefone, data_nascimento) VALUES
('João Silva', '111.222.333-44', 'joao.silva@email.com', '11-1234-5678', '1990-05-15'),
('Maria Oliveira', '555.666.777-88', 'maria.o@email.com', '21-9876-5432', '1985-11-20');

INSERT INTO Livros (titulo, id_autor_fk, id_editora_fk, genero, preco, quantidade_estoque) VALUES
('Dom Casmurro', 1, 2, 'Romance', 45.50, 50),
('Harry Potter e a Pedra Filosofal', 2, 1, 'Fantasia', 59.90, 100),
('1984', 3, 2, 'Ficção Científica', 52.00, 30);

-- Consultas (Read)
-- Consultar todos os livros com nome do autor e editora
SELECT
    l.titulo,
    l.preco,
    a.nome AS autor,
    e.nome AS editora
FROM Livros l
INNER JOIN Autores a ON l.id_autor_fk = a.id_autor
INNER JOIN Editoras e ON l.id_editora_fk = e.id_editora;

-- Consultar livros com estoque baixo (menos de 40 unidades)
SELECT titulo, quantidade_estoque FROM Livros WHERE quantidade_estoque < 40;

-- Atualização (Update)
-- Atualizar o preço de um livro específico
UPDATE Livros
SET preco = 49.90
WHERE id_livro = 1; -- Supondo que 'Dom Casmurro' seja o ID 1

-- Simulação de Operações da Livraria
-- Cadastro de um novo autor (se necessário)
INSERT INTO Autores (nome, nacionalidade, data_nascimento) VALUES ('Clarice Lispector', 'Ucraniana-Brasileira', '1920-12-10');

-- Cadastro de um novo livro
INSERT INTO Livros (titulo, id_autor_fk, id_editora_fk, genero, preco, quantidade_estoque) VALUES
('A Hora da Estrela', 4, 2, 'Romance', 38.00, 60);

-- Registro de uma Venda
-- Simulando uma venda para o cliente 'João Silva' (id 1) comprando
-- 1 'Dom Casmurro' (id 1, preço 49.90) e 2 '1984' (id 3, preço 52.00)

-- Passo A: Inserir a venda com o valor total calculado (1*49.90 + 2*52.00 = 153.90)
INSERT INTO Vendas (id_cliente_fk, valor_total) VALUES (1, 153.90);

-- Pegar o ID da última venda
SET @id_ultima_venda = LAST_INSERT_ID();

-- Passo B: Inserir os itens na tabela ItensVenda
INSERT INTO ItensVenda (id_venda_fk, id_livro_fk, quantidade, preco_unitario) VALUES
(@id_ultima_venda, 1, 1, 49.90),
(@id_ultima_venda, 3, 2, 52.00);

-- Passo C: Atualizar o estoque dos livros vendidos
UPDATE Livros SET quantidade_estoque = quantidade_estoque - 1 WHERE id_livro = 1;
UPDATE Livros SET quantidade_estoque = quantidade_estoque - 2 WHERE id_livro = 3;

-- Relatórios
-- Relatório de Livros mais vendidos
SELECT
    l.titulo,
    SUM(iv.quantidade) AS total_vendido
FROM ItensVenda iv
INNER JOIN Livros l ON iv.id_livro_fk = l.id_livro
GROUP BY l.titulo
ORDER BY total_vendido DESC;

-- Relatório de Clientes ativos (que já fizeram compras)
SELECT DISTINCT
    c.nome,
    c.email,
    c.telefone
FROM Clientes c
INNER JOIN Vendas v ON c.id_cliente = v.id_cliente_fk;
