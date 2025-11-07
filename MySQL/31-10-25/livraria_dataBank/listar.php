<?php
// Arquivo: listar.php (Atualizado)

// Adicionamos o <link> do CSS no HTML
echo '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios</title>
    <link rel="stylesheet" href="style.css"> 
</head>
<body>';

// Container para centralizar e estilizar o conteudo
echo '<div class="container-lista">'; 

$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");

if ($conn->connect_error) {
    die("Erro de conexao: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM usuarios");

echo "<h2>Usuarios</h2>";

// Removemos o border='1', pois o style.css cuida disso
echo "<table>"; 
echo "<tr><th>ID</th><th>Nome</th><th>Email</th><th>Acoes</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>
            <td>{$row['id_usuario']}</td>
            <td>{$row['nome']}</td>
            <td>{$row['email']}</td>
            <td>
                <a href='editar.php?id={$row['id_usuario']}'>Editar</a> | 
                
                <a href='excluir.php?id={$row['id_usuario']}' onclick='return confirm(\"Tem certeza que deseja excluir?\");'>Excluir</a>
            
            </td>
          </tr>";
}

echo "</table>";
$conn->close();

// Botao para voltar ao index
echo "<a href='index.html'><button type='button'>Página Inicial</button></a>";

echo '</div>'; // Fecha o .container-lista
echo '</body></html>'; // Fecha o body e html
?>