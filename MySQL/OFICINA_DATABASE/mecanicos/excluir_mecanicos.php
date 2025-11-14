<?php
include 'conexao.php';
if (isset($_GET['id'])) {
    $id_mecanico = (int)$_GET['id'];
    $sql = "DELETE FROM Mecanicos WHERE id_mecanico = $id_mecanico";

    if (!mysqli_query($conexao, $sql)) {
        // Trata erro de FK (Mecânico está em uma OS)
        if(mysqli_errno($conexao) == 1451){
            echo "Erro: Este mecânico não pode ser excluído pois está vinculado a uma Ordem de Serviço. <br>";
            echo '<a href="index_mecanicos.php">Voltar</a>';
        } else {
            echo "Erro ao excluir: " . mysqli_error($conexao);
        }
    } else {
         header("Location: index_mecanicos.php");
         exit;
    }
} else {
    header("Location: index_mecanicos.php");
    exit;
}
mysqli_close($conexao);
?>