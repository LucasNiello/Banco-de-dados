<?php
include 'conexao.php';

// Lógica de Inserção (POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_veiculo = (int)$_POST['id_veiculo'];
    $descricao_problema = mysqli_real_escape_string($conexao, $_POST['descricao_problema']);
    $status_os = mysqli_real_escape_string($conexao, $_POST['status_os']);
    
    $sql = "INSERT INTO Ordens_Servico (id_veiculo, descricao_problema, status_os) 
            VALUES ($id_veiculo, '$descricao_problema', '$status_os')";

    if (mysqli_query($conexao, $sql)) {
        $id_os_criada = mysqli_insert_id($conexao);
        header("Location: detalhes_os.php?id=" . $id_os_criada);
        exit;
    } else {
        echo "Erro ao abrir OS: " . mysqli_error($conexao);
    }
}

// Lógica de busca para o formulário (GET)
$sql_veiculos = "SELECT v.id_veiculo, v.placa, v.modelo, c.nome AS nome_cliente 
                 FROM Veiculos v
                 JOIN Clientes c ON v.id_cliente = c.id_cliente
                 ORDER BY c.nome, v.modelo";
$resultado_veiculos = mysqli_query($conexao, $sql_veiculos);
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Abrir Nova Ordem de Serviço</title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        textarea {
            width: 100%; padding: 10px; box-sizing: border-box;
            border: 1px solid #ddd; border-radius: 4px; min-height: 100px;
        }
        select {
             width: 100%; padding: 10px; box-sizing: border-box;
             border: 1px solid #ddd; border-radius: 4px; background-color: white;
        }
    </style>
</head>
<body>
    <?php include 'menu.php'; ?>

    <h1>Abrir Nova Ordem de Serviço</h1>
    <form action="cadastrar_os.php" method="POST">
        <div>
            <label for="id_veiculo">Veículo:</label>
            <select id="id_veiculo" name="id_veiculo" required>
                <option value="">Selecione um veículo...</option>
                <?php
                if (mysqli_num_rows($resultado_veiculos) > 0) {
                    while ($veiculo = mysqli_fetch_assoc($resultado_veiculos)) {
                        $nome_exibicao = $veiculo['nome_cliente'] . ' - ' . $veiculo['modelo'] . ' (' . $veiculo['placa'] . ')';
                        echo '<option value="' . $veiculo['id_veiculo'] . '">' 
                             . htmlspecialchars($nome_exibicao)
                             . '</option>';
                    }
                }
                ?>
            </select>
        </div>
        <div>
            <label for="descricao_problema">Descrição do Problema (Relato do Cliente):</label>
            <textarea id="descricao_problema" name="descricao_problema" required></textarea>
        </div>
        <div>
            <label for="status_os">Status Inicial:</label>
            <select id="status_os" name="status_os" required>
                <option value="Aberta" selected>Aberta</option>
                <option value="Em Análise">Em Análise</option>
                <option value="Aguardando Aprovação">Aguardando Aprovação</option>
            </select>
        </div>
        <div>
            <button type="submit" class="btn-salvar">Abrir e Adicionar Itens</button>
        </div>
    </form>
    <a href="index_os.php" class="link-voltar">Cancelar (Voltar para a Lista)</a>
    <?php mysqli_close($conexao); ?>
</body>
</html>