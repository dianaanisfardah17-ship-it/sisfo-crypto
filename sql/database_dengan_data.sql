-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: sisfo_crypto
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `auth_config`
--

DROP TABLE IF EXISTS `auth_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pass_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_config`
--

LOCK TABLES `auth_config` WRITE;
/*!40000 ALTER TABLE `auth_config` DISABLE KEYS */;
INSERT INTO `auth_config` VALUES (1,'$2y$12$Ir1JhWxBlW3bdzTZm.EQPuVKth3A1CXzeQ50G9Sg4fWLvkxbh/z..','-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2gedmVKzq7j9KOrZJhWv\ncQ2zpqI37lUggaBQXTmE6BhubPe4+TvRl67cO9rl8Dt0K9dN/9BXuFUsdTyviecm\n5Jpk7fj24QPLl7Op/1HBSH5Nq9f5fbu8z0BvHLN/95aLR8q1Ek2/kwxm2766uKj2\n5dCdb16O8B3gB3UEfrxM5qGURE3BBpbLXQOrCThfOu0XQs/irBt9zccAnPpEB/68\nSjJV1asn6OuAxZ3V4A5wXutQVvD6mP9R0JbHfMb06Vc2L/1VE92Gjs/juh7nJgdV\n7rJXuhTayfZq8Ulqsnjy3xPlwkZ2jdCHSxLcZ8BpYogdZR6BbW7O9N39vtMAxKST\nNQIDAQAB\n-----END PUBLIC KEY-----\n','2026-11-15 12:42:28');
/*!40000 ALTER TABLE `auth_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `judul_enc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `isi_enc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `wrapped_key` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records`
--

LOCK TABLES `records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
INSERT INTO `records` VALUES (2,'l825MtGbG3ILZeS+YnwlaB1xR8qvXTIDVKvbS8S7oD4qdViIndlYwX51+0qdBNko9yB5PKKwgzO/z0LyKpKrqvc=','hQwL8A5UrsrRzE79G32oVAH/0OxefVEeILSluGfM+vrpIzl5Vz+Zng2jqkWdx9EzrdksX0PxlyULoupdFeS6+/IzPRs=','MGPB6RdShNjq9Eq3m5gmBhw4oTPf+wnY+geAThd/AD7afWh+VybI23eBMZYrE/1N+gE0xARXKFORoBBzRsGQ6l0n7ALwuX5S6rixR7VRbXAv4EMk/TTB64IHED6FEdb1ON8b3ZteXPU6rgODfo8yawtjYJJo/wprcjtbL93TIjmKeJpBP+fhoLULMsrihooWl1rQHg3sl4eNFSuSUlKQ9EddQF+6RvVowiB1veq5SU+1rG8PEG73TkY6aXOsqx9XdFM7detLycfr/w04D79OlqvQsMG04lr7O5JnnEgxpMjLOIqsFAWa/9oAWiU7pJzrI6R2QsjbibD3sqqmdNhfPg==','2026-11-15 12:53:35'),(3,'p7jKhkz8nIBLqCJPDqnsCIGy1jmlz+dntUYL4pk5FvaQjIzsMMtAZHWeaHLKm34=','q3n1muGGAfEWwzKJuIdMEbcH+ZXdGHVmKKq4m3vpuftuhg2KnALmLWCcFP5taaYJPEWQhOKw5aM/CEsaf8zik4PAUsnMoF3QNw3pl8BBYdtUF4c0nfS0qe1R33FoJ93mBsVhAw==','sc1/5+hQbBNNzd6D4PjTakaoCP+LFbkNGzKAvcd/fVfVeDrNnH/yFSxAyxOr6Y/jW47BmYVNJrSWSHDob+YLYRndAXsUzo8ZvhSkMayKwzdaaaULIXgudn/xmAEn4qUkWZA5rOFAfv0v40xlNgKwfaYzs6+QCPM5IGtC9UNZQUH3wOjQruNqqa01Irk3jmRBcodwAtZkfwyIr1/EYSqZHVXTCbi7fUgqO72vrZaMXyHrgUDvwRINqMqf4fatmKi8vluf/vHI4X/x76hgpkqBwUKTaSIxr+Dfj04NhlvA3sBLGXALkqm7wpxXHNILKDAB43pTsljR8q/2XDTQHArTNw==','2026-11-15 12:53:35'),(4,'AvCYIWWMTqJDz5RWPzPAdyYg8syBLyAg/s4UIVszQF5utuKINzN4pzr79SNUAZ7kzXY=','dw/Qa0pGFdoSsy+eVoKkbJCxkrQ7q1rOKaaLTxmQICZBDhcLpfVqDMjPpfzh4VkKfSrlcgCayHFcnrMb49E+LMT7FYPEQHMwnkPJo5ECRRoDa1d5lQtkEPSwjIoqevnhWGqmo4OQxnlblA==','DLc+SCR7IRXbjuDiRUOj7BB+31MHQ/cNalxbK1Cozw9VvfVYoQ95DFsGhkz5AEyKCSQEFJj7tyMoZ3cv9+OaTrr5Jfi3kQ2z+IRhEtl9C7qgRtfIzOgqv8SRAWOV7ybqviVXq2oVfHRxdLw/XtWJJIWvrsLdWt8nhO7LNxavGqdmtKTJELK8mSnTeZYG1pNckQpU6xv91tfdlxKkpGRNkettyarZctUHgQTI1oEpXKjsLM5N0K4dQhNOK6YUBcKEYqqlK4xe703LkOl5MBeyxN39KqZQEf5MkhPQTzi9PC/WCXEzjAnjCCxuEbB1WQJKv2siSDfi/BiwmzlwsP37iw==','2026-11-15 12:53:35'),(5,'rY1HVkdyGmxkDIW7/mPKZWZckiqibMqixDmiRhvmUgoTxo02j6lDOr0YjFby94YnK5savA==','2fAjBgV7iBE36D8MUrxLKEGvWTFmQFXEzclEvl0MOCpX9IHSPQRDRJ3Tn6fA7oy6EjD+S5OI7HGuGjmdF5KwY4XPkEOp1QzXswA5KBosWvtWvfq/','Btwrl9yB7psQF+ghyo64jSvW8vxEuyrRLSYjsqRgKyRdmdayklFm1nvdbIqpRjJRzOc8rOn15UKNL4NcjL7/8pnr3rhbR9iuuvF+Yk8DByQgLkph1xmoo2aut9SHl6wv9ErCiEFE9prY8rUSVWAzt8vsSGC5uzcFds+9SbVqTKUeKND6e73muxJw991oSVbjNqjZ11G7Mb0pimQyXpQKifg7Gbd1Tgsee8LhwnnvvAjrnDxrMYOHgnTPkUh9HqJulCB33Wvc9xGur4qW78A3q4B8o/au9TtQGdLv9hct/PeyLiqRORhowsflhKFeWzgaLcwrfBZcyvCxNM22xmNtug==','2026-11-15 12:53:35'),(6,'71Bs8F7XqVZjbA1CQKmd3nFSExzr3RhyJjUNiuOs4TRS2hiDBUceqOIfFrYqwXywQKsmunM=','spbWi1WktnMxzndbVZRJDuBGNiW6WF6x9+mEEiqnyOe/jlqHOsixHgY5RGVgEzL4kZw/oZ59A9YTU+90kC5fNo7AeXZ3/INiFjZbyPuhAFL3lgIOCflbhTDgR6wVd3X1','BViklhvEp1W31r5q54ptBBOAiX2KgzezFPdpE+ceI3rMRWqXy5jjjphQB9oiPZTDPk7OPCMIPx74yLbdSIXgfIQ4aqTT+A4ykMrT+u3dcKoPrIvnQGelqZSqxr6Tsl+M6ZgnwkLCnUrGv4FrDw52+zE3O9APfMZRrqrOe5gWyn/4SZSqDNYsGzQC0mhu2et5Ql5ucMxuDDkayLffoQDkCUClZw5wHm+HGrXbHmeL1fvcVvVevCYxjETWoZJt6vyOKGbmSkIkCWrAEWmoIPrOcATB1lkNmwcavrr4CdUcLT3S5iyuk8bw7CS7/lgvG4UMGIQCXK7PL0yfoK3mKg4KVQ==','2026-11-15 12:53:35');
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 20:29:20
