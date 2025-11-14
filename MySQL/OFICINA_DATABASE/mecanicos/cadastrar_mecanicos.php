<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    include 'conexao.php';
    $nome = mysqli_real_escape_string($conexao, $_POST['nome']);
    $cpf = mysqli_real_escape_string($conexao, $_POST['cpf']);
    $especialidade = mysqli_real_escape_string($conexao, $_POST['especialidade']);

    $sql = "INSERT INTO Mecanicos (nome, cpf, especialidade) 
            VALUES ('$nome', '$cpf', '$especialidade')";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_mecanicos.php");
        exit;
    } else {
        echo "Erro ao cadastrar: " . mysqli_error($conexao);
    }
    mysqli_close($conexao);
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Mecânico</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Cadastrar Novo Mecânico</h1>
    <form action="cadastrar_mecanicos.php" method="POST">
        <div>
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf">
        </div>
        <div>
            <label for="especialidade">Especialidade:</label>
            <input type="text" id="especialidade" name="especialidade">
        </div>
        <div>
            <button type="submit" class="btn-salvar">Salvar</button>
        </div>
    </form>
    <a href="index_mecanicos.php" class="link-voltar">Voltar</a>
</body>
</html>