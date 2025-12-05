<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Oficina Mecânica</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.php"><i class="fas fa-wrench"></i> OficinaSystem</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
<ul class="navbar-nav">
    <li class="nav-item">
        <a class="nav-link" href="index.php">Dashboard</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index.php?controller=cliente&action=index">Clientes</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index.php?controller=veiculo&action=index">Veículos</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="index.php?controller=os&action=index">Ordens de Serviço</a>
    </li>
</ul>    </div>
  </div>
</nav>

<div class="container">