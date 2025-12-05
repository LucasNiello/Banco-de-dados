<?php include ROOT_PATH . '/views/layouts/header.php'; ?>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Gerenciar Veículos</h2>
    <a href="index.php?controller=veiculo&action=create" class="btn btn-primary"><i class="fas fa-plus"></i> Novo Veículo</a>
</div>

<div class="card shadow">
    <div class="card-body">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Placa</th>
                    <th>Modelo/Marca</th>
                    <th>Ano</th>
                    <th>Proprietário</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($veiculos as $v): ?>
                <tr>
                    <td><strong><?= strtoupper($v['placa']) ?></strong></td>
                    <td><?= $v['modelo'] ?> - <?= $v['marca'] ?></td>
                    <td><?= $v['ano'] ?></td>
                    <td><?= $v['nome_dono'] ?></td>
                    <td>
                        <a href="index.php?controller=veiculo&action=delete&id=<?= $v['id_veiculo'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Excluir este veículo?');"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>