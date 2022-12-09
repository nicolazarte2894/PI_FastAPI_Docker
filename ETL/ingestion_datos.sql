/*Creacion del Database*/
DROP DATABASE IF EXISTS moviesDB;
CREATE DATABASE  IF NOT EXISTS `moviesDB`;
USE `moviesDB`;

/*Importacion de las tablas*/
/*AMAZON*/
DROP TABLE IF EXISTS `movies_amazon`;
CREATE TABLE IF NOT EXISTS `movies_amazon` (
  	`IdMovie` 			VARCHAR(5),
  	`Type` 				VARCHAR(50),
  	`Title` 			VARCHAR(150),
    `Director`			TEXT,
  	`Cast` 				TEXT,
    `Country`			VARCHAR(200),
    `Date_Added`		VARCHAR(50),
    `Release_Year`		INT,
    `Rating`			VARCHAR(50),
    `Duration`			VARCHAR(50),
    `Listed_In`			VARCHAR(150),
    `Description`		TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ;
/*Ingesta de datos*/
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\amazon_prime_titles.csv'
INTO TABLE `movies_amazon` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

/*DISNEY*/
DROP TABLE IF EXISTS `movies_disney`;
CREATE TABLE IF NOT EXISTS `movies_disney` (
  	`IdMovie` 			VARCHAR(5),
  	`Type` 				VARCHAR(50),
  	`Title` 			VARCHAR(150),
    `Director`			TEXT,
  	`Cast` 				TEXT,
    `Country`			VARCHAR(200),
    `Date_Added`		VARCHAR(50),
    `Release_Year`		INT,
    `Rating`			VARCHAR(50),
    `Duration`			VARCHAR(50),
    `Listed_In`			VARCHAR(150),
    `Description`		TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ;
/*Ingesta de datos*/
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\disney_plus_titles.csv'
INTO TABLE `movies_disney` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

/*HULU*/
DROP TABLE IF EXISTS `movies_hulu`;
CREATE TABLE IF NOT EXISTS `movies_hulu` (
  	`IdMovie` 			VARCHAR(5),
  	`Type` 				VARCHAR(50),
  	`Title` 			VARCHAR(150),
    `Director`			TEXT,
  	`Cast` 				TEXT,
    `Country`			VARCHAR(200),
    `Date_Added`		VARCHAR(50),
    `Release_Year`		INT,
    `Rating`			VARCHAR(50),
    `Duration`			VARCHAR(50),
    `Listed_In`			VARCHAR(150),
    `Description`		TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ;
/*Ingesta de datos*/
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\hulu_titles.csv'
INTO TABLE `movies_hulu` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

/*NETFLIX*/
DROP TABLE IF EXISTS `movies_netflix`;
CREATE TABLE IF NOT EXISTS `movies_netflix` (
  	`IdMovie` 			VARCHAR(5),
  	`Type` 				VARCHAR(50),
  	`Title` 			VARCHAR(150),
    `Director`			TEXT,
  	`Cast` 				TEXT,
    `Country`			VARCHAR(200),
    `Date_Added`		VARCHAR(50),
    `Release_Year`		INT,
    `Rating`			VARCHAR(50),
    `Duration`			VARCHAR(50),
    `Listed_In`			VARCHAR(150),
    `Description`		TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*Ingesta de datos*/
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\netflix_titles.csv'
INTO TABLE `movies_netflix` 
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY ''
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;