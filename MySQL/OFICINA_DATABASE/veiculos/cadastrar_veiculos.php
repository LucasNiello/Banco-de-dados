<?php
include 'conexao.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $placa = mysqli_real_escape_string($conexao, $_POST['placa']);
    $modelo = mysqli_real_escape_string($conexao, $_POST['modelo']);
    $marca = mysqli_real_escape_string($conexao, $_POST['marca']);
    $ano = (int)$_POST['ano'];
    $cor = mysqli_real_escape_string($conexao, $_POST['cor']);
    $id_cliente = (int)$_POST['id_cliente'];

    $sql = "INSERT INTO Veiculos (placa, modelo, marca, ano, cor, id_cliente) 
            VALUES ('$placa', '$modelo', '$marca', $ano, '$cor', $id_cliente)";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_veiculos.php");
        exit;
    } else {
        echo "Erro ao cadastrar veículo: " . mysqli_error($conexao);
    }
}

// Buscar clientes para o dropdown
$sql_clientes = "SELECT id_cliente, nome FROM Clientes ORDER BY nome ASC";
$resultado_clientes = mysqli_query($conexao, $sql_clientes);
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Veículo</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        /* Estilo para dropdown */
        select {
             width: 100%; padding: 10px; box-sizing: border-box;
             border: 1px solid #ddd; border-radius: 4px; background-color: white;
        }
    </style>
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Cadastrar Novo Veículo</h1>
    <form action="cadastrar_veiculos.php" method="POST">
        <div>
            <label for="placa">Placa:</label>
            <input type="text" id="placa" name="placa" required>
        </div>
        <div>
            <label for="modelo">Modelo:</label>
            <input type="text" id="modelo" name="modelo" required>
        </div>
        <div>
            <label for="marca">Marca:</label>
            <input type="text" id="marca" name="marca" required>
        </div>
        <div>
            <label for="ano">Ano:</label>
            <input type="number" id="ano" name="ano">
        </div>
        <div>
            <label for="cor">Cor:</label>
            <input type="text" id="cor" name="cor">
        </div>
        <div>
            <label for="id_cliente">Proprietário (Cliente):</label>
            <select id="id_cliente" name="id_cliente" required>
                <option value="">Selecione um cliente...</option>
                <?php
                if (mysqli_num_rows($resultado_clientes) > 0) {
                    while ($cliente = mysqli_fetch_assoc($resultado_clientes)) {
                        echo '<option value="' . $cliente['id_cliente'] . '">' 
                             . htmlspecialchars($cliente['nome']) 
                             . '</option>';
                    }
                }
                ?>
            </select>
        </div>
        <div>
            <button type="submit" class="btn-salvar">Salvar Veículo</button>
        </div>
    </form>
    <a href="index_veiculos.php" class="link-voltar">Voltar para a Lista</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>