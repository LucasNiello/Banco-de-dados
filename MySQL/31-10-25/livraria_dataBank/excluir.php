<?php
// Arquivo: excluir.php

// 1. Conexao com o banco
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");

if ($conn->connect_error) {
    die("Conexao falhou: " . $conn->connect_error);
}

// 2. Pegar o ID da URL (metodo GET)
$id = $_GET['id'];

// 3. Montar o SQL de exclusao
$SQL = "DELETE FROM usuarios WHERE id_usuario = $id";

// 4. Executar e redirecionar
IF ($conn->query($SQL) === TRUE) {
    // Se deu certo, manda o usuario de volta para a lista
    header("Location: listar.php");
    exit;
} else { 
    echo "Erro ao excluir: " . $conn->error;
}

$conn->close();
?>