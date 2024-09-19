CREATE PROCEDURE large_salaries()
SELECT * FROM employee_salary
WHERE salary >= 50000;


CALL large_salaries();

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
    SELECT * 
    FROM employee_salary
    WHERE salary >= 10000;
END $$
DELIMITER ;



-- Stored Procedure with parameters
DELIMITER $$
CREATE PROCEDURE large_salaries4(employee_id INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = employee_id;
END $$
DELIMITER ;

CALL large_salaries4(2)
