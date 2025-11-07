<?php
// Arquivo: atualizar.php (Corrigido e Estilizado)

// --- Bloco PHP (Processamento) ---
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");
$mensagem = ""; // Variavel para guardar a mensagem

// 1. Verificamos a conexao PRIMEIRO
if ($conn->connect_error) {
    $mensagem = "Erro de Conexao: " . $conn->connect_error;
} else {
    // 2. Se a conexao funcionar, pegamos os dados
    $id = $_POST['id_usuario'];
    $nome = $_POST['nome'];
    $email = $_POST['email'];

    $SQL = "UPDATE usuarios SET nome='$nome', email='$email' WHERE id_usuario=$id";

    IF ($conn->query($SQL) === TRUE) {
        $mensagem = "Registro atualizado com sucesso!";
    } else { 
        $mensagem = "Erro ao atualizar: " . $conn->error;
    }
    $conn->close();
}
// --- Fim do Bloco PHP ---
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aviso de Atualizacao</title>
    
    <link rel="stylesheet" href="style.css"> 
</head>
<body>

    <div class="container-lista">
        
        <h2><?php echo $mensagem; ?></h2>
        
        <br>
        
        <a href="listar.php">
            <button type="button">Voltar para a lista</button>
        </a>
        
    </div>

</body>
</html>