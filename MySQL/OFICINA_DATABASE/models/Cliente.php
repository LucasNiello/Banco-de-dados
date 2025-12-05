<?php
// models/Cliente.php

class Cliente {
    private $conn;
    private $table_name = "clientes";

    public $id_cliente;
    public $nome;
    public $cpf;
    public $telefone;
    public $email;
    public $endereco;
    public $cidade;
    public $estado;
    public $ativo;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Ler todos
    public function readAll() {
        $query = "SELECT * FROM " . $this->table_name . " WHERE ativo = 1 ORDER BY nome";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Criar
    public function create() {
        $query = "INSERT INTO " . $this->table_name . " 
                  SET nome=:nome, cpf=:cpf, telefone=:telefone, email=:email, 
                      endereco=:endereco, cidade=:cidade, estado=:estado";

        $stmt = $this->conn->prepare($query);

        // Sanitização básica
        $this->nome = htmlspecialchars(strip_tags($this->nome));
        $this->cpf = htmlspecialchars(strip_tags($this->cpf));
        // ... (faça isso para os outros campos)

        $stmt->bindParam(":nome", $this->nome);
        $stmt->bindParam(":cpf", $this->cpf);
        $stmt->bindParam(":telefone", $this->telefone);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":endereco", $this->endereco);
        $stmt->bindParam(":cidade", $this->cidade);
        $stmt->bindParam(":estado", $this->estado);

        if($stmt->execute()) {
            return true;
        }
        return false;
    }

    // Ler Um (para edição)
    public function readOne() {
        $query = "SELECT * FROM " . $this->table_name . " WHERE id_cliente = ? LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->id_cliente);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if($row) {
            $this->nome = $row['nome'];
            $this->cpf = $row['cpf'];
            $this->telefone = $row['telefone'];
            $this->email = $row['email'];
            $this->endereco = $row['endereco'];
            $this->cidade = $row['cidade'];
            $this->estado = $row['estado'];
        }
    }

    // Atualizar
    public function update() {
        $query = "UPDATE " . $this->table_name . " 
                  SET nome=:nome, cpf=:cpf, telefone=:telefone, email=:email, 
                      endereco=:endereco, cidade=:cidade, estado=:estado
                  WHERE id_cliente = :id_cliente";
        
        $stmt = $this->conn->prepare($query);
        // (Binds similares ao create, adicione o id_cliente)
        $stmt->bindParam(":nome", $this->nome);
        $stmt->bindParam(":cpf", $this->cpf);
        $stmt->bindParam(":telefone", $this->telefone);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":endereco", $this->endereco);
        $stmt->bindParam(":cidade", $this->cidade);
        $stmt->bindParam(":estado", $this->estado);
        $stmt->bindParam(":id_cliente", $this->id_cliente);

        return $stmt->execute();
    }

    // Excluir (Soft Delete)
    public function delete() {
        $query = "UPDATE " . $this->table_name . " SET ativo = 0 WHERE id_cliente = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $this->id_cliente);
        return $stmt->execute();
    }
    
    // Busca
    public function search($keywords) {
        $query = "SELECT * FROM " . $this->table_name . " 
                  WHERE ativo = 1 AND (nome LIKE ? OR cpf LIKE ?)";
        $stmt = $this->conn->prepare($query);
        $keywords = "%{$keywords}%";
        $stmt->bindParam(1, $keywords);
        $stmt->bindParam(2, $keywords);
        $stmt->execute();
        return $stmt;
    }
}