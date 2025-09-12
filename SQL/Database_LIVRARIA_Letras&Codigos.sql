Análise e Correção do Script SQL com Comentários de Estudo
Este é o script completo e correto que você deve usar no seu MySQL. Ele corrige todos os problemas mencionados anteriormente e segue o modelo de dados que definimos, agora com comentários detalhados para facilitar o aprendizado.

-- Geração de Modelo Físico - MySQL

-- Passo 1: Criar e selecionar o banco de dados com um nome válido
CREATE DATABASE IF NOT EXISTS Livraria_Letras_E_Codigos; -- Cria o banco de dados, mas apenas se ele ainda não existir.
USE Livraria_Letras_E_Codigos; -- Seleciona o banco de dados para que todos os comandos seguintes sejam executados nele.

-- Passo 2: Criar as tabelas com os tipos de dados e relacionamentos corretos

-- Tabela de Autores
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT, -- Chave primária: identificador único que se auto-incrementa a cada novo autor.
    nome VARCHAR(100) NOT NULL, -- NOT NULL significa que este campo é de preenchimento obrigatório.
    nacionalidade VARCHAR(50),
    data_nascimento DATE -- Tipo de dado específico para armazenar datas no formato 'AAAA-MM-DD'.
);

-- Tabela de Editoras
CREATE TABLE Editoras (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE, -- UNIQUE garante que não haverá duas editoras com o mesmo nome.
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
    cpf VARCHAR(14) NOT NULL UNIQUE, -- CPF também deve ser único para cada cliente.
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_nascimento DATE
);

-- Tabela de Livros (com as chaves estrangeiras para Autores e Editoras)
CREATE TABLE Livros (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    id_autor_fk INT NOT NULL, -- Esta será a chave estrangeira que liga o livro ao seu autor.
    id_editora_fk INT NOT NULL, -- Esta será a chave estrangeira que liga o livro à sua editora.
    genero VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL, -- DECIMAL é o tipo ideal para dinheiro, com 10 dígitos no total e 2 após a vírgula.
    quantidade_estoque INT NOT NULL,
    FOREIGN KEY (id_autor_fk) REFERENCES Autores(id_autor), -- Cria o relacionamento: id_autor_fk desta tabela referencia id_autor da tabela Autores.
    FOREIGN KEY (id_editora_fk) REFERENCES Editoras(id_editora) -- Cria o relacionamento com a tabela Editoras.
);

-- Tabela de Vendas (com a chave estrangeira para Clientes)
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente_fk INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- TIMESTAMP armazena data e hora. DEFAULT preenche automaticamente com o momento da criação.
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente_fk) REFERENCES Clientes(id_cliente) -- Liga a venda ao cliente que a realizou.
);

-- Tabela de Itens da Venda (tabela associativa que detalha os produtos de uma venda)
CREATE TABLE ItensVenda (
    id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda_fk INT NOT NULL, -- Chave estrangeira que aponta para a venda específica.
    id_livro_fk INT NOT NULL, -- Chave estrangeira que aponta para o livro vendido.
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL, -- Guarda o preço do livro no momento da venda, para histórico.
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

-- Note que os números '1', '2', '3' em id_autor_fk correspondem aos IDs dos autores inseridos acima.
INSERT INTO Livros (titulo, id_autor_fk, id_editora_fk, genero, preco, quantidade_estoque) VALUES
('Dom Casmurro', 1, 2, 'Romance', 45.50, 50),
('Harry Potter e a Pedra Filosofal', 2, 1, 'Fantasia', 59.90, 100),
('1984', 3, 2, 'Ficção Científica', 52.00, 30);

-- Consultas (Read)
-- Consultar todos os livros com nome do autor e editora
SELECT
    l.titulo, -- Seleciona a coluna 'titulo' da tabela Livros
    l.preco,
    a.nome AS autor, -- Seleciona a coluna 'nome' da tabela Autores e a renomeia para 'autor' no resultado.
    e.nome AS editora
FROM Livros l -- Define 'l' como um apelido para a tabela Livros, para facilitar a escrita.
INNER JOIN Autores a ON l.id_autor_fk = a.id_autor -- Junta com a tabela Autores onde a chave estrangeira e primária se correspondem.
INNER JOIN Editoras e ON l.id_editora_fk = e.id_editora; -- Faz o mesmo para a tabela Editoras.

-- Consultar livros com estoque baixo (menos de 40 unidades)
SELECT titulo, quantidade_estoque FROM Livros WHERE quantidade_estoque < 40; -- A cláusula WHERE filtra os resultados.

-- Atualização (Update)
-- Atualizar o preço de um livro específico
UPDATE Livros -- Indica qual tabela será atualizada.
SET preco = 49.90 -- Define o novo valor para a coluna 'preco'.
WHERE id_livro = 1; -- Cláusula OBRIGATÓRIA para especificar QUAL registro será alterado.

-- Simulação de Operações da Livraria
-- Cadastro de um novo autor (resultará no id_autor = 4)
INSERT INTO Autores (nome, nacionalidade, data_nascimento) VALUES ('Clarice Lispector', 'Ucraniana-Brasileira', '1920-12-10');

-- Cadastro de um novo livro usando o ID do novo autor
INSERT INTO Livros (titulo, id_autor_fk, id_editora_fk, genero, preco, quantidade_estoque) VALUES
('A Hora da Estrela', 4, 2, 'Romance', 38.00, 60);

-- Registro de uma Venda
-- Simulando uma venda para o cliente 'João Silva' (id 1) comprando
-- 1 'Dom Casmurro' (id 1, preço 49.90) e 2 '1984' (id 3, preço 52.00)

-- Passo A: Inserir a venda com o valor total calculado (1*49.90 + 2*52.00 = 153.90)
INSERT INTO Vendas (id_cliente_fk, valor_total) VALUES (1, 153.90);

-- Passo B: Pegar o ID da venda que acabamos de criar para usar na tabela de itens
SET @id_ultima_venda = LAST_INSERT_ID(); -- Função do MySQL que recupera o último ID gerado por AUTO_INCREMENT.

-- Passo C: Inserir os itens na tabela ItensVenda, ligando-os ao ID da venda
INSERT INTO ItensVenda (id_venda_fk, id_livro_fk, quantidade, preco_unitario) VALUES
(@id_ultima_venda, 1, 1, 49.90),
(@id_ultima_venda, 3, 2, 52.00);

-- Passo D: Atualizar o estoque dos livros vendidos
UPDATE Livros SET quantidade_estoque = quantidade_estoque - 1 WHERE id_livro = 1;
UPDATE Livros SET quantidade_estoque = quantidade_estoque - 2 WHERE id_livro = 3;

-- Relatórios
-- Relatório de Livros mais vendidos
SELECT
    l.titulo,
    SUM(iv.quantidade) AS total_vendido -- SUM() é uma função de agregação que soma todos os valores de 'quantidade'.
FROM ItensVenda iv
INNER JOIN Livros l ON iv.id_livro_fk = l.id_livro
GROUP BY l.titulo -- Agrupa as linhas por título para que o SUM() some as quantidades por livro.
ORDER BY total_vendido DESC; -- Ordena o resultado do maior para o menor total vendido.

-- Relatório de Clientes ativos (que já fizeram compras)
SELECT DISTINCT -- DISTINCT garante que cada cliente apareça apenas uma vez, mesmo que tenha feito várias compras.
    c.nome,
    c.email,
    c.telefone
FROM Clientes c
INNER JOIN Vendas v ON c.id_cliente = v.id_cliente_fk;
