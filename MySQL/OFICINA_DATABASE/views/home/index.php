<?php include ROOT_PATH . '/views/layouts/header.php'; ?>
<div class="row mb-4">
    <div class="col-12">
        <h2><i class="fas fa-tachometer-alt"></i> Dashboard</h2>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-3">
        <div class="card text-white bg-primary shadow h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase">Clientes</h6>
                        <h2 class="mb-0"><?= $stats['clientes'] ?></h2>
                    </div>
                    <div class="fs-1"><i class="fas fa-users"></i></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-success shadow h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase">Veículos</h6>
                        <h2 class="mb-0"><?= $stats['veiculos'] ?></h2>
                    </div>
                    <div class="fs-1"><i class="fas fa-car"></i></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-warning shadow h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase">OS Abertas</h6>
                        <h2 class="mb-0"><?= $stats['os_abertas'] ?></h2>
                    </div>
                    <div class="fs-1"><i class="fas fa-clipboard-list"></i></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-white bg-info shadow h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="card-title text-uppercase">Faturamento/Mês</h6>
                        <h2 class="mb-0">R$ <?= number_format($stats['faturamento_mes'], 2, ',', '.') ?></h2>
                    </div>
                    <div class="fs-1"><i class="fas fa-dollar-sign"></i></div>
                </div>
            </div>
            <div class="card-footer bg-info bg-opacity-75">
                <small>OS Concluídas: <?= $stats['os_mes'] ?></small>
            </div>
        </div>
    </div>
</div>

<div class="card shadow">
    <div class="card-header bg-secondary text-white">
        <h5 class="mb-0">Últimas Ordens de Serviço</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>OS</th>
                        <th>Cliente</th>
                        <th>Veículo</th>
                        <th>Data</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach($stats['ultimas_os'] as $os): ?>
                    <tr>
                        <td><strong><?= $os['numero_os'] ?></strong></td>
                        <td><?= htmlspecialchars($os['cliente']) ?></td>
                        <td><?= $os['marca'] . ' ' . $os['modelo'] ?></td>
                        <td><?= date('d/m/Y', strtotime($os['data_abertura'])) ?></td>
                        <td><span class="badge bg-secondary"><?= $os['status'] ?></span></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>