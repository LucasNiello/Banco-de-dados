-- ===================================================
-- Criação do banco de dados
-- ===================================================
CREATE DATABASE PlataformaCursosDB;  -- Cria o banco de dados
USE PlataformaCursosDB;               -- Seleciona o banco pra uso

-- ===================================================
-- Tabela Aluno
-- ===================================================
CREATE TABLE Aluno (
    id_aluno INT PRIMARY KEY,        -- Chave primaria do alino
    nome VARCHAR(100) NOT NULL,      -- Nome do aluno, obrigratório
    email VARCHAR(150),              -- Email do alino, pode ser nulo
    data_nasc DATE                   -- Data de nascimentoo
);

-- ===================================================
-- Tabela Curso
-- ===================================================
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,        -- Chave primária do curso
    nome_curso VARCHAR(150) NOT NULL,-- Nome do curso, obrgatorio
    descricao TEXT,                  -- Descrição detalhada do curso
    c_horaria INT NOT NULL,          -- Carga horaria do curso em horas
    status ENUM('ativo', 'inativo') DEFAULT 'ativo'  -- Status do curso
);

-- ===================================================
-- Tabela Inscricao
-- ===================================================
CREATE TABLE Inscricao (
    id_insc INT PRIMARY KEY,         -- Chave primaria da inscriçao
    id_aluno INT NOT NULL,           -- FK pra alino
    id_curso INT NOT NULL,           -- FK para curso
    data_insc DATE NOT NULL,         -- Data da inscripção
    FOREIGN KEY (id_aluno) REFERENCES Aluno (id_aluno),  -- Restrição FK
    FOREIGN KEY (id_curso) REFERENCES Curso (id_curso)   -- Restrição FK
);

-- ===================================================
-- Tabela Avaliacao
-- ===================================================
CREATE TABLE Avaliacao (
    id_avaliacao INT PRIMARY KEY,    -- Chave primária da avaliaçao
    id_insc INT UNIQUE NOT NULL,     -- FK pra inscriçao (1:1)
    nota DECIMAL(4, 2) NOT NULL,    -- Nota atribuda
    comentario TEXT,                 -- Comentario opcional
    FOREIGN KEY (id_insc) REFERENCES Inscricao (id_insc) -- Restrição FK
);

-- ===================================================
-- Verificação das tabelas criadas
-- ===================================================
USE PlataformaCursosDB;

SHOW TABLES;                        -- Lista todas as tabelas do banco

DESCRIBE Aluno;                      
DESCRIBE Curso;                      
DESCRIBE Inscricao;                  
DESCRIBE Avaliacao;                  

SHOW CREATE TABLE inscricao;          
SHOW CREATE TABLE avaliacao;          

-- ===================================================
-- Inserção de dados nas tabelas
-- ===================================================

-- Inserir alunos
INSERT INTO Aluno (id_aluno, nome, email, data_nasc)
VALUES 
(1, 'Ana Silva', 'ana@email.com', '2000-03-15'),
(2, 'Bruno Souza', 'bruno@email.com', '1998-07-22'),
(3, 'Carla Mendes', NULL, '2001-01-10'),
(4, 'Daniel Lima', 'daniel@email.com', '1999-11-05'),
(5, 'Eduarda Alves', 'eduarda@email.com', '2002-06-30');

-- Inserir cursos
INSERT INTO Curso (id_curso, nome_curso, descricao, c_horaria, status)
VALUES
(1, 'SQL Básico', 'Introdução ao SQL', 20, 'ativo'),
(2, 'Python Avançado', 'Programação em Python', 40, 'ativo'),
(3, 'JavaScript Intermediário', 'JS para Web', 30, 'ativo'),
(4, 'HTML e CSS', 'Front-end Básico', 25, 'ativo'),
(5, 'Gestão de Projetos', 'Metodologias ágeis', 35, 'inativo'); -- Curso inativo

-- Inserir inscrições
INSERT INTO Inscricao (id_insc, id_aluno, id_curso, data_insc)
VALUES
(1, 1, 1, '2025-09-26'),
(2, 2, 2, '2025-09-26'),
(3, 3, 3, '2025-09-26'),
(4, 4, 4, '2025-09-26'),
(5, 5, 1, '2025-09-26');

-- Inserir avaliações
INSERT INTO Avaliacao (id_avaliacao, id_insc, nota, comentario)
VALUES
(1, 1, 9.5, 'Excelente curso!'),
(2, 2, 8.0, 'Conteúdo bom, mas poderia ser mais pratico.'), -- exemplo de comentario com erro
(3, 3, 7.5, 'Aprendi bastante, mas algumas aulas foram rapidas.');

-- ===================================================
-- Consultas
-- ===================================================

-- Listar alunos com cursos ativos
SELECT a.nome, c.nome_curso
FROM Aluno a
JOIN Inscricao i ON a.id_aluno = i.id_aluno
JOIN Curso c ON i.id_curso = c.id_curso
WHERE c.status = 'ativo';

-- Média de notas por curso
SELECT c.nome_curso, AVG(av.nota) AS media_nota
FROM Avaliacao av
JOIN Inscricao i ON av.id_insc = i.id_insc
JOIN Curso c ON i.id_curso = c.id_curso
GROUP BY c.nome_curso;

-- Inserir avaliações restantes
INSERT INTO Avaliacao (id_avaliacao, id_insc, nota, comentario)
VALUES
(4, 4, 8.5, 'Otimo conteudo!'),
(5, 5, 9.0, 'Curso muito bem explicaddo.');

-- Total de alunos por curso
SELECT c.nome_curso, COUNT(i.id_insc) AS total_alunos
FROM Curso c
LEFT JOIN Inscricao i ON c.id_curso = i.id_curso
GROUP BY c.nome_curso;

-- Alunos sem avaliação
SELECT a.nome
FROM Aluno a
JOIN Inscricao i ON a.id_aluno = i.id_aluno
LEFT JOIN Avaliacao av ON i.id_insc = av.id_insc
WHERE av.id_insc IS NULL;

-- ==================================================
-- Atualização de dados
-- ==================================================

-- 1. Atualizar email de um aluno com o id_aluno = 1
UPDATE Aluno
SET email = 'novo_email@email.com'
WHERE id_aluno = 1;

-- 2. alterar a carga horaria do curso Python Avançado (id_curso = 2)
UPDATE Curso
SET c_horaria = 45
WHERE id_curso = 2;

-- 3. corrigir o nome de um aluno Carla Mendes id_aluno = 3
UPDATE Aluno
SET nome = 'Carla M. Mendes'
WHERE id_aluno = 3;

-- 4. Mudar status de um curso. Gestão de Projetos (id_curso = 5) para ativo
UPDATE Curso
SET status = 'ativo'
WHERE id_curso = 5;

-- 5. Alterar nota de uma avaliação. id_avaliacao = 3
UPDATE Avaliacao
SET nota = 9.0
WHERE id_avaliacao = 3;

-- ===================================================
-- Consultas de verificação
-- ===================================================

SELECT id_aluno, nome, email
FROM Aluno
WHERE id_aluno = 1;

SELECT id_curso, nome_curso, c_horaria
FROM Curso
WHERE id_curso = 2;

SELECT id_aluno, nome
FROM Aluno
WHERE id_aluno = 3;

SELECT id_curso, nome_curso, status
FROM Curso
WHERE id_curso = 5;

SELECT id_avaliacao, id_insc, nota
FROM Avaliacao
WHERE id_avaliacao = 3;

-- ===================================================
-- PARTE 5 — Exclusão de Dados
-- ===================================================

DELETE FROM Inscricao
WHERE id_insc = 5;

DELETE av
FROM Avaliacao av
JOIN Inscricao i ON av.id_insc = i.id_insc
WHERE i.id_curso = 5;

DELETE FROM Inscricao
WHERE id_curso = 5;

DELETE FROM Curso
WHERE id_curso = 5;

DELETE FROM Avaliacao
WHERE id_avaliacao = 2;

DELETE av
FROM Avaliacao av
JOIN Inscricao i ON av.id_insc = i.id_insc
WHERE i.id_aluno = 5;

DELETE FROM Inscricao
WHERE id_aluno = 5;

DELETE FROM Aluno
WHERE id_aluno = 5;

DELETE av
FROM Avaliacao av
JOIN Inscricao i ON av.id_insc = i.id_insc
WHERE i.id_curso = 3;

DELETE FROM Inscricao
WHERE id_curso = 3;

SELECT * FROM Inscricao; 
SELECT * FROM Curso;
SELECT * FROM Avaliacao;
SELECT * FROM Aluno;

-- ===================================================
-- PARTE 6 — Consultas com Critérios e Agrupamentos
-- ===================================================

SELECT * FROM Aluno;

SELECT nome, email
FROM Aluno;

SELECT * FROM Curso
WHERE c_horaria > 30;

SELECT * FROM Curso
WHERE status = 'inativo';

SELECT * FROM Aluno
WHERE YEAR(data_nasc) > 1995;

SELECT * FROM Avaliacao
WHERE nota > 9;

SELECT COUNT(*) AS total_cursos
FROM Curso;

SELECT * FROM Curso
ORDER BY c_horaria DESC
LIMIT 3;

-- ==================================================
-- PARTE 7 — Deafios extras
-- ==================================================

CREATE INDEX idx_email ON Aluno(email);

SELECT *
FROM Aluno
WHERE email = 'ana.silva@novoemail.com'; -- verficar indice
