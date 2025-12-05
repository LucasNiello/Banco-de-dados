<?php
require_once 'config/Database.php';
require_once 'models/Veiculo.php';
require_once 'models/Cliente.php'; // Necessário para listar os donos

class VeiculoController {
    private $db;
    private $veiculo;
    private $clienteModel;

    public function __construct() {
        $database = new Database();
        $this->db = $database->getConnection();
        $this->veiculo = new Veiculo($this->db);
        $this->clienteModel = new Cliente($this->db);
    }

    public function index() {
        $stmt = $this->veiculo->readAll();
        $veiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        require_once 'views/veiculos/index.php';
    }

    public function create() {
        // Busca clientes para preencher o <select>
        $stmt = $this->clienteModel->readAll();
        $clientes = $stmt->fetchAll(PDO::FETCH_ASSOC);
        require_once 'views/veiculos/create.php';
    }

    public function store() {
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $this->veiculo->id_cliente = $_POST['id_cliente'];
            $this->veiculo->placa = $_POST['placa'];
            $this->veiculo->marca = $_POST['marca'];
            $this->veiculo->modelo = $_POST['modelo'];
            $this->veiculo->ano = $_POST['ano'];
            $this->veiculo->cor = $_POST['cor'];

            if($this->veiculo->create()) {
                header("Location: index.php?controller=veiculo&action=index&msg=created");
            } else {
                echo "Erro ao cadastrar veículo.";
            }
        }
    }

    public function delete() {
        if(isset($_GET['id'])) {
            $this->veiculo->id_veiculo = $_GET['id'];
            $this->veiculo->delete();
            header("Location: index.php?controller=veiculo&action=index&msg=deleted");
        }
    }
}