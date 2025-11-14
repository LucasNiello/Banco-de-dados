<?php
include 'conexao.php';
$sql = "SELECT * FROM Servicos ORDER BY nome_servico ASC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Serviços</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Gestão de Serviços (Mão de Obra)</h1>
    <a href="cadastrar_servicos.php" class="btn-novo">Cadastrar Novo Serviço</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome do Serviço</th>
                <th>Valor (R$)</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_servico']; ?></td>
                    <td><?php echo htmlspecialchars($linha['nome_servico']); ?></td>
                    <td><?php echo number_format($linha['valor_mao_obra'], 2, ',', '.'); ?></td>
                    <td>
                        <a href="editar_servicos.php?id=<?php echo $linha['id_servico']; ?>">Editar</a>
                        <a href="excluir_servicos.php?id=<?php echo $linha['id_servico']; ?>" 
                           onclick="return confirm('Tem certeza?');">Excluir</a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>