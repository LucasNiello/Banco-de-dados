
-- 1. Selecionar o banco de dados
USE oficina_mecanica;

-- ---
-- 2. Inserir dados nos "Catálogos" (Tabelas sem dependências)
-- ---

INSERT INTO Clientes (nome, telefone, email, cpf) VALUES 
('João Silva', '11988887777', 'joao@email.com', '111.222.333-44'),
('Maria Souza', '19977776666', 'maria@email.com', '555.666.777-88'),
('Ricardo Almeida', '21955554444', 'ricardo@email.com', '888.999.000-11');

INSERT INTO Mecanicos (nome, cpf, especialidade) VALUES 
('Carlos Pereira', '999.888.777-11', 'Motor e Injeção'),
('Ana Beatriz', '123.456.789-00', 'Suspensão e Freios'),
('Marcos Totti', '321.654.987-01', 'Elétrica e Ar Condicionado');

INSERT INTO Pecas (nome_peca, preco_unitario, quantidade_estoque) VALUES 
('Filtro de Óleo - Modelo A', 45.00, 50),
('Pastilha de Freio Dianteira (Par)', 120.50, 30),
('Óleo Motor 5W30 Sintético (Litro)', 65.00, 100),
('Vela de Ignição (Unidade)', 35.75, 80);

INSERT INTO Servicos (nome_servico, valor_mao_obra) VALUES 
('Troca de Óleo e Filtro', 80.00),
('Troca de Pastilhas de Freio', 90.00),
('Alinhamento e Balanceamento', 120.00),
('Diagnóstico de Injeção Eletrônica', 150.00);

-- ---
-- 3. Inserir dados nas tabelas dependentes (1:N)
-- ---

-- Assumindo que os IDs de Clientes são 1 (João) e 2 (Maria)
INSERT INTO Veiculos (id_cliente, placa, modelo, marca, ano) VALUES 
(1, 'ABC1234', 'Gol', 'Volkswagen', 2018), -- Veículo 1 (do João)
(2, 'XYZ7890', 'Corolla', 'Toyota', 2022), -- Veículo 2 (da Maria)
(1, 'DEF5678', 'Onix', 'Chevrolet', 2020); -- Veículo 3 (do João também)

-- ---
-- 4. Simular a Ação: Abrir Ordens de Serviço
-- ---

-- Assumindo que os IDs de Veículos são 1 (Gol) e 2 (Corolla)
INSERT INTO Ordens_Servico (id_veiculo, descricao_problema, status_os) VALUES 
(1, 'Revisão geral, barulho no freio dianteiro.', 'Em Andamento'), -- OS #1
(2, 'Troca de óleo de rotina.', 'Concluída'); -- OS #2

-- ---
-- 5. Ligar os itens às Ordens de Serviço (Tabelas N:M)
-- ---

-- Ligar Mecânicos às OS
-- Assumindo que as OS são 1 e 2; Mecânicos são 1 (Carlos) e 2 (Ana)
INSERT INTO OS_Mecanicos (id_os, id_mecanico) VALUES 
(1, 1), -- OS 1: Carlos (Motor)
(1, 2); -- OS 1: Ana (Freios)

INSERT INTO OS_Mecanicos (id_os, id_mecanico) VALUES 
(2, 1); -- OS 2: Apenas Carlos (Motor)

-- Ligar Serviços às OS
-- Assumindo que os Serviços são 1 (Troca Óleo) e 2 (Troca Pastilha)
INSERT INTO OS_Servicos (id_os, id_servico) VALUES 
(1, 1), -- OS 1: Fez Troca de Óleo
(1, 2); -- OS 1: Fez Troca de Pastilhas

INSERT INTO OS_Servicos (id_os, id_servico) VALUES 
(2, 1); -- OS 2: Fez apenas Troca de Óleo

-- Ligar Peças às OS
-- Assumindo que as Peças são 1 (Filtro), 2 (Pastilha) e 3 (Óleo)
INSERT INTO OS_Pecas (id_os, id_peca, quantidade_utilizada) VALUES 
(1, 1, 1), -- OS 1: 1 Filtro de Óleo
(1, 3, 4), -- OS 1: 4 Litros de Óleo
(1, 2, 1); -- OS 1: 1 Par de Pastilhas

INSERT INTO OS_Pecas (id_os, id_peca, quantidade_utilizada) VALUES 
(2, 1, 1), -- OS 2: 1 Filtro de Óleo
(2, 3, 5); -- OS 2: 5 Litros de Óleo (Corolla usa mais)


-- ======================================================================================
-- Validar os dados inseridos com consultas simples
-- ======================================================================================

USE oficina_mecanica;

SELECT 
    -- 1. Identifica a Ordem de Serviço
    os.id_os,
    v.placa AS veiculo_placa,
    c.nome AS cliente_nome,
    
    -- 2. Calcula o Subtotal de Serviços (Critério 8: SUM)
    (SELECT SUM(s.valor_mao_obra)
     FROM OS_Servicos oss
     JOIN Servicos s ON oss.id_servico = s.id_servico
     WHERE oss.id_os = os.id_os) AS total_servicos,
     
    -- 3. Calcula o Subtotal de Peças (Critério 8: SUM)
    (SELECT SUM(p.preco_unitario * osp.quantidade_utilizada) 
     FROM OS_Pecas osp
     JOIN Pecas p ON osp.id_peca = p.id_peca
     WHERE osp.id_os = os.id_os) AS total_pecas,
     
    -- 4. Calcula o VALOR TOTAL
    (
        (SELECT SUM(s.valor_mao_obra)
         FROM OS_Servicos oss
         JOIN Servicos s ON oss.id_servico = s.id_servico
         WHERE oss.id_os = os.id_os)
        +
        (SELECT SUM(p.preco_unitario * osp.quantidade_utilizada) 
         FROM OS_Pecas osp
         JOIN Pecas p ON osp.id_peca = p.id_peca
         WHERE osp.id_os = os.id_os)
    ) AS valor_total_os

FROM 
    Ordens_Servico os
-- (Critério 5: JOINs para buscar dados do cliente/veículo)
JOIN 
    Veiculos v ON os.id_veiculo = v.id_veiculo
JOIN 
    Clientes c ON v.id_cliente = c.id_cliente
WHERE 
    os.id_os = 1; -- Estamos buscando o valor da OS #1

    -- ======================================================================================

    USE oficina_mecanica;

SELECT 
    -- 1. Identifica a Ordem de Serviço
    os.id_os,
    v.placa AS veiculo_placa,
    c.nome AS cliente_nome,
    
    -- 2. Calcula o Subtotal de Serviços (Critério 8: SUM)
    (SELECT SUM(s.valor_mao_obra)
     FROM OS_Servicos oss
     JOIN Servicos s ON oss.id_servico = s.id_servico
     WHERE oss.id_os = os.id_os) AS total_servicos,
     
    -- 3. Calcula o Subtotal de Peças (Critério 8: SUM)
    (SELECT SUM(p.preco_unitario * osp.quantidade_utilizada) 
     FROM OS_Pecas osp
     JOIN Pecas p ON osp.id_peca = p.id_peca
     WHERE osp.id_os = os.id_os) AS total_pecas,
     
    -- 4. Calcula o VALOR TOTAL
    (
        (SELECT SUM(s.valor_mao_obra)
         FROM OS_Servicos oss
         JOIN Servicos s ON oss.id_servico = s.id_servico
         WHERE oss.id_os = os.id_os)
        +
        (SELECT SUM(p.preco_unitario * osp.quantidade_utilizada) 
         FROM OS_Pecas osp
         JOIN Pecas p ON osp.id_peca = p.id_peca
         WHERE osp.id_os = os.id_os)
    ) AS valor_total_os

FROM 
    Ordens_Servico os
-- (Critério 5: JOINs para buscar dados do cliente/veículo)
JOIN 
    Veiculos v ON os.id_veiculo = v.id_veiculo
JOIN 
    Clientes c ON v.id_cliente = c.id_cliente
WHERE 
    os.id_os = 1; -- Estamos buscando o valor da OS #1

-- ======================================================================================
-- FIM
