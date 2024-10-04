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