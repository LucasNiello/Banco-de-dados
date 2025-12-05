<?php include ROOT_PATH . '/views/layouts/header.php'; ?>

<h2>Novo Veículo</h2>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="index.php?controller=veiculo&action=store" method="POST">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Proprietário (Cliente)</label>
                    <select name="id_cliente" class="form-select" required>
                        <option value="">Selecione um cliente...</option>
                        <?php foreach($clientes as $c): ?>
                            <option value="<?= $c['id_cliente'] ?>"><?= $c['nome'] ?> (CPF: <?= $c['cpf'] ?>)</option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-md-6">
                    <label>Placa</label>
                    <input type="text" name="placa" class="form-control" maxlength="8" required>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-4">
                    <label>Marca</label>
                    <input type="text" name="marca" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Modelo</label>
                    <input type="text" name="modelo" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <label>Ano</label>
                    <input type="number" name="ano" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <label>Cor</label>
                    <input type="text" name="cor" class="form-control">
                </div>
            </div>
            <button type="submit" class="btn btn-success">Salvar Veículo</button>
            <a href="index.php?controller=veiculo&action=index" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>