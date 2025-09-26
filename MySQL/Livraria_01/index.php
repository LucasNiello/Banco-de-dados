<?php
// index.php - Lista de livros (ordenável) com autor/editora
// Ajuste as credenciais abaixo se for diferente do seu ambiente
$dbHost = '127.0.0.1';
$dbPort = 3306;            // altere se seu MySQL usa outra porta
$dbUser = 'root';
$dbPass = 'senaisp';             // <-- coloque a senha aqui se tiver (ex: 'senaisp')
$dbName = 'LIVRARIA_LETRAS_E_CODIGOS';

// Conexão (modo mysqli procedural)
$mysqli = mysqli_connect($dbHost, $dbUser, $dbPass, $dbName, $dbPort);
if (!$mysqli) {
    die("Erro ao conectar ao MySQL: " . mysqli_connect_error());
}
mysqli_set_charset($mysqli, 'utf8mb4');

// Colunas permitidas para ordenação (whitelist)
$columns = [
    'ID_LIVRO','TITULO','ID_AUTOR_FK','ID_EDITORA_FK',
    'GENERO','PRECO','QUANTIDADE_ESTOQUE','DATA_PUBLICACAO',
    'AUTOR','EDITORA'
];

// Recebe parâmetros de GET com validação
$col = isset($_GET['column']) && in_array($_GET['column'], $columns) ? $_GET['column'] : 'TITULO';
$sort_order = (isset($_GET['sort']) && strtoupper($_GET['sort']) === 'DESC') ? 'DESC' : 'ASC';

// Para as colunas derivadas (AUTOR, EDITORA) mapeamos para expressão válida no ORDER BY
$orderExprMap = [
    'AUTOR' => 'A.NOME',
    'EDITORA' => 'E.NOME'
];
$orderBy = $orderExprMap[$col] ?? "L.$col";

// Monta a query com JOIN para trazer autor/editora (mais útil)
$sql = "
    SELECT
        L.ID_LIVRO,
        L.TITULO,
        L.GENERO,
        L.PRECO,
        L.QUANTIDADE_ESTOQUE,
        L.DATA_PUBLICACAO,
        A.NOME AS AUTOR,
        E.NOME AS EDITORA
    FROM LIVROS L
    LEFT JOIN AUTORES A ON L.ID_AUTOR_FK = A.ID_AUTOR
    LEFT JOIN EDITORAS E ON L.ID_EDITORA_FK = E.ID_EDITORA
    ORDER BY {$orderBy} {$sort_order}
";

$result = mysqli_query($mysqli, $sql);
if (!$result) {
    die("Erro na consulta: " . mysqli_error($mysqli));
}

// Helpers visuais
$up_or_down = $sort_order === 'ASC' ? '↑' : '↓';
$asc_or_desc = $sort_order === 'ASC' ? 'DESC' : 'ASC';

function esc($s) { return htmlspecialchars($s, ENT_QUOTES|ENT_SUBSTITUTE, 'UTF-8'); }
function money($v) { return number_format((float)$v, 2, ',', '.'); }

?>
<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Livraria — Lista de Livros</title>
<style>
    body{font-family:Inter,Segoe UI,Arial;margin:18px;background:#fafafa;color:#222}
    table{border-collapse:collapse;width:100%;background:#fff}
    th,td{padding:10px;border:1px solid #ddd;text-align:left}
    th a{color:inherit;text-decoration:none}
    th a:hover{text-decoration:underline}
    .muted{color:#666;font-size:0.9rem}
    .right{text-align:right}
    .small{font-size:0.9rem}
</style>
</head>
<body>
<h1>Livros cadastrados <span class="muted">/ banco: <?= esc($dbName) ?></span></h1>

<table>
    <thead>
        <tr>
            <th><a href="?column=TITULO&sort=<?= $asc_or_desc ?>">Título <?= $col === 'TITULO' ? $up_or_down : '' ?></a></th>
            <th><a href="?column=AUTOR&sort=<?= $asc_or_desc ?>">Autor <?= $col === 'AUTOR' ? $up_or_down : '' ?></a></th>
            <th><a href="?column=EDITORA&sort=<?= $asc_or_desc ?>">Editora <?= $col === 'EDITORA' ? $up_or_down : '' ?></a></th>
            <th><a href="?column=GENERO&sort=<?= $asc_or_desc ?>">Gênero <?= $col === 'GENERO' ? $up_or_down : '' ?></a></th>
            <th class="right"><a href="?column=QUANTIDADE_ESTOQUE&sort=<?= $asc_or_desc ?>">Estoque <?= $col === 'QUANTIDADE_ESTOQUE' ? $up_or_down : '' ?></a></th>
            <th class="right"><a href="?column=PRECO&sort=<?= $asc_or_desc ?>">Preço <?= $col === 'PRECO' ? $up_or_down : '' ?></a></th>
            <th class="small muted">Publicado</th>
        </tr>
    </thead>
    <tbody>
    <?php while ($row = mysqli_fetch_assoc($result)): ?>
        <tr>
            <td><?= esc($row['TITULO']) ?></td>
            <td><?= esc($row['AUTOR'] ?? '-') ?></td>
            <td><?= esc($row['EDITORA'] ?? '-') ?></td>
            <td><?= esc($row['GENERO'] ?? '-') ?></td>
            <td class="right"><?= (int)$row['QUANTIDADE_ESTOQUE'] ?></td>
            <td class="right">R$ <?= money($row['PRECO']) ?></td>
            <td class="small muted"><?= $row['DATA_PUBLICACAO'] ? esc($row['DATA_PUBLICACAO']) : '-' ?></td>
        </tr>
    <?php endwhile; ?>
    </tbody>
</table>

<?php
// liberar e fechar
mysqli_free_result($result);
mysqli_close($mysqli);
?>

</body>
</html>
