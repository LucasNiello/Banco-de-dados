<?php
include 'conexao.php';
if (isset($_GET['id'])) {
    $id_servico = (int)$_GET['id'];
    $sql = "DELETE FROM Servicos WHERE id_servico = $id_servico";

    if (!mysqli_query($conexao, $sql)) {
        // Trata erro de FK (Serviço está em uma OS)
        if(mysqli_errno($conexao) == 1451){
            echo "Erro: Este serviço não pode ser excluído pois está vinculado a uma Ordem de Serviço. <br>";
            echo '<a href="index_servicos.php">Voltar</a>';
        } else {
            echo "Erro ao excluir: " . mysqli_error($conexao);
        }
    } else {
         header("Location: index_servicos.php");
         exit;
    }
} else {
    header("Location: index_servicos.php");
    exit;
}
mysqli_close($conexao);
?>