--570.Manager with at Least 5 Direct Reports
SELECT name
FROM employee
WHERE managerId IN (SELECT managerId
FROM employee
GROUP BY managerId
HAVING COUNT(*) >= 5 )

--1934. Confirmation Rate
SELECT s.user_id , IFNULL(sub.confirmation_rate,0) as confirmation_rate
FROM Signups s LEFT JOIN 
(
SELECT user_id  , ROUND(count(case when action='confirmed' then 1 end)/count(*),2) as confirmation_rate
FROM Confirmations 
GROUP BY user_id  
)sub
ON s.user_id = sub.user_id

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

--1174. Immediate Food Delivery II ***
SELECT ROUND(avg(sub.temp_col)*100,2) AS immediate_percentage
FROM (
    SELECT  IF(DATEDIFF(MIN(order_date),MIN(customer_pref_delivery_date))=0, 1 ,0) as temp_col
    FROM Delivery
    GROUP BY customer_id
) sub

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
