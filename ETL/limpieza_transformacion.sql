#PASOS
/* 
1) Creación e ingesta de una tabla movies que une las tablas de las 4 plataformas
*/
#Creación tabla movies
  DROP TABLE IF EXISTS `movies`;
  CREATE TABLE IF NOT EXISTS `movies` (
      `IdMovie` 			INT NOT NULL AUTO_INCREMENT,
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
      `Description`		TEXT,
      `Plataforma`		VARCHAR(10),
      
      PRIMARY KEY (`IdMovie`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#Injesta de Peliculas de todas las plataformas en la tabla movies
INSERT INTO movies (Type, Title, Director, Cast, Country, Date_Added, Release_Year, Rating, Duration, Listed_In, Description, Plataforma)
SELECT Type, Title, Director, Cast, Country, Date_Added, Release_Year, Rating, Duration, Listed_In, Description, 'Amazon' FROM movies_amazon
UNION
SELECT Type, Title, Director, Cast, Country, Date_Added, Release_Year, Rating, Duration, Listed_In, Description, 'Disney' FROM movies_disney
UNION
SELECT Type, Title, Director, Cast, Country, Date_Added, Release_Year, Rating, Duration, Listed_In, Description, 'Hulu' FROM movies_hulu
UNION
SELECT Type, Title, Director, Cast, Country, Date_Added, Release_Year, Rating, Duration, Listed_In, Description, 'Netflix' FROM movies_netflix;

/*
2) Se realiza una limpieza de los datos de Duration:
 -Buscando los datos de duracion en la columna rating y copiandolos en la columna auxiliar de duracion para no perder los datos iniciales
 -Aplicando REPLACE y TRIM para reemplazar los strins de Season, Seasons y min. Solo se dejan los numeros
 -Se transforma la columna Duration a tipo de dato entero
*/
#Se agrega una columna de duración auxiliar llamada Duration_copy para no perder los datos y hacer las transformaciones
ALTER TABLE movies
ADD COLUMN Duration_copy VARCHAR(50) AFTER Duration;
#Se buscan los datos de duración en rating y se lo agrega en Duration_copy
UPDATE movies SET Duration_copy = Duration;
UPDATE movies SET Duration = Rating WHERE Rating LIKE '%min%' OR Rating LIKE '%Season%';
#Reemplazar min, Season y Seasons por NULL
UPDATE movies SET Duration = REPLACE(Duration,'Season','');
UPDATE movies SET Duration = REPLACE(Duration,'s','');
UPDATE movies SET Duration = TRIM(REPLACE(Duration,'min',''));
UPDATE movies SET Duration = REPLACE(Duration,'',NULL) WHERE Duration = '';
#Se cambia a INT los datos de duracion y dropeo la columna Duration_copy
ALTER TABLE movies
CHANGE COLUMN Duration Duration INT DEFAULT NULL,
DROP COLUMN Duration_copy;

/*
3) Pruebas de consultas de para la API
*/
#CONSULTA 1:  Máxima duracion
SELECT Title
FROM movies
WHERE Plataforma = 'Hulu' AND Release_Year = 2018
ORDER BY Duration DESC
LIMIT 1;

#CONSULTA 2: Cantidad de peliculas o tv shows
SELECT COUNT(*)
FROM(SELECT *
FROM movies
WHERE Type = 'Movie' AND Plataforma = 'Netflix') AS subquery;

#CONSULTA 3:  Cantidad de repeticion de un género en una plataforma
SELECT COUNT(*)
FROM(SELECT *
FROM movies
where Listed_In LIKE '%ComEdy%'and Plataforma = 'Amazon') AS subquery;

