<?php include 'views/layouts/header.php'; ?>

<h2>Novo Cliente</h2>
<div class="card shadow mt-3">
    <div class="card-body">
        <form action="index.php?controller=cliente&action=store" method="POST">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Nome Completo</label>
                    <input type="text" name="nome" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label>CPF</label>
                    <input type="text" name="cpf" class="form-control" required>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control">
                </div>
                <div class="col-md-6">
                    <label>Telefone</label>
                    <input type="text" name="telefone" class="form-control" required>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label>Endereço</label>
                    <input type="text" name="endereco" class="form-control">
                </div>
                <div class="col-md-4">
                    <label>Cidade</label>
                    <input type="text" name="cidade" class="form-control">
                </div>
                <div class="col-md-2">
                    <label>UF</label>
                    <input type="text" name="estado" class="form-control" maxlength="2">
                </div>
            </div>
            <button type="submit" class="btn btn-success">Salvar</button>
            <a href="index.php?controller=cliente&action=index" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</div>

<?php include 'views/layouts/footer.php'; ?>