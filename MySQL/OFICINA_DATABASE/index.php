<?php

// index.php (Roteador)

define('ROOT_PATH', __DIR__);

// Configurações iniciais
define('URL_BASE', 'http://localhost/oficina_mecanica'); // Ajuste conforme sua pasta

// Autoload simples (opcional, ou use requires manuais)
require_once 'config/Database.php';

// Captura controlador e ação da URL (ex: index.php?controller=cliente&action=create)
$controllerName = isset($_GET['controller']) ? $_GET['controller'] : 'home';
$actionName = isset($_GET['action']) ? $_GET['action'] : 'index';

// Formata o nome da classe (ex: cliente -> ClienteController)
$controllerClass = ucfirst($controllerName) . 'Controller';
$controllerFile = 'controllers/' . $controllerClass . '.php';

// Verifica se o arquivo do controller existe
if (file_exists($controllerFile)) {
    require_once $controllerFile;
    
    // Instancia o controller
    if (class_exists($controllerClass)) {
        $controller = new $controllerClass();
        
        // Verifica se o método (action) existe
        if (method_exists($controller, $actionName)) {
            $controller->$actionName();
        } else {
            echo "Erro: Ação '$actionName' não encontrada no controlador '$controllerClass'.";
        }
    } else {
        echo "Erro: Classe '$controllerClass' não encontrada.";
    }
} else {
    echo "Erro: Controlador '$controllerName' não encontrado. (Arquivo esperado: $controllerFile)";
}