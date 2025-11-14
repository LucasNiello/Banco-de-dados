<?php
include 'conexao.php';

if (isset($_GET['id'])) {
    $id_cliente = (int)$_GET['id'];
    $sql = "DELETE FROM Clientes WHERE id_cliente = $id_cliente";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_clientes.php");
        exit;
    } else {
        // Trata erro de FK (Cliente tem Veículos)
        if(mysqli_errno($conexao) == 1451){
            echo "Erro: Este cliente não pode ser excluído pois possui veículos cadastrados. <br>";
            echo '<a href="index_clientes.php">Voltar</a>';
        } else {
            echo "Erro ao excluir cliente: " . mysqli_error($conexao);
        }
    }
} else {
    header("Location: index_clientes.php");
    exit;
}
mysqli_close($conexao);
?>