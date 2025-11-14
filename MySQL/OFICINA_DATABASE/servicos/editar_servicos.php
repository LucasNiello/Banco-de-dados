<?php
include 'conexao.php';
$servico = null;
$id_servico = 0;

// Lógica de atualização (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_servico = (int)$_POST['id_servico'];
    $nome_servico = mysqli_real_escape_string($conexao, $_POST['nome_servico']);
    $descricao = mysqli_real_escape_string($conexao, $_POST['descricao']);
    $valor_mao_obra = (float) str_replace(',', '.', $_POST['valor_mao_obra']);

    $sql = "UPDATE Servicos SET 
                nome_servico = '$nome_servico', descricao = '$descricao', 
                valor_mao_obra = $valor_mao_obra
            WHERE id_servico = $id_servico";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_servicos.php");
        exit;
    } else {
        echo "Erro ao atualizar: " . mysqli_error($conexao);
    }
}

// Lógica de busca (GET)
if (isset($_GET['id'])) {
    $id_servico = (int)$_GET['id'];
    $sql = "SELECT * FROM Servicos WHERE id_servico = $id_servico";
    $resultado = mysqli_query($conexao, $sql);
    if ($resultado && mysqli_num_rows($resultado) > 0) {
        $servico = mysqli_fetch_assoc($resultado);
    } else {
        header("Location: index_servicos.php"); exit; // Evita loop
    }
} else {
    header("Location: index_servicos.php"); exit; // Evita loop
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Serviço</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Editar Serviço</h1>
    <form action="editar_servicos.php" method="POST">
        <input type="hidden" name="id_servico" value="<?php echo $servico['id_servico']; ?>">
        <div>
            <label for="nome_servico">Nome do Serviço:</label>
            <input type="text" id="nome_servico" name="nome_servico" value="<?php echo htmlspecialchars($servico['nome_servico']); ?>" required>
        </div>
        <div>
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" value="<?php echo htmlspecialchars($servico['descricao']); ?>">
        </div>
        <div>
            <label for="valor_mao_obra">Valor (Mão de Obra) (Ex: 80.00):</label>
            <input type="text" id="valor_mao_obra" name="valor_mao_obra" value="<?php echo $servico['valor_mao_obra']; ?>" required>
        </div>
        <div>
            <button type="submit" class="btn-atualizar">Atualizar</button>
        </div>
    </form>
    <a href="index_servicos.php" class="link-voltar">Voltar</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>