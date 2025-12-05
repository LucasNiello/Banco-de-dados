<?php
// controllers/ClienteController.php

require_once 'config/Database.php';
require_once 'models/Cliente.php';

class ClienteController {
    private $db;
    private $cliente;

    public function __construct() {
        $database = new Database();
        $this->db = $database->getConnection();
        $this->cliente = new Cliente($this->db);
    }

    public function index() {
        $stmt = $this->cliente->readAll();
        $clientes = $stmt->fetchAll(PDO::FETCH_ASSOC);
        require_once 'views/clientes/index.php';
    }

    public function create() {
        require_once 'views/clientes/create.php';
    }

    public function store() {
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $this->cliente->nome = $_POST['nome'];
            $this->cliente->cpf = $_POST['cpf'];
            $this->cliente->telefone = $_POST['telefone'];
            $this->cliente->email = $_POST['email'];
            $this->cliente->endereco = $_POST['endereco'];
            $this->cliente->cidade = $_POST['cidade'];
            $this->cliente->estado = $_POST['estado'];

            if($this->cliente->create()) {
                header("Location: index.php?controller=cliente&action=index&msg=created");
            } else {
                echo "Erro ao criar cliente.";
            }
        }
    }

    public function edit() {
        if(isset($_GET['id'])) {
            $this->cliente->id_cliente = $_GET['id'];
            $this->cliente->readOne();
            require_once 'views/clientes/edit.php';
        }
    }

    public function update() {
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $this->cliente->id_cliente = $_POST['id_cliente'];
            $this->cliente->nome = $_POST['nome'];
            $this->cliente->cpf = $_POST['cpf'];
            $this->cliente->telefone = $_POST['telefone'];
            $this->cliente->email = $_POST['email'];
            $this->cliente->endereco = $_POST['endereco'];
            $this->cliente->cidade = $_POST['cidade'];
            $this->cliente->estado = $_POST['estado'];

            if($this->cliente->update()) {
                header("Location: index.php?controller=cliente&action=index&msg=updated");
            } else {
                echo "Erro ao atualizar.";
            }
        }
    }

    public function delete() {
        if(isset($_GET['id'])) {
            $this->cliente->id_cliente = $_GET['id'];
            if($this->cliente->delete()) {
                header("Location: index.php?controller=cliente&action=index&msg=deleted");
            } else {
                echo "Erro ao excluir.";
            }
        }
    }
}