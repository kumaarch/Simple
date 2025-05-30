CREATE TABLE Employee (
    Emp_no INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Emp_dept VARCHAR(100),
    Job VARCHAR(100),
    Mgr INT,
    Sal DECIMAL(10,2)
);

-- a) Group By clause - Employees in a department
SELECT Emp_name, Sal
FROM Employee
WHERE Emp_dept = 'xxx'
GROUP BY Emp_dept, Emp_name, Sal;

-- b) Lowest-paid employee per department
SELECT e.*
FROM Employee e
INNER JOIN (
    SELECT Emp_dept, MIN(Sal) AS min_sal
    FROM Employee
    GROUP BY Emp_dept
) dept_min
ON e.Emp_dept = dept_min.Emp_dept AND e.Sal = dept_min.min_sal;

-- c) List employee names in descending order
SELECT Emp_name
FROM Employee
ORDER BY Emp_name DESC;

-- d) Rename column Mgr to Manager
ALTER TABLE Employee
CHANGE COLUMN Mgr Manager INT;

-- e) Trigger for automatic insertion into Employee table
CREATE TABLE NewHires (
    Emp_no INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Emp_dept VARCHAR(100),
    Job VARCHAR(100),
    Manager INT,
    Sal DECIMAL(10,2)
);

DELIMITER $$
CREATE TRIGGER after_newhire_insert
AFTER INSERT ON NewHires
FOR EACH ROW
BEGIN
    INSERT INTO Employee (Emp_no, Emp_name, Emp_dept, Job, Manager, Sal)
    VALUES (NEW.Emp_no, NEW.Emp_name, NEW.Emp_dept, NEW.Job, NEW.Manager, NEW.Sal);
END$$
DELIMITER ;
