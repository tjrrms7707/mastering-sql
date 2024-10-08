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

--595. Big Countries
SELECT name, population , area
FROM World 
WHERE population >= 25000000
OR area >=3000000

--596. Classes More Than 5 Students
SELECT class
FROM Courses
GROUP BY class
having count(class) >=5

--607.Sales Person
SELECT name 
FROM SalesPerson
WHERE sales_id not in (
    SELECT sales_id 
    FROM Orders
    WHERE com_id = (
        SELECT com_id
        FROM Company
        WHERE name = "RED"
    )
)

--610. Triangle Judgement
SELECT 
    x,y,z,
    CASE
        WHEN x+y > z AND y + z > x AND  x + z > y THEN 'Yes'
        ELSE 'No'
    END as 'triangle'
FROM Triangle 

--619. Bigget Single Number

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
SELECT s.student_id ,s.student_name ,sub.subject_name ,IFNULL(s2.attended_exams,0) AS attended_exams
FROM
Students s CROSS JOIN Subjects sub
LEFT JOIN (SELECT student_id  , subject_name,count(*) AS attended_exams
FROM Examinations
GROUP BY student_id , subject_name) s2
ON s.student_id = s2.student_id 
AND sub.subject_name =s2.subject_name 
ORDER BY s.student_id,sub.subject_name

--1327. List the Products Ordered in a Period
SELECT product_name , SUM(UNIT) as unit
FROM Orders o INNER JOIN Products p
ON o.product_id  = p.product_id  
WHERE o.order_date BETWEEN '2020-02-01' AND LAST_DAY('2020-02-01')
GROUP BY p.product_id,p.product_name
HAVING SUM(UNIT)>=100

--1378. Replace Employee ID With The Unique Identifier
SELECT unique_id , name
FROM Employees e LEFT JOIN EmployeeUNI eu
ON e.id = eu.id

--1407. Top Travellers
SELECT name , IFNULL(SUM(distance),0) AS travelled_distance 
FROM
Users u LEFT JOIN Rides r 
ON u.id = r.user_id
GROUP BY r.user_id
ORDER BY 2 DESC, 1

--1484. Group Sold Products By The Date
SELECT sell_date, COUNT(DISTINCT product) as num_sold , group_concat(DISTINCT product ORDER BY product) AS products
FROM Activities
GROUP BY sell_date 
ORDER BY 1

--1517. Find Users With Valid E-Mails


--1527. Patients With a Condition
SELECT *
FROM Patients
WHERE  conditions LIKE 'DIAB1%'
OR conditions LIKE '% DIAB1%'

--1581. Customer Who Visited but Did Not Make Any Transactions
SELECT customer_id , COUNT(*) AS count_no_trans
FROM Visits v LEFT JOIN Transactions t
USING(visit_id)
WHERE transaction_id IS NULL
GROUP BY customer_id 

--1587. Bank Account Summary II
SELECT   u.name AS name , sum(t.amount) as balance
FROM Transactions t JOIN Users u
USING(account)
GROUP BY t.account
HAVING sum(amount) >10000

--1633. Percentage of Users Attended a Contest
SELECT contest_id , ROUND((COUNT(*)/(select count(*) from Users)*100),2) AS percentage
FROM Register r JOIN Users u
USING(user_id)
GROUP BY r.contest_id
ORDER BY 2 DESC,1

--1661. Average Time of Process per Machine
SELECT a1.machine_id, round(avg(a2.timestamp-a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2
USING (machine_id, process_id)
WHERE a1.activity_type = 'start'
AND a2.activity_type = 'end'
GROUP BY machine_id

--1667. Fix Names in a Table
SELECT user_id , CONCAT(UPPER(LEFT(name,1)),LOWER(SUBSTRING(name,2))) as name
FROM Users
ORDER BY 1

--1683. Invalid Tweets
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15


--1693. Daily Leads and Partners
SELECT 
date_id , 
make_name , 
count(DISTINCT lead_id ) AS unique_leads,
count(DISTINCT parter_id) AS unique_partners
FROM DailySales
GROUP BY date_id , make_name


--1729. Find Followers Count
SELECT user_id , COUNT(follower_id ) as followers_count
FROM Followers 
GROUP BY 1
ORDER BY 1

--1731. The Number of Employees Which Report to Each Employee
SELECT e1.reports_to AS employee_id , e2.name AS name , COUNT(*) AS reports_count , ROUND(AVG(e1.age)) AS 
average_age
FROM Employees e1 INNER JOIN Employees e2
ON e1.reports_to = e2.employee_id
WHERE e1.reports_to IS NOT NULL
GROUP BY e1.reports_to
ORDER BY 1

--1741. Find Total Time Spent by Each Employee
SELECT event_day as day , emp_id , sum(out_time) - sum(in_time) AS total_time
FROM Employees
GROUP BY 1 , 2

--1757. Recyclable and Low Fat Products
SELECT product_id
FROM Products
WHERE low_fats = 'Y' 
AND recyclable = 'Y'

--1789. Primary Department for Each Employee
SELECT employee_id, department_id
FROM employee e
WHERE primary_flag = 'Y'
OR (
  employee_id in (
    select employee_id from employee
    group by employee_id 
    having count(employee_id) = 1
  )
)

--1795. Rearrange Products Table
SELECT product_id, 'store1' AS store, store1 AS price
FROM Products
WHERE store1 IS NOT NULL
UNION ALL
SELECT product_id, 'store2' AS store, store2 AS price
FROM Products
WHERE store2 IS NOT NULL
UNION ALL
SELECT product_id, 'store3' AS store, store3 AS price
FROM Products
WHERE store3 IS NOT NULL

--1873. Calculate Special Bonus
SELECT employee_id  , IF(MOD(employee_id,2)=1,IF(LEFT(name,1) ='M',0,salary) , 0) as bonus
FROM Employees
ORDER BY 1

--1890. The Latest Login in 2020
SELECT user_id , MAX(time_stamp) as last_stamp
FROM Logins
WHERE time_stamp >='2020-01-01' AND time_stamp < '2021-01-01'
GROUP BY 1 

--1965. Employees With Missing Information
SELECT employee_id 
FROM (
    SELECT e.employee_id , e.name , s.salary 
    FROM Employees e LEFT JOIN Salaries s
    ON e.employee_id  = s.employee_id 
    UNION
    SELECT s.employee_id , e.name     , s.salary
    FROM Employees e RIGHT JOIN Salaries s
    ON e.employee_id  = s.employee_id 
) sub
WHERE name IS NULL OR salary IS NULL
ORDER BY 1

--1978. Employees Whose Manager Left the Company
SELECT e1.employee_id 
FROM Employees e1 LEFT JOIN Employees e2
ON e1.manager_id = e2.employee_id
WHERE e2.employee_id IS NULL
AND e1.manager_id IS NOT NULL
AND e1.salary < 30000
ORDER BY 1

--2356. Number of Unique Subjects Taught by Each Teacher
