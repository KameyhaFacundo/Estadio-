-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: estadio-prueba
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditoria_entradas`
--

DROP TABLE IF EXISTS `auditoria_entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_entradas` (
  `IdAuditoria` bigint NOT NULL AUTO_INCREMENT,
  `IdEntrada` bigint DEFAULT NULL,
  `Accion` varchar(10) DEFAULT NULL,
  `FechaAccion` datetime DEFAULT NULL,
  PRIMARY KEY (`IdAuditoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_entradas`
--

LOCK TABLES `auditoria_entradas` WRITE;
/*!40000 ALTER TABLE `auditoria_entradas` DISABLE KEYS */;
INSERT INTO `auditoria_entradas` VALUES (1,1,'ACTUALIZAR','2024-12-27 16:08:19'),(2,1,'BORRAR','2024-12-27 16:16:04'),(3,4,'INSERTAR','2024-12-27 16:17:31');
/*!40000 ALTER TABLE `auditoria_entradas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `butacas`
--

DROP TABLE IF EXISTS `butacas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `butacas` (
  `IdButaca` bigint NOT NULL,
  `IdZona` smallint NOT NULL,
  `NroButaca` int NOT NULL,
  `Fila` int NOT NULL,
  `Columna` int NOT NULL,
  `EstadoBut` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`IdButaca`,`IdZona`),
  UNIQUE KEY `UI_IdButaca` (`IdButaca`),
  UNIQUE KEY `UI_NroButaca` (`NroButaca`),
  KEY `Ref1214` (`IdZona`),
  CONSTRAINT `RefZonas147` FOREIGN KEY (`IdZona`) REFERENCES `zonas` (`IdZona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las butacas de la zona.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `butacas`
--

LOCK TABLES `butacas` WRITE;
/*!40000 ALTER TABLE `butacas` DISABLE KEYS */;
INSERT INTO `butacas` VALUES (1,1,101,1,1,'A'),(2,1,102,1,2,'A'),(3,2,201,1,1,'A'),(4,3,301,1,1,'A');
/*!40000 ALTER TABLE `butacas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `IdCliente` bigint NOT NULL AUTO_INCREMENT,
  `Apellidos` varchar(150) NOT NULL,
  `Nombres` varchar(150) NOT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Pass` char(32) NOT NULL,
  `DNI` char(10) NOT NULL,
  `EstadoCli` char(1) NOT NULL,
  PRIMARY KEY (`IdCliente`),
  UNIQUE KEY `UI_IdCliente` (`IdCliente`),
  UNIQUE KEY `UI_Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los clientes que compran las entradas.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Pérez','Juan','juan.perez@example.com','5f4dcc3b5aa765d61d8327deb882cf99','12345678','A'),(2,'González','María','maria.gonzalez@example.com','5f4dcc3b5aa765d61d8327deb882cf99','87654321','A');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entradas`
--

DROP TABLE IF EXISTS `entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entradas` (
  `IdEntrada` bigint NOT NULL AUTO_INCREMENT,
  `IdEvento` bigint NOT NULL,
  `IdZona` smallint NOT NULL,
  `IdCliente` bigint NOT NULL,
  `IdButaca` bigint NOT NULL,
  `FechaAlta` datetime NOT NULL,
  `FechaEntrada` datetime NOT NULL,
  `FechaResenia` datetime NOT NULL,
  `Resenia` varchar(150) DEFAULT NULL,
  `DatosPago` varchar(150) NOT NULL,
  `EstadoEnt` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`IdEntrada`,`IdEvento`,`IdZona`,`IdCliente`),
  UNIQUE KEY `UI_IdEntrada` (`IdEntrada`),
  KEY `Ref1316` (`IdZona`,`IdButaca`),
  KEY `Ref1117` (`IdEvento`,`IdZona`),
  KEY `Ref1819` (`IdCliente`),
  KEY `RefButacas167` (`IdButaca`,`IdZona`),
  CONSTRAINT `RefButacas167` FOREIGN KEY (`IdButaca`, `IdZona`) REFERENCES `butacas` (`IdButaca`, `IdZona`),
  CONSTRAINT `RefClientes197` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`),
  CONSTRAINT `RefZonasEvento177` FOREIGN KEY (`IdEvento`, `IdZona`) REFERENCES `zonasevento` (`IdEvento`, `IdZona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las entradas para ingresar al estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entradas`
--

LOCK TABLES `entradas` WRITE;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` VALUES (2,2,2,2,3,'2024-11-23 11:00:00','2024-12-15 20:00:00','2024-12-18 18:00:00',NULL,'Efectivo','A'),(3,1,3,2,4,'2024-12-26 15:00:00','2024-12-25 15:30:00','2024-12-25 14:00:00','Otra reseña','Datos de pago','A'),(4,1,1,1,2,'2024-10-25 15:00:00','2024-12-25 15:30:00','2024-12-25 14:00:00','Reseña','Datos de pago','A');
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertar_entrada` AFTER INSERT ON `entradas` FOR EACH ROW BEGIN
    INSERT INTO auditoria_entradas (IdEntrada, Accion, FechaAccion)
    VALUES (NEW.IdEntrada, 'INSERTAR', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_entrada` AFTER UPDATE ON `entradas` FOR EACH ROW BEGIN
    INSERT INTO auditoria_entradas (IdEntrada, Accion, FechaAccion)
    VALUES (NEW.IdEntrada, 'ACTUALIZAR', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borrar_entrada` BEFORE DELETE ON `entradas` FOR EACH ROW BEGIN
    INSERT INTO auditoria_entradas (IdEntrada, Accion, FechaAccion)
    VALUES (OLD.IdEntrada, 'BORRAR', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `IdEquipo` bigint NOT NULL,
  `IdTorneo` int NOT NULL,
  `Equipo` varchar(150) NOT NULL,
  PRIMARY KEY (`IdEquipo`,`IdTorneo`),
  UNIQUE KEY `UI_IdEquipo` (`IdEquipo`),
  KEY `Ref310` (`IdTorneo`),
  CONSTRAINT `RefTorneos107` FOREIGN KEY (`IdTorneo`) REFERENCES `torneos` (`IdTorneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los equipos que jugarán en el estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,1,'Equipo A'),(2,1,'Equipo B'),(3,2,'Equipo C'),(4,2,'Equipo D'),(7,3,'Equipo 5'),(8,3,'Equipo 6'),(9,4,'Equipo 4'),(10,3,'Equipo 3');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos` (
  `IdEvento` bigint NOT NULL AUTO_INCREMENT,
  `Evento` varchar(150) NOT NULL,
  `FechaProbableFin` datetime DEFAULT NULL,
  `FechaProbableInicio` datetime DEFAULT NULL,
  `FechaInicio` datetime NOT NULL,
  `FechaFin` datetime NOT NULL,
  `Observaciones` varchar(250) DEFAULT NULL,
  `EstadoEve` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`IdEvento`),
  UNIQUE KEY `UI_IdEvento` (`IdEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los eventos que se desarrollan en el estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (1,'Concierto Rock','2024-12-20 00:00:00','2024-12-18 00:00:00','2024-12-18 00:00:00','2024-12-20 00:00:00','Concierto de bandas locales.','A'),(2,'Partido de Fútbol','2024-12-15 00:00:00','2024-12-15 00:00:00','2024-12-15 00:00:00','2024-12-15 00:00:00','Final de campeonato.','A'),(4,'Evento A',NULL,NULL,'2024-12-15 08:00:00','2024-12-15 18:00:00',NULL,'A'),(5,'Evento B',NULL,NULL,'2024-12-16 08:00:00','2024-12-16 18:00:00',NULL,'A');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventosnd`
--

DROP TABLE IF EXISTS `eventosnd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventosnd` (
  `IdEvento` bigint NOT NULL,
  `Actores` text NOT NULL,
  PRIMARY KEY (`IdEvento`),
  KEY `Ref727` (`IdEvento`),
  CONSTRAINT `RefEventos277` FOREIGN KEY (`IdEvento`) REFERENCES `eventos` (`IdEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventosnd`
--

LOCK TABLES `eventosnd` WRITE;
/*!40000 ALTER TABLE `eventosnd` DISABLE KEYS */;
INSERT INTO `eventosnd` VALUES (1,'Banda Los Rockeros'),(2,'No Aplica');
/*!40000 ALTER TABLE `eventosnd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidos` (
  `IdEvento` bigint NOT NULL,
  `IdTorneo` int NOT NULL,
  `IdEquipoLocal` bigint NOT NULL,
  `IdEquipoVisitante` bigint NOT NULL,
  `NroFecha` datetime NOT NULL,
  PRIMARY KEY (`IdEvento`,`IdTorneo`,`IdEquipoLocal`,`IdEquipoVisitante`),
  KEY `Ref78` (`IdEvento`),
  KEY `Ref625` (`IdTorneo`,`IdEquipoLocal`),
  KEY `Ref626` (`IdTorneo`,`IdEquipoVisitante`),
  CONSTRAINT `RefEquipos257` FOREIGN KEY (`IdTorneo`, `IdEquipoLocal`) REFERENCES `equipos` (`IdTorneo`, `IdEquipo`),
  CONSTRAINT `RefEquipos267` FOREIGN KEY (`IdTorneo`, `IdEquipoVisitante`) REFERENCES `equipos` (`IdTorneo`, `IdEquipo`),
  CONSTRAINT `RefEventos87` FOREIGN KEY (`IdEvento`) REFERENCES `eventos` (`IdEvento`),
  CONSTRAINT `RefTorneos97` FOREIGN KEY (`IdTorneo`) REFERENCES `torneos` (`IdTorneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los partidos que se desarrollan en el estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (2,1,1,2,'2025-01-01 20:00:00'),(4,2,3,4,'2024-12-18 00:00:00'),(5,3,7,8,'2024-12-26 16:00:00');
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `torneos`
--

DROP TABLE IF EXISTS `torneos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `torneos` (
  `IdTorneo` int NOT NULL,
  `Torneo` varchar(60) NOT NULL,
  `EstadoTor` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`IdTorneo`),
  UNIQUE KEY `UI_IdTorneo` (`IdTorneo`),
  UNIQUE KEY `UI_Torneo` (`Torneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena los torneos que se desarrollan en el estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `torneos`
--

LOCK TABLES `torneos` WRITE;
/*!40000 ALTER TABLE `torneos` DISABLE KEYS */;
INSERT INTO `torneos` VALUES (1,' Copa Libertadores 2024','A'),(2,'Copa Tucumana','I'),(3,'Copa de la liga','A'),(4,'Liga Tucumana','A'),(5,'Copa de la liga Burru','A');
/*!40000 ALTER TABLE `torneos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zonas`
--

DROP TABLE IF EXISTS `zonas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zonas` (
  `IdZona` smallint NOT NULL,
  `Zona` varchar(150) NOT NULL,
  `TipoZona` char(1) NOT NULL,
  `Capacidad` int NOT NULL,
  `EstadoZon` char(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`IdZona`),
  UNIQUE KEY `UI_IdZona` (`IdZona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las zonas del estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zonas`
--

LOCK TABLES `zonas` WRITE;
/*!40000 ALTER TABLE `zonas` DISABLE KEYS */;
INSERT INTO `zonas` VALUES (1,'Plateas Altas','P',500,'A'),(2,'General Norte','G',700,'A'),(3,'VIP Sur','V',50,'A');
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zonasevento`
--

DROP TABLE IF EXISTS `zonasevento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zonasevento` (
  `IdEvento` bigint NOT NULL,
  `IdZona` smallint NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `Capacidad` int NOT NULL,
  `Ocupacion` int NOT NULL,
  PRIMARY KEY (`IdEvento`,`IdZona`),
  KEY `Ref711` (`IdEvento`),
  KEY `Ref1215` (`IdZona`),
  CONSTRAINT `RefEventos117` FOREIGN KEY (`IdEvento`) REFERENCES `eventos` (`IdEvento`),
  CONSTRAINT `RefZonas157` FOREIGN KEY (`IdZona`) REFERENCES `zonas` (`IdZona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabla que almacena las zonas que tiene el estadio.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zonasevento`
--

LOCK TABLES `zonasevento` WRITE;
/*!40000 ALTER TABLE `zonasevento` DISABLE KEYS */;
INSERT INTO `zonasevento` VALUES (1,1,500.00,200,150),(1,3,1000.00,50,25),(2,2,300.00,500,450);
/*!40000 ALTER TABLE `zonasevento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'estadio-prueba'
--
/*!50003 DROP PROCEDURE IF EXISTS `bsp_activar_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_activar_entrada`(
    pIdEntrada BIGINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado de una entrada a A: Activa siempre y cuando no esté ya activa.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Verifica que la entrada exista
    IF NOT EXISTS(SELECT IdEntrada FROM entradas WHERE IdEntrada = pIdEntrada) THEN
        SELECT 'La entrada especificada no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que la entrada no esté ya activa
    IF EXISTS(SELECT IdEntrada FROM entradas WHERE IdEntrada = pIdEntrada AND EstadoEnt = 'A') THEN
        SELECT 'La entrada ya está activa.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Activa la entrada
        UPDATE entradas
        SET EstadoEnt = 'A'
        WHERE IdEntrada = pIdEntrada;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_activar_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_activar_torneo`(
    pIdTorneo SMALLINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado del torneo a A: Activo siempre y cuando
        no esté ya activo. Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Control de parámetros
    IF NOT EXISTS(SELECT IdTorneo FROM Torneos WHERE IdTorneo = pIdTorneo) THEN
        SELECT 'No existe el torneo que quiere activar.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    IF NOT EXISTS(SELECT IdTorneo FROM Torneos WHERE IdTorneo = pIdTorneo AND EstadoTor = 'I') THEN
        SELECT 'El torneo ya está activo.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Activa el torneo
        UPDATE Torneos SET EstadoTor = 'A' WHERE IdTorneo = pIdTorneo;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_activar_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_activar_zona`(
    pIdZona SMALLINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado de la zona a A: Activo siempre y cuando
        no esté ya activa. Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Control de parámetros
    IF NOT EXISTS(SELECT IdZona FROM zonas WHERE IdZona = pIdZona) THEN
        SELECT 'No existe la zona que quiere activar.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    IF NOT EXISTS(SELECT IdZona FROM zonas WHERE IdZona = pIdZona AND EstadoZon = 'I') THEN
        SELECT 'La zona ya está activa.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Activa la zona
        UPDATE zonas SET EstadoZon = 'A' WHERE IdZona = pIdZona;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_alta_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_alta_entrada`(
    pIdEvento BIGINT,
    pIdZona SMALLINT,
    pIdCliente BIGINT,
    pIdButaca BIGINT,
    pFechaAlta DATETIME,
    pFechaEntrada DATETIME,
    pFechaResenia DATETIME,
    pResenia VARCHAR(150),
    pDatosPago VARCHAR(150)
)
SALIR: BEGIN
    /*
        Permite dar de alta una entrada controlando que los datos sean válidos.
        La da de alta al final del orden, con estado A: Activa.
        Devuelve OK + Id o el mensaje de error en Mensaje.
    */
    DECLARE pIdEntrada BIGINT;
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje, NULL AS Id;
        ROLLBACK;
    END;

    -- Controla que los campos obligatorios no sean NULL
    IF pIdEvento IS NULL OR pIdZona IS NULL OR pIdCliente IS NULL OR pIdButaca IS NULL OR pFechaAlta IS NULL OR pFechaEntrada IS NULL OR pFechaResenia IS NULL OR pDatosPago IS NULL THEN
        SELECT 'Debe proveer todos los campos obligatorios para la entrada' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista una entrada con los mismos detalles
    IF EXISTS(SELECT IdEntrada FROM entradas 
              WHERE IdEvento = pIdEvento 
                AND IdZona = pIdZona 
                AND IdCliente = pIdCliente 
                AND IdButaca = pIdButaca) THEN
        SELECT 'Ya existe una entrada con esos detalles' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdZona e IdButaca existan en la tabla `butacas`
    IF NOT EXISTS(SELECT IdButaca FROM butacas WHERE IdZona = pIdZona AND IdButaca = pIdButaca) THEN
        SELECT 'La butaca no existe en la zona especificada' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdCliente exista en la tabla `clientes`
    IF NOT EXISTS(SELECT IdCliente FROM clientes WHERE IdCliente = pIdCliente) THEN
        SELECT 'El cliente no existe' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdEvento y IdZona existan en la tabla `zonasevento`
    IF NOT EXISTS(SELECT IdEvento FROM zonasevento WHERE IdEvento = pIdEvento AND IdZona = pIdZona) THEN
        SELECT 'La zona especificada no existe para el evento' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        SET pIdEntrada = 1 + (SELECT COALESCE(MAX(IdEntrada), 0) FROM entradas);

        INSERT INTO entradas (IdEntrada, IdEvento, IdZona, IdCliente, IdButaca, FechaAlta, FechaEntrada, FechaResenia, Resenia, DatosPago, EstadoEnt)
        VALUES (pIdEntrada, pIdEvento, pIdZona, pIdCliente, pIdButaca, pFechaAlta, pFechaEntrada, pFechaResenia, pResenia, pDatosPago, 'A');

        SELECT 'OK' AS Mensaje, pIdEntrada AS Id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_alta_partido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_alta_partido`(
    pIdEvento BIGINT,
    pIdTorneo INT,
    pIdEquipoLocal BIGINT,
    pIdEquipoVisitante BIGINT,
    pNroFecha DATETIME
)
SALIR: BEGIN
    /*
        Permite dar de alta un partido controlando que no exista ya.
        Lo da de alta al final del orden, con estado A: Activa.
        Devuelve OK + Id o el mensaje de error en Mensaje.
    */
    DECLARE pIdPartido BIGINT;
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje, NULL AS Id;
        ROLLBACK;
    END;

    -- Controla que los campos obligatorios no sean NULL
    IF pIdEvento IS NULL OR pIdTorneo IS NULL OR pIdEquipoLocal IS NULL OR pIdEquipoVisitante IS NULL OR pNroFecha IS NULL THEN
        SELECT 'Debe proveer todos los campos obligatorios para el partido' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista un partido con los mismos equipos y fecha
    IF EXISTS(SELECT IdEvento FROM partidos 
              WHERE IdTorneo = pIdTorneo 
                AND IdEquipoLocal = pIdEquipoLocal 
                AND IdEquipoVisitante = pIdEquipoVisitante 
                AND NroFecha = pNroFecha) THEN
        SELECT 'Ya existe un partido con esos equipos y fecha' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdTorneo e IdEquipoLocal existan en la tabla `equipos`
    IF NOT EXISTS(SELECT IdEquipo FROM equipos WHERE IdTorneo = pIdTorneo AND IdEquipo = pIdEquipoLocal) THEN
        SELECT 'El equipo local no existe en el torneo especificado' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdTorneo e IdEquipoVisitante existan en la tabla `equipos`
    IF NOT EXISTS(SELECT IdEquipo FROM equipos WHERE IdTorneo = pIdTorneo AND IdEquipo = pIdEquipoVisitante) THEN
        SELECT 'El equipo visitante no existe en el torneo especificado' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        SET pIdPartido = 1 + (SELECT COALESCE(MAX(IdEvento), 0) FROM partidos);

        INSERT INTO partidos (IdEvento, IdTorneo, IdEquipoLocal, IdEquipoVisitante, NroFecha)
        VALUES (pIdPartido, pIdTorneo, pIdEquipoLocal, pIdEquipoVisitante, pNroFecha);

        SELECT 'OK' AS Mensaje, pIdPartido AS Id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_alta_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_alta_torneo`(
    pTorneo VARCHAR(60)
)
SALIR:BEGIN
    /*
        Permite dar de alta un torneo controlando que el nombre no exista ya.
        La da de alta al final del orden, con estado A: Activa.
        Devuelve OK + Id o el mensaje de error en Mensaje.
    */
    DECLARE pIdTorneo SMALLINT;
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje, NULL AS Id;
        ROLLBACK;
    END;

    -- Controla que el nombre del torneo sea obligatorio 
    IF pTorneo = '' OR pTorneo IS NULL THEN
        SELECT 'Debe proveer un nombre para el torneo' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista un torneo con el mismo nombre
    IF EXISTS(SELECT Torneo FROM Torneos WHERE Torneo = pTorneo) THEN
        SELECT 'Ya existe un torneo con ese nombre' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        SET pIdTorneo = 1 + (SELECT COALESCE(MAX(IdTorneo), 0) FROM Torneos);

        INSERT INTO Torneos (IdTorneo, Torneo, EstadoTor)
        VALUES (pIdTorneo, pTorneo, 'A');

        SELECT 'OK' AS Mensaje, pIdTorneo AS Id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_alta_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_alta_zona`(
    pZona VARCHAR(150),
    pTipoZona CHAR(1),
    pCapacidad INT
)
SALIR: BEGIN
    /*
        Permite dar de alta una zona controlando que el nombre no exista ya.
        La da de alta al final del orden, con estado A: Activa.
        Devuelve OK + Id o el mensaje de error en Mensaje.
    */
    DECLARE pIdZona SMALLINT;
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje, NULL AS Id;
        ROLLBACK;
    END;

    -- Controla que el nombre de la zona sea obligatorio 
    IF pZona = '' OR pZona IS NULL THEN
        SELECT 'Debe proveer un nombre para la zona' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista una zona con el mismo nombre
    IF EXISTS(SELECT Zona FROM zonas WHERE Zona = pZona) THEN
        SELECT 'Ya existe una zona con ese nombre' AS Mensaje, NULL AS Id;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        SET pIdZona = 1 + (SELECT COALESCE(MAX(IdZona), 0) FROM zonas);

        INSERT INTO zonas (IdZona, Zona, TipoZona, Capacidad, EstadoZon)
        VALUES (pIdZona, pZona, pTipoZona, pCapacidad, 'A');

        SELECT 'OK' AS Mensaje, pIdZona AS Id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_autocompletar_torneos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_autocompletar_torneos`(pCadena varchar(60), pIncluyeBajas char(1))
BEGIN
    /*
        Permite listar todos los torneos que cumplan con la condición de autocompletar de la cadena de búsqueda que coincida con el nombre del torneo.
        Puede o no incluir los torneos inactivos según pIncluyeBajas (S: Si - N: No). Busca a partir del cuarto caracter y ordena por nombre.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    SELECT t.*
    FROM Torneos t
    WHERE LENGTH(pCadena) >= 4
      AND t.Torneo LIKE CONCAT('%', pCadena, '%')
      AND (pIncluyeBajas = 'S' OR t.EstadoTor = 'A')
    ORDER BY t.Torneo;

    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_autocompletar_zonas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_autocompletar_zonas`(
    pCadena VARCHAR(150), 
    pIncluyeBajas CHAR(1)
)
BEGIN
    /*
        Permite listar todas las zonas que cumplan con la condición de autocompletar de la cadena de búsqueda que coincida con el nombre de la zona.
        Puede o no incluir las zonas inactivas según pIncluyeBajas (S: Si - N: No). Busca a partir del cuarto caracter y ordena por nombre.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    SELECT z.*
    FROM zonas z
    WHERE LENGTH(pCadena) >= 4
      AND z.Zona LIKE CONCAT('%', pCadena, '%')
      AND (pIncluyeBajas = 'S' OR z.EstadoZon = 'A')
    ORDER BY z.Zona;

    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_borra_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_borra_entrada`(
    pIdEntrada BIGINT
)
SALIR: BEGIN
    /*
        Permite borrar una entrada.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
        -- Borra la entrada
        DELETE FROM entradas WHERE IdEntrada = pIdEntrada;
        
        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_borra_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_borra_torneo`(
    pIdTorneo SMALLINT
)
SALIR: BEGIN
    /*
        Permite borrar un torneo controlando que no tenga partidos asociados.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que el torneo no tenga partidos asociados
    IF EXISTS(SELECT IdTorneo FROM Partidos WHERE IdTorneo = pIdTorneo) THEN
        SELECT 'No puede borrar el torneo. Existen partidos asociados.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Borra torneos
        DELETE FROM Torneos WHERE IdTorneo = pIdTorneo;
        
        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_borra_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_borra_zona`(
    pIdZona SMALLINT
)
SALIR: BEGIN
    /*
        Permite borrar una zona controlando que no tenga referencias en la tabla butacas.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que no existan referencias en la tabla butacas
    IF EXISTS(SELECT IdZona FROM butacas WHERE IdZona = pIdZona) THEN
        SELECT 'No puede borrar la zona. Existen butacas asociadas.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Borra zonas
        DELETE FROM zonas WHERE IdZona = pIdZona;
        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_buscar_torneos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_buscar_torneos`(
    pCadena VARCHAR(60), 
    pIncluyeBajas CHAR(1)
)
BEGIN
    /*
        Permite buscar los torneos dada una cadena de búsqueda que contenga una parte del nombre. 
        Puede o no incluir los torneos inactivos según pIncluyeBajas (S: Si - N: No).
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
    SELECT t.*
    FROM Torneos t
    WHERE t.Torneo LIKE CONCAT('%', pCadena, '%')
      AND (pIncluyeBajas = 'S' OR t.EstadoTor = 'A');
    
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_buscar_zonas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_buscar_zonas`(
    pBusqueda VARCHAR(150),
    pIncluyeBajas CHAR(1)
)
BEGIN
    /*
        Permite buscar las zonas dada una cadena de búsqueda que contenga una parte del nombre.
        Puede o no incluir las zonas inactivas según pIncluyeBajas (S: Si - N: No).
    */
    IF pIncluyeBajas = 'S' THEN
        SELECT *
        FROM zonas
        WHERE Zona LIKE CONCAT('%', pBusqueda, '%');
    ELSE
        SELECT *
        FROM zonas
        WHERE Zona LIKE CONCAT('%', pBusqueda, '%')
          AND EstadoZon = 'A';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_dame_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_dame_entrada`(
    pIdEntrada BIGINT
)
BEGIN
    /*
        Procedimiento que sirve para instanciar una entrada desde la base de datos utilizando solo pIdEntrada.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
    SELECT *
    FROM entradas
    WHERE IdEntrada = pIdEntrada;
    
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_dame_partido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_dame_partido`(
    pIdEvento BIGINT,
    pIdTorneo INT,
    pIdEquipoLocal BIGINT,
    pIdEquipoVisitante BIGINT
)
BEGIN
    /*
        Procedimiento que sirve para instanciar un partido desde la base de datos.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
    SELECT *
    FROM partidos
    WHERE IdEvento = pIdEvento
      AND IdTorneo = pIdTorneo
      AND IdEquipoLocal = pIdEquipoLocal
      AND IdEquipoVisitante = pIdEquipoVisitante;
    
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_dame_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_dame_torneo`(
    pIdTorneo SMALLINT
)
BEGIN
    /*
        Procedimiento que sirve para instanciar un torneo desde la base de datos.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
    SELECT *
    FROM Torneos
    WHERE IdTorneo = pIdTorneo;
    
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_dame_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_dame_zona`(
    pIdZona SMALLINT
)
BEGIN
    /*
        Procedimiento que sirve para instanciar una zona desde la base de datos.
    */
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    
    SELECT *
    FROM zonas
    WHERE IdZona = pIdZona;
    
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_inactivar_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_inactivar_entrada`(
    pIdEntrada BIGINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado de una entrada a I: Inactiva siempre y cuando no esté ya inactiva.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Verifica que la entrada exista
    IF NOT EXISTS(SELECT IdEntrada FROM entradas WHERE IdEntrada = pIdEntrada) THEN
        SELECT 'La entrada especificada no existe.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que la entrada no esté ya inactiva
    IF EXISTS(SELECT IdEntrada FROM entradas WHERE IdEntrada = pIdEntrada AND EstadoEnt = 'I') THEN
        SELECT 'La entrada ya está inactiva.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Inactiva la entrada
        UPDATE entradas
        SET EstadoEnt = 'I'
        WHERE IdEntrada = pIdEntrada;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_inactivar_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_inactivar_torneo`(
    pIdTorneo SMALLINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado del torneo a I: Inactivo siempre y cuando
        no esté ya inactivo ni existan partidos asociados.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Control de parámetros
    IF NOT EXISTS(SELECT IdTorneo FROM Torneos WHERE IdTorneo = pIdTorneo) THEN
        SELECT 'No existe el torneo que quiere inactivar.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    IF NOT EXISTS(SELECT IdTorneo FROM Torneos WHERE IdTorneo = pIdTorneo AND EstadoTor = 'A') THEN
        SELECT 'El torneo ya está inactivo.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    IF EXISTS(SELECT IdTorneo FROM Partidos WHERE IdTorneo = pIdTorneo) THEN
        SELECT 'No puede inactivar el torneo. Existen partidos asociados.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Da de baja
        UPDATE Torneos SET EstadoTor = 'I' WHERE IdTorneo = pIdTorneo;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_inactivar_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_inactivar_zona`(
    pIdZona SMALLINT
)
SALIR: BEGIN
    /*
        Permite cambiar el estado de la zona a I: Inactiva siempre y cuando
        no esté ya inactiva ni existan dependencias asociadas.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    
    -- Control de parámetros
    IF NOT EXISTS(SELECT IdZona FROM zonas WHERE IdZona = pIdZona) THEN
        SELECT 'No existe la zona que quiere inactivar.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    IF NOT EXISTS(SELECT IdZona FROM zonas WHERE IdZona = pIdZona AND EstadoZon = 'A') THEN
        SELECT 'La zona ya está inactiva.' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        -- Da de baja
        UPDATE zonas SET EstadoZon = 'I' WHERE IdZona = pIdZona;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_modifica_entrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_modifica_entrada`(
    pIdEntrada BIGINT,
    pIdEvento BIGINT,
    pIdZona SMALLINT,
    pIdCliente BIGINT,
    pIdButaca BIGINT,
    pFechaAlta DATETIME,
    pFechaEntrada DATETIME,
    pFechaResenia DATETIME,
    pResenia VARCHAR(150),
    pDatosPago VARCHAR(150)
)
SALIR: BEGIN
    /*
        Permite modificar una entrada existente.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    DECLARE Mensaje VARCHAR(100);

    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que los campos obligatorios no sean NULL
    IF pIdEntrada IS NULL OR pIdEvento IS NULL OR pIdZona IS NULL OR pIdCliente IS NULL OR pIdButaca IS NULL OR pFechaAlta IS NULL OR pFechaEntrada IS NULL OR pFechaResenia IS NULL OR pDatosPago IS NULL THEN
        SELECT 'Debe proveer todos los campos obligatorios para la entrada' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdEntrada exista en la tabla `entradas`
    IF NOT EXISTS(SELECT IdEntrada FROM entradas WHERE IdEntrada = pIdEntrada) THEN
        SELECT 'La entrada especificada no existe' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdZona e IdButaca existan en la tabla `butacas`
    IF NOT EXISTS(SELECT IdButaca FROM butacas WHERE IdZona = pIdZona AND IdButaca = pIdButaca) THEN
        SELECT 'La butaca no existe en la zona especificada' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdCliente exista en la tabla `clientes`
    IF NOT EXISTS(SELECT IdCliente FROM clientes WHERE IdCliente = pIdCliente) THEN
        SELECT 'El cliente no existe' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Verifica que el IdEvento y IdZona existan en la tabla `zonasevento`
    IF NOT EXISTS(SELECT IdEvento FROM zonasevento WHERE IdEvento = pIdEvento AND IdZona = pIdZona) THEN
        SELECT 'La zona especificada no existe para el evento' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        UPDATE entradas
        SET IdEvento = pIdEvento,
            IdZona = pIdZona,
            IdCliente = pIdCliente,
            IdButaca = pIdButaca,
            FechaAlta = pFechaAlta,
            FechaEntrada = pFechaEntrada,
            FechaResenia = pFechaResenia,
            Resenia = pResenia,
            DatosPago = pDatosPago
        WHERE IdEntrada = pIdEntrada;

        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_modifica_partido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_modifica_partido`(
    pIdPartido BIGINT,
    pIdTorneo INT,
    pIdEquipoLocal BIGINT,
    pIdEquipoVisitante BIGINT,
    pNroFecha DATETIME
)
SALIR: BEGIN
    /*
        Permite modificar un partido existente controlando que no existan duplicados.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que los campos obligatorios no sean NULL
    IF pIdTorneo IS NULL OR pIdEquipoLocal IS NULL OR pIdEquipoVisitante IS NULL OR pNroFecha IS NULL THEN
        SELECT 'Debe proveer todos los campos obligatorios para el partido' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista un partido con los mismos detalles pero diferente ID
    IF EXISTS(SELECT IdEvento FROM partidos 
              WHERE IdTorneo = pIdTorneo 
                AND IdEquipoLocal = pIdEquipoLocal 
                AND IdEquipoVisitante = pIdEquipoVisitante 
                AND NroFecha = pNroFecha
                AND IdEvento != pIdPartido) THEN
        SELECT 'Ya existe un partido con esos detalles' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        UPDATE partidos
        SET IdTorneo = pIdTorneo, IdEquipoLocal = pIdEquipoLocal, IdEquipoVisitante = pIdEquipoVisitante, NroFecha = pNroFecha
        WHERE IdEvento = pIdPartido;
        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_modifica_torneo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_modifica_torneo`(
    pIdTorneo SMALLINT, 
    pTorneo VARCHAR(60)
)
SALIR:BEGIN
    /*
        Permite modificar un torneo existente controlando que el nombre no exista ya.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que el nombre del torneo sea obligatorio 
    IF pTorneo = '' OR pTorneo IS NULL THEN
        SELECT 'Debe proveer un nombre para el torneo' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista un torneo con el mismo nombre
    IF EXISTS(SELECT Torneo FROM Torneos WHERE Torneo = pTorneo AND IdTorneo != pIdTorneo) THEN
        SELECT 'Ya existe un torneo con ese nombre' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        UPDATE Torneos
        SET Torneo = pTorneo
        WHERE IdTorneo = pIdTorneo;
        SELECT 'OK' AS Mensaje;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bsp_modifica_zona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bsp_modifica_zona`(
    pIdZona SMALLINT, 
    pZona VARCHAR(150), 
    pTipoZona CHAR(1), 
    pCapacidad INT
)
SALIR: BEGIN
    /*
        Permite modificar una zona existente controlando que el nombre no exista ya.
        Devuelve OK o el mensaje de error en Mensaje.
    */
    -- Manejo de error en la transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SHOW ERRORS;
        SELECT 'Error en la transacción. Contáctese con el administrador.' AS Mensaje;
        ROLLBACK;
    END;

    -- Controla que el nombre de la zona sea obligatorio 
    IF pZona = '' OR pZona IS NULL THEN
        SELECT 'Debe proveer un nombre para la zona' AS Mensaje;
        LEAVE SALIR;
    END IF;

    -- Controla que no exista una zona con el mismo nombre
    IF EXISTS(SELECT Zona FROM zonas WHERE Zona = pZona AND IdZona != pIdZona) THEN
        SELECT 'Ya existe una zona con ese nombre' AS Mensaje;
        LEAVE SALIR;
    END IF;

    START TRANSACTION;
        UPDATE zonas
        SET Zona = pZona, TipoZona = pTipoZona, Capacidad = pCapacidad
        WHERE IdZona = pIdZona;
        SELECT 'OK' AS Mensaje;
    COMMIT;
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

-- Dump completed on 2024-12-27 16:18:47
