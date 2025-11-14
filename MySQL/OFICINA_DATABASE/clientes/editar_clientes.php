<?php
include 'conexao.php';
$cliente = null;
$id_cliente = 0;

// Lógica de atualização (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_cliente = (int)$_POST['id_cliente'];
    $nome = mysqli_real_escape_string($conexao, $_POST['nome']);
    $telefone = mysqli_real_escape_string($conexao, $_POST['telefone']);
    $email = mysqli_real_escape_string($conexao, $_POST['email']);
    $cpf = mysqli_real_escape_string($conexao, $_POST['cpf']);
    $endereco = mysqli_real_escape_string($conexao, $_POST['endereco']);

    $sql = "UPDATE Clientes SET 
                nome = '$nome', telefone = '$telefone', email = '$email', 
                cpf = '$cpf', endereco = '$endereco' 
            WHERE id_cliente = $id_cliente";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_clientes.php");
        exit;
    } else {
        echo "Erro ao atualizar cliente: " . mysqli_error($conexao);
    }
}

// Lógica de busca (GET)
if (isset($_GET['id'])) {
    $id_cliente = (int)$_GET['id'];
    $sql = "SELECT * FROM Clientes WHERE id_cliente = $id_cliente";
    $resultado = mysqli_query($conexao, $sql);
    if ($resultado && mysqli_num_rows($resultado) > 0) {
        $cliente = mysqli_fetch_assoc($resultado);
    } else {
        header("Location: index_clientes.php"); exit; // Evita loop
    }
} else {
    header("Location: index_clientes.php"); exit; // Evita loop
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Editar Cliente (ID: <?php echo $cliente['id_cliente']; ?>)</h1>
    <form action="editar_clientes.php" method="POST">
        <input type="hidden" name="id_cliente" value="<?php echo $cliente['id_cliente']; ?>">
        <div>
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" 
                   value="<?php echo htmlspecialchars($cliente['nome']); ?>" required>
        </div>
        <div>
            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" 
                   value="<?php echo htmlspecialchars($cliente['telefone']); ?>" required>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" 
                   value="<?php echo htmlspecialchars($cliente['email']); ?>">
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" 
                   value="<?php echo htmlspecialchars($cliente['cpf']); ?>">
        </div>
        <div>
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" 
                   value="<?php echo htmlspecialchars($cliente['endereco']); ?>">
        </div>
        <div>
            <button type="submit" class="btn-atualizar">Atualizar Cliente</button>
        </div>
    </form>
    <a href="index_clientes.php" class="link-voltar">Voltar para a Lista</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>