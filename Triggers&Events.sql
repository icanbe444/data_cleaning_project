-- Triggers and Events


-- Triggers

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
	FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics ( employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Abdullahi', 'Akanbi', 'Exntertainment 720 CEO', 10000000, NULL);

-- Events

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;


SHOW VARIABLES LIKE 'event%';