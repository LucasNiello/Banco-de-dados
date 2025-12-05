<?php include ROOT_PATH . '/views/layouts/header.php'; ?>

<h2>Abrir Nova Ordem de Serviço</h2>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="index.php?controller=os&action=store" method="POST">
            <div class="row mb-3">
                <div class="col-md-12">
                    <label>Selecione o Veículo</label>
                    <select name="id_veiculo" class="form-select" required>
                        <option value="">Escolha um veículo...</option>
                        <?php foreach($veiculos as $v): ?>
                            <option value="<?= $v['id_veiculo'] ?>">
                                <?= strtoupper($v['placa']) ?> - <?= $v['modelo'] ?> (Dono: <?= $v['nome_dono'] ?>)
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="mb-3">
                <label>Descrição do Problema / Serviço</label>
                <textarea name="descricao_problema" class="form-control" rows="4" required placeholder="Ex: Cliente relata barulho no freio..."></textarea>
            </div>
            
            <button type="submit" class="btn btn-success">Abrir OS</button>
            <a href="index.php?controller=os&action=index" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>