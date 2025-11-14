<?php
include 'conexao.php';
$sql = "SELECT v.*, c.nome AS nome_cliente 
        FROM Veiculos v 
        JOIN Clientes c ON v.id_cliente = c.id_cliente 
        ORDER BY v.modelo ASC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Veículos</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Gestão da Oficina - Veículos</h1>
    <a href="cadastrar_veiculos.php" class="btn-novo">Cadastrar Novo Veículo</a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Placa</th>
                <th>Modelo</th>
                <th>Marca</th>
                <th>Ano</th>
                <th>Proprietário</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_veiculo']; ?></td>
                    <td><?php echo htmlspecialchars($linha['placa']); ?></td>
                    <td><?php echo htmlspecialchars($linha['modelo']); ?></td>
                    <td><?php echo htmlspecialchars($linha['marca']); ?></td>
                    <td><?php echo $linha['ano']; ?></td>
                    <td><?php echo htmlspecialchars($linha['nome_cliente']); ?></td>
                    <td>
                        <a href="editar_veiculos.php?id=<?php echo $linha['id_veiculo']; ?>">Editar</a>
                        <a href="excluir_veiculos.php?id=<?php echo $linha['id_veiculo']; ?>"
                           onclick="return confirm('Tem certeza?');">Excluir</a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>