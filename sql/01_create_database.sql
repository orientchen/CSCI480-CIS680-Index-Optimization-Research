CREATE DATABASE IF NOT EXISTS index_research;
USE index_research;

CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    adm_year INT NOT NULL,
    gpa DECIMAL(3,2) NOT NULL
) ENGINE=InnoDB;
