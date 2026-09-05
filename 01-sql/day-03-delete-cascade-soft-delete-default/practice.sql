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