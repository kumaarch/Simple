-- Create Account table
CREATE TABLE Account (
    Account_No VARCHAR(20) PRIMARY KEY,
    Cust_Name VARCHAR(50) NOT NULL,
    Branch_Name VARCHAR(50),
    Account_Balance DECIMAL(15,2) DEFAULT 0.00,
    Account_Type VARCHAR(20)
);

-- a) Display customers of specific branch
SELECT Cust_Name, Account_No
FROM Account
WHERE Branch_Name = 'XXXXX';

-- b) High balance accounts
SELECT Cust_Name, Account_Type
FROM Account
WHERE Account_Balance > 10000;

-- c) Add Date of Birth column
ALTER TABLE Account
ADD COLUMN Cust_Date_of_Birth DATE;

-- d) Low balance accounts
SELECT Account_No, Cust_Name, Branch_Name
FROM Account
WHERE Account_Balance < 1000;

-- e) Create stored procedure to retrieve customer details
DELIMITER //
CREATE PROCEDURE GetCustomerDetails(
    IN branch_name VARCHAR(50),
    IN min_balance DECIMAL(15,2)
)
BEGIN
    SELECT Account_No, Cust_Name, Branch_Name, Account_Balance, Account_Type
    FROM Account
    WHERE Branch_Name = branch_name
    AND Account_Balance >= min_balance;
END //
DELIMITER ;

-- Usage:
CALL GetCustomerDetails('Main', 5000);
