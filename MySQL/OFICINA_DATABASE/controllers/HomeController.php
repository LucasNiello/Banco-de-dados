<?php
// controllers/HomeController.php

require_once 'config/Database.php';

class HomeController {
    private $db;

    public function __construct() {
        $database = new Database();
        $this->db = $database->getConnection();
    }

    public function index() {
        // Inicializa o array de estatísticas
        $stats = [];

        // 1. Contagem de Clientes
        $query = "SELECT COUNT(*) as total FROM clientes WHERE ativo = 1";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['clientes'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

        // 2. Contagem de Veículos
        $query = "SELECT COUNT(*) as total FROM veiculos";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['veiculos'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

        // 3. OS Abertas
        $query = "SELECT COUNT(*) as total FROM ordens_servico WHERE status = 'ABERTA'";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['os_abertas'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

        // 4. Faturamento do Mês Atual
        $query = "SELECT SUM(valor_final) as total FROM ordens_servico 
                  WHERE status = 'CONCLUIDA' 
                  AND MONTH(data_conclusao) = MONTH(CURRENT_DATE())
                  AND YEAR(data_conclusao) = YEAR(CURRENT_DATE())";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $res = $stmt->fetch(PDO::FETCH_ASSOC);
        $stats['faturamento_mes'] = $res['total'] ?? 0;

        // 5. Quantidade de OS concluídas no mês
        $query = "SELECT COUNT(*) as total FROM ordens_servico 
                  WHERE status = 'CONCLUIDA' 
                  AND MONTH(data_conclusao) = MONTH(CURRENT_DATE())";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['os_mes'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

        // 6. Peças com baixo estoque
        $query = "SELECT COUNT(*) as total FROM pecas WHERE quantidade_estoque < estoque_minimo AND ativo = 1";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['pecas_baixo_estoque'] = $stmt->fetch(PDO::FETCH_ASSOC)['total'];

        // 7. Últimas 5 OS
        $query = "SELECT os.numero_os, c.nome as cliente, v.marca, v.modelo, v.placa, os.data_abertura, os.status 
                  FROM ordens_servico os 
                  JOIN veiculos v ON os.id_veiculo = v.id_veiculo 
                  JOIN clientes c ON v.id_cliente = c.id_cliente 
                  ORDER BY os.data_abertura DESC LIMIT 5";
        $stmt = $this->db->prepare($query);
        $stmt->execute();
        $stats['ultimas_os'] = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Carrega a view (O antigo index.php deve ser movido para esta pasta)
        require_once 'views/home/index.php';
    }
}