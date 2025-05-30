-- Create Bank table
CREATE TABLE Bank (
    S_No INT PRIMARY KEY AUTO_INCREMENT,
    Cust_Name VARCHAR(50) NOT NULL,
    Acc_No VARCHAR(20) UNIQUE NOT NULL,
    Balance DECIMAL(15,2) DEFAULT 0.00,
    Branch VARCHAR(50)
);

-- a) Select with WHERE clause
SELECT Cust_Name, Acc_No, Balance
FROM Bank
WHERE Branch = 'Main';

-- b) Select with comparison operator
SELECT *
FROM Bank
WHERE Balance > 5000;

-- c) Update balance in second row (assuming S_No=2)
UPDATE Bank
SET Balance = 7500.00
WHERE S_No = 2;

-- d) Select with BETWEEN for balance
SELECT Cust_Name, Acc_No
FROM Bank
WHERE Balance BETWEEN 1000 AND 10000;

-- e) Create trigger for low balance
-- First create notifications table
CREATE TABLE low_balance_notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    acc_no VARCHAR(20),
    balance DECIMAL(15,2),
    notification_date DATETIME
);

DELIMITER //
CREATE TRIGGER check_balance
AFTER UPDATE ON Bank
FOR EACH ROW
BEGIN
    IF NEW.Balance < 1000 THEN
        INSERT INTO low_balance_notifications (acc_no, balance, notification_date)
        VALUES (NEW.Acc_No, NEW.Balance, NOW());
    END IF;
END; //
DELIMITER ;
