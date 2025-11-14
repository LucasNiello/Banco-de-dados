<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    include 'conexao.php';
    $nome_servico = mysqli_real_escape_string($conexao, $_POST['nome_servico']);
    $descricao = mysqli_real_escape_string($conexao, $_POST['descricao']);
    $valor_mao_obra = (float) str_replace(',', '.', $_POST['valor_mao_obra']);

    $sql = "INSERT INTO Servicos (nome_servico, descricao, valor_mao_obra) 
            VALUES ('$nome_servico', '$descricao', $valor_mao_obra)";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_servicos.php");
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
    <title>Cadastrar Serviço</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Cadastrar Novo Serviço</h1>
    <form action="cadastrar_servicos.php" method="POST">
        <div>
            <label for="nome_servico">Nome do Serviço:</label>
            <input type="text" id="nome_servico" name="nome_servico" required>
        </div>
        <div>
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao">
        </div>
         <div>
            <label for="valor_mao_obra">Valor (Mão de Obra) (Ex: 80.00):</label>
            <input type="text" id="valor_mao_obra" name="valor_mao_obra" required>
        </div>
        <div>
            <button type="submit" class="btn-salvar">Salvar</button>
        </div>
    </form>
    <a href="index_servicos.php" class="link-voltar">Voltar</a>
</body>
</html>