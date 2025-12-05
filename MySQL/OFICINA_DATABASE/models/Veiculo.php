<?php
class Veiculo {
    private $conn;
    private $table_name = "veiculos";

    public $id_veiculo;
    public $id_cliente;
    public $placa;
    public $marca;
    public $modelo;
    public $ano;
    public $cor;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function readAll() {
        // Traz os dados do veiculo E o nome do cliente
        $query = "SELECT v.*, c.nome as nome_dono 
                  FROM " . $this->table_name . " v
                  JOIN clientes c ON v.id_cliente = c.id_cliente
                  ORDER BY v.id_veiculo DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function create() {
        $query = "INSERT INTO " . $this->table_name . " 
                  SET id_cliente=:id_cliente, placa=:placa, marca=:marca, 
                      modelo=:modelo, ano=:ano, cor=:cor";
        
        $stmt = $this->conn->prepare($query);

        $this->placa = htmlspecialchars(strip_tags($this->placa));
        $this->marca = htmlspecialchars(strip_tags($this->marca));
        $this->modelo = htmlspecialchars(strip_tags($this->modelo));
        $this->cor = htmlspecialchars(strip_tags($this->cor));

        $stmt->bindParam(":id_cliente", $this->id_cliente);
        $stmt->bindParam(":placa", $this->placa);
        $stmt->bindParam(":marca", $this->marca);
        $stmt->bindParam(":modelo", $this->modelo);
        $stmt->bindParam(":ano", $this->ano);
        $stmt->bindParam(":cor", $this->cor);

        if($stmt->execute()) { return true; }
        return false;
    }

    public function delete() {
        $query = "DELETE FROM " . $this->table_name . " WHERE id_veiculo = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->id_veiculo);
        if($stmt->execute()) { return true; }
        return false;
    }
}