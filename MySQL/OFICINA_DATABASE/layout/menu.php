<?php
// Define o caminho base da sua aplicação.
// Ajuste "/oficina" se o seu projeto estiver noutra pasta.
$base_url = "/oficina"; 
?>
<nav class="menu-principal">
    <a href="<?php echo $base_url; ?>/index_clientes.php">Clientes</a>
    <a href="<?php echo $base_url; ?>/index_veiculos.php">Veículos</a>
    <a href="<?php echo $base_url; ?>/index_mecanicos.php">Mecânicos</a>
    <a href="<?php echo $base_url; ?>/index_pecas.php">Peças</a>
    <a href="<?php echo $base_url; ?>/index_servicos.php">Serviços</a>
    <a href="<?php echo $base_url; ?>/index_os.php">Ordens de Serviço</a>
</nav>