<?php
include 'conexao.php';
$peca = null;
$id_peca = 0;

// Lógica de atualização (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_peca = (int)$_POST['id_peca'];
    $nome_peca = mysqli_real_escape_string($conexao, $_POST['nome_peca']);
    $descricao = mysqli_real_escape_string($conexao, $_POST['descricao']);
    $preco_unitario = (float) str_replace(',', '.', $_POST['preco_unitario']);
    $quantidade_estoque = (int) $_POST['quantidade_estoque'];

    $sql = "UPDATE Pecas SET 
                nome_peca = '$nome_peca', descricao = '$descricao', 
                preco_unitario = $preco_unitario, quantidade_estoque = $quantidade_estoque
            WHERE id_peca = $id_peca";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_pecas.php");
        exit;
    } else {
        echo "Erro ao atualizar: " . mysqli_error($conexao);
    }
}

// Lógica de busca (GET)
if (isset($_GET['id'])) {
    $id_peca = (int)$_GET['id'];
    $sql = "SELECT * FROM Pecas WHERE id_peca = $id_peca";
    $resultado = mysqli_query($conexao, $sql);
    if ($resultado && mysqli_num_rows($resultado) > 0) {
        $peca = mysqli_fetch_assoc($resultado);
    } else {
        header("Location: index_pecas.php"); exit; // Evita loop
    }
} else {
    header("Location: index_pecas.php"); exit; // Evita loop
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Peça</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Editar Peça</h1>
    <form action="editar_pecas.php" method="POST">
        <input type="hidden" name="id_peca" value="<?php echo $peca['id_peca']; ?>">
        <div>
            <label for="nome_peca">Nome da Peça:</label>
            <input type="text" id="nome_peca" name="nome_peca" value="<?php echo htmlspecialchars($peca['nome_peca']); ?>" required>
        </div>
        <div>
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" value="<?php echo htmlspecialchars($peca['descricao']); ?>">
        </div>
        <div>
            <label for="preco_unitario">Preço Unitário (Ex: 45.50):</label>
            <input type="text" id="preco_unitario" name="preco_unitario" value="<?php echo $peca['preco_unitario']; ?>" required>
        </div>
        <div>
            <label for="quantidade_estoque">Quantidade em Estoque:</label>
            <input type="number" id="quantidade_estoque" name="quantidade_estoque" value="<?php echo $peca['quantidade_estoque']; ?>" required>
        </div>
        <div>
            <button type="submit" class="btn-atualizar">Atualizar</button>
        </div>
    </form>
    <a href="index_pecas.php" class="link-voltar">Voltar</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>