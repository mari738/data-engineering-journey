CREATE DATABASE IF NOT EXISTS day6_db;
USE day6_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    manager_id INT,
    email VARCHAR(150)
);

INSERT INTO employees
(employee_id, employee_name, department, salary, bonus, manager_id, email)
VALUES
(1, 'Arun', 'Engineering', 60000, 5000, 5, 'arun@example.com'),
(2, 'Bala', 'Engineering', 75000, NULL, 5, 'bala@example.com'),
(3, 'Divya', 'HR', 45000, 3000, NULL, 'divya@example.com'),
(4, 'Kumar', 'Finance', 50000, NULL, 7, NULL),
(5, 'Priya', 'Engineering', 65000, 7000, NULL, 'priya@example.com'),
(6, 'Ravi', 'Finance', 55000, 2000, 7, 'ravi@example.com'),
(7, 'Meena', 'HR', 70000, NULL, NULL, 'meena@example.com'),
(8, 'Sanjay', 'Engineering', 80000, 10000, 5, NULL),
(9, 'Kavya', 'Marketing', 40000, NULL, 10, 'kavya@example.com'),
(10, 'Vijay', 'Marketing', 60000, 4000, NULL, 'vijay@example.com');

--Problem 1 — Find NULL values--
SELECT employee_name
FROM Employees
Where bonus is null;

SELECT employee_name
FROM Employees
Where manager_id is null;

SELECT employee_name
FROM Employees
Where email is null;

SELECT employee_name
FROM Employees
Where bonus is not null;

--Problem 2 — NULL vs normal comparison--
SELECT employee_name
FROM Employees
Where bonus = null;
-- we cannot compare null values with normal comparison operators, we have to use IS NULL or IS NOT NULL--

SELECT employee_name
FROM Employees
Where bonus is null;

SELECT employee_name
FROM Employees
Where bonus is not null;

--Problem 3 — Replace NULL using COALESCE--
SELECT employee_name, salary, bonus,
coalesce(bonus, "0") as Bonus_Amount, salary + coalesce(bonus, "0") as Total_Amount
FROM Employees

--Problem 4 — CASE WHEN: Salary Category--
SELECT employee_name, salary,
CASE 
WHEN salary >= 75000 then "High Salary"
when salary >= 50000 then "medium salary"
when salary < 5000 then "low salary"
end as salary_cartegory
FROM Employees

--Problem 5 — CASE WHEN with NULL--
SELECT employee_name, bonus,
CASE 
WHEN bonus is null then "no bonus"
when bonus > 5000 then "high bonus"
else "regular bonus"
end as Bonus_Status
FROM Employees

-- Problem 6 — CASE WHEN with multiple conditions --
SELECT employee_name,salary, bonus,
CASE 
WHEN salary >= 70000 AND bonus >= 5000 then "Senior"
when salary >= 60000 then "mid-level"
when salary < 50000 then "junior"
end as Employee_Level
FROM Employees

-- Problem 7 — CASE WHEN + NULL handling --
SELECT employee_name,email, manager_id,
CASE 
WHEN email is null then "email missing"
WHEN manager_id is null then "Top level"
else "Regular employee" 
end as Employee_Profile
FROM Employees

-- Problem 8 — Aggregate + NULL handling -- 
SELECT COUNT(*) as total_employees,
count(bonus) as bonus_employees,
count(*) - count(bonus) as no_bonus_employees,
sum(bonus) as total_bonus, 
avg(bonus) as average_bonus,
avg(coalesce(bonus, "0")) as average_bonus_all_employees
FROM employees

-- Problem 9 — Department-wise CASE WHEN --
SELECT department, count(*) as Total_employees, avg(salary) as Average_salary, count(bonus) as Employee_with_bonus,
case 
when avg(salary) >= 65000 then "High Paying"
when avg(salary) >= 50000 then "Medium Paying"
else "Low Paying"
end as salary_level
FROM Employees
Group BY department;

-- Problem 10 — Department-wise CASE WHEN + NULL handling --