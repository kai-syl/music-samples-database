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
INSERT INTO `artist` VALUES (1,'revenxnt','American','breakcore'),(2,'Shygirl','British','club'),(3,'Cosha','Irish',NULL),(4,'Club Shy',NULL,NULL),(5,'SG Lewis','British','dance'),(6,'Ian Asher','American','dance'),(7,'Phantogram','American','electronic rock'),(8,'Kenny Barron Trio','American','jazz'),(9,'biko','American','dance'),(20,'test artist','for m2m CRUD','test genre'),(21,'test artist 2','m2m crud test 2','HELLO');
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
INSERT INTO `artist_song` VALUES (2,1),(3,1),(4,1),(5,2),(1,3),(1,4),(6,5),(7,5),(8,6),(1,7),(9,7),(2,12),(5,12),(1,16),(1,22),(9,22),(20,22),(1,26),(9,26);
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
INSERT INTO `release` VALUES ('album','2025-09-05',10,'Anemoia','00602478202438','https://open.spotify.com/album/3kse3e9XxmIedJb9bfjErH?si=9500e41cbbd749f1'),('single','2025-07-11',2,'Sugar (feat. Shygirl)','00602478202544','https://open.spotify.com/album/1QTFFa1qM6luiHOk5ey5ue?si=I6sWtbeNRBSgbm9zHASLPA'),('single','2025-08-15',1,'Black Out Days (Stay Away)','00602478924026','https://open.spotify.com/album/5tqjvPX88OX1OpVo1QGBYC?si=mBW6ZIsnRKaKaQEYe9NzUg'),('single','2024-10-04',1,'eternal','055855825308','https://open.spotify.com/album/54DbzaGBPlDL4NBLzYnneo?si=0M-itmdVSg2ycc11dyrHVw'),('single','2025-12-05',1,'Florabella','057914094991','https://open.spotify.com/album/2RM5QT9eleqeO5vebySDO1?si=-PAM-PsVR_yMAm2ZUa1GHA'),('EP','2025-12-19',2,'Fortune Lies','057914201535',NULL),('single','2025-11-27',1,'tTitle','12345678910',''),('single','2025-10-10',1,'Cyanica','199740065803','https://open.spotify.com/album/3LTOyINgcxhCRfkKCHBuEC?si=lEOjwgohRSSjyQQwEEGcNg'),('album','2009-08-19',10,'Minor Blues','4538182548462','https://open.spotify.com/album/54sNnRkbv3V2ppJH836Rxb?si=OtOHNwBNTTaFi_0Zky14CA'),('EP','2024-02-09',6,'Club Shy','5056556135012','https://open.spotify.com/album/7q7aNUQEh4cY2JfuylF21F?si=4vIHYKm4QOuIKz096g9jCw');
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
INSERT INTO `release_song` VALUES ('5056556135012','GBMVH2300650',1),('00602478202438','GBUM72503544',2),('00602478202544','GBUM72503544',2),('055855825308','CALVP2475952',3),('00602478924026','USUM72509197',5),('4538182548462','JPI291065403',6),('199740065803','QT3F32561928',7),('00602478202438','GBUM72503569',12),('057914201535','CBF8B2555901',16),('057914201535','CBF8B2555900',22),('057914094991','CBF8B2543651',26);
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sampleSource`
--

LOCK TABLES `sampleSource` WRITE;
/*!40000 ALTER TABLE `sampleSource` DISABLE KEYS */;
INSERT INTO `sampleSource` VALUES (1),(2),(3),(4),(6),(7),(9),(10),(11),(12),(13),(14),(18),(21),(31),(32),(33),(34),(35),(36),(37),(38),(39);
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (8,'session:CdJvz9wFIdYt4SWyOGUMnqfhj1GlNkXkPQr-zrzR_IE',_binary '…ª_permanentÃ«oauth_state¾PuBks96qJbB3OfWH0l90MS1AOCxXru«oauth_token†¬access_token\ÚOeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4MDQwODEsImlhdCI6MTc2NDgwMzc4MSwiYXV0aF90aW1lIjoxNzY0ODAzNzQ3LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6ImViZWRlYmU5ZmJjMTRmZjJjODY2ODBiMDlmMTE3YTJkNjA0MzkzYTIxYjZmNTE3ZTc1NWE0NzZjNjZhN2Y2NzgiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl0sImF6cCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJ1aWQiOiJxVEZ4ZDFpMEdzeUNHWWRZTUpEa28wMU9ZZHBqT1UxMUI1VWE3Zk5VIn0.uhJwB143MQtuwauL8PKO_vdbZGXHoNJmCo8QC40Jcep_4Jb7UMkfBRv53bkEbGK8P4e3PiLx6t6Slk6KasrqUj0ew8_KWQN23NYEGInLHLZKvA7-gybozLLaXDUxZEJYtqYhyLPJJYH7oPK-GW_3bE9Ro0IzOQIIGDHozwcJEU-sKOpwOmqcFnZqN-I1vzWXwsm-EGOPZatdELdVxqGMcpncTUNTJLsnn-8fymTscWu-yzuBEKQv6kNslL6Ket-sVahO9_1Rcx1NYWLo2ykBVUm3-7MH22_05OqxGEAlCttgz0gtone42zr7zabQl1mToYrUNL5jEDpEFbu0XnD5STZdzHoCNNTGwvDzOtBzwRoGxZMQUFJ6s5tQGhCmSvWwIuPSA6_Bn1L86c36Kh8UzTIC04gdmZg3lTOxC8XEHNxwha7UC4fT-2j6o4hlMDaaRZvv0PrT3NEEs6bnl-DqY8Q5PzYgcVMgbgrQVxXlinHjXXhNPafdBeROAZgBzgJUXhsApIJ_6HpC9ODMUqLtzBr5D1DJe4VnlpwzGstRd0E--x4zeUWItff2_0GPxUbQEnXAxesDbJT4Swhp_mbwp07VD4NWHoJHMDYtoLuSIo3rSCuREDMmd7evxWmis9oQft_v6ziU-sNDR-HlLmhA8X-DAY0JfiaBR53WK3cPEiwªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\Ú\ÌeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4MDQwODEsImlhdCI6MTc2NDgwMzc4MSwiYXV0aF90aW1lIjoxNzY0ODAzNzQ3LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6ImViZWRlYmU5ZmJjMTRmZjJjODY2ODBiMDlmMTE3YTJkNjA0MzkzYTIxYjZmNTE3ZTc1NWE0NzZjNjZhN2Y2NzgiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl19.UzvqhCx7PQmdiQsi-gwuedQ5N4lnN1kH7eylYs6b8zu3GfZPFGH_xEAOMFDzr4UQfssKY12VQDgiNg8Ao4QAJIpUT5vfo4HChRH9AsoYCP64rdDbnR2Z6BUe3d2LgKRuK9tTX1SN0axwoyk8VMVaXEUJqESYNxXN0iZ9-fsrwRDAcu4FgXXbg_ON7Pzj7L4jLQxuedHqyhFCQcFVhoHU2icUWAZGTyrkCO1CO8OvTDCc5vLl6Zp4DcUgZdlwznT8VZlga3CfzagaYe3CTyvPCrKk-H4khRo0nenWFY2W8jYwF7acGvgq5PugB3c02pEcq7ov9df8xzQTKiURoyPggUhiNiNf-grpF6xM9152ckX1X01T6S0JQW1gkpv6VfmlFHqiXdn0Zpm9HMk0IUT-7c0clB6h9NN1mLxFFLgryM2lac-v6IxD_3gVgMKLorRBjTreLimNfAV6vKbPB2llVzm1Ojon6tnAWc0XWfQ-Ej520nPekYVdGYoAUi6epzW7zGOFncU6yR3uqtSE5KABNGZCuQpqHPEnqm0yh-FxnLQ47vEXRlLPEEvcFrK4SWggHZ0Wl6KMfsRRXn2CxxIL3zJMt0tTbbSWXSl-TXWnSvqkBq8_fpS6rFY22FizjRnAarUKasa-K6_RoljUfBfPF9wiARTQ4z_QX40_2ef3Prsªexpires_at\Îi0\Å\ó¤userˆ£sub£kai¥email®kai@kaisyl.net®email_verifiedÃ¤name£kaiªgiven_name£kai²preferred_username£kai¨nickname£kai¦groups–°authentik Admins¬basic access£kai¦family©cf-access«MSDB Admins¥admin\Ã','2025-12-03 23:46:25'),(9,'session:4D788Z-YF7pJP3Yzu3b_fJPphD2O8hVALV9qJvx9nN4',_binary '‚ª_permanentÃ«oauth_state¾hPcwlBS4L90YJlt4dlkYXX2cQ6Dqrh','2025-12-04 23:35:41'),(11,'session:MkJbUYz9fWLizl9H7RTihWv3Sz7mgbLYTtiD6P31Nro',_binary '…ª_permanentÃ«oauth_state¾19LQV5SVeaNwEeUknYDAvVbw6UKB7s«oauth_token†¬access_token\ÚOeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4OTE4NjgsImlhdCI6MTc2NDg5MTU2OCwiYXV0aF90aW1lIjoxNzY0ODkxNTI1LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6IjE0MDcxNzAwZDE0YmNlYTBiMzg1NDNiYmM3M2NiZjk5N2Y4YmRhY2Q1ZWNlZmMyNGRmZjIwNmIyNGEyOTY3NmQiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl0sImF6cCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJ1aWQiOiJKdnE0TGtjY2FKc3J5a0p5eDg5UmFldGV0Tlh0aENzV2JLRHZwNzU4In0.Hg41n46Sg4pA7yTKM2bj2EFpe7-hrOC7LlBM0aXUyZBLIqUzSmNQIvu7IVge8n_v6o8kr1pBc3hhw6V9CNqciJ9n2MrqkWaW9lLowAH8MXJrFn-tcmg438bwRZtZTqCswQet0kq4NW-HjjgR-bs8xRvBnv8EpnzlpPr4vVXabz6Qz6zUct3t3PVZ4dxJdTmo1hMCZDWvbdBRuYmOktCqWdyI_gd4xszTDqn6hySKbr4xOCFaE_yQvyMF2tGrVLMX_e1llsSL9YF0noI9Ewkd1lmXRpnElorWheU7JLEwWeFkn1tbvx_WTs94Eec1yoME2nduXEjACD63XuXrplRZAZoIn-XZXkK9u24CxKYFbx7vMbHJVzWiLIRkRJ8vJeYSTjMqxw_pBRHD0mc4a9qM9eP3sq-aBQMPzjALjRxgdTbdN9POERXkUuLIvon-Ctxd__q_GzVXAnFtm3Ki06Y3hWMyHMOlQrpZZF_x4ZU6oO7Ju0JIjYzA4qQniN8vnyzGgEpHrNS2v0bqrVrEbGwbnP2XTOeehRT4AxAoVzqRNr1cCLhiAvLWgj9L6rz1gcspZpwNUE32m8vlMsXYeVggpRvZoL33SdewWAnC6JK2fR0KY5h_fbI8jxTrG6XcUhgwYIyWX30c-SjBGcF-EGWUvMAVXnIBGsWVxpXBtPNUxJ4ªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\Ú\ÌeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL2ZsYXNrLWFwcC10ZXN0LyIsInN1YiI6ImthaSIsImF1ZCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJleHAiOjE3NjQ4OTE4NjgsImlhdCI6MTc2NDg5MTU2OCwiYXV0aF90aW1lIjoxNzY0ODkxNTI1LCJhY3IiOiJnb2F1dGhlbnRpay5pby9wcm92aWRlcnMvb2F1dGgyL2RlZmF1bHQiLCJhbXIiOlsicHdkIiwibWZhIl0sInNpZCI6IjE0MDcxNzAwZDE0YmNlYTBiMzg1NDNiYmM3M2NiZjk5N2Y4YmRhY2Q1ZWNlZmMyNGRmZjIwNmIyNGEyOTY3NmQiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl19.Uwjbi0sHrbizsuq_gGTjFH3SLVjzKVcrffnDwTUEVg4IQ-gl1Ddbhs8mGZtKDVUDfgwtfSzxKt3JP2ResTOV49TauZqzSWmUUMmSSxr7B-G7N6wYTFmYBv84336jZcIHtLdehmqNGuL0vptxP36ZtqjCsTv7CfMZqSdLEipgIoWTt2lBIB_vC4X1zP6_qggmktunhW8-g4TxfQRG6Nf2V1iaSLbvZGNTsVEWQxeQES063SVQtoaaWwrI34P3AoDI8a7gdgAGceUpaZuEun50uVAheGXP9_jVmCvZMb9-JZNQpmYMTnFKD2oC1nXgboP8tC_vCCvxYSFUS8dwfBwU03oAlpk-tMtayS2NF_ajcc7_DG15dkD31OLrr5DKTsrsNcIiWXDpoXPlEcVNqwb-AzeCo7jbtP1RGXpXicXLyYVvUQj1MzEPrTs14MD1BGydv1zWoywT9qejhv2pIU8-TrYsoJ3aONBwjx1YjvBoFb2ShRnz_wHvMpdgYX3EADOMmx6K0Mgtln2gKNdLQXbXLY8gf8HnfpecotJ9ooPGR3iWmMbNIV-EJVNf5Oy8_9496D5KGxrV5W4v75fU2kiuGa_KOZ6iuzLzgVX6AwHl32Im8OH34YHwhPERp6ERQMFH4uj7YpylJFItYhWmeoqIxOG9_6gjsnV6XSjUmBenEzcªexpires_at\Îi2Ý¤userˆ£sub£kai¥email®kai@kaisyl.net®email_verifiedÃ¤name£kaiªgiven_name£kai²preferred_username£kai¨nickname£kai¦groups–°authentik Admins¬basic access£kai¦family©cf-access«MSDB Admins¥admin\Ã','2025-12-05 00:09:33'),(33,'session:s9pNKXIqoIhd8YbX_XpWlCMVLEJisSs8YcI7-9SIe0Q',_binary '‚ª_permanentÃ«oauth_state¾ueSjVG0vR6IluzYLR5WqbxMIJC9xis','2025-12-05 02:51:09'),(36,'session:EBlme7h-xQCmXxAXBWaqm_X8tLOgkmta922NmRgF02c',_binary '…ª_permanentÃ«oauth_state¾gGI7yX5knkgxoMuW2WilEpEFimSEp5«oauth_token†¬access_token\ÚeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MDY3MTU4LCJpYXQiOjE3NjUwNjY4NTgsImF1dGhfdGltZSI6MTc2NTA2NjY5NywiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiI1NGRlZmJlNWNmYjkwNTNjMGRkMTE3NWFiY2JlMjI2YTgyYzZjMDEwNmY4NTA2NGMzZWJjNWZlMDgzOTYxY2IxIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdLCJhenAiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwidWlkIjoiUFJqQTZ6UXJmVTE4VXFUZFNMU281ODJVZE1oNFNXMVpRVVYyNFNFNSJ9.YeIRR4MO3jb7T8XqvPaD7d-P4tYPCLCU4e2n0pWDYVkpK5HeFa0Xg8Kfyx-1RqJflOzC6z-Dg6m8bVAwfe3_Xa8ngzK5AY7Uk1TaxOuYkBvIwyratrnJRygpnji3SxOWnI-aWghY7MrZc5j2iXUNBwMLvp79VHzR7DbJPufejIkZy7FHUQ4FoRcQ6h5qFR-BaWiEo4wJn-fVOHF2d_qYBTa5Q8wwWP3cfnO6X_oThNqWDtV1KVAkQcFa4fGjp1Ju8lyPpEqi0g_ziDwDNs-B1VCmLZwyIQ8aino_XKthstwEdbP1ds34lL9tTVYasgQkhsQvcvo2Ap2notgPMxZdVVP24-M-H0P37oryWGc6v5ykU6UwzVLc3KbmvyGZUQNyQ8ZMWYyDk0qfvTvj0wnJ0Z13tHZAM9-YpDntMAztJZAs9o510SWgflxD4-2bdCq3209ZeWw7ZVhL9EN_It-mnPOGyAnxL3z-j0uNaWpCop11YP7bi48TFgEN0Zs0jon71LUGXOAztNP4cTuZuPMmjl8yQyFNnd7AD61tvoABeAETERFmLunsCu-VIhNg1D504YrU5AlxcphWiBZ5BTlw5BsAHO8ke6di3mUjVJ2zhPtP6MwvV6B1s76JajXgM0Gd013zweTgb7mituWF3cFEW94BNwjXiNnszttprbMa3jwªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\ÚŽeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MDY3MTU4LCJpYXQiOjE3NjUwNjY4NTgsImF1dGhfdGltZSI6MTc2NTA2NjY5NywiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiI1NGRlZmJlNWNmYjkwNTNjMGRkMTE3NWFiY2JlMjI2YTgyYzZjMDEwNmY4NTA2NGMzZWJjNWZlMDgzOTYxY2IxIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdfQ.VCczIHAM09viSbLHS_E0c6rBezw04xqxt0JhLxh1wUjxICz-NscDxfdWpMJYLl_5iEmKXBfHxnLkr67o0lwxpmrrJh1lhPUqoEqSKn0y3W7PRvYXlPGa0quugSyaS0Z_UB-VlZv6IOPgfH2rPe8qvI7he1xgps3LPbwVreffm7yj3f11lbDsYaQRy43YwKLThZIwVht_HLkNwaWzT9T7N2Y2m1fZs9v5znVR0Z1gm1lSRoO3VP9ELDI6jrNo38yT62KECln3KjQHPec6qpquvuRPIshci0q-0xMUZ5SGSxELk6vpaPGNrzD691gcplWr5xNdIQTx2NoR2C8pOgsIzn6EOu_t6ckAVKuB0HJdUUYxj_isR69KhJk3YUoJ52NceOKIcU6v6GPPeTi8yskNrrfcVhzGU-jsAnGhbs2JrKOIdKyRlwj3dUeR8q9UaPAy4DRRs61_JAavB80tlwpSpu2o1KdZz4U3ZfRjgKMtyIopo4vvIWswc91TKVh4Ynj2DsQWVzEWbgLVNvv_f0aC2YNrvmPaZrObmdawWR35FtwnKVGDPhiApQvZ9ojN4SgPSmdgD_f1d1UgM5bHpZeCJWeb8rAqp11Y2wgPQJFlY2t-_glVjeNSPtLbupj8k2vOTs2Qm8FUrt5rlhMWd9CR0fI4D_aXm54VxXs0hGGD1WEªexpires_at\Îi4É—¤userˆ£sub¨dbviewer¥email³dbviewer@kaisyl.net®email_verifiedÃ¤name¨dbviewerªgiven_name¨dbviewer²preferred_username¨dbviewer¨nickname¨dbviewer¦groups‘«MSDB Guests¥admin\Â','2025-12-07 00:52:03'),(38,'session:k63Ve9fYLb1dta6Fj5N5Bi7TIFtkfWiwOkHpvt-LWG4',_binary '‚ª_permanentÃªlogged_out\Ã','2025-12-07 23:57:10'),(39,'session:mnASYB7FVxy9Azy1uUmI13fGRRQLUGLDK7FU3nlCCJo',_binary '…ª_permanentÃ«oauth_state¾OMsGdBHLbsaao5QgwpYaQdY8egQaRX«oauth_token†¬access_token\ÚeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4MTI1LCJpYXQiOjE3NjUxNDc4MjUsImF1dGhfdGltZSI6MTc2NTE0NzgxNywiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiI5MzU1ZWRhZGY1Y2JjOWJkY2NlMTc0NjAzMjZkODQxNzMzZWVmNjQ0NzkxNjRhY2Y5MmJhZTJkNGQxM2ZkNzM5IiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdLCJhenAiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwidWlkIjoiSERFY0pTVmcwamZHYWRESlRLcDhZRE1acGV1TVVtQXZuOUNRR05rQyJ9.OdO8kPyG0dbgaibA1qiuEJB4VNtCzA9SVlBbHkuSsMeXa01-YYAA_91iTaDiLUOqqmTtL1OxogT5S0yqWQkaRkms7eXTdGENqQTTb771IT4v9Oz-LNivQDvj4MezG4lhVQ2CZZ_LfSHmpCJ0uk2_va6Ay5KRRL5Qzn0_8AZym3K8CW0l-ZlVBU62Kk_kfa295lcI8H_7mig7s5eQXLPY_r2aA6IAH6LjfdJZLV_wqezbV3tCHbt64mQExdCCGso2nNc2D9Q7lfCj1y9E5TEA-NXq5T7QBcYPP39-FDfApbGgNi9Y79IUWQYDiWz4ypaGCyiedAQUJM_cwBoTVvPP9TOpQVc0jDChGEIzGXQZriVKU3kS8SDfSi35OWqFISn4QOZhPmxtKj3-ylbN6ncrN0-RjBPcjsEi-WdC2pBnFAHGEP8RxBT6_9aX22VZDccr1QbjahLPMhYtEE0EOUfhe-RvUQ-mQTn7h-l_csEy9gHEMFynYCbU6vqDNqvwzjEePHGj6fOhbSuVoQyUXkc2MrUPr4oGKO-e2I74YkWbx0ssnUYAte1WXfMZYyIlQg-dsU_b7wSgYBdGz4nxxoo_reUK_7puJ_5MLkN7huFdXGKOmlN462xIkFZAsVsdAcZ7eWWik0kRS-bISlAWHE46YG1U9lGKXwtnDLl8AdSZsLsªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\ÚŽeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4MTI1LCJpYXQiOjE3NjUxNDc4MjUsImF1dGhfdGltZSI6MTc2NTE0NzgxNywiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiI5MzU1ZWRhZGY1Y2JjOWJkY2NlMTc0NjAzMjZkODQxNzMzZWVmNjQ0NzkxNjRhY2Y5MmJhZTJkNGQxM2ZkNzM5IiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdfQ.uEPoaTb_eBai_LAkH_jaCkgSwEmhkUv-eTHYJHFnOr-Ouaf3DmsvERicIkPXD3-PCUGqj6Zfdi1HWHz3EDZmBUzMkwRBW1n0C-ZAiu1_w4iYqo6VZI7bUU1Ssa1VKy97-9CW7e658WcrlgfIdDGLakOS462GO00n48as-0Se65_ib3NjHxPr_cdyvl4hGiADAzwl4dmncgvtRPFjACrg0fYkLuDYZZnCSuw29PGOWcuUy_puza5W9fYmu5X6mRLIXGWoN_wU3Te9AemMFGUSNEzEGkyAxuoIfP-wYU17vD-Lh5M5x0O61zqHjkMlVQafw_XwVXwHz-DpLY7bybcrxQily8PqU-ue9i2gmGzmRfYLoHJTxVramiX2N9EZ-FS0blczNNSDIHVhFHSyOgO6byziVxdoiFHnkudNd2SLpg7Pp7T9D8Vga9XMJyX--VmPNXGwZB2A3nyNuu_5KAo2BJIuNF88FITdAHvH1V7SROsbk4OAmJy4EggVDHqw-zUvgReSKSriTOnSi4wInjyjrjjWyhZpkUUzPKPW_e3ltivEhTFZRoHSZNjKahtZAcpTrEPUQSfyxYEiINhPdA5_lCqksW5OTK4uzdK0AlvzDHDBJUarrqNReRCo9Ty8TSOfd3rHAEjL0dRIg70BFfIcWeA1JUkD9tJ_ob0RWho-44kªexpires_at\Îi6Þ¤userˆ£sub¨dbviewer¥email³dbviewer@kaisyl.net®email_verifiedÃ¤name¨dbviewerªgiven_name¨dbviewer²preferred_username¨dbviewer¨nickname¨dbviewer¦groups‘«MSDB Guests¥admin\Â','2025-12-07 23:20:33'),(40,'session:a-ab8Yu_gePOugUsMKA904F7uCCviZeONydwcrPpOg4',_binary '‚ª_permanentÃªlogged_out\Ã','2025-12-07 23:22:52'),(41,'session:RDBB3bnK67781lJsGxGR3SBsSobjrcFBpcZTFSPPwAk',_binary '†ª_permanentÃªlogged_outÃ«oauth_state¾v9zW00ZkGkoAGb3OJ9bEkFk2iv88yn«oauth_token†¬access_token\ÚeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4NDM5LCJpYXQiOjE3NjUxNDgxMzksImF1dGhfdGltZSI6MTc2NTE0Nzk4NiwiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiIzNjY3NjcwYzBhNjNmZDJkY2M4NzQ2MzY0ZDAxMWU2MGRjZGNiMWQyZjcyOWEwYjA4YTc2OWQyNThkY2UwY2EyIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdLCJhenAiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwidWlkIjoic3NZNWk3VVdTQUI5NktuQzZkMmN0U01MbmY2VEZJTXA1dHdQTVkzSiJ9.BgKBMTNlYhhJpQyu58vmNbUVGj3Zq5jwZgMIRtg-lWOd6xM81w25SwPUX_ryLjWAIJ76itacvLsAtkDWOQ2ROEUkgPFgahtyj6qDzS8KXnegU4ak5lE0AVO5HSV1x0maIpb6rBQSpC3ErFwUQkqBwnIwmSOJdiarKvyq2Xku4pLIRGC421OvDq10T2877GEGW5XG-djaeIgmy0PN-o-SYxXa5jTxn_glD9LAj9-jr3mMMpHJDADZijwmwK-thUVwFnJkLDkxjdJtoZinpS3XAp0eQ4h0L6mEzvm4vEXiOyRgwH2vi7I2CfxmFc5BySrZxZ_i1rvjI8qKpn1J62wij9XJQTDuLGRKgYfb5sUxxEy3VA0VQXPSYIoY_duLK0CqQ5CEupHa2xE3Cd6j9j2LvcnmL44SP3pC2TaagDfkWaxxsJ-nUUNrnuxRxK6sb8p-dKLmkabXfIoxm2VZBfihPVTqw7Zvd3dG2zjP5X_28YIPXJTcrJKw2bR_m8b8UldOU80H7VgKKxGExBXnBNoahXIUpf4qg26KN_TYpaN7icxPxlE5TqYRLC3aEteOj7is1BoigMMXws2JdMDOo8jOI5PN9qMpJ6BNyEiJNllLW1roPArKNzx4GhaiJzMfJa-JxbAAwhvsZE74ysQqQ2Z3M1Tlv6fX2fIrgjxFtlRbORQªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\ÚŽeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4NDM5LCJpYXQiOjE3NjUxNDgxMzksImF1dGhfdGltZSI6MTc2NTE0Nzk4NiwiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiIzNjY3NjcwYzBhNjNmZDJkY2M4NzQ2MzY0ZDAxMWU2MGRjZGNiMWQyZjcyOWEwYjA4YTc2OWQyNThkY2UwY2EyIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdfQ.X9H4M35mdT7YABuLZxM5vX1lgfmBxum4cKbY6YReFWxBpkQ4EjLkxee7cV6JQqpRgXMr8zKcjuOT2435HaMaqnSbtssTE1wlHf2KdK1mjyYVtryuVYl2sSJ97Ouphd2cJfW2kc1JrzgO5pW52OIWwNq_Zu3tRji2CWFXylEWdRWN2bNGwa9fasLgB1bdcdbo7vOs_BC3lRgUzJp1OllFlAnEWqfKQcpvr7LPzkECqMw_dBNGffVJvA50eHWNqo5wsOVcQHt5QNB8R78W1Vt_EG12Ia9cWmYe_pQmiBuTarxH_8aUNp4PXW6kj2Beof9GUFz7Pn6ICRSnj6vUT2hVnH_O_KLZdtyHfG0IICN6LWtgkRvYOkuNHySHLvQpX-MEj1hkceBuq4SQs5oNeCoCOz0G910EOWqIXQklvzNvHWqVdkCoRTQEJiaMXNVyFIT_eUwJvGuKGoAPj5z8yTn1YkzL99cWpY49MwoeHKh6DcIM6FXrCwJUUD-tviH4q_U9i20mhcVflta20wC2HhmGFkclEYwJEe-koeO_2XZx21Tc6KQCsGI03QojZBHsJXAjF3mu3TQOQt0kHDhh6C0vzNj1JdJcsW2Jsvjy3v10aoMU-DfRm3QP71rXuyBxqdACLRxX5Drvt7FLA3b9Tly8EflKlQNjlJNb2xmssgrkojgªexpires_at\Îi6¤userˆ£sub¨dbviewer¥email³dbviewer@kaisyl.net®email_verifiedÃ¤name¨dbviewerªgiven_name¨dbviewer²preferred_username¨dbviewer¨nickname¨dbviewer¦groups‘«MSDB Guests¥admin\Â','2025-12-07 23:26:31'),(42,'session:rjvDQ8yF5R4AL4szIcks1NhKJJtn6VM-lAK4llC0OLI',_binary '‚ª_permanentÃ«oauth_state¾TOOXyciFHsBggIF5mUx8mf2Tbo27gc','2025-12-07 23:26:31'),(43,'session:Hw8Fbd377QU4dlOsCuV3fCZwea3ddoIjzl7m9ot1YN8',_binary '‚ª_permanentÃªlogged_out\Ã','2025-12-07 23:29:56'),(44,'session:s2K4vKEdKeOMSADwoj1282WPae_9PKCfVM-9Q8L5dxc',_binary '‚ª_permanentÃ«oauth_state¾KvBZIhy8eemOTks3vSCtFDJ3l8ojTT','2025-12-07 23:31:31'),(45,'session:HlixpoQMbm-rEDq_9YtNhiYUklHk1V-GBFrEFBmIq6E',_binary '…ª_permanentÃ«oauth_state¾TB2TzSNryZfrEGhxNp3QJmXgRukXgh«oauth_token†¬access_token\ÚeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4OTA2LCJpYXQiOjE3NjUxNDg2MDYsImF1dGhfdGltZSI6MTc2NTE0ODU5NCwiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiIxYTdiNDg3ZWZhNGNhODQ0NzBmOGM0MmUzMDZmY2MzYWJiYTgyYjlhYjNhYWRjMThlNDdiNmQwNWFhNDE2YzgxIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdLCJhenAiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwidWlkIjoiZ0VFRG9OeFZZRnJkdjB1RlRrSVhtaFQ5aFViRk5hZFNoWFc3TlN0cSJ9.wn434u_Q6-zke4FJqWQbmjhWrOARsFRoHk6-7L1pJydMz-s9EluVCGTntTCLGdx3ZTnyvTH5ped2jIu5iLKf5N3mu6nZYRG5uX8yQlzB7XLckCsp6s8oFOYnafRrKVLFSAmcjc8RhZdVWcPgJGUzh_elZJQoJSmHouO15T_22G5ZeksTyJRzdbn1uaiUlFIyU2qahqtNngHKVk8pwMHtiBDWmPFKHbWfgZYmqFxmqYEYtLV8L03HObUzXOPd4xhzd8IdCjAq_mZfqZY_WuzUfbRYawIq_d_ackyDT3UT8wvbjy1Wp9jajFYUhUu_S6Agi2DUcqW-cdqjdB0gUBJMgWsg-Ji2CQ5Yz5AEf7Dkk50gO-A74UfBx-2cR2i9r2wOTMJXysUhsZUdzL8tflV6BQC2ob_R0ztlKwgqltmcEs_2CTp2NkeY-9XzEQevcCTIV9D722XzAWzPi2Jzd7zFraE0Wx3z3Y_8XsP9gZQbjg5-P7z49e0OnISQKiO-jdkRFDA-yd4y37cvQ3GIcTUi68WjC7_a6oUqohCd7EbqIEZ8Sgx-ywUH_Y0gvvUqBzu5ER5yQNZ4kVw2-4uvWAUQVJN7JIOF1nHyVG_tQ9Q9nCibGTv9k_xioYq7PwCElOL6MnMOsT7qiSkvkt6YsYpwevhLBUZ8F4DVJDlyHKhJodYªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\ÚŽeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoiZGJ2aWV3ZXIiLCJhdWQiOiJYTkVnck1VcnJ5c1RlN2ZRd0dLa3BEZkUwOGc5WjkyT1dHRUkybWRuIiwiZXhwIjoxNzY1MTQ4OTA2LCJpYXQiOjE3NjUxNDg2MDYsImF1dGhfdGltZSI6MTc2NTE0ODU5NCwiYWNyIjoiZ29hdXRoZW50aWsuaW8vcHJvdmlkZXJzL29hdXRoMi9kZWZhdWx0IiwiYW1yIjpbInB3ZCJdLCJzaWQiOiIxYTdiNDg3ZWZhNGNhODQ0NzBmOGM0MmUzMDZmY2MzYWJiYTgyYjlhYjNhYWRjMThlNDdiNmQwNWFhNDE2YzgxIiwiZW1haWwiOiJkYnZpZXdlckBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkYnZpZXdlciIsImdpdmVuX25hbWUiOiJkYnZpZXdlciIsInByZWZlcnJlZF91c2VybmFtZSI6ImRidmlld2VyIiwibmlja25hbWUiOiJkYnZpZXdlciIsImdyb3VwcyI6WyJNU0RCIEd1ZXN0cyJdfQ.u9ywCxCN8C3EJIJqBSkcGRltRHAtVS9210J-FC2dJHCHqNE0UdXspalO83O0vEikYdYgSd0ZY4r0-oVMC4_wnNxvMCwdOC7848zp0mwhGM16d5Vo7-ONhatt5-tfJQbNP3dcVfOc73vNaxzoNbG5NTYcA9XMTKGSF5ESQNSCkrcnXs59NaDLUUVM77LrY3zcPRnao7ESdnHsJ3RiubfJ8CRxazExyLsAKSP6HWmmixK4aNx9g0V7RL0wJijeXEIUCu7YbnRavJ7ZlIVQHrIXb3eRHHFK75pgpxlGEtryH3VhKdxBh7ls1jIfpLK5KTfy8eLhz2w02uCDVEtFu_iP7SDP_j4VX9m0470aRmldnQQ11mrRhM30L4WfyQFj9Le5Ef6DeYqTfEXIUCYxSk7odKkPGHPLoeYFMsuhTRYtjK6UwEXSqGl6BLfsrNawUPHS0GS8n2Eyrs_kbFH3nnO7o8dYpc8eAMCKcXWqEQmTF8jaEtSLC9X2bR75guOl9z_8ST3fotiNgjT6zHA9oErUfZt2fU_Xg0nxz1Jh_MQ9lxJNFMWHIGr4db4Q78jT6sumphacB7bEOd6jPGaSe2Ad_qqmTeZQHgS8LRRhskjHAYlKH-UTuT6mEgQZUAZ4tnSo-pF5o0zsku7TfCTX_iABqLN9f9QhadePrnAYGevFEaUªexpires_at\Îi6\ë¤userˆ£sub¨dbviewer¥email³dbviewer@kaisyl.net®email_verifiedÃ¤name¨dbviewerªgiven_name¨dbviewer²preferred_username¨dbviewer¨nickname¨dbviewer¦groups‘«MSDB Guests¥admin\Â','2025-12-07 23:33:57'),(46,'session:p3_QwbvtwlDYj0FxWUHt8qpgISZb_eMGIhctmVCCJbw',_binary '‚ª_permanentÃ«oauth_state¾kVHmjTM3QZsvczCxh5Q9t0soRilZBr','2025-12-07 23:36:31'),(47,'session:zVgE0c-cDJbHudt8EQ_00j7XaUfXGQXibsgpYxbAn5E',_binary '‚ª_permanentÃ«oauth_state¾CySAiagamITAXYYBThjyfiSyZPuVyq','2025-12-07 23:41:31'),(48,'session:LmYYGGUKOB0t6N3383Ck09_ZU9SX4wwoFFMrRmPxf84',_binary '‚ª_permanentÃ«oauth_state¾a4pY9mfEamtKrrawc92CDAysx6fzsO','2025-12-07 23:46:31'),(49,'session:Fj3oN9ZARcDJwn82mKvcFCESrpGLzFQsEjkmM_zFXGI',_binary '‚ª_permanentÃ«oauth_state¾74jtA0T83MN2kC6kyqVMjBzePYkTRs','2025-12-07 23:51:31'),(50,'session:zryVSwAubNc3cLXtzO6N8EPUSuBJWkJVw1VZU8atv6Q',_binary '‚ª_permanentÃ«oauth_state¾jdI8CATXqg9btlMzAwlGQerKICD7sR','2025-12-07 23:56:31'),(51,'session:FltiViLZE96iVr8KdBqe5LLrAZNAYil4yXdfVpi8xNw',_binary '†ª_permanentÃªlogged_outÃ«oauth_state¾Q8YC51dvyjJSe6Xjam9YRIcvnh8Zmd«oauth_token†¬access_token\ÚCeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoia2FpIiwiYXVkIjoiWE5FZ3JNVXJyeXNUZTdmUXdHS2twRGZFMDhnOVo5Mk9XR0VJMm1kbiIsImV4cCI6MTc2NTIxMDE3NCwiaWF0IjoxNzY1MjA5ODc0LCJhdXRoX3RpbWUiOjE3NjUyMDcwMzksImFjciI6ImdvYXV0aGVudGlrLmlvL3Byb3ZpZGVycy9vYXV0aDIvZGVmYXVsdCIsImFtciI6WyJ1c2VyIiwibWZhIl0sInNpZCI6Ijg3ODE0ZWI3ZjQ3ZDhjOTczMTFlYWVkMDcyNWFmYWQ3YWZmZGQyNTlhZjE3ODI4YmMzNGNkOThhNGI3ZDI1YjkiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl0sImF6cCI6IlhORWdyTVVycnlzVGU3ZlF3R0trcERmRTA4ZzlaOTJPV0dFSTJtZG4iLCJ1aWQiOiJ2YzRlRk1sRktxRDN3dmFrSVBlWm5vZUFMSllmYkwwOGM3OG5sWldsIn0.g1tcAgTheVAYEkj3NWPZG8uDZU9JpLmFU302x55A96TnsG_7RoO11mLzitlnmrjYw2sx-b_C_6cKIxCFlKcUoZ8-XwMBcowOdg5l06IbgqYWtmXI5e62pL4s0b0CaUgcW2I5qwo_S0e_p_hLtS0LbXKsojGkLx_kzR4rztSrXojLzTCPoU7zfRxWYG-qKLjEUDYhRDk6eX_OhpEh6iq3ThtMgNJgl3xOkVg_KuD37EiLjnyQaR5NDZ2o0qy4bPZN8lUk6sWqDZanqhrryjV7C2YhMlmkEKt7YJziBK5A-_8fMUzhmd-JAENUA2jeVM2OC7KGUNEQJq12F788zaPZ2072wsq4c3WSenxg3wFPNnmlSPSiyM_kYVhjRRGc8uLcnPiEsQimPc-iIoJZNnvMIveA8fWlsuGbneqf-zoFTYk5biRAQUiAnKTdRznrnoiE-cPVbyGJ3Ss5i81ftzVK20FOHpbetRgV5cuDtr1xb7k3OH0uP50E36Ev7jy8Q1n3DS25mIs6DDqGPojEpL9Hcudkw8QG3rdF7QLe4n8ENU7sIjvb4_Kgg3vQqKVcM_1a1mmsGU4CPIMGAtVix_DX2riM0WLDLjiMTvRzGmh2rdpqNdvMdWEIiR2Dc5R3qLy7VcMBF35MIdIogRgU9vK1d1SlkHPVDj-u8GVkKvI8Bccªtoken_type¦Bearer¥scope“§profile¥email¦openidªexpires_in\Í,¨id_token\ÚÀeyJhbGciOiJSUzI1NiIsImtpZCI6IjhjYWIwYWU0ZTk2MTg5NGQ0Y2IwN2U0NjExZmY2YzVjIiwidHlwIjoiSldUIn0.eyJpc3MiOiJodHRwczovL2F1dGgua2Fpc3lsLm5ldC9hcHBsaWNhdGlvbi9vL21zZGIvIiwic3ViIjoia2FpIiwiYXVkIjoiWE5FZ3JNVXJyeXNUZTdmUXdHS2twRGZFMDhnOVo5Mk9XR0VJMm1kbiIsImV4cCI6MTc2NTIxMDE3NCwiaWF0IjoxNzY1MjA5ODc0LCJhdXRoX3RpbWUiOjE3NjUyMDcwMzksImFjciI6ImdvYXV0aGVudGlrLmlvL3Byb3ZpZGVycy9vYXV0aDIvZGVmYXVsdCIsImFtciI6WyJ1c2VyIiwibWZhIl0sInNpZCI6Ijg3ODE0ZWI3ZjQ3ZDhjOTczMTFlYWVkMDcyNWFmYWQ3YWZmZGQyNTlhZjE3ODI4YmMzNGNkOThhNGI3ZDI1YjkiLCJlbWFpbCI6ImthaUBrYWlzeWwubmV0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJrYWkiLCJnaXZlbl9uYW1lIjoia2FpIiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FpIiwibmlja25hbWUiOiJrYWkiLCJncm91cHMiOlsiYXV0aGVudGlrIEFkbWlucyIsImJhc2ljIGFjY2VzcyIsImthaSIsImZhbWlseSIsImNmLWFjY2VzcyIsIk1TREIgQWRtaW5zIl19.CgzpSN9LHoGCM3257YO3tRUXyRxuBz4JR-HGwJgl_q2mntp75j62fKuuaa-hvlayXSkQ_VUDr9v4oSK6WdAZUPfQmFf771NH2sPSLe0eG3IuqJlhwf6CF2BTOvRjhdJEnKRtEYR0FfUKEc5SeqlMG-B9jk0BQ28DuZOXB5lqn-YffTMOcs6TTLLL979XpFgyTbTxALA2dQ7aNP3mEpJtpy2qDG7qbVryhsiBVgo-mbhyv1s-EYb1og8OTPlHtZ2EoBkQ59Z5ufdJQfe-rwcsS_SdffOEN2tlr-eZP3IwnOnnYedfX3am32a7tBaPvbuGSbdo1FrKkOZDP3Cv5BmJRbrCsl2NTPthhuSvjYS5QhYdd9HBH32mJ6hTKVbvG7CgYi8j7pN-SpPXB1M3WgrRqR2vz1J6uKK-VdYl_2U0CE3Q40nMA4vq_F3hDmNeff-z67frunMiQT88nEwRnbCiShgxGyYuvjARB-_pLNOd9DX-43b8K7mVKo-6CXksNbmVsDv0gCP1tMSYyo6ilcRkpZ8DAnAFLbKfp9kTS82AhW77kLxdUOOA7W_TzC_cyaZETMV0mDGUFKAGqaer056v72iHsUA5x-o_exUqgGPi_t9GekY2Sn93wG3NWiuIqskKylbAQUzUxt3NwzVCSgImXa_CVNHRZ_lXXT1Rh191STwªexpires_at\Îi6ø?¤userˆ£sub£kai¥email®kai@kaisyl.net®email_verifiedÃ¤name£kaiªgiven_name£kai²preferred_username£kai¨nickname£kai¦groups–°authentik Admins¬basic access£kai¦family©cf-access«MSDB Admins¥admin\Ã','2025-12-08 16:46:17'),(52,'session:frdK18qFebXFukcdr0Srz8klaHH8GRLgCAo5TXGCQzA',_binary '‚ª_permanentÃ«oauth_state¾LAFi58Cp32PN5JWgW9RpJuT6ZFajDR','2025-12-08 15:50:31'),(53,'session:XkFC68gnvOBiWFf8YJLtefOJEgRwp2YV-QoZPQlP8Vg',_binary '‚ª_permanentÃªlogged_out\Ã','2025-12-08 15:54:56'),(54,'session:HJNXvOY-frSmctjd7MFn6rSosMb5n6CUU3zN9rb56KU',_binary '‚ª_permanentÃ«oauth_state¾HLNGtGdUQCLdJEmfWRZE4nymID5JDI','2025-12-08 15:53:47'),(55,'session:qS7T1b4Tn5fp1SbiVWrDaEXM17hw47JBYS9mTt-_LPw',_binary '‚ª_permanentÃ«oauth_state¾2IYg7Qt8uR8K9nBfBR8p8kzs1fqko0','2025-12-08 16:38:14');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'dance','thicc','CM','GBMVH2300650',130,1),(2,'pop','Sugar','DbM','GBUM72503544',130,2),(3,'breakcore','eternal','GM','CALVP2475952',160,10),(4,'breakcore','10o3//dusk','N/A','CALVP2413177',170,11),(5,'dance','Black Out Days (Stay Away)','Gbm','USUM72509197',155,3),(6,'jazz','Emily','CM','JPI291065403',115,7),(7,'dance','Cyanica','Am','QT3F32561928',123,12),(12,'pop','Baby Blue','DbM','GBUM72503569',125,13),(16,'Dance','Fortune Lies','Am','CBF8B2555901',130,14),(22,'Electronica','Collisions','N/A','CBF8B2555900',150,34),(26,'breakcore','Florabella','Dm','CBF8B2543651',170,39);
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

-- Dump completed on 2025-12-11  1:09:33
