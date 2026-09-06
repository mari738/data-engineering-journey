-- MYSQL DAY 03 - PRACTICE PROBLEMS
-- ====================================================================

USE company_db;

-- ====================================================================
-- PROBLEM 1 — DEFAULT
-- ====================================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert omitting 'status' and 'created_at'
INSERT INTO users (user_id, name)
VALUES 
    (1, 'Aarav Mehta'),
    (2, 'Priya Sharma'),
    (3, 'Rohan Verma');

-- Verify default values were populated
SELECT * FROM users;


-- ====================================================================
-- PROBLEM 2 — DEFAULT with numbers
-- ====================================================================
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0
);

-- Insert 5 products without passing stock
INSERT INTO products (product_id, product_name, price)
VALUES 
    (101, 'Mechanical Keyboard', 79.99),
    (102, 'Wireless Mouse', 29.50),
    (103, 'USB-C Dock', 55.00),
    (104, 'Gaming Headset', 64.99),
    (105, 'HD Webcam', 45.00);

-- Display all products (stock will show 0 for all)
SELECT * FROM products;


-- ====================================================================
-- PROBLEM 3 — Override DEFAULT
-- ====================================================================
INSERT INTO products (product_id, product_name, price, stock)
VALUES (106, 'Ergonomic Desk Mat', 19.99, 50);

-- Verify stock is 50, not the default 0
SELECT * FROM products WHERE product_id = 106;


-- ====================================================================
-- PROBLEM 4 — DELETE CASCADE: Parent table setup
-- ====================================================================
CREATE TABLE IF NOT EXISTS dept_demo (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO dept_demo (department_id, department_name)
VALUES
    (1, 'Engineering'),
    (2, 'Marketing'),
    (3, 'Finance');

CREATE TABLE IF NOT EXISTS emp_demo (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    CONSTRAINT fk_emp_dept_initial
        FOREIGN KEY (department_id) 
        REFERENCES dept_demo(department_id)
);

INSERT INTO emp_demo (employee_id, employee_name, department_id)
VALUES
    (1, 'Siddharth', 1),
    (2, 'Ananya', 1),
    (3, 'Kavya', 2),
    (4, 'Vikram', 3);

-- ====================================================================
-- PROBLEM 5 — Test DELETE CASCADE
-- ====================================================================
-- Drop the original foreign key and re-add with ON DELETE CASCADE
ALTER TABLE emp_demo DROP FOREIGN KEY fk_emp_dept_initial;

ALTER TABLE emp_demo 
ADD CONSTRAINT fk_emp_dept_cascade
    FOREIGN KEY (department_id) 
    REFERENCES dept_demo(department_id)
    ON DELETE CASCADE;

-- Delete one department (Department 1: Engineering)
DELETE FROM dept_demo WHERE department_id = 1;

-- Check employees: Siddharth and Ananya are now automatically gone
SELECT * FROM emp_demo;

/*
================================================================================
Question: What happened to the employees belonging to the deleted department?
Answer:
Because the foreign key constraint was defined with `ON DELETE CASCADE`, MySQL 
automatically deleted all child rows in `emp_demo` whose `department_id` matched 
the deleted parent record (department_id = 1). The database preserved referential 
integrity by purging dependent rows instead of throwing a constraint violation.
================================================================================
*/


-- ====================================================================
-- PROBLEM 6 — CASCADE with multiple child records
-- ====================================================================
CREATE TABLE IF NOT EXISTS customers_cascade (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders_cascade (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_customer_orders
        FOREIGN KEY (customer_id)
        REFERENCES customers_cascade(customer_id)
        ON DELETE CASCADE
);

INSERT INTO customers_cascade (customer_id, customer_name)
VALUES (1, 'Aditi Rao'), (2, 'Rahul Nair');

INSERT INTO orders_cascade (order_id, customer_id, order_total)
VALUES 
    (1001, 1, 150.00),
    (1002, 1, 240.50),
    (1003, 1, 89.00),
    (1004, 2, 45.00);

-- Delete customer 1
DELETE FROM customers_cascade WHERE customer_id = 1;

-- Verify all 3 orders associated with customer 1 were dropped
SELECT * FROM orders_cascade;

-- ====================================================================
-- PROBLEM 7 — Understand the danger of CASCADE
-- ====================================================================
CREATE TABLE IF NOT EXISTS authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
    book_id INT PRIMARY KEY,
    author_id INT,
    title VARCHAR(150) NOT NULL,
    CONSTRAINT fk_author_books
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON DELETE CASCADE
);

-- Insert 3 parents, 5 children
INSERT INTO authors (author_id, author_name)
VALUES (1, 'George Orwell'), (2, 'J.K. Rowling'), (3, 'J.R.R. Tolkien');

INSERT INTO books (book_id, author_id, title)
VALUES 
    (1, 1, '1984'),
    (2, 1, 'Animal Farm'),
    (3, 2, 'Harry Potter 1'),
    (4, 2, 'Harry Potter 2'),
    (5, 3, 'The Hobbit');

-- Pre-delete check
SELECT * FROM authors;
SELECT * FROM books;

-- Delete one author (Author 2: J.K. Rowling)
DELETE FROM authors WHERE author_id = 2;

-- Post-delete check: Books 3 and 4 vanished without explicit warning
SELECT * FROM authors;
SELECT * FROM books;


-- ====================================================================
-- PROBLEM 8 — Soft Delete
-- ====================================================================
CREATE TABLE IF NOT EXISTS employees_soft_delete (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    is_deleted TINYINT(1) DEFAULT 0
);

INSERT INTO employees_soft_delete (employee_id, employee_name, salary)
VALUES
    (1, 'Neha Kapoor', 65000.00),
    (2, 'Dev Patel', 72000.00),
    (3, 'Tanvi Joshi', 81000.00),
    (4, 'Arjun Das', 59000.00),
    (5, 'Zoya Khan', 93000.00);

-- Perform soft delete on employee 3
UPDATE employees_soft_delete
SET is_deleted = 1
WHERE employee_id = 3;

-- Retrieve only active employees
SELECT * 
FROM employees_soft_delete
WHERE is_deleted = 0;


-- ====================================================================
-- PROBLEM 9 — Soft Delete + Restore
-- ====================================================================
-- 1. Soft delete 2 employees (IDs 1 and 4)
UPDATE employees_soft_delete
SET is_deleted = 1
WHERE employee_id IN (1, 4);

-- 2. Display only active employees
SELECT * 
FROM employees_soft_delete
WHERE is_deleted = 0;

-- 3. Display deleted employees
SELECT * 
FROM employees_soft_delete
WHERE is_deleted = 1;

-- 4. Restore one deleted employee (ID 1)
UPDATE employees_soft_delete
SET is_deleted = 0
WHERE employee_id = 1;

-- 5. Display active employees again
SELECT * 
FROM employees_soft_delete
WHERE is_deleted = 0;

-- ====================================================================
-- PROBLEM 10 — Mini Real-World Challenge 🔥
-- ====================================================================
CREATE TABLE IF NOT EXISTS challenge_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE IF NOT EXISTS challenge_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    is_deleted TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_challenge_cust_orders
        FOREIGN KEY (customer_id)
        REFERENCES challenge_customers(customer_id)
        ON DELETE CASCADE
);

-- Insert 5 customers (using DEFAULT for status)
INSERT INTO challenge_customers (customer_id, customer_name)
VALUES
    (1, 'Aakash Roy'),
    (2, 'Bhavna Sen'),
    (3, 'Chetan Bhagat'),
    (4, 'Divya Nair'),
    (5, 'Eeshan Guha');

-- Insert 10 orders across customers
INSERT INTO challenge_orders (order_id, customer_id, order_amount)
VALUES
    (101, 1, 120.50),
    (102, 1, 450.00),
    (103, 2, 75.20),
    (104, 2, 230.00),
    (105, 3, 990.00),
    (106, 3, 310.00),
    (107, 4, 60.00),
    (108, 4, 180.00),
    (109, 5, 520.00),
    (110, 5, 840.00);

-- Soft-delete at least 2 orders
UPDATE challenge_orders
SET is_deleted = 1
WHERE order_id IN (102, 106);

-- Query only active orders
SELECT * 
FROM challenge_orders
WHERE is_deleted = 0;

-- Restore one soft-deleted order (Order 102)
UPDATE challenge_orders
SET is_deleted = 0
WHERE order_id = 102;

-- Delete one customer (Customer 5)
DELETE FROM challenge_customers
WHERE customer_id = 5;

-- Verify customer 5's orders (109, 110) were permanently cascaded out
SELECT * 
FROM challenge_orders
WHERE customer_id = 5;

/*
================================================================================
Hard Delete vs Soft Delete:

1. Hard Delete (SQL DELETE):
   - Physically purges the row from the disk storage and database tables.
   - Irreversible without restoring from external backups or binlogs.
   - Cascading hard deletes can lead to accidental mass data loss across child tables.

2. Soft Delete (SQL UPDATE on flag column like `is_deleted` or `deleted_at`):
   - Keeps the row physically in storage, toggling a status marker instead.
   - Fully reversible by flipping the flag back to 0.
   - Preserves audit trails, historical analytics, and prevents broken joins 
     in historical reporting tables.
================================================================================
*/