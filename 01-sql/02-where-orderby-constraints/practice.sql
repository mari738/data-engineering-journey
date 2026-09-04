-- =============================================
-- MYSQL DAY 02 - PRACTICE PROBLEMS
-- =============================================

USE company_db;

-- =============================================
-- PROBLEM 1 — WHERE 🟢
-- Display employees whose salary > 50000
-- =============================================
SELECT * 
FROM employees
WHERE salary > 50000;


-- =============================================
-- PROBLEM 2 — WHERE with Text 🟢
-- Display employees who work in Data Engineering
-- =============================================
SELECT * 
FROM employees
WHERE department = 'Data Engineering';


-- =============================================
-- PROBLEM 3 — WHERE with Multiple Conditions 🟢
-- Salary > 50000 AND department = 'Engineering'
-- =============================================
SELECT * 
FROM employees
WHERE salary > 50000 
  AND department = 'Engineering';


-- =============================================
-- PROBLEM 4 — ORDER BY 🟢
-- Salary from lowest to highest (ASC by default)
-- =============================================
SELECT * 
FROM employees
ORDER BY salary ASC;


-- =============================================
-- PROBLEM 5 — DESC 🟡
-- Salary from highest to lowest explicitly using DESC
-- =============================================
SELECT * 
FROM employees
ORDER BY salary DESC;


-- =============================================
-- PROBLEM 6 — PRIMARY KEY 🟡
-- Create and populate departments table
-- =============================================
CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    manager_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name, manager_name)
VALUES
    (1, 'Data Engineering', 'Elena Rostova'),
    (2, 'Platform Engineering', 'Marcus Vance'),
    (3, 'Human Resources', 'Sarah Jenkins'),
    (4, 'Finance', 'David Kim'),
    (5, 'Product Management', 'Amina Yusuf');


-- =============================================
-- PROBLEM 7 — UNIQUE + NOT NULL + CHECK 🟡
-- Create students table and test constraints
-- =============================================
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    age INT,
    CONSTRAINT chk_student_age CHECK (age >= 18)
);

-- Valid records
INSERT INTO students (student_id, student_name, email, age)
VALUES
    (101, 'Aarav Patel', 'aarav.p@example.com', 20),
    (102, 'Beatriz Silva', 'beatriz.s@example.com', 22),
    (103, 'Chloe Dubois', 'chloe.d@example.com', 19),
    (104, 'Dmitri Volkov', 'dmitri.v@example.com', 24),
    (105, 'Emma Watson', 'emma.w@example.com', 21);

-- --- Deliberate Error Tests (Commented out to preserve execution) ---

-- Test 1: Duplicate Primary Key (Error 1062: Duplicate entry '101' for key 'students.PRIMARY')
-- INSERT INTO students (student_id, student_name, email, age)
-- VALUES (101, 'Duplicate ID Test', 'unique1@example.com', 20);

-- Test 2: Duplicate Email (Error 1062: Duplicate entry 'aarav.p@example.com' for key 'students.email')
-- INSERT INTO students (student_id, student_name, email, age)
-- VALUES (106, 'Test Person', 'aarav.p@example.com', 23);

-- Test 3: NULL for student_name (Error 1048: Column 'student_name' cannot be null)
-- INSERT INTO students (student_id, student_name, email, age)
-- VALUES (107, NULL, 'noname@example.com', 25);

-- Test 4: Age below 18 (Error 3819: Check constraint 'chk_student_age' is violated)
-- INSERT INTO students (student_id, student_name, email, age)
-- VALUES (108, 'Minor Student', 'minor@example.com', 15);


-- =============================================
-- PROBLEM 8 — COMPOSITE PRIMARY KEY 🔥
-- Create junction table and test composite uniqueness
-- =============================================
CREATE TABLE IF NOT EXISTS employee_projects (
    employee_id INT,
    project_id INT,
    assigned_date DATE NOT NULL,
    PRIMARY KEY (employee_id, project_id)
);

-- Valid assignments
INSERT INTO employee_projects (employee_id, project_id, assigned_date)
VALUES
    (1, 1001, '2026-01-10'),
    (1, 1002, '2026-02-01'),
    (2, 1001, '2026-01-15');

-- Duplicate combination test:
-- Fails with Error 1062: Duplicate entry '1-1001' for key 'employee_projects.PRIMARY'
-- A composite primary key allows duplicate employee_ids or project_ids individually, 
-- but the exact pair (employee_id + project_id) must remain strictly unique.
-- INSERT INTO employee_projects (employee_id, project_id, assigned_date)
-- VALUES (1, 1001, '2026-03-01');


-- =============================
-- PROBLEM 9 — FOREIGN KEY 🔥
-- Reference departments table from employees_v2
-- =============================================
CREATE TABLE IF NOT EXISTS employees_v2 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    CONSTRAINT fk_employees_dept
        FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Valid inserts (department IDs 1 and 2 exist in departments table)
INSERT INTO employees_v2 (employee_id, employee_name, department_id)
VALUES
    (201, 'Julian Hayes', 1),
    (202, 'Maya Lin', 2);

-- --- Non-existent Foreign Key Test ---
-- Fails with Error 1452: Cannot add or update a child row: a foreign key constraint fails
-- INSERT INTO employees_v2 (employee_id, employee_name, department_id)
-- VALUES (203, 'Ghost Worker', 99);

/*
========================================================================================
Question: Why does MySQL reject department_id = 99?
Answer:
MySQL enforces Referential Integrity through the Foreign Key constraint. 
Before inserting or updating a child row in `employees_v2`, the database engine checks 
the parent table `departments`. Because no record exists with `department_id = 99`, 
MySQL aborts the operation to prevent "orphan records" — rows that reference non-existent 
parent entities.
========================================================================================
*/


-- =============================================
-- PROBLEM 10 — 🔥 Real-World Challenge
-- Companies & Employees relational schema with constraints
-- =============================================

CREATE TABLE IF NOT EXISTS companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE
);

CREATE TABLE IF NOT EXISTS company_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    age INT,
    company_id INT,
    salary DECIMAL(10, 2),
    CONSTRAINT chk_emp_age CHECK (age >= 18),
    CONSTRAINT chk_emp_salary CHECK (salary > 0),
    CONSTRAINT fk_company_emp
        FOREIGN KEY (company_id) 
        REFERENCES companies(company_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 1. Insert at least 3 companies
INSERT INTO companies (company_id, company_name, email)
VALUES
    (1, 'Apex Technologies', 'contact@apextech.com'),
    (2, 'Nexus Data Labs', 'info@nexusdatalabs.io'),
    (3, 'Crest Financials', 'support@crestfin.com');

-- 2. Insert at least 8 employees across companies
INSERT INTO company_employees (employee_id, employee_name, email, age, company_id, salary)
VALUES
    (301, 'Liam Scott', 'liam.s@apextech.com', 28, 1, 82000.00),
    (302, 'Sophia Miller', 'sophia.m@apextech.com', 32, 1, 95000.00),
    (303, 'Lucas Gray', 'lucas.g@apextech.com', 24, 1, 61000.00),
    (304, 'Ava Chen', 'ava.c@nexusdatalabs.io', 30, 2, 88000.00),
    (305, 'Noah Patel', 'noah.p@nexusdatalabs.io', 27, 2, 73000.00),
    (306, 'Isabella Ramos', 'isabella.r@crestfin.com', 35, 3, 105000.00),
    (307, 'Mason Reed', 'mason.r@crestfin.com', 29, 3, 79000.00),
    (308, 'Olivia Brooks', 'olivia.b@crestfin.com', 22, 3, 54000.00);

-- --- Deliberate Negative Tests ---

-- Test A: Invalid Company ID (Fails FK constraint: company 99 does not exist)
-- INSERT INTO company_employees (employee_id, employee_name, email, age, company_id, salary)
-- VALUES (309, 'Orphan User', 'orphan@nowhere.com', 30, 99, 60000.00);

-- Test B: Duplicate Email (Fails UNIQUE constraint on email)
-- INSERT INTO company_employees (employee_id, employee_name, email, age, company_id, salary)
-- VALUES (310, 'Duplicate User', 'liam.s@apextech.com', 40, 1, 70000.00);

-- Test C: Invalid Age (Fails CHECK constraint: age < 18)
-- INSERT INTO company_employees (employee_id, employee_name, email, age, company_id, salary)
-- VALUES (311, 'Underage Worker', 'underage@apextech.com', 16, 1, 45000.00);

-- Test D: Negative Salary (Fails CHECK constraint: salary <= 0)
-- INSERT INTO company_employees (employee_id, employee_name, email, age, company_id, salary)
-- VALUES (312, 'Negative Salary', 'negative@apextech.com', 26, 1, -1200.00);

-- 3. Display employees belonging to Apex Technologies (company_id = 1)
SELECT *
FROM company_employees
WHERE company_id = 1;

-- 4. Display employees from highest salary to lowest salary
SELECT *
FROM company_employees
ORDER BY salary DESC;