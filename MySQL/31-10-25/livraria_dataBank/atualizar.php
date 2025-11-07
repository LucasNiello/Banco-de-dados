<?php
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");

$id = $_POST['id_usuario'];
$nome = $_POST['nome'];
$email = $_POST['email'];

$SQL = "UPDATE usuarios SET nome='$nome', email='$email' WHERE id_usuario=$id";

IF ($conn->query($SQL) === TRUE) {
    echo "Registro atualizado com sucesso.";
    echo "<br><a href='index.html'>Voltar</a>";
} else { 
    echo "Erro!!: " . $conn->error;
}

$conn->close();
?>