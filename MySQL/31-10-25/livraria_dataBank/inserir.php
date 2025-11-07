<?php
// Arquivo: inserir.php (Corrigido)

// --- Bloco PHP (Processamento) ---
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");
$mensagem = ""; // Variavel para guardar a mensagem

// 1. Verificamos a conexao PRIMEIRO
if ($conn->connect_error) {
    $mensagem = "Erro de Conexao: " . $conn->connect_error;
} else {
    // 2. Se a conexao funcionar, pegamos os dados
    $nome = $_POST['nome'];
    $email = $_POST['email'];

    // (Usando o SQL inseguro, como combinado)
    $sql = "INSERT INTO usuarios (nome, email) VALUES ('$nome', '$email')";

    if ($conn->query($sql) === TRUE) {
        $mensagem = "Novo registro criado com sucesso!"; // Salva a msg
    } else {
        $mensagem = "Erro: " . $conn->error; // Salva a msg
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
    <title>Aviso de Cadastro</title>
    
    <link rel="stylesheet" href="style.css"> 
</head>
<body>

    <div class="container-lista">
        
        <h2><?php echo $mensagem; ?></h2>
        
        <br>
        
        <a href="index.html">
            <button type="button">Voltar</button>
        </a>
        
    </div>

</body>
</html>