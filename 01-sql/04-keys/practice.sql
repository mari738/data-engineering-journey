-- Problem 1 — Identify Super Keys --
CREATE table students (
    student_id INT unique,
    student_name VARCHAR(100),
    email VARCHAR(100) unique,  
    phone int unique
);
-- --
-- Problem 2 — Find Candidate Keys --

--problem 3 --
CREATE TABLE employees(
    employee_id INT unique,
    email VARCHAR(100) unique,
    phone INT unique,
    name varchar(200),
    department varchar(100)
);

INSERT INTO employees (employee_id, email, phone, name, department)
VALUES(1, 'JOHN@GMAIL.COM', 1234567890, 'JOHN ROJERS', 'IT'),
(2, 'sam@gmail.com', 78945611230, 'sam', 'law'),
(3, 'stephen@gmail.com', 78945611231, 'stephen', 'finance'),
(4, 'abi@gmail.com', 9512357846, 'abishek', 'marketing'),
(5, 'chadra@gmail.com', 7891134560, 'chandra sekar', 'mechanical');
--problem 4 --
--problem 5 --
CREATE table countries(
    country_code INT unique,
    coutry_name VARCHAR(150),
    currency_code VARCHAR(30)
);

CREATE products(
    product_id INT primary key,
    sku INT unique,
    product_name VARCHAR(200),
    price DECIMAL(10,2)
);

CREATE table students(
    student_id INT auto_increment primary key,
    email varchar(100) unique,
    phone INT unique,
    student_name VARCHAR(100),
    course varchar(100)
);
INSERT INTO students (email, phone, student_name, course)
VALUES('john.doe@example.com', 1234567890, 'John Doe', 'Computer Science'),
('RAJ@gmail.com', 789945611230, 'Raj', 'Data Science'),
('babu', 1595744862, 'babu', 'data analyst'),
('rajesh', 9874556310, 'rajesh', 'business analyst',
('harish', 78932114566, 'harish', 'data engineer'),
('kuumar', 75315996842, 'kumar', 'forward deployed engineer'),
('suresh', 7894561230, 'suresh', 'data scientist'),
('kumar', 7894561230, 'kumar', 'data analyst'),
('rajesh', 7894561230, 'rajesh', 'data engineer'),
('harish', 7894561230, 'harish', 'data scientist');