SELECT * FROM employee_salary;


SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age > 30 THEN 'Adult'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
END AS Age_Bracket
FROM employee_demographics;


SELECT first_name, last_name, salary, occupation,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.01)
    WHEN salary < 70000 THEN salary + (salary * 0.05)
    WHEN salary = 50000 AND occupation = 'Entrepreneur' THEN salary + 10000
END AS New_Salary
FROM employee_salary


