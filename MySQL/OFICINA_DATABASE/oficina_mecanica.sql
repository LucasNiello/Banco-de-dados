-- ============================================
-- BANCO DE DADOS: OFICINA MECÂNICA
-- ============================================

-- Criar banco de dados
DROP DATABASE IF EXISTS oficina_mecanica;
CREATE DATABASE oficina_mecanica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE oficina_mecanica;

-- ============================================
-- DDL - CRIAÇÃO DE TABELAS
-- ============================================

-- Tabela: clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    estado CHAR(2),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_cpf (cpf),
    INDEX idx_nome (nome)
) ENGINE=InnoDB;

-- Tabela: veiculos
CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(8) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(30),
    km_atual INT DEFAULT 0,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    INDEX idx_placa (placa),
    INDEX idx_cliente (id_cliente)
) ENGINE=InnoDB;

-- Tabela: mecanicos
CREATE TABLE mecanicos (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    especialidade VARCHAR(100),
    salario DECIMAL(10,2),
    data_admissao DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_nome (nome)
) ENGINE=InnoDB;

-- Tabela: servicos (catálogo de serviços)
CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    valor_mao_obra DECIMAL(10,2) NOT NULL,
    tempo_estimado INT COMMENT 'Tempo em minutos',
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_nome (nome)
) ENGINE=InnoDB;

-- Tabela: pecas (estoque)
CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    marca VARCHAR(50),
    valor_unitario DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT DEFAULT 0,
    estoque_minimo INT DEFAULT 5,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_codigo (codigo),
    INDEX idx_nome (nome)
) ENGINE=InnoDB;

-- Tabela: ordens_servico
CREATE TABLE ordens_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    numero_os VARCHAR(20) UNIQUE NOT NULL,
    id_veiculo INT NOT NULL,
    data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME NULL,
    status ENUM('ABERTA', 'EM_ANDAMENTO', 'AGUARDANDO_PECAS', 'CONCLUIDA', 'CANCELADA') DEFAULT 'ABERTA',
    km_veiculo INT,
    defeito_relatado TEXT NOT NULL,
    observacoes TEXT,
    valor_total DECIMAL(10,2) DEFAULT 0.00,
    desconto DECIMAL(10,2) DEFAULT 0.00,
    valor_final DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo),
    INDEX idx_numero_os (numero_os),
    INDEX idx_status (status),
    INDEX idx_data (data_abertura)
) ENGINE=InnoDB;

-- Tabela: os_mecanicos (relacionamento N:N)
CREATE TABLE os_mecanicos (
    id_os_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_inicio DATETIME,
    data_fim DATETIME,
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os) ON DELETE CASCADE,
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id_mecanico),
    UNIQUE KEY unique_os_mecanico (id_os, id_mecanico)
) ENGINE=InnoDB;

-- Tabela: os_servicos (relacionamento N:N)
CREATE TABLE os_servicos (
    id_os_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os) ON DELETE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
) ENGINE=InnoDB;

-- Tabela: os_pecas (relacionamento N:N)
CREATE TABLE os_pecas (
    id_os_peca INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    FOREIGN KEY (id_os) REFERENCES ordens_servico(id_os) ON DELETE CASCADE,
    FOREIGN KEY (id_peca) REFERENCES pecas(id_peca)
) ENGINE=InnoDB;

-- ============================================
-- DML - INSERÇÃO DE DADOS
-- ============================================

-- Inserir Clientes
INSERT INTO clientes (nome, cpf, telefone, email, endereco, cidade, estado) VALUES
('João da Silva', '123.456.789-00', '(19) 98765-4321', 'joao.silva@email.com', 'Rua das Flores, 123', 'Campinas', 'SP'),
('Maria Santos', '987.654.321-00', '(19) 97654-3210', 'maria.santos@email.com', 'Av. Principal, 456', 'Campinas', 'SP'),
('Pedro Oliveira', '456.789.123-00', '(19) 96543-2109', 'pedro.oliveira@email.com', 'Rua do Comércio, 789', 'Valinhos', 'SP'),
('Ana Costa', '789.123.456-00', '(19) 95432-1098', 'ana.costa@email.com', 'Av. Brasil, 321', 'Campinas', 'SP'),
('Carlos Mendes', '321.654.987-00', '(19) 94321-0987', 'carlos.mendes@email.com', 'Rua São Paulo, 654', 'Indaiatuba', 'SP');

-- Inserir Veículos
INSERT INTO veiculos (id_cliente, placa, marca, modelo, ano, cor, km_atual) VALUES
(1, 'ABC-1234', 'Volkswagen', 'Gol', 2018, 'Prata', 45000),
(1, 'DEF-5678', 'Fiat', 'Uno', 2015, 'Branco', 78000),
(2, 'GHI-9012', 'Chevrolet', 'Onix', 2020, 'Preto', 35000),
(3, 'JKL-3456', 'Toyota', 'Corolla', 2019, 'Cinza', 42000),
(4, 'MNO-7890', 'Honda', 'Civic', 2021, 'Azul', 28000),
(5, 'PQR-1234', 'Ford', 'Ka', 2017, 'Vermelho', 56000);

-- Inserir Mecânicos
INSERT INTO mecanicos (nome, cpf, telefone, especialidade, salario, data_admissao) VALUES
('Roberto Mecânico', '111.222.333-44', '(19) 91111-1111', 'Motor e Transmissão', 3500.00, '2020-01-15'),
('Fernando Silva', '222.333.444-55', '(19) 92222-2222', 'Suspensão e Freios', 3200.00, '2019-06-20'),
('Lucas Santos', '333.444.555-66', '(19) 93333-3333', 'Elétrica', 3800.00, '2021-03-10'),
('Marcos Alves', '444.555.666-77', '(19) 94444-4444', 'Serviços Gerais', 2800.00, '2022-08-05');

-- Inserir Serviços (Catálogo)
INSERT INTO servicos (nome, descricao, valor_mao_obra, tempo_estimado) VALUES
('Troca de Óleo', 'Troca de óleo lubrificante e filtro', 80.00, 30),
('Alinhamento', 'Alinhamento de direção', 100.00, 45),
('Balanceamento', 'Balanceamento de rodas', 80.00, 30),
('Revisão Completa', 'Revisão de todos os sistemas', 350.00, 180),
('Troca de Pastilhas de Freio', 'Substituição das pastilhas dianteiras', 120.00, 60),
('Troca de Correia Dentada', 'Substituição da correia dentada', 200.00, 120),
('Diagnóstico Eletrônico', 'Análise via computador de bordo', 150.00, 60),
('Limpeza de Bicos Injetores', 'Limpeza ultrassônica', 180.00, 90);

-- Inserir Peças (Estoque)
INSERT INTO pecas (codigo, nome, descricao, marca, valor_unitario, quantidade_estoque, estoque_minimo) VALUES
('P001', 'Óleo Lubrificante 5W30', 'Óleo sintético 1L', 'Mobil', 45.00, 50, 10),
('P002', 'Filtro de Óleo', 'Filtro padrão', 'Mann', 25.00, 40, 8),
('P003', 'Filtro de Ar', 'Filtro de ar motor', 'Bosch', 35.00, 30, 6),
('P004', 'Pastilha de Freio Dianteira', 'Jogo completo', 'Fras-le', 180.00, 20, 4),
('P005', 'Pastilha de Freio Traseira', 'Jogo completo', 'Fras-le', 150.00, 20, 4),
('P006', 'Correia Dentada', 'Correia sincronizadora', 'Gates', 280.00, 10, 3),
('P007', 'Vela de Ignição', 'Vela comum', 'NGK', 18.00, 60, 12),
('P008', 'Bateria 60Ah', 'Bateria automotiva', 'Moura', 450.00, 8, 2),
('P009', 'Palheta Limpador', 'Par de palhetas', 'Bosch', 65.00, 25, 5),
('P010', 'Fluido de Freio', 'DOT 4 500ml', 'Mobil', 28.00, 35, 8);

-- Inserir Ordens de Serviço
INSERT INTO ordens_servico (numero_os, id_veiculo, km_veiculo, defeito_relatado, status, observacoes) VALUES
('OS-2024-001', 1, 45000, 'Troca de óleo preventiva', 'CONCLUIDA', 'Cliente solicita óleo sintético'),
('OS-2024-002', 3, 35000, 'Ruído ao frear', 'CONCLUIDA', 'Pastilhas desgastadas'),
('OS-2024-003', 4, 42000, 'Revisão dos 40 mil km', 'EM_ANDAMENTO', 'Revisão programada'),
('OS-2024-004', 2, 78000, 'Motor falhando', 'ABERTA', 'Cliente relata perda de potência'),
('OS-2024-005', 5, 28000, 'Bateria descarregando', 'AGUARDANDO_PECAS', 'Aguardando bateria nova');

-- Vincular Mecânicos às OS
INSERT INTO os_mecanicos (id_os, id_mecanico, data_inicio, data_fim) VALUES
(1, 1, '2024-11-01 08:00:00', '2024-11-01 09:00:00'),
(2, 2, '2024-11-02 10:00:00', '2024-11-02 11:30:00'),
(3, 1, '2024-11-05 08:00:00', NULL),
(3, 3, '2024-11-05 08:30:00', NULL),
(4, 1, '2024-11-10 14:00:00', NULL),
(5, 3, '2024-11-12 09:00:00', NULL);

-- Vincular Serviços às OS
INSERT INTO os_servicos (id_os, id_servico, quantidade, valor_unitario) VALUES
(1, 1, 1, 80.00),
(2, 5, 1, 120.00),
(3, 4, 1, 350.00),
(3, 1, 1, 80.00),
(4, 7, 1, 150.00);

-- Vincular Peças às OS
INSERT INTO os_pecas (id_os, id_peca, quantidade, valor_unitario) VALUES
(1, 1, 4, 45.00),
(1, 2, 1, 25.00),
(2, 4, 1, 180.00),
(3, 1, 4, 45.00),
(3, 2, 1, 25.00),
(3, 3, 1, 35.00),
(4, 7, 4, 18.00);

-- Atualizar valores das OS (usando função de agregação)
UPDATE ordens_servico os
SET valor_total = (
    SELECT COALESCE(SUM(oss.valor_total), 0) + COALESCE(SUM(osp.valor_total), 0)
    FROM (SELECT id_os, SUM(valor_total) as valor_total FROM os_servicos GROUP BY id_os) oss
    LEFT JOIN (SELECT id_os, SUM(valor_total) as valor_total FROM os_pecas GROUP BY id_os) osp 
    ON oss.id_os = osp.id_os
    WHERE oss.id_os = os.id_os
),
valor_final = valor_total - desconto;

-- ============================================
-- FUNÇÕES E PROCEDURES
-- ============================================

-- Procedure: Calcular total da OS
DELIMITER //
CREATE PROCEDURE calcular_total_os(IN p_id_os INT)
BEGIN
    DECLARE v_total_servicos DECIMAL(10,2);
    DECLARE v_total_pecas DECIMAL(10,2);
    
    SELECT COALESCE(SUM(valor_total), 0) INTO v_total_servicos
    FROM os_servicos WHERE id_os = p_id_os;
    
    SELECT COALESCE(SUM(valor_total), 0) INTO v_total_pecas
    FROM os_pecas WHERE id_os = p_id_os;
    
    UPDATE ordens_servico 
    SET valor_total = v_total_servicos + v_total_pecas,
        valor_final = (v_total_servicos + v_total_pecas) - desconto
    WHERE id_os = p_id_os;
END //
DELIMITER ;

-- Function: Contar OS por status
DELIMITER //
CREATE FUNCTION contar_os_por_status(p_status VARCHAR(20))
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM ordens_servico WHERE status = p_status;
    RETURN v_count;
END //
DELIMITER ;

-- ============================================
-- CONSULTAS ÚTEIS (EXEMPLOS)
-- ============================================

-- 1. Listar todas as OS com informações do cliente e veículo
SELECT 
    os.numero_os,
    os.status,
    c.nome AS cliente,
    CONCAT(v.marca, ' ', v.modelo, ' - ', v.placa) AS veiculo,
    os.data_abertura,
    os.valor_final
FROM ordens_servico os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
JOIN clientes c ON v.id_cliente = c.id_cliente
ORDER BY os.data_abertura DESC;

-- 2. Relatório de serviços por OS
SELECT 
    os.numero_os,
    s.nome AS servico,
    oss.quantidade,
    oss.valor_unitario,
    oss.valor_total
FROM os_servicos oss
JOIN ordens_servico os ON oss.id_os = os.id_os
JOIN servicos s ON oss.id_servico = s.id_servico;

-- 3. Peças com estoque abaixo do mínimo
SELECT codigo, nome, quantidade_estoque, estoque_minimo
FROM pecas
WHERE quantidade_estoque < estoque_minimo AND ativo = TRUE;

-- 4. Mecânicos e suas OS em andamento
SELECT 
    m.nome AS mecanico,
    os.numero_os,
    os.status,
    v.placa
FROM os_mecanicos osm
JOIN mecanicos m ON osm.id_mecanico = m.id_mecanico
JOIN ordens_servico os ON osm.id_os = os.id_os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
WHERE os.status IN ('ABERTA', 'EM_ANDAMENTO');

-- 5. Faturamento total por período
SELECT 
    DATE_FORMAT(data_conclusao, '%Y-%m') AS mes,
    COUNT(*) AS total_os,
    SUM(valor_final) AS faturamento
FROM ordens_servico
WHERE status = 'CONCLUIDA' AND data_conclusao IS NOT NULL
GROUP BY DATE_FORMAT(data_conclusao, '%Y-%m')
ORDER BY mes DESC;

/* =======================================================
                  EXERCICIOS SOMATIVA
   ======================================================= */


/* =======================================================
   1. SELECT (Consultas Básicas)
   ======================================================= */

-- 1.1 Veículos da marca Ford
SELECT *
FROM veiculos
WHERE marca = 'Ford';

-- 1.2 Clientes que abriram OS nos últimos 6 meses
SELECT DISTINCT c.*
FROM clientes c
JOIN veiculos v ON v.id_cliente = c.id_cliente
JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
WHERE os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 1.3 Mecânicos com especialidade "Injeção Eletrônica"
SELECT *
FROM mecanicos
WHERE especialidade = 'Injeção Eletrônica';

-- 1.4 Ordens de Serviço com status "Aguardando peça"
SELECT *
FROM ordens_servico
WHERE status = 'AGUARDANDO_PECAS';

-- 1.5 Peças com estoque abaixo de 5 unidades
SELECT *
FROM pecas
WHERE quantidade_estoque < 5;

-- 1.6 Veículos que já tiveram mais de uma OS (subconsulta correlacionada)
SELECT v.*
FROM veiculos v
WHERE (
    SELECT COUNT(*)
    FROM ordens_servico os
    WHERE os.id_veiculo = v.id_veiculo
) > 1;

-- 1.7 OS executadas por um mecânico específico
SELECT os.*
FROM ordens_servico os
JOIN os_mecanicos om ON os.id_os = om.id_os
WHERE om.id_mecanico = 3;

-- 1.8 (Desafio) Peças cujo valor_unitario é maior que a média
SELECT nome, valor_unitario
FROM pecas
WHERE valor_unitario > (SELECT AVG(valor_unitario) FROM pecas);



/* =======================================================
   2. UPDATE (Atualização de Dados)
   ======================================================= */

-- 2.1 Aumento de 5% nas peças da marca "Bosch"
UPDATE pecas
SET valor_unitario = valor_unitario * 1.05
WHERE marca = 'Bosch';

-- 2.2 Alterar status da OS 105 para "Concluída"
UPDATE ordens_servico
SET status = 'CONCLUIDA'
WHERE id_os = 105;

-- 2.3 Atualizar data_conclusao de OS em andamento abertas há +30 dias
UPDATE ordens_servico
SET data_conclusao = NOW()
WHERE status = 'EM_ANDAMENTO'
  AND data_abertura < DATE_SUB(NOW(), INTERVAL 30 DAY);

-- 2.4 (Desafio) Dobrar estoque da peça com id_peca = 20
UPDATE pecas
SET quantidade_estoque = quantidade_estoque * 2
WHERE id_peca = 20;



/* =======================================================
   3. ALTER TABLE (Modificação da Estrutura)
   ======================================================= */

-- 3.1 Adicionar coluna email (caso não exista)
ALTER TABLE clientes
ADD COLUMN email VARCHAR(100);

-- 3.2 Alterar tamanho da coluna especialidade
ALTER TABLE mecanicos
MODIFY especialidade VARCHAR(150);

-- 3.3 Remover coluna diagnostico_entrada
ALTER TABLE ordens_servico
DROP COLUMN diagnostico_entrada;

-- 3.4 (Desafio) Adicionar CHECK: valor_unitario >= 0
ALTER TABLE pecas
ADD CONSTRAINT chk_valor_unitario CHECK (valor_unitario >= 0);



/* =======================================================
   4. JOIN (Consultas com Multiplas tabelas)
   ======================================================= */

-- 4.1 OS + cliente + placa + data abertura
SELECT 
    os.id_os,
    os.numero_os,
    c.nome AS cliente,
    v.placa AS veiculo,
    os.data_abertura
FROM ordens_servico os
JOIN veiculos v ON v.id_veiculo = os.id_veiculo
JOIN clientes c ON c.id_cliente = v.id_cliente;

-- 4.2 Peças usadas na OS 50
SELECT 
    p.nome AS peca,
    op.quantidade
FROM os_pecas op
JOIN pecas p ON op.id_peca = p.id_peca
WHERE op.id_os = 50;

-- 4.3 Mecânicos que trabalharam na OS 75
SELECT 
    m.nome
FROM os_mecanicos om
JOIN mecanicos m ON m.id_mecanico = om.id_mecanico
WHERE om.id_os = 75;

-- 4.4 (Desafio) Veículos + nome do proprietário
SELECT 
    v.placa,
    v.modelo,
    c.nome AS proprietario
FROM veiculos v
JOIN clientes c ON c.id_cliente = v.id_cliente;

/* =======================================================
   5. INNER JOIN (Apenas interseções)
   ======================================================= */

-- 5.1 Veículos com OS "Em Execução" (no banco → EM_ANDAMENTO)
SELECT v.placa, v.modelo
FROM veiculos v
INNER JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
WHERE os.status = 'EM_ANDAMENTO';

-- 5.2 Nome dos clientes com veículos Volkswagen
SELECT DISTINCT c.nome
FROM clientes c
INNER JOIN veiculos v ON v.id_cliente = c.id_cliente
WHERE v.marca = 'Volkswagen';

-- 5.3 Mecânicos que já trabalharam em pelo menos uma OS
SELECT DISTINCT m.nome
FROM mecanicos m
INNER JOIN os_mecanicos om ON om.id_mecanico = m.id_mecanico;

-- 5.4 (Desafio) Serviços que já foram executados
SELECT DISTINCT s.nome
FROM servicos s
INNER JOIN os_servicos oss ON oss.id_servico = s.id_servico;



/* =======================================================
   6. LEFT JOIN (Priorizando a esquerda)
   ======================================================= */

-- 6.1 Todos os clientes + IDs das OS (clientes sem OS devem aparecer)
SELECT c.nome, os.id_os
FROM clientes c
LEFT JOIN veiculos v ON v.id_cliente = c.id_cliente
LEFT JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo;

-- 6.2 Mecânicos + quantidade de OS trabalhadas (incluindo novatos)
SELECT 
    m.nome,
    COUNT(om.id_os) AS total_os
FROM mecanicos m
LEFT JOIN os_mecanicos om ON om.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico, m.nome;

-- 6.3 Todas as peças + quantidade total vendida (ou zero)
SELECT 
    p.nome,
    COALESCE(SUM(op.quantidade), 0) AS total_vendida
FROM pecas p
LEFT JOIN os_pecas op ON op.id_peca = p.id_peca
GROUP BY p.id_peca, p.nome;

-- 6.4 (Desafio) Todos os veículos + data da última OS
SELECT 
    v.placa,
    v.modelo,
    MAX(os.data_abertura) AS ultima_os
FROM veiculos v
LEFT JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
GROUP BY v.id_veiculo, v.placa, v.modelo;



/* =======================================================
   7. RIGHT JOIN (Priorizando a direita)
   ======================================================= */

-- 7.1 Todas as OS + nome do cliente
-- (inverso do LEFT JOIN de clientes)
SELECT 
    os.id_os,
    c.nome AS cliente
FROM clientes c
RIGHT JOIN veiculos v ON v.id_cliente = c.id_cliente
RIGHT JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo;

-- 7.2 Todos os serviços + IDs das OS onde foram usados
SELECT 
    s.nome,
    oss.id_os
FROM servicos s
RIGHT JOIN os_servicos oss ON oss.id_servico = s.id_servico;

-- 7.3 Todos os OS_Mecanicos + nome do mecânico
SELECT 
    om.*,
    m.nome
FROM os_mecanicos om
RIGHT JOIN mecanicos m ON m.id_mecanico = om.id_mecanico;

-- 7.4 (Desafio) Veículos (direita) + OS associadas (esquerda)
SELECT 
    v.placa,
    v.modelo,
    os.id_os
FROM ordens_servico os
RIGHT JOIN veiculos v ON v.id_veiculo = os.id_veiculo;



/* =======================================================
   8. SUBCONSULTAS (SUBQUERIES)
   ======================================================= */

-- 8.1 Clientes com mais de 3 OS
SELECT c.*
FROM clientes c
WHERE (
    SELECT COUNT(*)
    FROM veiculos v
    JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
    WHERE v.id_cliente = c.id_cliente
) > 3;

-- 8.2 Peças usadas em OS do mecânico "Carlos" (ID 4)
SELECT DISTINCT p.nome
FROM pecas p
WHERE p.id_peca IN (
    SELECT op.id_peca
    FROM os_pecas op
    WHERE op.id_os IN (
        SELECT om.id_os
        FROM os_mecanicos om
        WHERE om.id_mecanico = 4
    )
);

-- 8.3 Veículos que nunca tiveram OS
SELECT 
    v.placa,
    v.modelo
FROM veiculos v
WHERE v.id_veiculo NOT IN (
    SELECT id_veiculo
    FROM ordens_servico
);

-- 8.4 (Desafio) Serviços cujo valor_mao_obra > média geral
SELECT *
FROM servicos
WHERE valor_mao_obra > (
    SELECT AVG(valor_mao_obra)
    FROM servicos
);

/* =======================================================
   9. AGREGAÇÃO (SUM, COUNT, AVG, GROUP BY)
   ======================================================= */

-- 9.1 Faturamento total de uma OS específica (ID 100)
SELECT 
    (SELECT COALESCE(SUM(valor_total), 0)
     FROM os_servicos
     WHERE id_os = 100)
  + (SELECT COALESCE(SUM(valor_total), 0)
     FROM os_pecas
     WHERE id_os = 100)
  AS faturamento_total;

-- 9.2 Tempo médio (em dias) que as OS ficam abertas
SELECT AVG(DATEDIFF(data_conclusao, data_abertura)) AS tempo_medio_dias
FROM ordens_servico
WHERE data_conclusao IS NOT NULL;



/* =======================================================
   9.1 AGREGAÇÕES SIMPLES
   ======================================================= */

-- Número total de veículos cadastrados
SELECT COUNT(*) AS total_veiculos
FROM veiculos;

-- Valor total do inventário (estoque)
-- Obs: banco não tem preco_custo → adaptado usando valor_unitario
SELECT SUM(quantidade_estoque * valor_unitario) AS valor_total_estoque
FROM pecas;

-- Preço médio da mão de obra (tabela Servicos)
SELECT AVG(valor_mao_obra) AS preco_medio_mao_obra
FROM servicos;



/* =======================================================
   9.2 AGRUPAMENTO (GROUP BY)
   ======================================================= */

-- Veículos por marca
SELECT marca, COUNT(*) AS total
FROM veiculos
GROUP BY marca;

-- Número de OS abertas por mês
SELECT 
    MONTH(data_abertura) AS mes,
    COUNT(*) AS total_os
FROM ordens_servico
GROUP BY MONTH(data_abertura);

-- Contagem de OS por status
SELECT 
    status,
    COUNT(*) AS total
FROM ordens_servico
GROUP BY status;



/* =======================================================
   9.3 AGREGAÇÕES COM FILTRO (WHERE)
   ======================================================= */

-- Número total de OS concluídas
SELECT COUNT(*) AS total_concluidas
FROM ordens_servico
WHERE status = 'CONCLUIDA';

-- Faturamento total dos veículos Fiat no último ano
SELECT 
    SUM(oss.valor_total) + SUM(osp.valor_total) AS faturamento_total
FROM ordens_servico os
JOIN veiculos v ON v.id_veiculo = os.id_veiculo
LEFT JOIN os_servicos oss ON oss.id_os = os.id_os
LEFT JOIN os_pecas osp ON osp.id_os = os.id_os
WHERE v.marca = 'Fiat'
  AND os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Preço médio da mão de obra de serviços de "Motor"
SELECT AVG(valor_mao_obra) AS media_motor
FROM servicos
WHERE nome LIKE '%Motor%';



/* =======================================================
   9.4 HAVING (Condições após o agrupamento)
   ======================================================= */

-- Clientes que já gastaram mais de R$ 5.000,00
SELECT 
    c.id_cliente,
    c.nome,
    SUM(os.valor_final) AS total_gasto
FROM clientes c
JOIN veiculos v ON v.id_cliente = c.id_cliente
JOIN ordens_servico os ON os.id_veiculo = v.id_veiculo
GROUP BY c.id_cliente, c.nome
HAVING total_gasto > 5000;

-- Peças vendidas mais de 100 vezes no total
SELECT 
    id_peca,
    SUM(quantidade) AS total_vendida
FROM os_pecas
GROUP BY id_peca
HAVING total_vendida > 100;

-- Especialidades dos mecânicos que trabalharam em mais de 20 OS
SELECT 
    m.especialidade,
    COUNT(om.id_os) AS total_os
FROM mecanicos m
JOIN os_mecanicos om ON om.id_mecanico = m.id_mecanico
GROUP BY m.especialidade
HAVING total_os > 20;

-- (Desafio) Mecânico que mais trabalhou em OS
SELECT 
    m.nome,
    COUNT(om.id_os) AS total_os
FROM mecanicos m
JOIN os_mecanicos om ON om.id_mecanico = m.id_mecanico
GROUP BY m.id_mecanico, m.nome
ORDER BY total_os DESC
LIMIT 1;



/* =======================================================
   10. INDEXAÇÃO
   ======================================================= */

-- 10.1 Criar índice para consulta por placa
CREATE INDEX idx_placa ON veiculos (placa);

-- 10.2 Explicação:
-- O JOIN entre ordens_servico e veiculos é rápido porque:
-- → id_veiculo é uma chave estrangeira e já está indexada.
-- Sem índice: o MySQL faria uma varredura completa (FULL SCAN),
-- deixando o JOIN extremamente lento em tabelas grandes.

-- Criar índice na chave estrangeira (se não existir)
CREATE INDEX idx_os_id_veiculo ON ordens_servico (id_veiculo);

-- 10.3 (Desafio) Índice composto
-- Um índice composto (id_os, id_peca) é mais eficiente para consultas
-- que filtram por AMBOS ao mesmo tempo, pois só um índice resolve.
-- Exemplo:
-- CREATE UNIQUE INDEX idx_os_peca ON os_pecas (id_os, id_peca);
