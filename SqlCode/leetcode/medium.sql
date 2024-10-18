--176.Second Highest Salary
WITH sal_ranking AS (
    SELECT *,DENSE_RANK() OVER(ORDER BY salary DESC) as salary_rank
    FROM Employee
)

SELECT IF(count(salary)=0,null,salary) AS SecondHighestSalary
FROM sal_ranking
WHERE salary_rank = 2

--178.Rank Scores
SELECT score , DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores

--180.Consecutive Numbers
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1 
LEFT JOIN Logs l2 ON l1.id  = l2.id - 1 
LEFT JOIN Logs l3 ON l1.id = l3.id -2 
WHERE l1.num = l2.num
AND l2.num = l3.num

--184. Department Highest Salary
SELECT d.name  AS Department, e.name AS employee , e.salary
FROM (
SELECT departmentid ,DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC)  AS sal_rank, name , salary 
FROM Employee) e JOIN Department d
ON e.departmentId  = d.id
WHERE sal_rank = 1 

--550. Game Play Analysis IV
WITH temp1(player_id , value_day ,value) as
(
SELECT player_id ,  DATE_ADD(MIN(event_date), INTERVAL 1 DAY) ,1 as value
FROM Activity 
GROUP BY player_id 
)

SELECT IFNULL(ROUND(SUM(value)/COUNT(DISTINCT a.player_id),2),0) AS fraction  
FROM Activity a LEFT JOIN temp1 t
ON a.player_id = t.player_id
AND a.event_date = t.value_day

--550. 다른 풀이
SELECT ROUND(COUNT(player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity),2) as fraction  
FROM Activity
WHERE (player_id , event_date) IN (SELECT player_id ,  DATE_ADD(MIN(event_date), INTERVAL 1 DAY) 
FROM Activity 
GROUP BY player_id )

--570.Manager with at Least 5 Direct Reports
SELECT name
FROM employee
WHERE managerId IN (SELECT managerId
FROM employee
GROUP BY managerId
HAVING COUNT(*) >= 5 )

--585.Investments in 2016
SELECT ROUND(SUM(tiv_2016),2) as tiv_2016
FROM (
    SELECT tiv_2015  , tiv_2016 
    FROM Insurance 
    GROUP BY lat , lon
    HAVING COUNT(*) = 1
)SUB
WHERE tiv_2015  IN (
    SELECT tiv_2015
    FROM Insurance 
    GROUP BY tiv_2015 
    HAVING COUNT(*) > 1 
)

--602
WITH result AS(
SELECT requester_id AS id , count(*) AS cnt
FROM RequestAccepted
GROUP BY requester_id
UNION ALL
SELECT accepter_id AS id ,  count(*) AS cnt
FROM RequestAccepted
GROUP BY accepter_id 
)

SELECT id , sum(cnt) AS num
FROM result
GROUP BY id 
ORDER BY 2 DESC 
LIMIT 1

--608. Tree Node
SELECT id , CASE
WHEN p_id is null THEN 'Root'
WHEN id IN (SELECT p_id FROM Tree) THEN 'Inner'
ELSE 'Leaf'
END AS 'type'
FROM Tree 

-626.Exchange Seats
SELECT CASE
	WHEN MOD(id,2) = 1 AND id = (SELECT COUNT(*) FROM Seat) THEN id
	WHEN MOD(id,2) = 1 THEN id + 1
	ELSE
		id - 1
	END AS id,
	student
FROM Seat
ORDER BY id 

--1045.Customers Who Bought All Products
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING count(distinct product_key) = (SELECT COUNT(*) FROM Product)

--1070. Product Sales Analysis III
SELECT product_id , year as first_year , quantity , price
FROM Sales
WHERE (product_id , year) IN (SELECT product_id ,MIN(year)
FROM Sales
GROUP BY product_id)

--1158.Market Analysis I
WITH 2019_buyer AS(
    SELECT buyer_id , count(*) AS cnt
    FROM Orders
    WHERE order_date LIKE "2019%"
    GROUP BY buyer_id 
)
SELECT u.user_id AS buyer_id , join_date , IFNULL(cnt ,0) AS orders_in_2019
FROM Users u LEFT JOIN 2019_buyer b 
ON u.user_id = b.buyer_id 


--1164.Product Price at a Given Date
SELECT product_id , new_price as price
FROM (
SELECT *, ROW_NUMBER() OVER(partition by product_id ORDER BY change_date desc) as new_date
FROM products
WHERE change_date <= '2019-08-16'
) t
WHERE new_date = 1

UNION

SELECT product_id , 10 AS price
FROM products 
GROUP BY product_id 
HAVING MIN(change_date) > '2019-08-16'

--1174. Immediate Food Delivery II ***
SELECT ROUND(avg(sub.temp_col)*100,2) AS immediate_percentage
FROM (
    SELECT  IF(DATEDIFF(MIN(order_date),MIN(customer_pref_delivery_date))=0, 1 ,0) as temp_col
    FROM Delivery
    GROUP BY customer_id
) sub

--1193. Monthly Transactions I ***
SELECT 
DATE_FORMAT(trans_date, '%Y-%m') AS month , 
country , 
COUNT(state) AS trans_count ,
COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count , 
SUM(amount) AS trans_total_amount ,
SUM(IF(state='approved',amount,0)) AS approved_total_amount
FROM transactions 
GROUP BY DATE_FORMAT(trans_date, '%Y-%m') , country

--1204.Last Person to Fin in the Bus
# Write your MySQL query statement below
WITH total AS (
    SELECT person_name  ,SUM(Weight) OVER (ORDER BY TURN) AS Total_Weight
    FROM Queue
)

SELECT person_name
FROM total
WHERE Total_Weight <= 1000
ORDER BY Total_Weight DESC
LIMIT 1

--1341.Movie Rating
SELECT name AS results
FROM (
    SELECT u.name , count(*)
    FROM MovieRating m JOIN Users u
    USING (user_id)
    GROUP BY u.name
    ORDER BY 2 DESC , 1
    LIMIT 1
) t
UNION ALL
SELECT title AS results
FROM (
    SELECT m.title , AVG(rating)
    FROM movierating mr 
    JOIN Movies m
    USING(movie_id)
    WHERE created_at LIKE "2020-02%"
    GROUP BY mr.movie_id
    ORDER BY 2 DESC , 1	
    LIMIT 1) t2

--1393.Capital Gain/Loss
WITH summary AS(
    SELECT stock_name , operation  , sum(price) as total_price
    FROM Stocks
    GROUP BY stock_name , operation
)

SELECT stock_name , SUM(IF(operation ='Sell',total_price , -1*total_price)) AS capital_gain_loss
FROM summary
GROUP BY stock_name

--1934. Confirmation Rate
SELECT s.user_id , IFNULL(sub.confirmation_rate,0) as confirmation_rate
FROM Signups s LEFT JOIN 
(
SELECT user_id  , ROUND(count(case when action='confirmed' then 1 end)/count(*),2) as confirmation_rate
FROM Confirmations 
GROUP BY user_id  
)sub
ON s.user_id = sub.user_id

--1970.Count Salary Categories
WITH c AS (SELECT 'Low Salary' AS category
           UNION
           SELECT 'Average Salary'
           UNION
           SELECT 'High Salary' )
, t AS (select
            case when income < 20000 then 'Low Salary'
                 when income > 50000 then 'High Salary'
                 else 'Average Salary' end
            as category,
            count(1) as cnt
        from Accounts
        group by 1)
SELECT c.category, IFNULL(t.cnt,0) AS accounts_count
FROM c
     LEFT JOIN t using(category)
ORDER BY 2 DESC
