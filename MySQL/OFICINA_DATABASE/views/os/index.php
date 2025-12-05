<?php include ROOT_PATH . '/views/layouts/header.php'; ?>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Ordens de Serviço</h2>
    <a href="index.php?controller=os&action=create" class="btn btn-primary"><i class="fas fa-file-alt"></i> Nova OS</a>
</div>

<div class="card shadow">
    <div class="card-body">
        <div class="table-responsive"> <table class="table table-hover align-middle"> <thead>
                    <tr>
                        <th style="width: 10%">Nº OS</th>
                        <th style="width: 20%">Veículo</th>
                        <th style="width: 15%">Cliente</th>
                        <th style="width: 30%">Defeito Relatado</th> <th style="width: 10%">Status</th>
                        <th style="width: 10%">Data</th>
                        <th style="width: 5%">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <?php foreach($lista_os as $os): ?>
                    <?php 
                        $badgeClass = 'bg-secondary';
                        if($os['status'] == 'ABERTA') $badgeClass = 'bg-primary';
                        if($os['status'] == 'EM_ANDAMENTO') $badgeClass = 'bg-warning text-dark';
                        if($os['status'] == 'AGUARDANDO_PECAS') $badgeClass = 'bg-info text-dark';
                        if($os['status'] == 'CONCLUIDA') $badgeClass = 'bg-success';
                        if($os['status'] == 'CANCELADA') $badgeClass = 'bg-danger';
                    ?>
                    <tr>
                        <td><strong>#<?= $os['id_os'] ?></strong></td>
                        
                        <td>
                            <?= $os['modelo'] ?> <br> 
                            <small class="text-muted"><?= $os['placa'] ?></small>
                        </td>
                        
                        <td><?= $os['nome_cliente'] ?></td>
                        
                        <td style="white-space: pre-wrap; word-wrap: break-word; min-width: 200px;">
                            <?= htmlspecialchars($os['defeito_relatado']) ?>
                        </td>
                        
                        <td><span class="badge <?= $badgeClass ?>"><?= str_replace('_', ' ', $os['status']) ?></span></td>
                        
                        <td><?= date('d/m/Y', strtotime($os['data_abertura'])) ?></td>
                        
                        <td>
                            <a href="index.php?controller=os&action=edit&id=<?= $os['id_os'] ?>" class="btn btn-sm btn-warning" title="Editar Status">
                                <i class="fas fa-edit"></i>
                            </a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                    
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>