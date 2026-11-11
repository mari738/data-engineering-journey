CREATE DATABASE IF NOT EXISTS day5_db;
USE day5_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    role VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees
    (employee_id, employee_name, department, role, salary)
VALUES
    (1, 'Arun', 'Engineering', 'Data Engineer', 60000),
    (2, 'Bala', 'Engineering', 'Software Engineer', 75000),
    (3, 'Divya', 'HR', 'HR Executive', 45000),
    (4, 'Kumar', 'Finance', 'Accountant', 50000),
    (5, 'Priya', 'Engineering', 'Data Analyst', 65000),
    (6, 'Ravi', 'Finance', 'Financial Analyst', 55000),
    (7, 'Meena', 'HR', 'HR Manager', 70000),
    (8, 'Sanjay', 'Engineering', 'Data Engineer', 80000),
    (9, 'Kavya', 'Marketing', 'Marketing Executive', 40000),
    (10, 'Vijay', 'Marketing', 'Marketing Manager', 60000);

PROBLEM 1 — IN and NOT IN
SELECT * FROM Employees
WHERE department IN ("Engineering","Finance","HR");

SELECT * FROM Employees
WHERE department NOT IN ("Engineering","Finance","HR");

Problem 2 — AND and OR
1.Find employees whose salary is greater than 60,000 and who work in Engineering.
SELECT * FROM Employees
WHERE department IN ("Engineering") AND salary > 60000;

2.Find employees who work in HR or Marketing.
SELECT * FROM Employees
WHERE department IN ("HR") OR department IN ("Marketing");

3.Find employees who work in Engineering or Finance and earn more than 60,000. Use parentheses to make the intended logic clear.
SELECT * FROM Employees
WHERE department IN ("Engineering", "Finance") AND salary > 60000;

Problem 3 — Column aliases
SELECT employee_name AS Name, department AS Department_Name, salary AS Monthly_Salary 
FROM Employees;

SELECT  MAX(salary) AS Highest_Salary 
FROM Employees;

Problem 4 — MIN and MAX
SELECT MAX(salary) AS Maximum_Salary,  MIN(salary) AS Minimum_Salary 
FROM Employees;

Problem 5 — COUNT
SELECT COUNT(*) AS Total_Employees
FROM Employees;

SELECT COUNT(*) AS Total_Employees
FROM Employees
WHERE Department = 'Engineering';

SELECT COUNT(*) AS Total_Employees
FROM Employees
WHERE salary >= 60000;

Problem 6 — SUM and AVG
SELECT SUM(salary) AS Total_salary
FROM Employees;

SELECT AVG(salary) AS Average_salary
FROM Employees;

SELECT AVG(salary) AS Average_salary
FROM Employees
WHERE Department = 'Engineering';


