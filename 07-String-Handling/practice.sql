CREATE DATABASE IF NOT EXISTS day7_db;
USE day7_db;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    email VARCHAR(150),
    phone VARCHAR(20),
    city VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees
(employee_id, employee_name, department, email, phone, city, salary)
VALUES
(1, '  Mari Sekar  ', 'Data Engineering', 'mari.sekar@gmail.com', '9876543210', 'Chennai', 60000),
(2, 'Nethaji Kumar', 'Software Engineering', 'nethaji.kumar@gmail.com', '9876501234', 'Bangalore', 70000),
(3, ' Sathish ', 'Accounting', 'sathish@gmail.com', '9988776655', 'Chennai', 55000),
(4, 'Karuna Devi', 'Data Engineering', 'karuna.devi@gmail.com', '9123456780', 'Coimbatore', 65000),
(5, 'Arun Prakash', 'HR', 'arun.prakash@gmail.com', '9012345678', 'Madurai', 45000),
(6, ' Priya ', 'Software Engineering', 'priya@gmail.com', '9345678901', 'Chennai', 75000);

--Problem 1 — LENGTH--
SELECT employee_name, length(employee_name) as number_of_characters
FROM Employees

--Problem 2 — UPPER & LOWER--
SELECT employee_name, upper(employee_name) as upper_name, lower(employee_name) as lower_name
FROM Employees;

--Problem 3 — CONCAT--
SELECT employee_name, CONCAT(employee_name,' - ', department) as employee_info
FROM employees;

--Problem 4 — SUBSTRING--
SELECT employee_name, substring(employee_name, 1,5 ) as first_five_char
FROM employees;

--Problem 5 — TRIM + UPPER--
SELECT trim(upper(employee_name)) as upper_name
FROM employees;

--Problem 6 — LPAD & RPAD--
SELECT lpad(employee_name, 15, '*') as LEFT_PADDING,
rpad(employee_name, 15, '-') as RIGHT_PADDING
FROM employees;

--Problem 7 — REPLACE--
SELECT email as original_mail,  replace(email, '@gmail.com', '@company.com') as new_mail
FROM employees;

-- Problem 8 — INSTR & RIGHT --
SELECT employee_name, email, instr(email, '@') as position,  right(phone, 10) as last_10_phone_digits
FROM employees;

--Problem 9 — REVERSE & FORMAT--
SELECT employee_name, reverse(employee_name) as reversed_name, format(salary, 2) as formatted_salary
FROM employees;

--  Problem 10 — 🔥 Final Challenge: Employee Profile--
SELECT employee_id, trim(employee_name),
upper(employee_name),
length(employee_name),
substring(employee_name, 1, 3),
concat(department,' ',city), 
instr(email, '@') as email_position,
right(phone, 4) last_4digits_phone, 
reverse(employee_name) as reversed, 
format(salary, 2) as formatted_salary
FROM employees;