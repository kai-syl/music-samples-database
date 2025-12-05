-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: samples
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.24.04.1

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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `nationality` text,
  `genre` text,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'revenxnt','American','breakcore'),(2,'Shygirl','British','club'),(3,'Cosha','Irish',NULL),(4,'Club Shy',NULL,NULL),(5,'SG Lewis','British','dance'),(6,'Ian Asher','American','dance'),(7,'Phantogram','American','electronic rock'),(8,'Kenny Barron Trio','American','jazz'),(9,'biko','American','dance'),(20,'test artist','for m2m CRUD','test genre'),(21,'test artist 2','m2m crud test 2','HELLO'),(22,'test artist 3','artist 3','3');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_song`
--

DROP TABLE IF EXISTS `artist_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_song` (
  `artist_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`artist_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `artist_song_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `artist_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_song`
--

LOCK TABLES `artist_song` WRITE;
/*!40000 ALTER TABLE `artist_song` DISABLE KEYS */;
INSERT INTO `artist_song` VALUES (2,1),(3,1),(4,1),(5,2),(1,3),(1,4),(6,5),(7,5),(8,6),(1,7),(9,7),(2,12),(5,12),(1,16),(1,22),(9,22);
/*!40000 ALTER TABLE `artist_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release`
--

DROP TABLE IF EXISTS `release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release` (
  `type` text NOT NULL,
  `releaseDate` date NOT NULL,
  `numSongs` int DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `UPC` varchar(15) NOT NULL,
  `url` text,
  PRIMARY KEY (`UPC`),
  UNIQUE KEY `UPC` (`UPC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release`
--

LOCK TABLES `release` WRITE;
/*!40000 ALTER TABLE `release` DISABLE KEYS */;
INSERT INTO `release` VALUES ('album','2025-09-05',10,'Anemoia','00602478202438','https://open.spotify.com/album/3kse3e9XxmIedJb9bfjErH?si=9500e41cbbd749f1'),('single','2025-07-11',2,'Sugar (feat. Shygirl)','00602478202544','https://open.spotify.com/album/1QTFFa1qM6luiHOk5ey5ue?si=I6sWtbeNRBSgbm9zHASLPA'),('single','2025-08-15',1,'Black Out Days (Stay Away)','00602478924026','https://open.spotify.com/album/5tqjvPX88OX1OpVo1QGBYC?si=mBW6ZIsnRKaKaQEYe9NzUg'),('single','2024-10-04',1,'eternal','055855825308','https://open.spotify.com/album/54DbzaGBPlDL4NBLzYnneo?si=0M-itmdVSg2ycc11dyrHVw'),('EP','2025-12-19',2,'Fortune Lies','057914201535',NULL),('single','2025-11-27',1,'tTitle','12345678910',''),('single','2025-10-10',1,'Cyanica','199740065803','https://open.spotify.com/album/3LTOyINgcxhCRfkKCHBuEC?si=lEOjwgohRSSjyQQwEEGcNg'),('album','2009-08-19',10,'Minor Blues','4538182548462','https://open.spotify.com/album/54sNnRkbv3V2ppJH836Rxb?si=OtOHNwBNTTaFi_0Zky14CA'),('EP','2024-02-09',6,'Club Shy','5056556135012','https://open.spotify.com/album/7q7aNUQEh4cY2JfuylF21F?si=4vIHYKm4QOuIKz096g9jCw');
/*!40000 ALTER TABLE `release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_song`
--

DROP TABLE IF EXISTS `release_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release_song` (
  `UPC` varchar(15) NOT NULL,
  `ISRC` char(12) NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`UPC`,`ISRC`),
  KEY `ISRC` (`ISRC`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `release_song_ibfk_1` FOREIGN KEY (`ISRC`) REFERENCES `song` (`ISRC`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `release_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `release_song_ibfk_3` FOREIGN KEY (`UPC`) REFERENCES `release` (`UPC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_song`
--

LOCK TABLES `release_song` WRITE;
/*!40000 ALTER TABLE `release_song` DISABLE KEYS */;
INSERT INTO `release_song` VALUES ('5056556135012','GBMVH2300650',1),('00602478202438','GBUM72503544',2),('00602478202544','GBUM72503544',2),('055855825308','CALVP2475952',3),('00602478924026','USUM72509197',5),('4538182548462','JPI291065403',6),('199740065803','QT3F32561928',7),('00602478202438','GBUM72503569',12),('057914201535','CBF8B2555901',16),('057914201535','CBF8B2555900',22);
/*!40000 ALTER TABLE `release_song` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `get_song_id` BEFORE INSERT ON `release_song` FOR EACH ROW begin set NEW.song_id = (select song_id from song where song.ISRC = NEW.ISRC);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repo`
--

DROP TABLE IF EXISTS `repo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repo` (
  `source_id` int NOT NULL,
  `custodian` text,
  `type` text,
  `price` decimal(8,2) DEFAULT NULL,
  `billed` text,
  `name` text,
  PRIMARY KEY (`source_id`),
  CONSTRAINT `repo_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo`
--

LOCK TABLES `repo` WRITE;
/*!40000 ALTER TABLE `repo` DISABLE KEYS */;
INSERT INTO `repo` VALUES (4,'Splice',NULL,12.99,'monthly','Splice Sounds'),(6,'NastyNasty','pack',0.00,'n/a','Breakcore is not a good way to get laid');
/*!40000 ALTER TABLE `repo` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `repo_source_id_before_in` BEFORE INSERT ON `repo` FOR EACH ROW begin
insert into sampleSource values ();
set NEW.source_id = last_insert_id();
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample` (
  `sample_id` int NOT NULL AUTO_INCREMENT,
  `instrument` text,
  `genre` text,
  `source_id` int DEFAULT NULL,
  PRIMARY KEY (`sample_id`),
  KEY `sample_ibfk_1` (`source_id`),
  CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample`
--

LOCK TABLES `sample` WRITE;
/*!40000 ALTER TABLE `sample` DISABLE KEYS */;
INSERT INTO `sample` VALUES (1,'vocal','dance',1),(2,'synth','pop',2),(3,'drum loop','dance',3),(4,'piano','jazz',7),(6,'drum loop','breakcore',6);
/*!40000 ALTER TABLE `sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sampleSource`
--

DROP TABLE IF EXISTS `sampleSource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sampleSource` (
  `source_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sampleSource`
--

LOCK TABLES `sampleSource` WRITE;
/*!40000 ALTER TABLE `sampleSource` DISABLE KEYS */;
INSERT INTO `sampleSource` VALUES (1),(2),(3),(4),(6),(7),(9),(10),(11),(12),(13),(14),(18),(21),(31),(32),(33),(34),(35),(36),(37),(38);
/*!40000 ALTER TABLE `sampleSource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample_on_song`
--

DROP TABLE IF EXISTS `sample_on_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sample_on_song` (
  `sample_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`sample_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `sample_on_song_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sample_on_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_on_song`
--

LOCK TABLES `sample_on_song` WRITE;
/*!40000 ALTER TABLE `sample_on_song` DISABLE KEYS */;
INSERT INTO `sample_on_song` VALUES (2,3),(1,4),(3,4);
/*!40000 ALTER TABLE `sample_on_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) DEFAULT NULL,
  `data` blob,
  `expiry` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (8,'session:CdJvz9wFIdYt4SWyOGUMnqfhj1GlNkXkPQr-zrzR_IE',_binary '…ª_permanentÃ«oauth_state¾PuBks96qJbB3OfWH0l90MS1AOCxXru«oauth_token†¬access_token\ÚOeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4MDQwODEsImlhdCI6MTc2NDgwMzc4MSwiYXV0aF90aW1lIjoxNzY0ODAzNzQ3LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6ImViZWRlYmU5ZmJjMTRmZjJjODY2ODBiMDlmMTE3YTJkNjA0MzkzYTIxYjZmNTE3ZTc1NWE0NzZjNjZhN2Y2NzgiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl0sImF6cCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJ1aWQiOiJxVEZ4ZDFpMEdzeUNHWWRZTUpEa28wMU9ZZHBqT1UxMUI1VWE3Zk5VIn0.uhJwB143MQtuwauL8PKO_vdbZGXHoNJmCo8QC40Jcep_4Jb7UMkfBRv53bkEbGK8P4e3PiLx6t6Slk6KasrqUj0ew8_KWQN23NYEGInLHLZKvA7-gybozLLaXDUxZEJYtqYhyLPJJYH7oPK-GW_3bE9Ro0IzOQIIGDHozwcJEU-sKOpwOmqcFnZqN-I1vzWXwsm-EGOPZatdELdVxqGMcpncTUNTJLsnn-8fymTscWu-yzuBEKQv6kNslL6Ket-sVahO9_1Rcx1NYWLo2ykBVUm3-7MH22_05OqxGEAlCttgz0gtone42zr7zabQl1mToYrUNL5jEDpEFbu0XnD5STZdzHoCNNTGwvDzOtBzwRoGxZMQUFJ6s5tQGhCmSvWwIuPSA6_Bn1L86c36Kh8UzTIC04gdmZg3lTOxC8XEHNxwha7UC4fT-2j6o4hlMDaaRZvv0PrT3NEEs6bnl-DqY8Q5PzYgcVMgbgrQVxXlinHjXXhNPafdBeROAZgBzgJUXhsApIJ_6HpC9ODMUqLtzBr5D1DJe4VnlpwzGstRd0E--x4zeUWItff2_0GPxUbQEnXAxesDbJT4Swhp_mbwp07VD4NWHoJHMDYtoLuSIo3rSCuREDMmd7evxWmis9oQft_v6ziU-sNDR-HlLmhA8X-DAY0JfiaBR53WK3cPEiwªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\Ú\ÌeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4MDQwODEsImlhdCI6MTc2NDgwMzc4MSwiYXV0aF90aW1lIjoxNzY0ODAzNzQ3LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6ImViZWRlYmU5ZmJjMTRmZjJjODY2ODBiMDlmMTE3YTJkNjA0MzkzYTIxYjZmNTE3ZTc1NWE0NzZjNjZhN2Y2NzgiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl19.UzvqhCx7PQmdiQsi-gwuedQ5N4lnN1kH7eylYs6b8zu3GfZPFGH_xEAOMFDzr4UQfssKY12VQDgiNg8Ao4QAJIpUT5vfo4HChRH9AsoYCP64rdDbnR2Z6BUe3d2LgKRuK9tTX1SN0axwoyk8VMVaXEUJqESYNxXN0iZ9-fsrwRDAcu4FgXXbg_ON7Pzj7L4jLQxuedHqyhFCQcFVhoHU2icUWAZGTyrkCO1CO8OvTDCc5vLl6Zp4DcUgZdlwznT8VZlga3CfzagaYe3CTyvPCrKk-H4khRo0nenWFY2W8jYwF7acGvgq5PugB3c02pEcq7ov9df8xzQTKiURoyPggUhiNiNf-grpF6xM9152ckX1X01T6S0JQW1gkpv6VfmlFHqiXdn0Zpm9HMk0IUT-7c0clB6h9NN1mLxFFLgryM2lac-v6IxD_3gVgMKLorRBjTreLimNfAV6vKbPB2llVzm1Ojon6tnAWc0XWfQ-Ej520nPekYVdGYoAUi6epzW7zGOFncU6yR3uqtSE5KABNGZCuQpqHPEnqm0yh-FxnLQ47vEXRlLPEEvcFrK4SWggHZ0Wl6KMfsRRXn2CxxIL3zJMt0tTbbSWXSl-TXWnSvqkBq8_fpS6rFY22FizjRnAarUKasa-K6_RoljUfBfPF9wiARTQ4z_QX40_2ef3Prsªexpires_at\Îi0\Å\ó¤userˆ£sub£kai¥email®kai@kaisyl.net®email_verifiedÃ¤name£kaiªgiven_name£kai²preferred_username£kai¨nickname£kai¦groups–°authentik Admins¬basic access£kai¦family©cf-access«MSDB Admins¥admin\Ã','2025-12-03 23:46:25'),(9,'session:4D788Z-YF7pJP3Yzu3b_fJPphD2O8hVALV9qJvx9nN4',_binary '‚ª_permanentÃ«oauth_state¾hPcwlBS4L90YJlt4dlkYXX2cQ6Dqrh','2025-12-04 23:35:41'),(11,'session:MkJbUYz9fWLizl9H7RTihWv3Sz7mgbLYTtiD6P31Nro',_binary '…ª_permanentÃ«oauth_state¾19LQV5SVeaNwEeUknYDAvVbw6UKB7s«oauth_token†¬access_token\ÚOeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4OTE4NjgsImlhdCI6MTc2NDg5MTU2OCwiYXV0aF90aW1lIjoxNzY0ODkxNTI1LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6IjE0MDcxNzAwZDE0YmNlYTBiMzg1NDNiYmM3M2NiZjk5N2Y4YmRhY2Q1ZWNlZmMyNGRmZjIwNmIyNGEyOTY3NmQiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl0sImF6cCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJ1aWQiOiJKdnE0TGtjY2FKc3J5a0p5eDg5UmFldGV0Tlh0aENzV2JLRHZwNzU4In0.Hg41n46Sg4pA7yTKM2bj2EFpe7-hrOC7LlBM0aXUyZBLIqUzSmNQIvu7IVge8n_v6o8kr1pBc3hhw6V9CNqciJ9n2MrqkWaW9lLowAH8MXJrFn-tcmg438bwRZtZTqCswQet0kq4NW-HjjgR-bs8xRvBnv8EpnzlpPr4vVXabz6Qz6zUct3t3PVZ4dxJdTmo1hMCZDWvbdBRuYmOktCqWdyI_gd4xszTDqn6hySKbr4xOCFaE_yQvyMF2tGrVLMX_e1llsSL9YF0noI9Ewkd1lmXRpnElorWheU7JLEwWeFkn1tbvx_WTs94Eec1yoME2nduXEjACD63XuXrplRZAZoIn-XZXkK9u24CxKYFbx7vMbHJVzWiLIRkRJ8vJeYSTjMqxw_pBRHD0mc4a9qM9eP3sq-aBQMPzjALjRxgdTbdN9POERXkUuLIvon-Ctxd__q_GzVXAnFtm3Ki06Y3hWMyHMOlQrpZZF_x4ZU6oO7Ju0JIjYzA4qQniN8vnyzGgEpHrNS2v0bqrVrEbGwbnP2XTOeehRT4AxAoVzqRNr1cCLhiAvLWgj9L6rz1gcspZpwNUE32m8vlMsXYeVggpRvZoL33SdewWAnC6JK2fR0KY5h_fbI8jxTrG6XcUhgwYIyWX30c-SjBGcF-EGWUvMAVXnIBGsWVxpXBtPNUxJ4ªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\Ú\ÌeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4OTE4NjgsImlhdCI6MTc2NDg5MTU2OCwiYXV0aF90aW1lIjoxNzY0ODkxNTI1LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6IjE0MDcxNzAwZDE0YmNlYTBiMzg1NDNiYmM3M2NiZjk5N2Y4YmRhY2Q1ZWNlZmMyNGRmZjIwNmIyNGEyOTY3NmQiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl19.Uwjbi0sHrbizsuq_gGTjFH3SLVjzKVcrffnDwTUEVg4IQ-gl1Ddbhs8mGZtKDVUDfgwtfSzxKt3JP2ResTOV49TauZqzSWmUUMmSSxr7B-G7N6wYTFmYBv84336jZcIHtLdehmqNGuL0vptxP36ZtqjCsTv7CfMZqSdLEipgIoWTt2lBIB_vC4X1zP6_qggmktunhW8-g4TxfQRG6Nf2V1iaSLbvZGNTsVEWQxeQES063SVQtoaaWwrI34P3AoDI8a7gdgAGceUpaZuEun50uVAheGXP9_jVmCvZMb9-JZNQpmYMTnFKD2oC1nXgboP8tC_vCCvxYSFUS8dwfBwU03oAlpk-tMtayS2NF_ajcc7_DG15dkD31OLrr5DKTsrsNcIiWXDpoXPlEcVNqwb-AzeCo7jbtP1RGXpXicXLyYVvUQj1MzEPrTs14MD1BGydv1zWoywT9qejhv2pIU8-TrYsoJ3aONBwjx1YjvBoFb2ShRnz_wHvMpdgYX3EADOMmx6K0Mgtln2gKNdLQXbXLY8gf8HnfpecotJ9ooPGR3iWmMbNIV-EJVNf5Oy8_9496D5KGxrV5W4v75fU2kiuGa_KOZ6iuzLzgVX6AwHl32Im8OH34YHwhPERp6ERQMFH4uj7YpylJFItYhWmeoqIxOG9_6gjsnV6XSjUmBenEzcªexpires_at\Îi2Ý¤userˆ£sub£kai¥email®kai@kaisyl.net®email_verifiedÃ¤name£kaiªgiven_name£kai²preferred_username£kai¨nickname£kai¦groups–°authentik Admins¬basic access£kai¦family©cf-access«MSDB Admins¥admin\Ã','2025-12-05 00:09:33'),(33,'session:s9pNKXIqoIhd8YbX_XpWlCMVLEJisSs8YcI7-9SIe0Q',_binary '‚ª_permanentÃ«oauth_state¾ueSjVG0vR6IluzYLR5WqbxMIJC9xis','2025-12-05 02:51:09');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `genre` text,
  `title` varchar(100) NOT NULL,
  `key` varchar(3) DEFAULT NULL,
  `ISRC` char(12) DEFAULT NULL,
  `bpm` smallint DEFAULT NULL,
  `source_id` int NOT NULL,
  PRIMARY KEY (`song_id`),
  UNIQUE KEY `ISRC` (`ISRC`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `sampleSource` (`source_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'dance','thicc','CM','GBMVH2300650',130,1),(2,'pop','Sugar','DbM','GBUM72503544',130,2),(3,'breakcore','eternal','GM','CALVP2475952',160,10),(4,'breakcore','10o3//dusk',NULL,'CALVP2413177',170,11),(5,'dance','Black Out Days (Stay Away)','Gbm','USUM72509197',155,3),(6,'jazz','Emily','CM','JPI291065403',115,7),(7,'dance','Cyanica','Am','QT3F32561928',123,12),(12,'pop','Baby Blue','C#M','GBUM72503569',125,13),(16,'Dance','Fortune Lies','Am','CBF8B2555901',130,14),(22,'Electronica','Collisions','idk','CBF8B2555900',150,34);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `song_source_id_before_in` BEFORE INSERT ON `song` FOR EACH ROW begin
insert into sampleSource values ();
set NEW.source_id = last_insert_id();
end */;;
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

-- Dump completed on 2025-12-05 20:54:50
