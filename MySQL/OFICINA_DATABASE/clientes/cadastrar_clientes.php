<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    include 'conexao.php';
    $nome = mysqli_real_escape_string($conexao, $_POST['nome']);
    $telefone = mysqli_real_escape_string($conexao, $_POST['telefone']);
    $email = mysqli_real_escape_string($conexao, $_POST['email']);
    $cpf = mysqli_real_escape_string($conexao, $_POST['cpf']);
    $endereco = mysqli_real_escape_string($conexao, $_POST['endereco']);

    $sql = "INSERT INTO Clientes (nome, telefone, email, cpf, endereco) 
            VALUES ('$nome', '$telefone', '$email', '$cpf', '$endereco')";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_clientes.php");
        exit; 
    } else {
        echo "Erro ao cadastrar cliente: " . mysqli_error($conexao);
    }
    mysqli_close($conexao);
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Novo Cliente</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Cadastrar Novo Cliente</h1>
    <form action="cadastrar_clientes.php" method="POST">
        <div>
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>
        </div>
        <div>
            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" required>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email">
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf">
        </div>
        <div>
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco">
        </div>
        <div>
            <button type="submit" class="btn-salvar">Salvar Cliente</button>
        </div>
    </form>
    <a href="index_clientes.php" class="link-voltar">Voltar para a Lista</a>
</body>
</html>