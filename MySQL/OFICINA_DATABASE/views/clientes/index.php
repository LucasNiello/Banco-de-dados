<?php include 'views/layouts/header.php'; ?>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Gerenciar Clientes</h2>
    <a href="index.php?controller=cliente&action=create" class="btn btn-primary"><i class="fas fa-plus"></i> Novo Cliente</a>
</div>

<?php if(isset($_GET['msg'])): ?>
    <div class="alert alert-success">Operação realizada com sucesso!</div>
<?php endif; ?>

<div class="card shadow">
    <div class="card-body">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>CPF</th>
                    <th>Telefone</th>
                    <th>Cidade/UF</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($clientes as $c): ?>
                <tr>
                    <td><?= $c['id_cliente'] ?></td>
                    <td><?= htmlspecialchars($c['nome']) ?></td>
                    <td><?= $c['cpf'] ?></td>
                    <td><?= $c['telefone'] ?></td>
                    <td><?= $c['cidade'] . '/' . $c['estado'] ?></td>
                    <td>
                        <a href="index.php?controller=cliente&action=edit&id=<?= $c['id_cliente'] ?>" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i></a>
                        <a href="index.php?controller=cliente&action=delete&id=<?= $c['id_cliente'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza?');"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<?php include 'views/layouts/footer.php'; ?>