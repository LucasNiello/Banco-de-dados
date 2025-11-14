<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    include 'conexao.php';
    $nome_peca = mysqli_real_escape_string($conexao, $_POST['nome_peca']);
    $descricao = mysqli_real_escape_string($conexao, $_POST['descricao']);
    // Converte vírgula para ponto e força o tipo numérico (float)
    $preco_unitario = (float) str_replace(',', '.', $_POST['preco_unitario']);
    $quantidade_estoque = (int) $_POST['quantidade_estoque'];

    $sql = "INSERT INTO Pecas (nome_peca, descricao, preco_unitario, quantidade_estoque) 
            VALUES ('$nome_peca', '$descricao', $preco_unitario, $quantidade_estoque)";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_pecas.php");
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
    <title>Cadastrar Peça</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Cadastrar Nova Peça</h1>
    <form action="cadastrar_pecas.php" method="POST">
        <div>
            <label for="nome_peca">Nome da Peça:</label>
            <input type="text" id="nome_peca" name="nome_peca" required>
        </div>
        <div>
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao">
        </div>
         <div>
            <label for="preco_unitario">Preço Unitário (Ex: 45.50):</label>
            <input type="text" id="preco_unitario" name="preco_unitario" required>
        </div>
        <div>
            <label for="quantidade_estoque">Quantidade em Estoque:</label>
            <input type="number" id="quantidade_estoque" name="quantidade_estoque" value="0" required>
        </div>
        <div>
            <button type="submit" class="btn-salvar">Salvar</button>
        </div>
    </form>
    <a href="index_pecas.php" class="link-voltar">Voltar</a>
</body>
</html>