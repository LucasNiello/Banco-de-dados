<?php
include 'conexao.php';
$sql = "SELECT * FROM Clientes ORDER BY nome ASC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Clientes</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>
    
    <h1>Gestão da Oficina - Clientes</h1>
    <a href="cadastrar_clientes.php" class="btn-novo">Cadastrar Novo Cliente</a>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Telefone</th>
                <th>Email</th>
                <th>CPF</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_cliente']; ?></td>
                    <td><?php echo htmlspecialchars($linha['nome']); ?></td>
                    <td><?php echo htmlspecialchars($linha['telefone']); ?></td>
                    <td><?php echo htmlspecialchars($linha['email']); ?></td>
                    <td><?php echo htmlspecialchars($linha['cpf']); ?></td>
                    <td>
                        <a href="editar_clientes.php?id=<?php echo $linha['id_cliente']; ?>">Editar</a>
                        <a href="excluir_clientes.php?id=<?php echo $linha['id_cliente']; ?>" 
                           onclick="return confirm('Tem certeza?');">Excluir</a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>