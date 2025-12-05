-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: oficina_mecanica
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endereco` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cidade` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `idx_cpf` (`cpf`),
  KEY `idx_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'João da Silva','123.456.789-00','(19) 98765-4321','joao.silva@email.com','Rua das Flores, 123','Campinas','SP','2025-12-05 17:12:14',1),(2,'Maria Santos','987.654.321-00','(19) 97654-3210','maria.santos@email.com','Av. Principal, 456','Campinas','SP','2025-12-05 17:12:14',1),(3,'Pedro Oliveira','456.789.123-00','(19) 96543-2109','pedro.oliveira@email.com','Rua do Comércio, 789','Valinhos','SP','2025-12-05 17:12:14',1),(4,'Ana Costa','789.123.456-00','(19) 95432-1098','ana.costa@email.com','Av. Brasil, 321','Campinas','SP','2025-12-05 17:12:14',1),(5,'Carlos Mendes','321.654.987-00','(19) 94321-0987','carlos.mendes@email.com','Rua São Paulo, 654','Indaiatuba','SP','2025-12-05 17:12:14',1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

--
-- Table structure for table `mecanicos`
--

DROP TABLE IF EXISTS `mecanicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mecanicos` (
  `id_mecanico` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidade` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `data_admissao` date NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_mecanico`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `idx_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mecanicos`
--

/*!40000 ALTER TABLE `mecanicos` DISABLE KEYS */;
INSERT INTO `mecanicos` VALUES (1,'Roberto Mecânico','111.222.333-44','(19) 91111-1111','Motor e Transmissão',3500.00,'2020-01-15',1),(2,'Fernando Silva','222.333.444-55','(19) 92222-2222','Suspensão e Freios',3200.00,'2019-06-20',1),(3,'Lucas Santos','333.444.555-66','(19) 93333-3333','Elétrica',3800.00,'2021-03-10',1),(4,'Marcos Alves','444.555.666-77','(19) 94444-4444','Serviços Gerais',2800.00,'2022-08-05',1);
/*!40000 ALTER TABLE `mecanicos` ENABLE KEYS */;

--
-- Table structure for table `ordens_servico`
--

DROP TABLE IF EXISTS `ordens_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_servico` (
  `id_os` int NOT NULL AUTO_INCREMENT,
  `numero_os` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_veiculo` int NOT NULL,
  `data_abertura` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `data_conclusao` datetime DEFAULT NULL,
  `status` enum('ABERTA','EM_ANDAMENTO','AGUARDANDO_PECAS','CONCLUIDA','CANCELADA') COLLATE utf8mb4_unicode_ci DEFAULT 'ABERTA',
  `km_veiculo` int DEFAULT NULL,
  `defeito_relatado` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacoes` text COLLATE utf8mb4_unicode_ci,
  `valor_total` decimal(10,2) DEFAULT '0.00',
  `desconto` decimal(10,2) DEFAULT '0.00',
  `valor_final` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_os`),
  UNIQUE KEY `numero_os` (`numero_os`),
  KEY `id_veiculo` (`id_veiculo`),
  KEY `idx_numero_os` (`numero_os`),
  KEY `idx_status` (`status`),
  KEY `idx_data` (`data_abertura`),
  CONSTRAINT `ordens_servico_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_servico`
--

/*!40000 ALTER TABLE `ordens_servico` DISABLE KEYS */;
INSERT INTO `ordens_servico` VALUES (1,'OS-2024-001',1,'2025-12-05 17:12:14',NULL,'CONCLUIDA',45000,'Troca de óleo preventiva','Cliente solicita óleo sintético',285.00,0.00,285.00),(2,'OS-2024-002',3,'2025-12-05 17:12:14',NULL,'CONCLUIDA',35000,'Ruído ao frear','Pastilhas desgastadas',300.00,0.00,300.00),(3,'OS-2024-003',4,'2025-12-05 17:12:14',NULL,'EM_ANDAMENTO',42000,'Revisão dos 40 mil km','Revisão programada',670.00,0.00,670.00),(4,'OS-2024-004',2,'2025-12-05 17:12:14',NULL,'ABERTA',78000,'Motor falhando','Cliente relata perda de potência',222.00,0.00,222.00),(5,'OS-2024-005',5,'2025-12-05 17:12:14',NULL,'EM_ANDAMENTO',28000,'Peça paralela.sdfghjhgfdklsnvlkzbdvklçzjdbfvlkjdzbçvkjbzdçkvjhbçnfdvjabçdfkjg\r\n\r\nsdkjvbskdjbvs\r\n\r\nsdlvjbskdjbv','Aguardando bateria nova',0.00,0.00,0.00);
/*!40000 ALTER TABLE `ordens_servico` ENABLE KEYS */;

--
-- Table structure for table `os_mecanicos`
--

DROP TABLE IF EXISTS `os_mecanicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_mecanicos` (
  `id_os_mecanico` int NOT NULL AUTO_INCREMENT,
  `id_os` int NOT NULL,
  `id_mecanico` int NOT NULL,
  `data_inicio` datetime DEFAULT NULL,
  `data_fim` datetime DEFAULT NULL,
  PRIMARY KEY (`id_os_mecanico`),
  UNIQUE KEY `unique_os_mecanico` (`id_os`,`id_mecanico`),
  KEY `id_mecanico` (`id_mecanico`),
  CONSTRAINT `os_mecanicos_ibfk_1` FOREIGN KEY (`id_os`) REFERENCES `ordens_servico` (`id_os`) ON DELETE CASCADE,
  CONSTRAINT `os_mecanicos_ibfk_2` FOREIGN KEY (`id_mecanico`) REFERENCES `mecanicos` (`id_mecanico`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_mecanicos`
--

/*!40000 ALTER TABLE `os_mecanicos` DISABLE KEYS */;
INSERT INTO `os_mecanicos` VALUES (1,1,1,'2024-11-01 08:00:00','2024-11-01 09:00:00'),(2,2,2,'2024-11-02 10:00:00','2024-11-02 11:30:00'),(3,3,1,'2024-11-05 08:00:00',NULL),(4,3,3,'2024-11-05 08:30:00',NULL),(5,4,1,'2024-11-10 14:00:00',NULL),(6,5,3,'2024-11-12 09:00:00',NULL);
/*!40000 ALTER TABLE `os_mecanicos` ENABLE KEYS */;

--
-- Table structure for table `os_pecas`
--

DROP TABLE IF EXISTS `os_pecas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_pecas` (
  `id_os_peca` int NOT NULL AUTO_INCREMENT,
  `id_os` int NOT NULL,
  `id_peca` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) GENERATED ALWAYS AS ((`quantidade` * `valor_unitario`)) STORED,
  PRIMARY KEY (`id_os_peca`),
  KEY `id_os` (`id_os`),
  KEY `id_peca` (`id_peca`),
  CONSTRAINT `os_pecas_ibfk_1` FOREIGN KEY (`id_os`) REFERENCES `ordens_servico` (`id_os`) ON DELETE CASCADE,
  CONSTRAINT `os_pecas_ibfk_2` FOREIGN KEY (`id_peca`) REFERENCES `pecas` (`id_peca`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_pecas`
--

/*!40000 ALTER TABLE `os_pecas` DISABLE KEYS */;
INSERT INTO `os_pecas` (`id_os_peca`, `id_os`, `id_peca`, `quantidade`, `valor_unitario`) VALUES (1,1,1,4,45.00),(2,1,2,1,25.00),(3,2,4,1,180.00),(4,3,1,4,45.00),(5,3,2,1,25.00),(6,3,3,1,35.00),(7,4,7,4,18.00);
/*!40000 ALTER TABLE `os_pecas` ENABLE KEYS */;

--
-- Table structure for table `os_servicos`
--

DROP TABLE IF EXISTS `os_servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `os_servicos` (
  `id_os_servico` int NOT NULL AUTO_INCREMENT,
  `id_os` int NOT NULL,
  `id_servico` int NOT NULL,
  `quantidade` int DEFAULT '1',
  `valor_unitario` decimal(10,2) NOT NULL,
  `valor_total` decimal(10,2) GENERATED ALWAYS AS ((`quantidade` * `valor_unitario`)) STORED,
  PRIMARY KEY (`id_os_servico`),
  KEY `id_os` (`id_os`),
  KEY `id_servico` (`id_servico`),
  CONSTRAINT `os_servicos_ibfk_1` FOREIGN KEY (`id_os`) REFERENCES `ordens_servico` (`id_os`) ON DELETE CASCADE,
  CONSTRAINT `os_servicos_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `os_servicos`
--

/*!40000 ALTER TABLE `os_servicos` DISABLE KEYS */;
INSERT INTO `os_servicos` (`id_os_servico`, `id_os`, `id_servico`, `quantidade`, `valor_unitario`) VALUES (1,1,1,1,80.00),(2,2,5,1,120.00),(3,3,4,1,350.00),(4,3,1,1,80.00),(5,4,7,1,150.00);
/*!40000 ALTER TABLE `os_servicos` ENABLE KEYS */;

--
-- Table structure for table `pecas`
--

DROP TABLE IF EXISTS `pecas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pecas` (
  `id_peca` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `marca` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `quantidade_estoque` int DEFAULT '0',
  `estoque_minimo` int DEFAULT '5',
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_peca`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `idx_codigo` (`codigo`),
  KEY `idx_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pecas`
--

/*!40000 ALTER TABLE `pecas` DISABLE KEYS */;
INSERT INTO `pecas` VALUES (1,'P001','Óleo Lubrificante 5W30','Óleo sintético 1L','Mobil',45.00,50,10,1),(2,'P002','Filtro de Óleo','Filtro padrão','Mann',25.00,40,8,1),(3,'P003','Filtro de Ar','Filtro de ar motor','Bosch',35.00,30,6,1),(4,'P004','Pastilha de Freio Dianteira','Jogo completo','Fras-le',180.00,20,4,1),(5,'P005','Pastilha de Freio Traseira','Jogo completo','Fras-le',150.00,20,4,1),(6,'P006','Correia Dentada','Correia sincronizadora','Gates',280.00,10,3,1),(7,'P007','Vela de Ignição','Vela comum','NGK',18.00,60,12,1),(8,'P008','Bateria 60Ah','Bateria automotiva','Moura',450.00,8,2,1),(9,'P009','Palheta Limpador','Par de palhetas','Bosch',65.00,25,5,1),(10,'P010','Fluido de Freio','DOT 4 500ml','Mobil',28.00,35,8,1);
/*!40000 ALTER TABLE `pecas` ENABLE KEYS */;

--
-- Table structure for table `servicos`
--

DROP TABLE IF EXISTS `servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicos` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `valor_mao_obra` decimal(10,2) NOT NULL,
  `tempo_estimado` int DEFAULT NULL COMMENT 'Tempo em minutos',
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_servico`),
  KEY `idx_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicos`
--

/*!40000 ALTER TABLE `servicos` DISABLE KEYS */;
INSERT INTO `servicos` VALUES (1,'Troca de Óleo','Troca de óleo lubrificante e filtro',80.00,30,1),(2,'Alinhamento','Alinhamento de direção',100.00,45,1),(3,'Balanceamento','Balanceamento de rodas',80.00,30,1),(4,'Revisão Completa','Revisão de todos os sistemas',350.00,180,1),(5,'Troca de Pastilhas de Freio','Substituição das pastilhas dianteiras',120.00,60,1),(6,'Troca de Correia Dentada','Substituição da correia dentada',200.00,120,1),(7,'Diagnóstico Eletrônico','Análise via computador de bordo',150.00,60,1),(8,'Limpeza de Bicos Injetores','Limpeza ultrassônica',180.00,90,1);
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;

--
-- Table structure for table `veiculos`
--

DROP TABLE IF EXISTS `veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculos` (
  `id_veiculo` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `placa` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ano` int NOT NULL,
  `cor` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `km_atual` int DEFAULT '0',
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE KEY `placa` (`placa`),
  KEY `idx_placa` (`placa`),
  KEY `idx_cliente` (`id_cliente`),
  CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculos`
--

/*!40000 ALTER TABLE `veiculos` DISABLE KEYS */;
INSERT INTO `veiculos` VALUES (1,1,'ABC-1234','Volkswagen','Gol',2018,'Prata',45000,'2025-12-05 17:12:14'),(2,1,'DEF-5678','Fiat','Uno',2015,'Branco',78000,'2025-12-05 17:12:14'),(3,2,'GHI-9012','Chevrolet','Onix',2020,'Preto',35000,'2025-12-05 17:12:14'),(4,3,'JKL-3456','Toyota','Corolla',2019,'Cinza',42000,'2025-12-05 17:12:14'),(5,4,'MNO-7890','Honda','Civic',2021,'Azul',28000,'2025-12-05 17:12:14'),(6,5,'PQR-1234','Ford','Ka',2017,'Vermelho',56000,'2025-12-05 17:12:14');
/*!40000 ALTER TABLE `veiculos` ENABLE KEYS */;

--
-- Dumping routines for database 'oficina_mecanica'
--
/*!50003 DROP FUNCTION IF EXISTS `contar_os_por_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `contar_os_por_status`(p_status VARCHAR(20)) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM ordens_servico WHERE status = p_status;
    RETURN v_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcular_total_os` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_total_os`(IN p_id_os INT)
BEGIN
    DECLARE v_total_servicos DECIMAL(10,2);
    DECLARE v_total_pecas DECIMAL(10,2);
    SELECT COALESCE(SUM(valor_total), 0) INTO v_total_servicos
    FROM os_servicos WHERE id_os = p_id_os;
    SELECT COALESCE(SUM(valor_total), 0) INTO v_total_pecas
    FROM os_pecas WHERE id_os = p_id_os;
    UPDATE ordens_servico 
    SET valor_total = v_total_servicos + v_total_pecas,
        valor_final = (v_total_servicos + v_total_pecas) - desconto
    WHERE id_os = p_id_os;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 16:09:06
