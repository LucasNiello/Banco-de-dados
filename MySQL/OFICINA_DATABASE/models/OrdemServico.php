<?php
// models/OrdemServico.php

class OrdemServico {
    private $conn;
    private $table_name = "ordens_servico";

    // Colunas OFICIAIS da tabela
    public $id_os;
    public $numero_os;
    public $id_veiculo;
    public $status; 
    public $defeito_relatado; // CORRIGIDO (era descricao_problema)
    public $valor_final;
    public $data_abertura;
    public $data_conclusao;

    // Propriedades AUXILIARES (Join) - Declaradas para evitar erro "Deprecated"
    public $placa;
    public $modelo;
    public $nome_cliente;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function readAll() {
        $query = "SELECT os.*, v.placa, v.modelo, c.nome as nome_cliente 
                  FROM " . $this->table_name . " os
                  JOIN veiculos v ON os.id_veiculo = v.id_veiculo
                  JOIN clientes c ON v.id_cliente = c.id_cliente
                  ORDER BY os.data_abertura DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function create() {
        // Gera numero de OS único
        $this->numero_os = 'OS-' . date('Ymd-His'); 

        $query = "INSERT INTO " . $this->table_name . " 
                  SET numero_os=:numero_os, id_veiculo=:id_veiculo, defeito_relatado=:defeito, status='ABERTA', data_abertura=NOW()";
        
        $stmt = $this->conn->prepare($query);
        
        // Sanitização
        $this->defeito_relatado = htmlspecialchars(strip_tags($this->defeito_relatado));
        
        $stmt->bindParam(":numero_os", $this->numero_os);
        $stmt->bindParam(":id_veiculo", $this->id_veiculo);
        $stmt->bindParam(":defeito", $this->defeito_relatado);

        if($stmt->execute()) { return true; }
        return false;
    }

    public function readOne() {
        $query = "SELECT os.*, v.placa, v.modelo, c.nome as nome_cliente 
                  FROM " . $this->table_name . " os
                  JOIN veiculos v ON os.id_veiculo = v.id_veiculo
                  JOIN clientes c ON v.id_cliente = c.id_cliente
                  WHERE os.id_os = ? LIMIT 0,1";

        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->id_os);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            $this->id_veiculo = $row['id_veiculo'];
            $this->status = $row['status'];
            $this->defeito_relatado = $row['defeito_relatado']; // CORRIGIDO
            $this->valor_final = $row['valor_final'];
            
            // Preenche auxiliares
            $this->placa = $row['placa'];
            $this->modelo = $row['modelo'];
            $this->nome_cliente = $row['nome_cliente'];
            return true;
        }
        return false;
    }

    public function update() {
        $query = "UPDATE " . $this->table_name . " 
                  SET status=:status, 
                      valor_final=:valor, 
                      defeito_relatado=:defeito"; // CORRIGIDO
        
        if($this->status == 'CONCLUIDA') {
            $query .= ", data_conclusao=NOW()";
        }

        $query .= " WHERE id_os = :id_os";
        
        $stmt = $this->conn->prepare($query);

        $this->defeito_relatado = htmlspecialchars(strip_tags($this->defeito_relatado));
        
        $stmt->bindParam(":status", $this->status);
        $stmt->bindParam(":valor", $this->valor_final);
        $stmt->bindParam(":defeito", $this->defeito_relatado);
        $stmt->bindParam(":id_os", $this->id_os);
        
        return $stmt->execute();
    }
}