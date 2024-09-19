-- Common Table Expression (CTE)--


WITH CTE_demographics AS
(
SELECT gender, AVG(salary)  avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT avg_sal
FROM CTE_demographics 
;