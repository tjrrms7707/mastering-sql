/*
<문제>
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

link : https://www.hackerrank.com/challenges/revising-the-select-query/problem



*/

select * from CITY 
where population > 100000 
AND COUNTRYCODE='USA'