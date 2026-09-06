-- Problem 1 — Identify Super Keys --
CREATE table students (
    student_id INT unique,
    student_name VARCHAR(100),
    email VARCHAR(100) unique,  
    phone int unique
)