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
    price DECIMAL(10,2),
);