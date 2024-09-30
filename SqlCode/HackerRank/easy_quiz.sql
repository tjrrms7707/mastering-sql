/* Format 
Mysql 기준으로 작성

--문제이름
Query문

문제에 접속하고 싶다면
link:
https://www.hackerrank.com/challenges/Problem_name/problem

Problem_name에 --문제이름을 넣으면 된다.(--제외)

*/


--Revising-the-SELECT-Query
SELECT * FROM city 
WHERE population > 100000 
AND countrycode='USA'


--Revising-the-SELECT-Query-2
SELECT NAME FROM city
WHERE population > 120000
and countrycode = 'USA'

-- SELECT by id
SELECT * FROM city
WHERE ID = 1661

--japanese-cities-attributes
SELECT * FROM city
WHERE countrycode = 'JPN'

--japanese-cities-name
SELECT name FROM city
WHERE countrycode = 'JPN'

--weather-observation-station-1
SELECT city, STATE FROM STATION

--weather-observation-station-2
SELECT ROUND(SUM(lat_n),2) ,ROUND(SUM(long_w),2) 
FROM station

--weather-observation-station-3
SELECT DISTINCT city  FROM STATION 
WHERE MOD(ID,2) = 0

--weather-observation-station-4
SELECT count(*) - count(distinct city) as COUNT FROM STATION 

--weather-observation-station-5
(SELECT city , LENGTH(city) FROM STATION
ORDER BY LENGTH(city) DESC , city
LIMIT 1)
UNION
(SELECT city , LENGTH(city) FROM STATION
ORDER BY LENGTH(city)  , city
LIMIT 1)

--/weather-observation-station-6
/*
정규표현식을 사용하여 검색한다.
^A : A로 시작하는것
A$ : A로 끝나는 것 
*/
SELECT city FROM STATION
WHERE city REGEXP '^[aeiou]'

--weather-observation-station-7
SELECT DISTINCT city FROM STATION
WHERE city REGEXP '[aeiou]$'

--weather-observation-station-8
SELECT DISTINCT city 
FROM STATION
WHERE city REGEXP '^[aeiou]' 
AND city REGEXP '[aeiou]$' 

--weather-observation-station-9
SELECT DISTINCT city
FROM STATION
WHERE city REGEXP '^[^aeiou]'

--weather-observation-station-10
SELECT DISTINCT city
FROM STATION
WHERE city REGEXP '[^aeiou]$'

--weather-observation-station-11
SELECT DISTINCT city 
FROM STATION
WHERE city REGEXP '^[^aeiou]' 
OR city REGEXP '[^aeiou]$'

--weather-observation-station-12
SELECT DISTINCT city 
FROM STATION
WHERE city REGEXP '^[^aeiou]' 
AND city REGEXP '[^aeiou]$'

--weather-observation-station-13
SELECT TRUNCATE(SUM(lat_n),4)
FROM station
WHERE 38.7880 < lat_n
AND lat_n < 137.2345

--weather-observation-station-14
SELECT TRUNCATE(MAX(lat_n),4) 
FROM station
WHERE lat_n < 137.2345 

--weather-observation-station-15
SELECT ROUND(long_w,4) 
FROM station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
limit 1

--weather-observation-station-16
SELECT ROUND(MIN(lat_N),4)
FROM station
WHERE lat_n > 38.7780

--weather-observation-station-17
SELECT ROUND(long_w ,4)
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1

--weather-observation-station-18
--P(a,b)->최소 P(c,d)->최대
SELECT ROUND(ABS(Min(long_w)-MAX(long_w))+ABS(MIN(lat_n)-MAX(lat_N)),4)
FROM station

--weather-observation-station-19
SELECT TRUNCATE(SQRT(POW(MAX(lat_n)-MIN(lat_n),2)+POW(MAX(long_w)-MIN(long_w),2)),4)
FROM station

--more-than-75marks
SELECT Name , Marks 
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT (Name,3) , Id asc

--name-of-employees
SELECT NAME 
FROM Employee
ORDER BY NAME

--salary-of-employees
SELECT NAME 
FROM Employee
WHERE SALARY > 2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID asc

--revising-aggregations-the-count-function
SELECT COUNT(*)
FROM city
WHERE population > 100000

--revising-aggregations-sum
SELECT SUM(population)
FROM city
WHERE district = 'California'

--revising-aggregations-the-average-function
SELECT AVG(population)
FROM city
WHERE district = 'California'

--average-population
SELECT FLOOR(AVG(population))
FROM city

--japan-population
SELECT SUM(population)
FROM city
WHERE countrycode ='JPN'

--population-density-difference
SELECT max(population)-min(population)
FROM city

--the-blunder
SELECT CEILING(AVG(salary)-AVG(CAST(REPLACE(CAST(salary AS CHAR), '0, '') AS SIGNED)))
FROM employees

