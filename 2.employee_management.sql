CREATE TABLE employee (
    S_No INT PRIMARY KEY,
    Name VARCHAR(100),
    Designation VARCHAR(100),
    Branch VARCHAR(100)
);

-- Alter the table by adding a salary column
ALTER TABLE employee
ADD COLUMN salary DECIMAL(10,2);

-- Copy the employee table into a new table Emp
CREATE TABLE Emp AS SELECT * FROM employee;

-- Delete the 2nd row from the table
DELETE FROM employee WHERE S_No = 2;

-- Drop the employee table
DROP TABLE employee;

-- Add a last_updated column
ALTER TABLE employee
ADD COLUMN last_updated TIMESTAMP;

-- Create a trigger to update last_updated on row update
DELIMITER $$
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP();
END$$
DELIMITER ;
