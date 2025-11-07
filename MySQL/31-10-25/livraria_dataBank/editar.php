<?php
$conn = new mysqli("localhost", "root", "SenaiSP", "livraria");

$id = $_GET['id'];
$result = $conn->query("SELECT * FROM usuarios WHERE id_usuario = $id");
$row = $result->fetch_assoc();
?>

<form action="atualizar.php" method="POST">
    <input type="hidden" name="id_usuario" value="<?php echo $row['id_usuario']; ?>">
    <label>Nome:</label>
    <input type="text" name="nome" value="<?php echo $row['nome']; ?>" required><br>
    <label>Email:</label>
    <input type="email" name="email" value="<?php echo $row['email']; ?>" required><br>
    <button type="submit">Atualizar</button>