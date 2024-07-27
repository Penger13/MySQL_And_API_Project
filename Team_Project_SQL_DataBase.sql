/* Create and use database 'mydb' */
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

/* Creating the database */

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `RoleID` int NOT NULL AUTO_INCREMENT,
  `Role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Teacher'),(3,'Student');
UNLOCK TABLES;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `RoleID` int NOT NULL,
  PRIMARY KEY (`UserID`,`RoleID`),
  KEY `fk_Users_Roles1_idx` (`RoleID`),
  CONSTRAINT `fk_Users_Roles1` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'Clark Taylor',1),(2,'Natalie Armstrong',1),(3,'Max Barrett',2),(4,'Alisa Barnes',2),(5,'Catherine Nelson',2),(6,'Ted Casey',2),(7,'Dainton Henderson',2),(8,'Sarah Howard',2),(9,'Carina Higgins',2),(10,'Nicholas Ross',3),(11,'Adrianna Hall',3),(12,'Kelvin Murray',3),(13,'Kate Wilson',3),(14,'Marcus Johnson',3),(15,'Valeria Cooper',3),(16,'James Riley',3),(17,'Bruce Stewart',3),(18,'Alexia Barrett',3),(19,'Adam Perkins',3),(20,'Sam Foster',3),(21,'Charlotte Howard',3),(22,'Violet West',3),(23,'Brianna Brooks',3),(24,'Rubie Roberts',3),(25,'Jessica Perkins',3),(26,'Anna Roberts',3),(27,'Sabrina Crawford',3),(28,'Luke Murphy',3),(29,'Miley Cunningham',3),(30,'Julia Scott',3);
UNLOCK TABLES;


DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `CourseID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(45) DEFAULT NULL,
  `TeacherID` int DEFAULT '0',
  `isAvailable` tinyint DEFAULT '0',
  PRIMARY KEY (`CourseID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
INSERT INTO `courses` VALUES (1,'Data structures',6,0),(2,'Databases',5,0),(3,'Machine learning',0,0),(4,'Network security',0,0),(5,'Computer graphics',0,0),(6,'Computer programming I',0,0),(7,'Game development',0,0),(8,'Computer algorithms',0,0),(9,'Computer programming II',0,0),(10,'Project management',0,0);
UNLOCK TABLES;

DROP TABLE IF EXISTS `enrolments`;
CREATE TABLE `enrolments` (
  `EnrolmentID` int NOT NULL AUTO_INCREMENT,
  `Mark` tinyint DEFAULT NULL,
  `CourseID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`EnrolmentID`,`CourseID`,`UserID`),
  KEY `fk_Enrolments_Courses_idx` (`CourseID`),
  KEY `fk_Enrolments_Users1_idx` (`UserID`),
  CONSTRAINT `fk_Enrolments_Courses` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`),
  CONSTRAINT `fk_Enrolments_Users1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `enrolments`
--

LOCK TABLES `enrolments` WRITE;
INSERT INTO `enrolments` VALUES (12,1,1,16);
UNLOCK TABLES;

