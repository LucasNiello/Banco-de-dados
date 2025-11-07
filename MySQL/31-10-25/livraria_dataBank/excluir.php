<?php
// --- Início do Bloco PHP (Processamento) ---
// (Ignorando segurança, como combinado, mas usando a estrutura do professor)

$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");
if ($conn->connect_error) {
    die("Conexao falhou: " . $conn->connect_error);
}

$id = $_GET['id'];

// Preparar a declaracao (Método seguro)
$stmt = $conn->prepare("DELETE FROM usuarios WHERE id_usuario = ?");
$stmt->bind_param("i", $id);

// Executar e salvar a mensagem
if ($stmt->execute()) {
    $mensagem = "Usuário excluído com sucesso."; // 1. Salva a msg de sucesso
} else { 
    $mensagem = "Erro ao excluir: " . $stmt->error; // 2. Salva a msg de erro
}

$stmt->close();
$conn->close();

// --- Fim do Bloco PHP ---
// Agora, começamos a imprimir o HTML
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aviso de Exclusão</title>
    
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