<?php
include 'conexao.php';
if (isset($_GET['id'])) {
    $id_peca = (int)$_GET['id'];
    $sql = "DELETE FROM Pecas WHERE id_peca = $id_peca";

    if (!mysqli_query($conexao, $sql)) {
        // Trata erro de FK (Peça está em uma OS)
        if(mysqli_errno($conexao) == 1451){
            echo "Erro: Esta peça não pode ser excluída pois está vinculada a uma Ordem de Serviço. <br>";
            echo '<a href="index_pecas.php">Voltar</a>';
        } else {
            echo "Erro ao excluir: " . mysqli_error($conexao);
        }
    } else {
         header("Location: index_pecas.php");
         exit;
    }
} else {
    header("Location: index_pecas.php");
    exit;
}
mysqli_close($conexao);
?>