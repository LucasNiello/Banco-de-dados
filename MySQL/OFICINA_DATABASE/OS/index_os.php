<?php
include 'conexao.php';
$sql = "SELECT os.*, v.placa, v.modelo, c.nome AS nome_cliente 
        FROM Ordens_Servico os
        JOIN Veiculos v ON os.id_veiculo = v.id_veiculo
        JOIN Clientes c ON v.id_cliente = c.id_cliente
        ORDER BY os.data_abertura DESC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Ordens de Serviço</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Ordens de Serviço</h1>
    <a href="cadastrar_os.php" class="btn-novo">Abrir Nova OS</a> <table>
        <thead>
            <tr>
                <th>ID (OS)</th>
                <th>Data Abertura</th>
                <th>Cliente</th>
                <th>Veículo (Placa)</th>
                <th>Problema (Descrição)</th>
                <th>Status</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_os']; ?></td>
                    <td><?php echo date('d/m/Y H:i', strtotime($linha['data_abertura'])); ?></td>
                    <td><?php echo htmlspecialchars($linha['nome_cliente']); ?></td>
                    <td><?php echo htmlspecialchars($linha['modelo'] . ' (' . $linha['placa'] . ')'); ?></td>
                    <td><?php echo htmlspecialchars($linha['descricao_problema']); ?></td>
                    <td><?php echo htmlspecialchars($linha['status_os']); ?></td>
                    <td>
                        <a href="detalhes_os.php?id=<?php echo $linha['id_os']; ?>" class="btn-novo" style="background-color:#17a2b8; padding: 5px 10px;">
                            Ver / Adicionar Itens
                        </a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>