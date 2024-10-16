--185.Department Top Three Salaries
WITH sal_ranking AS(
	SELECT *, DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) as sal_rank
	FROM Employee
)

SELECT t.name AS Department   , s.name AS Employee   , s.salary
FROM sal_ranking s JOIN Department t
ON s.departmentId  = t.id
WHERE sal_rank <=3