SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


SELECT gender, AVG(MAX_AGE)
FROM
(SELECT gender, AVG(age), MAX(age) AS MAX_AGE, MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender;

SELECT AVG(MAX_AGE)
FROM
(SELECT gender, AVG(age), MAX(age) AS MAX_AGE, MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender