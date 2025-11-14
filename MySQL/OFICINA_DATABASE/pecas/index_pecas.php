<?php
include 'conexao.php';
$sql = "SELECT * FROM Pecas ORDER BY nome_peca ASC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Peças e Estoque</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Gestão de Peças e Estoque</h1>
    <a href="cadastrar_pecas.php" class="btn-novo">Cadastrar Nova Peça</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome da Peça</th>
                <th>Preço Unitário (R$)</th>
                <th>Estoque (Qtd)</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_peca']; ?></td>
                    <td><?php echo htmlspecialchars($linha['nome_peca']); ?></td>
                    <td><?php echo number_format($linha['preco_unitario'], 2, ',', '.'); ?></td>
                    <td><?php echo $linha['quantidade_estoque']; ?></td>
                    <td>
                        <a href="editar_pecas.php?id=<?php echo $linha['id_peca']; ?>">Editar</a>
                        <a href="excluir_pecas.php?id=<?php echo $linha['id_peca']; ?>" 
                           onclick="return confirm('Tem certeza?');">Excluir</a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>