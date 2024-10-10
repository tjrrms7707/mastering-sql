--570.Manager with at Least 5 Direct Reports
SELECT name
FROM employee
WHERE managerId IN (SELECT managerId
FROM employee
GROUP BY managerId
HAVING COUNT(*) >= 5 )

--1934. Confirmation Rate