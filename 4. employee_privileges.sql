-- Create DEPARTMENTS table
CREATE TABLE DEPARTMENTS (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(100),
    dept_location VARCHAR(100)
);

-- Create EMPLOYEES table
CREATE TABLE EMPLOYEES (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    emp_salary DECIMAL(10,2),
    dept_no INT,
    FOREIGN KEY (dept_no) REFERENCES DEPARTMENTS(dept_no)
);

-- a) Grant SELECT and INSERT privileges on EMPLOYEES to a user named hr_manager
GRANT SELECT, INSERT ON EMPLOYEES TO 'hr_manager'@'localhost';

-- b) Revoke all privileges from hr_manager
REVOKE ALL PRIVILEGES ON EMPLOYEES FROM 'hr_manager'@'localhost';

-- c) Revoke INSERT privilege from hr_manager
REVOKE INSERT ON EMPLOYEES FROM 'hr_manager'@'localhost';

-- d) Implement Savepoint in a transaction
START TRANSACTION;
INSERT INTO DEPARTMENTS (dept_no, dept_name, dept_location)
VALUES (10, 'IT', 'New York');
SAVEPOINT savepoint1;
INSERT INTO EMPLOYEES (emp_id, emp_name, emp_salary, dept_no)
VALUES (101, 'John Doe', 75000, 10);
ROLLBACK TO SAVEPOINT savepoint1;
COMMIT;

-- e) User-Defined Stored Procedure to calculate the average salary of employees in a department
DELIMITER $$
CREATE PROCEDURE GetAvgSalaryByDept(IN dept_id INT)
BEGIN
    SELECT AVG(emp_salary) AS avg_salary
    FROM EMPLOYEES
    WHERE dept_no = dept_id;
END$$
DELIMITER ;

-- Usage
CALL GetAvgSalaryByDept(10);
