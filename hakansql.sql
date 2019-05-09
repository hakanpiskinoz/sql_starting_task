DROP TABLE hakansql
CREATE TABLE hakansql (
Country varchar,
Region varchar,
Grape varchar,
Size varchar,
Sweetness varchar,
Colour varchar,
"Food match" varchar
);

SET CLIENT_ENCODING = 'UTF8';

COPY hakansql(Country,Region,Grape,Size,Sweetness,Colour,"Food match") 
FROM '‪C:\test.csv' DELIMITER ';' CSV

SELECT * from hakansql          --open table

SELECT COUNT(*) FROM hakansql;  --number of rows (1)

SELECT DISTINCT country         --just distinct rows (2)
FROM hakansql;

SELECT country, COUNT(*)        --just duplicate countries (3)
FROM hakansql
GROUP BY country
HAVING COUNT(*) > 1

SELECT country, COUNT(country) AS MOST_FREQUENT  --all countries accourding to most duplication in a column (4)
FROM hakansql
GROUP BY country
ORDER BY COUNT(country) DESC

SELECT COUNT(*)AS DUPLICATES_COUNT, size, "Food match" --multiple duplicated rows (5)
FROM hakansql
GROUP BY size,"Food match"
HAVING COUNT(*) > 1

SELECT * FROM hakansql   --data which start with "Pe" on the Grape column
WHERE Grape LIKE 'Pe%' 

SELECT Country, 	--output of size_new and country (7)
CAST(CASE Size WHEN '75CL' THEN '0.75' WHEN '1L' THEN '1' 
END AS DOUBLE PRECISION) AS Size_new 
FROM hakansql

SELECT Sum(Size_new)     --total litre (8)
FROM (SELECT Country ,CAST(CASE Size WHEN '75CL' THEN '0.75' WHEN '1L' THEN '1' 
END AS DOUBLE PRECISION) AS Size_new 
FROM hakansql)f

SELECT Country, Sum(Size_new) AS sumsizes    --total litre of the each country with order (9)
FROM (SELECT Country, CAST(CASE Size WHEN '75CL' THEN '0.75' WHEN '1L' THEN '1' 
END AS DOUBLE PRECISION) AS Size_new 
FROM hakansql)f 
GROUP BY Country ORDER BY sumsizes DESC;

TRUNCATE TABLE hakansql    --close table

