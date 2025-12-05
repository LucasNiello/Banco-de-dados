<?php
// controllers/OsController.php
require_once 'config/Database.php';
require_once 'models/OrdemServico.php';
require_once 'models/Veiculo.php';

class OsController {
    private $db;
    private $os;
    private $veiculoModel;

    public function __construct() {
        $database = new Database();
        $this->db = $database->getConnection();
        $this->os = new OrdemServico($this->db);
        $this->veiculoModel = new Veiculo($this->db);
    }

    public function index() {
        $stmt = $this->os->readAll();
        $lista_os = $stmt->fetchAll(PDO::FETCH_ASSOC);
        require_once 'views/os/index.php';
    }

    public function create() {
        $stmt = $this->veiculoModel->readAll();
        $veiculos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        require_once 'views/os/create.php';
    }

    public function store() {
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $this->os->id_veiculo = $_POST['id_veiculo'];
            // CORRIGIDO: nome do campo no formulário
            $this->os->defeito_relatado = $_POST['defeito_relatado']; 

            if($this->os->create()) {
                header("Location: index.php?controller=os&action=index&msg=created");
            } else {
                echo "Erro ao abrir OS.";
            }
        }
    }

    public function edit() {
        if(isset($_GET['id'])) {
            $this->os->id_os = $_GET['id'];
            if($this->os->readOne()) {
                require_once 'views/os/edit.php';
            } else {
                echo "OS não encontrada.";
            }
        }
    }

    public function update() {
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $this->os->id_os = $_POST['id_os'];
            $this->os->status = $_POST['status'];
            $this->os->valor_final = $_POST['valor_final'];
            // CORRIGIDO: nome do campo
            $this->os->defeito_relatado = $_POST['defeito_relatado'];

            if($this->os->update()) {
                header("Location: index.php?controller=os&action=index&msg=updated");
            } else {
                echo "Erro ao atualizar OS.";
            }
        }
    }
}