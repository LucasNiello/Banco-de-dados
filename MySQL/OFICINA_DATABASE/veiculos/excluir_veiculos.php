<?php
include 'conexao.php';

if (isset($_GET['id'])) {
    $id_veiculo = (int)$_GET['id'];
    
    $sql = "DELETE FROM Veiculos WHERE id_veiculo = $id_veiculo";

    if (mysqli_query($conexao, $sql)) {
        header("Location: index_veiculos.php");
        exit;
    } else {
        // Trata erro de FK (Veículo está em uma OS)
        if(mysqli_errno($conexao) == 1451){
            echo "Erro: Este veículo não pode ser excluído pois está vinculado a uma Ordem de Serviço. <br>";
            echo '<a href="index_veiculos.php">Voltar</a>';
        } else {
            echo "Erro ao excluir veículo: " . mysqli_error($conexao);
        }
    }
} else {
    header("Location: index_veiculos.php");
    exit;
}
mysqli_close($conexao);
?>