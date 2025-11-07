<?php
$nome = $_POST['nome'];
$email = $_POST['email'];

$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$sql = "INSERT INTO usuarios (nome, email) VALUES ('$nome', '$email')";

if ($conn->query($sql) === TRUE) {
    echo "Novo registro criado com sucesso";
} else {
    echo "Erro: " . $sql . "<br>" . $conn->error;
}
// header("Location: index.html"); //Ou index.php dependendo do seu arquivo principal
exit;
$conn->close();

?>
