-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: gearhub
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `gh_baterias`
--

DROP TABLE IF EXISTS `gh_baterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_baterias` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `capacidade_ah` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_instalacao` date DEFAULT NULL,
  `fim_garantia` date DEFAULT NULL,
  `foto` longblob,
  `km_instalacao` int DEFAULT NULL,
  `marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_arquivo_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voltagem` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `veiculo_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `veiculo_id` (`veiculo_id`),
  CONSTRAINT `gh_baterias_ibfk_1` FOREIGN KEY (`veiculo_id`) REFERENCES `gh_veiculos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_baterias`
--

LOCK TABLES `gh_baterias` WRITE;
/*!40000 ALTER TABLE `gh_baterias` DISABLE KEYS */;
INSERT INTO `gh_baterias` VALUES (1,'60Ah','2023-05-15','2025-05-15',NULL,40000,'Moura','M60GD',NULL,'12V',1),(2,'60Ah','2022-08-10','2024-08-10',NULL,30000,'Heliar','SL60PD',NULL,'12V',2),(3,'100Ah','2023-01-10','2025-01-10',NULL,5000,'ACDelco','ADR100',NULL,'12V',3),(4,'50Ah','2021-03-20','2023-03-20',NULL,25000,'Moura','M50JD',NULL,'12V',4);
/*!40000 ALTER TABLE `gh_baterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gh_documentos`
--

DROP TABLE IF EXISTS `gh_documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_documentos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ano_referencia` int NOT NULL,
  `arquivo_pdf` longblob,
  `data_pagamento` date DEFAULT NULL,
  `data_upload` datetime DEFAULT CURRENT_TIMESTAMP,
  `descricao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `nome_arquivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_documento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `veiculo_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_documentos_veiculo` (`veiculo_id`),
  CONSTRAINT `gh_documentos_ibfk_1` FOREIGN KEY (`veiculo_id`) REFERENCES `gh_veiculos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_documentos`
--

LOCK TABLES `gh_documentos` WRITE;
/*!40000 ALTER TABLE `gh_documentos` DISABLE KEYS */;
INSERT INTO `gh_documentos` VALUES (1,2024,NULL,NULL,'2026-03-24 18:57:07','IPVA do veÃ­culo KRA1234',NULL,'Atrasado','IPVA',1),(2,2024,NULL,'2024-02-15','2026-03-24 18:57:07','Licenciamento anual',NULL,'Regularizado','Licenciamento',2),(3,2023,NULL,'2023-01-10','2026-03-24 18:57:07','DPVAT vencido',NULL,'Regularizado','Seguro ObrigatÃ³rio',3),(4,2024,NULL,NULL,'2026-03-24 18:57:07','IPVA do veÃ­culo ESP9999',NULL,'Atrasado','IPVA',4);
/*!40000 ALTER TABLE `gh_documentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_baixa_automatica_documento` BEFORE UPDATE ON `gh_documentos` FOR EACH ROW BEGIN
    
    IF OLD.data_pagamento IS NULL AND NEW.data_pagamento IS NOT NULL THEN
        
        SET NEW.status = 'Regularizado';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gh_empresas`
--

DROP TABLE IF EXISTS `gh_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_empresas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cnpj` char(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `logo` longblob,
  `nome` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_arquivo_logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`),
  KEY `idx_empresa_cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_empresas`
--

LOCK TABLES `gh_empresas` WRITE;
/*!40000 ALTER TABLE `gh_empresas` DISABLE KEYS */;
INSERT INTO `gh_empresas` VALUES (1,'12345678000199','2026-03-24 18:57:07',NULL,'LogÃ­stica Norte Fluminense',NULL),(2,'98765432000100','2026-03-24 18:57:07',NULL,'TransCargas Sudeste',NULL);
/*!40000 ALTER TABLE `gh_empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gh_oleos`
--

DROP TABLE IF EXISTS `gh_oleos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_oleos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_troca` date DEFAULT NULL,
  `foto` longblob,
  `nome_arquivo_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantidade_litros` double DEFAULT NULL,
  `quilometragem` int DEFAULT NULL,
  `tipo_oleo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trocou_filtro` bit(1) DEFAULT NULL,
  `veiculo_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `veiculo_id` (`veiculo_id`),
  CONSTRAINT `gh_oleos_ibfk_1` FOREIGN KEY (`veiculo_id`) REFERENCES `gh_veiculos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_oleos`
--

LOCK TABLES `gh_oleos` WRITE;
/*!40000 ALTER TABLE `gh_oleos` DISABLE KEYS */;
INSERT INTO `gh_oleos` VALUES (1,'2024-03-10',NULL,NULL,NULL,55000,'5W30 SintÃ©tico',_binary '',1),(2,'2024-04-01',NULL,NULL,NULL,60000,'15W40 Mineral',_binary '',2),(3,'2024-02-28',NULL,NULL,NULL,12000,'15W40 Diesel',_binary '\0',3),(4,'2023-12-15',NULL,NULL,NULL,30000,'5W30 SintÃ©tico',_binary '',4);
/*!40000 ALTER TABLE `gh_oleos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gh_pneus`
--

DROP TABLE IF EXISTS `gh_pneus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_pneus` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_instalacao` date DEFAULT NULL,
  `foto` longblob,
  `km_instalacao` int DEFAULT NULL,
  `marca` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medida` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome_arquivo_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posicao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `veiculo_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pneus_veiculo` (`veiculo_id`),
  CONSTRAINT `gh_pneus_ibfk_1` FOREIGN KEY (`veiculo_id`) REFERENCES `gh_veiculos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_pneus`
--

LOCK TABLES `gh_pneus` WRITE;
/*!40000 ALTER TABLE `gh_pneus` DISABLE KEYS */;
INSERT INTO `gh_pneus` VALUES (1,'2024-01-20',NULL,45000,'Michelin','265/65R17','LTX Force',NULL,'Dianteiro Esquerdo',1),(2,'2024-01-20',NULL,45000,'Michelin','265/65R17','LTX Force',NULL,'Dianteiro Direito',1),(3,'2024-01-20',NULL,45000,'Michelin','265/65R17','LTX Force',NULL,'Traseiro Esquerdo',1),(4,'2024-01-20',NULL,45000,'Michelin','265/65R17','LTX Force',NULL,'Traseiro Direito',1);
/*!40000 ALTER TABLE `gh_pneus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gh_sedes`
--

DROP TABLE IF EXISTS `gh_sedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_sedes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `endereco` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` longblob,
  `nome` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_arquivo_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresa_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `gh_sedes_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `gh_empresas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_sedes`
--

LOCK TABLES `gh_sedes` WRITE;
/*!40000 ALTER TABLE `gh_sedes` DISABLE KEYS */;
INSERT INTO `gh_sedes` VALUES (1,'Av. 28 de MarÃ§o, 500, Campos dos Goytacazes - RJ',NULL,'Matriz Campos',NULL,1),(2,'Rodovia Amaral Peixoto, km 100, MacaÃ© - RJ',NULL,'Filial MacaÃ©',NULL,1),(3,'Av. Dante Michelini, 100, VitÃ³ria - ES',NULL,'Base VitÃ³ria',NULL,2);
/*!40000 ALTER TABLE `gh_sedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gh_veiculos`
--

DROP TABLE IF EXISTS `gh_veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gh_veiculos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ano_modelo` smallint NOT NULL,
  `capacidade_reserva_litros` double DEFAULT NULL,
  `capacidade_tanque_litros` double DEFAULT NULL,
  `combustivel_recomendado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `foto` longblob,
  `marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nome_arquivo_foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placa` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sede_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `placa` (`placa`),
  KEY `idx_veiculo_placa` (`placa`),
  KEY `idx_veiculo_sede` (`sede_id`),
  CONSTRAINT `gh_veiculos_ibfk_1` FOREIGN KEY (`sede_id`) REFERENCES `gh_sedes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gh_veiculos`
--

LOCK TABLES `gh_veiculos` WRITE;
/*!40000 ALTER TABLE `gh_veiculos` DISABLE KEYS */;
INSERT INTO `gh_veiculos` VALUES (1,2022,10,80,'Diesel S10','Caminhonete de apoio operacional',NULL,'Toyota','Hilux',NULL,'KRA1234',1),(2,2020,8,55,'Gasolina','Transporte de pequenas cargas',NULL,'Fiat','Fiorino',NULL,'LMN5678',1),(3,2023,30,275,'Diesel S10','CaminhÃ£o toco',NULL,'Volkswagen','Constellation',NULL,'RIO2023',2),(4,2021,9,76,'Diesel S10','VeÃ­culo da gerÃªncia',NULL,'Ford','Ranger',NULL,'ESP9999',3);
/*!40000 ALTER TABLE `gh_veiculos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-24 19:23:03
