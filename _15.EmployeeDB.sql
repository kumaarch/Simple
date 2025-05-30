-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

-- 2. Create the Employees Table
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Create the Employee Audit Log Table
CREATE TABLE IF NOT EXISTS EmployeeAuditLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    action_type VARCHAR(10) NOT NULL, -- INSERT, UPDATE, DELETE
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON,
    changed_by VARCHAR(50) DEFAULT USER()
);

-- 4. Create the INSERT Trigger
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAuditLog (
        employee_id,
        action_type,
        new_data
    ) VALUES (
        NEW.employee_id,
        'INSERT',
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email,
            'department', NEW.department,
            'salary', NEW.salary,
            'hire_date', NEW.hire_date
        )
    );
END;
//
DELIMITER ;

-- 5. Create the UPDATE Trigger
DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAuditLog (
        employee_id,
        action_type,
        old_data,
        new_data
    ) VALUES (
        NEW.employee_id,
        'UPDATE',
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'email', OLD.email,
            'department', OLD.department,
            'salary', OLD.salary,
            'hire_date', OLD.hire_date
        ),
        JSON_OBJECT(
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'email', NEW.email,
            'department', NEW.department,
            'salary', NEW.salary,
            'hire_date', NEW.hire_date
        )
    );
END;
//
DELIMITER ;

-- 6. Create the DELETE Trigger
DELIMITER //
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAuditLog (
        employee_id,
        action_type,
        old_data
    ) VALUES (
        OLD.employee_id,
        'DELETE',
        JSON_OBJECT(
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'email', OLD.email,
            'department', OLD.department,
            'salary', OLD.salary,
            'hire_date', OLD.hire_date
        )
    );
END;
//
DELIMITER ;

-- 7. Test Operations
-- Insert a new employee
INSERT INTO Employees (first_name, last_name, email, department, salary, hire_date)
VALUES ('John', 'Doe', 'john.doe@example.com', 'IT', 75000.00, '2023-01-15');

-- Update the employee
UPDATE Employees
SET salary = 80000.00, department = 'Engineering'
WHERE employee_id = 1;

-- Delete the employee
DELETE FROM Employees WHERE employee_id = 1;

-- View the audit log
SELECT * FROM EmployeeAuditLog;

-- 8. Drop Triggers (Optional Cleanup)
DROP TRIGGER IF EXISTS after_employee_insert;
DROP TRIGGER IF EXISTS before_employee_update;
DROP TRIGGER IF EXISTS before_employee_delete;
