<?php
include 'conexao.php';
$mecanico = null;
$id_mecanico = 0;

// Lógica de atualização (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_mecanico = (int)$_POST['id_mecanico'];
    $nome = mysqli_real_escape_string($conexao, $_POST['nome']);
    $cpf = mysqli_real_escape_string($conexao, $_POST['cpf']);
    $especialidade = mysqli_real_escape_string($conexao, $_POST['especialidade']);

    $sql = "UPDATE Mecanicos SET 
                nome = '$nome', cpf = '$cpf', especialidade = '$especialidade' 
            WHERE id_mecanico = $id_mecanico";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_mecanicos.php");
        exit;
    } else {
        echo "Erro ao atualizar: " . mysqli_error($conexao);
    }
}

// Lógica de busca (GET)
if (isset($_GET['id'])) {
    $id_mecanico = (int)$_GET['id'];
    $sql = "SELECT * FROM Mecanicos WHERE id_mecanico = $id_mecanico";
    $resultado = mysqli_query($conexao, $sql);
    if ($resultado && mysqli_num_rows($resultado) > 0) {
        $mecanico = mysqli_fetch_assoc($resultado);
    } else {
        header("Location: index_mecanicos.php"); exit; // Evita loop
    }
} else {
    header("Location: index_mecanicos.php"); exit; // Evita loop
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Mecânico</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Editar Mecânico</h1>
    <form action="editar_mecanicos.php" method="POST">
        <input type="hidden" name="id_mecanico" value="<?php echo $mecanico['id_mecanico']; ?>">
        <div>
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="<?php echo htmlspecialchars($mecanico['nome']); ?>" required>
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" value="<?php echo htmlspecialchars($mecanico['cpf']); ?>">
        </div>
        <div>
            <label for="especialidade">Especialidade:</label>
            <input type="text" id="especialidade" name="especialidade" value="<?php echo htmlspecialchars($mecanico['especialidade']); ?>">
        </div>
        <div>
            <button type="submit" class="btn-atualizar">Atualizar</button>
        </div>
    </form>
    <a href="index_mecanicos.php" class="link-voltar">Voltar</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>