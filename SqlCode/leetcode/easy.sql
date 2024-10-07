--175.combine two tables
SELECT firstName, lastName,city,state
FROM Person as p left join Address as a
ON p.personId = a.personId

--181. Employees Earning More Than Their Managers
SELECT a.name 
FROM Employee a , Employee b
WHERE a.managerId = b.id
AND a.salary > b.salary

--182. Dupliate Emails
SELECT email 
FROM Person
WHERE email is not null
GROUP BY email
HAVING COUNT(eamil) > 1

--183. Customers Who Never Order
SELECT C.name as customers
FROM Customers as C LEFT JOIN
Orders as O
ON C.id = O.customerid
WHERE O.customerid is null 

--196. delete Duplicate emails
DELETE FROM Person
WHERE id NOT IN (
    SELECT sub.id
    FROM (
        SELECT MIN(id) as id , email
        FROM Person
        GROUP BY email
    ) sub)

--197. Rising temperature
SELECT w1.id
FROM Weather w1 INNER JOIN Weather w2
ON w1.recordDate - interval 1 day = w2.recordDate
WHERE w1.temperature > w2.temperature 

--511. Game play analysis I
SELECT player_id , MIN(event_date) as first_login
FROM Activity
GROUP BY player_id

-- 577.Employee Bonus
SELECT e.name , b.Bonus
FROM Employee as E LEFT join Bonus as B
ON E.empid = B.empid
WHERE B.bonus < 1000 or B.bonus is null

--584. Find Customer Referee
SELECT name
FROM Customer
WHERE referee_id not in (2) or referee_id is null

--586. Customer Placing the Largest Number of Orders
SELECT customer_number 
FROM Orders
group by customer_number
ORDER BY count(order_number) desc 
LIMIT 1 

--620. Not Boring Movies
SELECT *
FROM cinema
WHERE MOD(id,2) = 1
AND description != 'boring'
ORDER BY rating DESC

--627.Swap Salary
Update Salary
set sex = if(sex = 'm','f','m')

--1050.Actors and Directors Who Cooperated At Least Three Times
SELECT actor_id , director_id
FROM ActorDirector
GROUP BY actor_id , director_id
HAVING COUNT(timestamp) >= 3

--1068.Product Sales Analysis I 
SELECT p.product_name , s.year , s.price
FROM Sales s inner join Product p
ON s.product_id = p.product_id

--1075.Project Employees I 
SELECT project_id , ROUND(AVG(experience_years),2) as average_years
FROM Project p inner join Employee e
ON p.employee_id = e.employee_id
GROUP BY project_id

--1084.Sales Analysis III
SELECT s.product_id , p.product_name
FROM Sales s inner join Product p
ON s.product_id = p.product_id
GROUP BY s.product_id
HAVING min(s.sale_date) >= '2019-01-01' AND MAX(s.sale_date) <= '2019-03-31'

--1141. User Activity for the Past 30 Days I
SELECT activity_date as day , count(user_id) as active_users
FROM (
    SELECT DISTINCT user_id , activity_date
    FROM Activity
    WHERE activity_date BETWEEN DATE_ADD('2019-07-27',INTERVAL -30 day)  AND '2019-07-27')
GROUP BY activity_date

SELECT activity_date as day , COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE activity_date BETWEEN DATE_ADD('2019-07-27',INTERVAL -29 day)  AND '2019-07-27'
GROUP BY activity_date

--1148. Article Views I
SELECT DISTINCT author_id as id
FROM Views
WHERE author_id = viewer_id
ORDER BY id 

--1179. Reformat Department Table
SELECT id, SUM(CASE WHEN month='JAN' THEN revenue ELSE NULL END) AS Jan_Revenue
       , SUM(CASE WHEN month='Feb' THEN revenue ELSE NULL END) AS Feb_Revenue
       , SUM(CASE WHEN month='Mar' THEN revenue ELSE NULL END) AS Mar_Revenue
       , SUM(CASE WHEN month='Apr' THEN revenue ELSE NULL END) AS Apr_Revenue
       , SUM(CASE WHEN month='May' THEN revenue ELSE NULL END) AS May_Revenue
       , SUM(CASE WHEN month='Jun' THEN revenue ELSE NULL END) AS Jun_Revenue
       , SUM(CASE WHEN month='Jul' THEN revenue ELSE NULL END) AS Jul_Revenue
       , SUM(CASE WHEN month='Aug' THEN revenue ELSE NULL END) AS Aug_Revenue
       , SUM(CASE WHEN month='Sep' THEN revenue ELSE NULL END) AS Sep_Revenue
       , SUM(CASE WHEN month='Oct' THEN revenue ELSE NULL END) AS Oct_Revenue
       , SUM(CASE WHEN month='Nov' THEN revenue ELSE NULL END) AS Nov_Revenue
       , SUM(CASE WHEN month='Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id

--1211. Queries Quality and Percentage
SELECT 
query_name ,
ROUND(AVG(rating/position),2) as quality ,
ROUND(AVG(IF(rating<3,1,0))*100,2) as poor_query_percentage 
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY query_name

--1251. Average Selling Price
SELECT p.product_id , IFNULL(ROUND(SUM(u.units*p.price)/SUM(u.units),2),0) as average_price
FROM Prices p LEFT JOIN  UnitsSold u
ON p.product_id = u.product_id
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY product_id

--1280. Students and Examinations
