-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: var4
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `активные сообщения`
--

DROP TABLE IF EXISTS `активные сообщения`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `активные сообщения` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Вид` varchar(45) NOT NULL,
  `Время` time NOT NULL,
  `Канал` int unsigned NOT NULL,
  `Номер` int unsigned NOT NULL,
  `Текст` varchar(200) NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `активные сообщения`
--

LOCK TABLES `активные сообщения` WRITE;
/*!40000 ALTER TABLE `активные сообщения` DISABLE KEYS */;
INSERT INTO `активные сообщения` VALUES (1,'Set','15:00:00',0,1762,'OS ядра – семейства Windows, но не XP. Возможны проблемы при взаимодействии со сторонними устройствами.'),(2,'Set','15:01:00',0,1754,'Файловая система станка в норме.'),(3,'Set','15:02:00',0,1822,'Постоянные циклы загружены успешно.'),(4,'Set','15:03:00',0,2300,'Виртуальный драйвер.'),(5,'Set','15:04:00',0,109,'DriveController инициализирован.'),(6,'Set','15:05:00',2,820,'Механизм смены инструмента. Инструмент T1 установлен в шпиндель S1 канала 2.'),(7,'Clear','15:06:00',1,820,'Механизм смены инструмента. Инструмент T1 установлен в шпиндель S2 канала 1.'),(8,'Set','15:07:00',1,2104,'Препроцессор: синтаксическая ошибка в управляющей программе.Переменная не существует.'),(9,'Clear','15:08:00',1,2104,'Препроцессор: синтаксическая ошибка в управляющей программе.Переменная не существует.'),(10,'Pulse','15:09:00',1,1746,'Ошибка пуска интерполятора в автоматическом режиме.'),(11,'Pulse','15:10:00',1,1917,'Заданная частота вращения шпинделя превышает максимальную.'),(12,'Pulse','15:11:00',1,1917,'Заданная частота вращения шпинделя превышает максимальную.'),(13,'Pulse','15:12:00',1,1889,'Останов при выполнении M-функции.');
/*!40000 ALTER TABLE `активные сообщения` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `виды работ за неделю`
--

DROP TABLE IF EXISTS `виды работ за неделю`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `виды работ за неделю` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Временная метка суток` datetime(6) NOT NULL,
  `Время на токарные операции` double NOT NULL,
  `Время на фрезерные операции` double NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Изменение температуры для главноего движения, т.е. фращение шпинсделя, это ось C''';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `виды работ за неделю`
--

LOCK TABLES `виды работ за неделю` WRITE;
/*!40000 ALTER TABLE `виды работ за неделю` DISABLE KEYS */;
INSERT INTO `виды работ за неделю` VALUES (1,'2023-11-13 00:00:00.000000',5,3),(2,'2023-11-14 00:00:00.000000',7,1),(3,'2023-11-15 00:00:00.000000',1,7),(4,'2023-11-16 00:00:00.000000',8,0),(5,'2023-11-17 00:00:00.000000',6,1),(6,'2023-11-18 00:00:00.000000',0,0),(7,'2023-11-19 00:00:00.000000',0,0);
/*!40000 ALTER TABLE `виды работ за неделю` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `двигатели`
--

DROP TABLE IF EXISTS `двигатели`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `двигатели` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Название` varchar(45) NOT NULL,
  `Тип` varchar(45) NOT NULL,
  `Для привода оси` varchar(45) NOT NULL,
  `Текущая температура` float NOT NULL DEFAULT '0' COMMENT 'Текущая температура, или сделать отдельную таблицу соврменем и температурами',
  `Время снятия температуры` varchar(45) NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `двигатели`
--

LOCK TABLES `двигатели` WRITE;
/*!40000 ALTER TABLE `двигатели` DISABLE KEYS */;
INSERT INTO `двигатели` VALUES (1,'\"Двигатель 1\"','Асинхронный серводвигатель','X\'',51.1,'14:00:00'),(2,'\"Двигатель 1\"','Асинхронный серводвигатель','Z\'',54.4,'14:00:00'),(3,'\"Двигатель 1\"','Асинхронный серводвигатель','C\'',49.9,'14:00:00'),(4,'\"Двигатель 2\"','Асинхронный серводвигатель','X',12.2,'14:00:00'),(5,'\"Двигатель 2\"','Асинхронный серводвигатель','Y',14.4,'14:00:00'),(6,'\"Двигатель 2\"','Асинхронный серводвигатель','Z',13.3,'14:00:00'),(7,'\"Двигатель 2\"','Асинхронный серводвигатель','C',11.1,'14:00:00');
/*!40000 ALTER TABLE `двигатели` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `оси`
--

DROP TABLE IF EXISTS `оси`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `оси` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Название` varchar(45) NOT NULL,
  `Описание` text NOT NULL,
  `Положение` varchar(45) NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `оси`
--

LOCK TABLES `оси` WRITE;
/*!40000 ALTER TABLE `оси` DISABLE KEYS */;
INSERT INTO `оси` VALUES (1,'X\'','Линейное перемещение по диаметру цилиндрической заготовки (чтобы ее увидеть, надо смотреть сверху на станок).перемещение резца','15'),(2,'Z\'','Линейное перемещение по высоте цилиндрической заготовки.перемещение резца','70'),(3,'C\'','Поворотное перемещение вокруг оси Z.Вращение шпинделя с заготовкой','90'),(4,'X','Линейное перемещение по диаметру цилиндрической заготовки (чтобы ее увидеть, надо смотреть сверху на станок).фреза','45'),(5,'Y','Линейное перемещение по диаметру цилиндрической заготовки (чтобы ее увидеть, надо смотреть сбоку на станок). Это та ось, которая специфична для нашего варианта.фреза','45'),(6,'Z','Линейное перемещение по высоте цилиндрической заготовки.фреза','45'),(7,'C','Поворотное перемещение вокруг оси Z.фреза','90');
/*!40000 ALTER TABLE `оси` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `приводы`
--

DROP TABLE IF EXISTS `приводы`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `приводы` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Название` varchar(45) NOT NULL,
  `Тип кинематической передачи` varchar(45) NOT NULL,
  `Состояние` varchar(45) NOT NULL,
  `Для оси` varchar(45) NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `приводы`
--

LOCK TABLES `приводы` WRITE;
/*!40000 ALTER TABLE `приводы` DISABLE KEYS */;
INSERT INTO `приводы` VALUES (1,'\"Механический привод 1\"','Клиноременная','Не готов','Ось X\''),(2,'\"Механический привод 1\"','Клиноременная','Не готов','Ось Z\''),(3,'\"Механический привод 1\"','Клиноременная','Не готов','Ось C\''),(4,'\"Механический привод 2\"','Шарико-винтовая','Готов','Ось X'),(5,'\"Механический привод 2\"','Шарико-винтовая','Готов','Ось Y'),(6,'\"Механический привод 2\"','Шарико-винтовая','Готов','Ось Z'),(7,'\"Механический привод 2\"','Шарико-винтовая','Готов','Ось C');
/*!40000 ALTER TABLE `приводы` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `станки`
--

DROP TABLE IF EXISTS `станки`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `станки` (
  `Идентификатор` int NOT NULL AUTO_INCREMENT,
  `Название` varchar(200) NOT NULL,
  `Тип` varchar(45) NOT NULL,
  PRIMARY KEY (`Идентификатор`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `станки`
--

LOCK TABLES `станки` WRITE;
/*!40000 ALTER TABLE `станки` DISABLE KEYS */;
INSERT INTO `станки` VALUES (1,'SPECTR TC','Токарные центры'),(2,'SKM NL 1500/2000','Токарные центры'),(3,'SPECTR TL','Токарные центры'),(4,'SPECTR TH-2500M/Y','Токарные центры'),(5,'SPECTR G5-Y','Токарно-фрезерные центр'),(6,'IRONMAC ITX-508MY','Токарно-фрезерный обрабатывающий центр '),(7,'IRONMAC ITX-65M/1250','Токарно-фрезерный обрабатывающий центр '),(8,'SKM NL 2500/3000','Токарные центры'),(9,'SPECTR TH-2500','Токарные центры'),(10,'SKM NL','Токарные центры с осью Y и противошпинделем'),(11,'SPECTR TL-2000SY','Токарные центры с противошпинделем'),(12,'SPECTR TH-2500SY','Токарные центры с противошпинделем'),(13,'SKM NL 4000/5000','Токарные центры'),(14,'SKM NL 6000','Токарные центры'),(15,'IRONMAC ITX-510SY','Токарно-фрезерный обрабатывающий центр');
/*!40000 ALTER TABLE `станки` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-10  4:03:38
