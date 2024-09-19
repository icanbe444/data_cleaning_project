-- Temporary Table

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favourite_movie varchar(100)
);

INSERT INTO temp_table
VALUES('Abdullahi','Akanbi', '24 Series'),
('Adesunkanmi','Akanbi', 'Prison Break'),
('Taiwo','Hammed', '25 Series'),
('Kenny','Hammed', '26 Series')
 
SELECT * FROM temp_table;


-- Alternate way to create temp tables

CREATE TEMPORARY TABLE salary_over_50k
SELECT * 
FROM employee_salary
WHERE salary > 50000;

SELECT * FROM salary_over_50k;

