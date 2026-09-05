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