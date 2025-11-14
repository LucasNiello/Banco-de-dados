<?php
include 'conexao.php';
$sql = "SELECT * FROM Mecanicos ORDER BY nome ASC";
$resultado = mysqli_query($conexao, $sql);
if (!$resultado) { die("Erro na consulta: " . mysqli_error($conexao)); }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Mecânicos</title>
    <link rel="stylesheet" href="estilo.css">
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Gestão de Mecânicos</h1>
    <a href="cadastrar_mecanicos.php" class="btn-novo">Cadastrar Novo Mecânico</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>CPF</th>
                <th>Especialidade</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($linha = mysqli_fetch_assoc($resultado)) { ?>
                <tr>
                    <td><?php echo $linha['id_mecanico']; ?></td>
                    <td><?php echo htmlspecialchars($linha['nome']); ?></td>
                    <td><?php echo htmlspecialchars($linha['cpf']); ?></td>
                    <td><?php echo htmlspecialchars($linha['especialidade']); ?></td>
                    <td>
                        <a href="editar_mecanicos.php?id=<?php echo $linha['id_mecanico']; ?>">Editar</a>
                        <a href="excluir_mecanicos.php?id=<?php echo $linha['id_mecanico']; ?>" 
                           onclick="return confirm('Tem certeza?');">Excluir</a>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
    <?php mysqli_close($conexao); ?>
</body>
</html>