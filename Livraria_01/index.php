<?php
// comunicação com o banco de dados
$mysqli = mysqli_connect("localhost", "root", "senaisp", "LIVRARIA_LETRAS_E_CODIGOS");

// verificar conexão
if (!$mysqli) {
    die("Erro ao conectar: " . mysqli_connect_error());
}

// segurança em buscar valores no Banco
$collumns = array('ID_LIVRO', 'TITULO', 'ID_AUTOR_FK', 'ID_EDITORA_FK', 'GENERO', 'PRECO', 'QUANTIDADE_ESTOQUE', 'DATA_PUBLICACAO');

// TRAZER CONTEÚDO DO BANCO
$column = isset($_GET['column']) && in_array($_GET['column'], $collumns) ? $_GET['column'] : $collumns[0];

// Trazer dados em ordem crescente ou decrescente
$sort_order = isset($_GET['sort']) && $_GET['sort'] === 'DESC' ? 'DESC' : 'ASC';

// verificar dados no banco
if ($result = $mysqli->query("SELECT * FROM LIVROS ORDER BY $column $sort_order")) {
    $up_or_down = $sort_order == 'ASC' ? '↑' : '↓';
    $asc_or_desc = $sort_order == 'ASC' ? 'DESC' : 'ASC';
    $add_class = ' class="highlight"';
} else {
    echo "Erro na consulta: " . $mysqli->error;
    exit;
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banco de dados - LIVRARIA</title>
</head>
<body>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th><a href="index.php?column=TITULO&sort=<?php echo $asc_or_desc; ?>">Título <?php echo $column == 'TITULO' ? $up_or_down : ''; ?></a></th>
            <th><a href="index.php?column=QUANTIDADE_ESTOQUE&sort=<?php echo $asc_or_desc; ?>">Quantidade <?php echo $column == 'QUANTIDADE_ESTOQUE' ? $up_or_down : ''; ?></a></th>
            <th><a href="index.php?column=GENERO&sort=<?php echo $asc_or_desc; ?>">Gênero <?php echo $column == 'GENERO' ? $up_or_down : ''; ?></a></th>
            <th><a href="index.php?column=PRECO&sort=<?php echo $asc_or_desc; ?>">Preço <?php echo $column == 'PRECO' ? $up_or_down : ''; ?></a></th>
        </tr>
        <?php 
        // Loop para mostrar os registros
        while ($row = $result->fetch_assoc()) { ?>
            <tr>
                <td><?php echo htmlspecialchars($row['TITULO']); ?></td>
                <td><?php echo $row['QUANTIDADE_ESTOQUE']; ?></td>
                <td><?php echo htmlspecialchars($row['GENERO']); ?></td>
                <td><?php echo $row['PRECO']; ?></td>
            </tr>
        <?php } 
        // LIBERAR resultado fora do loop (corrigido)
        $result->free(); 
        // FECHAR CONEXÃO COM BANCO (boa prática)
        $mysqli->close();
        ?>
    </table>        
</body>
</html>
