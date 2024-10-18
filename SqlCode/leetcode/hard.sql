--185.Department Top Three Salaries
WITH sal_ranking AS(
	SELECT *, DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) as sal_rank
	FROM Employee
)

SELECT t.name AS Department   , s.name AS Employee   , s.salary
FROM sal_ranking s JOIN Department t
ON s.departmentId  = t.id
WHERE sal_rank <=3

--262.
WITH banned AS (
	SELECT users_id as id
	FROM Users
	WHERE banned = 'Yes'
)


SELECT request_at AS "Day" , ROUND(AVG(IF(status='completed',0,1)),2) AS 'Cancellation Rate'
FROM Trips
WHERE client_id NOT IN (SELECT id FROM banned)
AND driver_id NOT IN (SELECT id FROM banned)
AND request_at BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY request_at 

--601.Human Tracffic of Stadium
WITH Base AS(
    SELECT *,
    LAG(id,1) OVER(ORDER BY id) AS id_p_1,
    LAG(id,2) OVER(ORDER BY id) AS id_p_2,
    LEAD(id,1) OVER(ORDER BY id) AS id_m_1,
    LEAD(id,2) OVER(ORDER BY id) AS id_m_2
    FROM Stadium
    WHERE people >=100
)
--1.id 기준 2개의 상위값(LEAD)이 연속일때
--2.id 기준 1개의 상위값과 1개의 하위값이 연속일때
--3.id 기준 2개의 하위값(LAG)이 연속일때

SELECT id , visit_date,people 
FROM Base
WHERE (id = id_p_1 +1 AND id = id_p_2 +2)
OR (id = id_p_1 +1 AND id = id_m_1 - 1)
OR (id = id_m_1 -1 AND id = id_m_2 -2)
ORDER BY 2 