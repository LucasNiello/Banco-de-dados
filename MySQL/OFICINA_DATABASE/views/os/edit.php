<?php include ROOT_PATH . '/views/layouts/header.php'; ?>

<h2>Editar Ordem de Serviço #<?= $this->os->id_os ?></h2>

<div class="card shadow mt-3">
    <div class="card-header bg-light">
        <strong>Veículo:</strong> <?= $this->os->modelo ?> (<?= $this->os->placa ?>) - 
        <strong>Cliente:</strong> <?= $this->os->nome_cliente ?>
    </div>
    <div class="card-body">
        <form action="index.php?controller=os&action=update" method="POST">
            <input type="hidden" name="id_os" value="<?= $this->os->id_os ?>">

            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Status da OS</label>
                    <select name="status" class="form-select" required>
                        <option value="ABERTA" <?= $this->os->status == 'ABERTA' ? 'selected' : '' ?>>ABERTA</option>
                        <option value="EM_ANDAMENTO" <?= $this->os->status == 'EM_ANDAMENTO' ? 'selected' : '' ?>>EM ANDAMENTO</option>
                        <option value="AGUARDANDO_PECAS" <?= $this->os->status == 'AGUARDANDO_PECAS' ? 'selected' : '' ?>>AGUARDANDO PEÇAS</option>
                        <option value="CONCLUIDA" <?= $this->os->status == 'CONCLUIDA' ? 'selected' : '' ?>>CONCLUÍDA</option>
                        <option value="CANCELADA" <?= $this->os->status == 'CANCELADA' ? 'selected' : '' ?>>CANCELADA</option>
                    </select>
                </div>
                
                <div class="col-md-6">
                    <label>Valor Final (R$)</label>
                    <input type="number" step="0.01" name="valor_final" class="form-control" value="<?= $this->os->valor_final ?>">
                    <small class="text-muted">Preencha ao concluir o serviço.</small>
                </div>
            </div>

            <div class="mb-3">
                <label>Descrição do Problema / Serviço Realizado</label>
                <textarea name="defeito_relatado" class="form-control" rows="5" required><?= $this->os->defeito_relatado ?></textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Atualizar Status</button>
            <a href="index.php?controller=os&action=index" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</div>

<?php include ROOT_PATH . '/views/layouts/footer.php'; ?>