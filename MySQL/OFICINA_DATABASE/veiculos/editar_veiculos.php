<?php
include 'conexao.php';
$veiculo = null;
$id_veiculo = 0;

// Lógica de atualização (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_veiculo = (int)$_POST['id_veiculo'];
    $placa = mysqli_real_escape_string($conexao, $_POST['placa']);
    $modelo = mysqli_real_escape_string($conexao, $_POST['modelo']);
    $marca = mysqli_real_escape_string($conexao, $_POST['marca']);
    $ano = (int)$_POST['ano'];
    $cor = mysqli_real_escape_string($conexao, $_POST['cor']);
    $id_cliente = (int)$_POST['id_cliente'];

    $sql = "UPDATE Veiculos SET 
                placa = '$placa', modelo = '$modelo', marca = '$marca', 
                ano = $ano, cor = '$cor', id_cliente = $id_cliente 
            WHERE id_veiculo = $id_veiculo";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_veiculos.php");
        exit;
    } else {
        echo "Erro ao atualizar veículo: " . mysqli_error($conexao);
    }
}

// Lógica de busca (GET)
if (isset($_GET['id'])) {
    $id_veiculo = (int)$_GET['id'];
    $sql_veiculo = "SELECT * FROM Veiculos WHERE id_veiculo = $id_veiculo";
    $resultado_veiculo = mysqli_query($conexao, $sql_veiculo);
    if ($resultado_veiculo && mysqli_num_rows($resultado_veiculo) > 0) {
        $veiculo = mysqli_fetch_assoc($resultado_veiculo);
    } else {
        header("Location: index_veiculos.php"); exit; // Evita loop
    }
} else {
    header("Location: index_veiculos.php"); exit; // Evita loop
}

// Buscar clientes para o dropdown
$sql_clientes = "SELECT id_cliente, nome FROM Clientes ORDER BY nome ASC";
$resultado_clientes = mysqli_query($conexao, $sql_clientes);
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Veículo</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        select {
             width: 100%; padding: 10px; box-sizing: border-box;
             border: 1px solid #ddd; border-radius: 4px; background-color: white;
        }
    </style>
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Editar Veículo (ID: <?php echo $veiculo['id_veiculo']; ?>)</h1>
    <form action="editar_veiculos.php" method="POST">
        <input type="hidden" name="id_veiculo" value="<?php echo $veiculo['id_veiculo']; ?>">
        <div>
            <label for="placa">Placa:</label>
            <input type="text" id="placa" name="placa" value="<?php echo htmlspecialchars($veiculo['placa']); ?>" required>
        </div>
        <div>
            <label for="modelo">Modelo:</label>
            <input type="text" id="modelo" name="modelo" value="<?php echo htmlspecialchars($veiculo['modelo']); ?>" required>
        </div>
        <div>
            <label for="marca">Marca:</label>
            <input type="text" id="marca" name="marca" value="<?php echo htmlspecialchars($veiculo['marca']); ?>" required>
        </div>
        <div>
            <label for="ano">Ano:</label>
            <input type="number" id="ano" name="ano" value="<?php echo $veiculo['ano']; ?>">
        </div>
        <div>
            <label for="cor">Cor:</label>
            <input type="text" id="cor" name="cor" value="<?php echo htmlspecialchars($veiculo['cor']); ?>">
        </div>
        <div>
            <label for="id_cliente">Proprietário (Cliente):</label>
            <select id="id_cliente" name="id_cliente" required>
                <option value="">Selecione um cliente...</option>
                <?php
                if (mysqli_num_rows($resultado_clientes) > 0) {
                    while ($cliente = mysqli_fetch_assoc($resultado_clientes)) {
                        $selected = ($cliente['id_cliente'] == $veiculo['id_cliente']) ? 'selected' : '';
                        echo '<option value="' . $cliente['id_cliente'] . '" ' . $selected . '>' 
                             . htmlspecialchars($cliente['nome']) 
                             . '</option>';
                    }
                }
                ?>
            </select>
        </div>
        <div>
            <button type="submit" class="btn-atualizar">Atualizar Veículo</button>
        </div>
    </form>
    <a href="index_veiculos.php" class="link-voltar">Voltar para a Lista</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>