<?php
// Arquivo: editar.php (Corrigido e Estilizado)

// --- Bloco PHP (Processamento) ---
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");
$mensagem = ""; // Variavel para erros
$row = null; // Variavel para dados

if ($conn->connect_error) {
    $mensagem = "Erro de Conexao: " . $conn->connect_error;
} else {
    $id = $_GET['id'];
    $result = $conn->query("SELECT * FROM usuarios WHERE id_usuario = $id");
    
    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
    } else {
        $mensagem = "Usuario nao encontrado ou erro na consulta.";
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
    <title>Editar Usuario</title>
    
    <link rel="stylesheet" href="style.css"> 
</head>
<body>

<?php
// Se deu erro (conexao ou nao achou o ID)
if (!empty($mensagem)) {
?>
    <div class="container-lista">
        <h2><?php echo $mensagem; ?></h2>
        <br>
        <a href="listar.php"><button type="button">Voltar para a lista</button></a>
    </div>
<?php
// Se tudo deu certo, mostra o formulario
} else {
?>
    <form action="atualizar.php" method="POST">
        <h2>Editar Usuario</h2>
        
        <input type="hidden" name="id_usuario" value="<?php echo $row['id_usuario']; ?>">
        
        <label>Nome:</label>
        <input type="text" name="nome" value="<?php echo $row['nome']; ?>" required><br>
        
        <label>Email:</label>
        <input type="email" name="email" value="<?php echo $row['email']; ?>" required><br>
        
        <button type="submit">Atualizar</button>
        
        <button type="button" class="button2" onclick="window.location.href='listar.php'">Voltar</button>
    </form>
<?php
} // Fim do else
?>

</body>
</html>