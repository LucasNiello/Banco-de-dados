<?php
include 'conexao.php';

// Validação do ID da OS
if (!isset($_GET['id']) || empty($_GET['id'])) {
    header("Location: index_os.php");
    exit;
}
$id_os = (int)$_GET['id'];

// --- LÓGICA DE AÇÕES (POST) ---
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Ação: Atualizar Status/Diagnóstico
    if (isset($_POST['action']) && $_POST['action'] == 'update_os') {
        $status_os = mysqli_real_escape_string($conexao, $_POST['status_os']);
        $diagnostico_tecnico = mysqli_real_escape_string($conexao, $_POST['diagnostico_tecnico']);
        $sql_update_os = "UPDATE Ordens_Servico SET 
                            status_os = '$status_os', 
                            diagnostico_tecnico = '$diagnostico_tecnico' 
                          WHERE id_os = $id_os";
        mysqli_query($conexao, $sql_update_os);
    }
    
    // Ação: Adicionar Serviço
    if (isset($_POST['action']) && $_POST['action'] == 'add_servico') {
        $id_servico = (int)$_POST['id_servico'];
        $sql_add_servico = "INSERT INTO OS_Servicos (id_os, id_servico) VALUES ($id_os, $id_servico)";
        mysqli_query($conexao, $sql_add_servico);
    }
    
    // Ação: Adicionar Peça
    if (isset($_POST['action']) && $_POST['action'] == 'add_peca') {
        $id_peca = (int)$_POST['id_peca'];
        $quantidade = (int)$_POST['quantidade'];
        if ($quantidade > 0) {
            $sql_add_peca = "INSERT INTO OS_Pecas (id_os, id_peca, quantidade_utilizada) VALUES ($id_os, $id_peca, $quantidade)";
            mysqli_query($conexao, $sql_add_peca);
        }
    }
    
    // Ação: Adicionar Mecânico
    if (isset($_POST['action']) && $_POST['action'] == 'add_mecanico') {
        $id_mecanico = (int)$_POST['id_mecanico'];
        // Evita adicionar o mesmo mecânico duas vezes
        $check_sql = "SELECT * FROM OS_Mecanicos WHERE id_os = $id_os AND id_mecanico = $id_mecanico";
        $check_result = mysqli_query($conexao, $check_sql);
        if (mysqli_num_rows($check_result) == 0) {
            $sql_add_mecanico = "INSERT INTO OS_Mecanicos (id_os, id_mecanico) VALUES ($id_os, $id_mecanico)";
            mysqli_query($conexao, $sql_add_mecanico);
        }
    }
    
    // Redireciona para si mesmo para evitar reenvio do formulário
    header("Location: detalhes_os.php?id=" . $id_os);
    exit;
}

// --- LÓGICA DE DELEÇÃO (GET) ---
if (isset($_GET['delete_servico'])) {
    $id_os_servico = (int)$_GET['delete_servico'];
    $sql_del_servico = "DELETE FROM OS_Servicos WHERE id_os_servico = $id_os_servico AND id_os = $id_os";
    mysqli_query($conexao, $sql_del_servico);
    header("Location: detalhes_os.php?id=" . $id_os); exit;
}
if (isset($_GET['delete_peca'])) {
    $id_os_peca = (int)$_GET['delete_peca'];
    $sql_del_peca = "DELETE FROM OS_Pecas WHERE id_os_peca = $id_os_peca AND id_os = $id_os";
    mysqli_query($conexao, $sql_del_peca);
    header("Location: detalhes_os.php?id=" . $id_os); exit;
}
if (isset($_GET['delete_mecanico'])) {
    // Correção: O DDL usa (id_os, id_mecanico) como PK, não há ID único.
    $id_mecanico_a_remover = (int)$_GET['delete_mecanico'];
    $sql_del_mecanico = "DELETE FROM OS_Mecanicos WHERE id_mecanico = $id_mecanico_a_remover AND id_os = $id_os";
    mysqli_query($conexao, $sql_del_mecanico);
    header("Location: detalhes_os.php?id=" . $id_os); exit;
}


// --- BUSCAR DADOS PARA EXIBIÇÃO ---
$sql_os = "SELECT os.*, v.placa, v.modelo, v.marca, c.nome AS nome_cliente, c.telefone AS tel_cliente
           FROM Ordens_Servico os
           JOIN Veiculos v ON os.id_veiculo = v.id_veiculo
           JOIN Clientes c ON v.id_cliente = c.id_cliente
           WHERE os.id_os = $id_os";
$resultado_os = mysqli_query($conexao, $sql_os);
$os = mysqli_fetch_assoc($resultado_os);
if (!$os) { header("Location: index_os.php"); exit; } // Se OS não existe, volta

// Listas de "Catálogo" para os Dropdowns
$servicos_disponiveis = mysqli_query($conexao, "SELECT * FROM Servicos ORDER BY nome_servico");
$pecas_disponiveis = mysqli_query($conexao, "SELECT * FROM Pecas WHERE quantidade_estoque > 0 ORDER BY nome_peca");
$mecanicos_disponiveis = mysqli_query($conexao, "SELECT * FROM Mecanicos ORDER BY nome");

// Itens JÁ ADICIONADOS nesta OS
$servicos_na_os = mysqli_query($conexao, "SELECT oss.*, s.nome_servico, s.valor_mao_obra FROM OS_Servicos oss JOIN Servicos s ON oss.id_servico = s.id_servico WHERE oss.id_os = $id_os");
$pecas_na_os = mysqli_query($conexao, "SELECT osp.*, p.nome_peca, p.preco_unitario FROM OS_Pecas osp JOIN Pecas p ON osp.id_peca = p.id_peca WHERE osp.id_os = $id_os");
$mecanicos_na_os = mysqli_query($conexao, "SELECT osm.*, m.nome, m.especialidade FROM OS_Mecanicos osm JOIN Mecanicos m ON osm.id_mecanico = m.id_mecanico WHERE osm.id_os = $id_os");

// Calcular Totais
$total_servicos = 0;
while ($serv = @mysqli_fetch_assoc($servicos_na_os)) { $total_servicos += $serv['valor_mao_obra']; }
@mysqli_data_seek($servicos_na_os, 0); 
$total_pecas = 0;
while ($peca = @mysqli_fetch_assoc($pecas_na_os)) { $total_pecas += ($peca['preco_unitario'] * $peca['quantidade_utilizada']); }
@mysqli_data_seek($pecas_na_os, 0);
$total_geral = $total_servicos + $total_pecas;
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Detalhes da OS: <?php echo $id_os; ?></title>
    <link rel="stylesheet" href="estilo.css">
    <style>
        /* Estilos específicos para esta página */
        body { background-color: #fff; }
        .os-header { background-color: #f4f4f4; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .os-header h1 { margin-top: 0; } .os-header p { margin: 5px 0; font-size: 16px; }
        .os-header strong { color: #333; }
        .os-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .os-section { background-color: #fdfdfd; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .os-section h2 { margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .form-add { display: flex; gap: 10px; margin-top: 15px; }
        .form-add select, .form-add input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 4px; }
        .form-add input[type="number"] { max-width: 80px; }
        .form-add button { padding: 10px 15px; }
        .item-table { width: 100%; margin-top: 15px; border-collapse: collapse; }
        .item-table th, .item-table td { text-align: left; padding: 10px; border-bottom: 1px solid #eee; }
        .item-table th { background-color: #f9f9f9; }
        .item-table .col-preco { text-align: right; }
        .item-table .col-acao { text-align: center; width: 60px; }
        .link-excluir { color: #dc3545; font-weight: bold; font-size: 14px; }
        .total-box { background-color: #343a40; color: white; padding: 20px; margin-top: 20px; border-radius: 8px; text-align: right; }
        .total-box h2 { margin: 0; font-size: 20px; color: #ffc107; }
        .total-box p { margin: 5px 0 0 0; font-size: 24px; font-weight: bold; }
        textarea { width: 100%; min-height: 80px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; background-color: white; }
    </style>
</head>
<body>
    <?php include 'menu.php'; ?>

    <div class="os-header">
        <h1>Detalhes da Ordem de Serviço #<?php echo $os['id_os']; ?></h1>
        <p><strong>Cliente:</strong> <?php echo htmlspecialchars($os['nome_cliente']); ?> (Tel: <?php echo htmlspecialchars($os['tel_cliente']); ?>)</p>
        <p><strong>Veículo:</strong> <?php echo htmlspecialchars($os['marca'] . ' ' . $os['modelo']); ?> (Placa: <?php echo htmlspecialchars($os['placa']); ?>)</p>
        <p><strong>Problema Relatado:</strong> <?php echo htmlspecialchars($os['descricao_problema']); ?></p>
        <p><strong>Data de Abertura:</strong> <?php echo date('d/m/Y H:i', strtotime($os['data_abertura'])); ?></p>
        <a href="index_os.php" class="link-voltar" style="font-weight:bold;">❮ Voltar para a Lista de OS</a>
    </div>

    <div class="os-grid">
        <div class="os-section">
            <h2>Status e Diagnóstico Técnico</h2>
            <form action="detalhes_os.php?id=<?php echo $id_os; ?>" method="POST">
                <input type="hidden" name="action" value="update_os">
                <div>
                    <label for="status_os">Status da OS:</label>
                    <select id="status_os" name="status_os">
                        <option value="Aberta" <?php echo ($os['status_os'] == 'Aberta') ? 'selected' : ''; ?>>Aberta</option>
                        <option value="Em Análise" <?php echo ($os['status_os'] == 'Em Análise') ? 'selected' : ''; ?>>Em Análise</option>
                        <option value="Aguardando Aprovação" <?php echo ($os['status_os'] == 'Aguardando Aprovação') ? 'selected' : ''; ?>>Aguardando Aprovação</option>
                        <option value="Em Execução" <?php echo ($os['status_os'] == 'Em Execução') ? 'selected' : ''; ?>>Em Execução</option>
                        <option value="Aguardando Peças" <?php echo ($os['status_os'] == 'Aguardando Peças') ? 'selected' : ''; ?>>Aguardando Peças</option>
                        <option value="Concluída" <?php echo ($os['status_os'] == 'Concluída') ? 'selected' : ''; ?>>Concluída</option>
                        <option value="Faturada/Paga" <?php echo ($os['status_os'] == 'Faturada/Paga') ? 'selected' : ''; ?>>Faturada/Paga</option>
                    </select>
                </div>
                <div>
                    <label for="diagnostico_tecnico">Diagnóstico Técnico:</label>
                    <textarea id="diagnostico_tecnico" name="diagnostico_tecnico"><?php echo htmlspecialchars($os['diagnostico_tecnico']); ?></textarea>
                </div>
                <button type="submit" class="btn-atualizar">Atualizar OS</button>
            </form>
        </div>
        
        <div class="os-section">
            <h2>Mecânicos na OS</h2>
            <form action="detalhes_os.php?id=<?php echo $id_os; ?>" method="POST" class="form-add">
                <input type="hidden" name="action" value="add_mecanico">
                <select name="id_mecanico" required>
                    <option value="">Selecione um mecânico...</option>
                    <?php while ($m = @mysqli_fetch_assoc($mecanicos_disponiveis)) { ?>
                        <option value="<?php echo $m['id_mecanico']; ?>"><?php echo htmlspecialchars($m['nome']); ?></option>
                    <?php } ?>
                </select>
                <button type="submit" class="btn-salvar">Adicionar</button>
            </form>
            <table class="item-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Especialidade</th>
                        <th class="col-acao">Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($m = @mysqli_fetch_assoc($mecanicos_na_os)) { ?>
                        <tr>
                            <td><?php echo htmlspecialchars($m['nome']); ?></td>
                            <td><?php echo htmlspecialchars($m['especialidade']); ?></td>
                            <td class="col-acao">
                                <a href="detalhes_os.php?id=<?php echo $id_os; ?>&delete_mecanico=<?php echo $m['id_mecanico']; ?>" class="link-excluir" onclick="return confirm('Remover mecânico?');">X</a>
                            </td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
    </div> 

    <div class="os-section" style="margin-top: 20px;">
        <h2>Serviços (Mão de Obra)</h2>
        <form action="detalhes_os.php?id=<?php echo $id_os; ?>" method="POST" class="form-add">
            <input type="hidden" name="action" value="add_servico">
            <select name="id_servico" required>
                <option value="">Selecione um serviço...</option>
                <?php @mysqli_data_seek($servicos_disponiveis, 0); ?>
                <?php while ($s = @mysqli_fetch_assoc($servicos_disponiveis)) { ?>
                    <option value="<?php echo $s['id_servico']; ?>"><?php echo htmlspecialchars($s['nome_servico']) . ' (R$ ' . number_format($s['valor_mao_obra'], 2, ',', '.') . ')'; ?></option>
                <?php } ?>
            </select>
            <button type="submit" class="btn-salvar">Adicionar</button>
        </form>
        <table class="item-table">
            <thead>
                <tr>
                    <th>Serviço</th>
                    <th class="col-preco">Valor (R$)</th>
                    <th class="col-acao">Ação</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($s = @mysqli_fetch_assoc($servicos_na_os)) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($s['nome_servico']); ?></td>
                        <td class="col-preco"><?php echo number_format($s['valor_mao_obra'], 2, ',', '.'); ?></td>
                        <td class="col-acao">
                            <a href="detalhes_os.php?id=<?php echo $id_os; ?>&delete_servico=<?php echo $s['id_os_servico']; ?>" class="link-excluir" onclick="return confirm('Remover serviço?');">X</a>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>

    <div class="os-section" style="margin-top: 20px;">
        <h2>Peças (Estoque)</h2>
        <form action="detalhes_os.php?id=<?php echo $id_os; ?>" method="POST" class="form-add">
            <input type="hidden" name="action" value="add_peca">
            <select name="id_peca" required>
                <option value="">Selecione uma peça...</option>
                <?php @mysqli_data_seek($pecas_disponiveis, 0); ?>
                <?php while ($p = @mysqli_fetch_assoc($pecas_disponiveis)) { ?>
                    <option value="<?php echo $p['id_peca']; ?>"><?php echo htmlspecialchars($p['nome_peca']) . ' (R$ ' . number_format($p['preco_unitario'], 2, ',', '.') . ')'; ?></option>
                <?php } ?>
            </select>
            <input type="number" name="quantidade" value="1" min="1" required>
            <button type="submit" class="btn-salvar">Adicionar</button>
        </form>
        <table class="item-table">
            <thead>
                <tr>
                    <th>Peça</th>
                    <th class="col-preco">Preço Unit. (R$)</th>
                    <th class="col-preco">Qtd.</th>
                    <th class="col-preco">Subtotal (R$)</th>
                    <th class="col-acao">Ação</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($p = @mysqli_fetch_assoc($pecas_na_os)) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($p['nome_peca']); ?></td>
                        <td class="col-preco"><?php echo number_format($p['preco_unitario'], 2, ',', '.'); ?></td>
                        <td class="col-preco"><?php echo $p['quantidade_utilizada']; ?></td>
                        <td class="col-preco"><?php echo number_format($p['preco_unitario'] * $p['quantidade_utilizada'], 2, ',', '.'); ?></td>
                        <td class="col-acao">
                            <a href="detalhes_os.php?id=<?php echo $id_os; ?>&delete_peca=<?php echo $p['id_os_peca']; ?>" class="link-excluir" onclick="return confirm('Remover peça?');">X</a>
                        </td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
    
    <div class="total-box">
        <h2>Total Serviços: R$ <?php echo number_format($total_servicos, 2, ',', '.'); ?></h2>
        <h2>Total Peças: R$ <?php echo number_format($total_pecas, 2, ',', '.'); ?></h2>
        <p>Valor Total da OS: R$ <?php echo number_format($total_geral, 2, ',', '.'); ?></p>
    </div>

    <?php
    mysqli_close($conexao);
    ?>
</body>
</html>