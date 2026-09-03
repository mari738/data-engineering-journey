--problem_1--
--Create a database--
CREATE DATABASE company_db;

--problem_2--
--Use the database--
USE company_db;

--problem_3--
--Create a table--
CREATE TABLE employees(id INT, name VARCHAR(200), salary DECIMAL(10, 2), role VARCHAR(200)));

-- PROBLEM 4 --
-- Insert 4 employee records --
INSERT INTO employees (id, name, salary, role)
VALUES
(1, 'mari sekar' , 60000 , 'Data Engineer'),
(2, 'nethaji' , 70000 , 'Software Engineer'),
(3, 'sathish', 60000 , 'Accounting'),
(4, 'karuna' , 40000, 'Electrician');

-- PROBLEM 5 --
-- Update the salary of one employee --
UPDATE employees SET salary = 80000
WHERE name = 'mari sekar';

-- PROBLEM 6 --
-- Delete one employee record --
DELETE FROM employees 
WHERE id = 2;

-- PROBLEM 7 --
-- Add a new column using ALTER TABLE --
ALTER TABLE employees 
ADD COLUMN Department VARCHAR(200);

-- PROBLEM 8 --
-- Remove a column using ALTER TABLE --
ALTER TABLE employees
DROP COLUMN Department;

-- PROBLEM 9 --
-- Create a backup table using CTAS --
CREATE TABLE emp AS
SELECT id, name
FROM employees 
WHERE id = 1;

CREATE TEMPORARY TABLE temp_employees(
    id INT,
    name VARCHAR(200)
);
INSERT INTO temp_employees
SELECT id , name 
FROM employees
WHERE id = 1;