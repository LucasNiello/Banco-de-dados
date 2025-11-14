<?php
/*
 * Arquivo de Conexão com o Banco de Dados
 */

// 1. Definições do Servidor MySQL
$servidor = "localhost";
$usuario = "root";       
$senha = "SenaiSP"; 
$banco = "oficina_mecanica"; 

// 2. Criar a Conexão
$conexao = mysqli_connect($servidor, $usuario, $senha, $banco);

// 3. Checar a Conexão
if (!$conexao) {
    die("Falha na conexão: " . mysqli_connect_error());
}

// 4. Definir o Charset
mysqli_set_charset($conexao, "utf8mb4");
?>