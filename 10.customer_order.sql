-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    C_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    City VARCHAR(50),
    Mobile_No VARCHAR(15)
);

-- Create ORDER table
CREATE TABLE `ORDER` (
    C_ID INT,
    P_ID INT,
    P_Name VARCHAR(50),
    P_COST DECIMAL(10,2),
    PRIMARY KEY (C_ID, P_ID),
    FOREIGN KEY (C_ID) REFERENCES CUSTOMER(C_ID)
);

-- a) List customers who ordered products costing more than 500
SELECT DISTINCT C.Name, C.Address
FROM CUSTOMER C
JOIN `ORDER` O ON C.C_ID = O.C_ID
WHERE O.P_COST > 500;

-- b) List product names with cost ≥1000
SELECT DISTINCT P_Name
FROM `ORDER`
WHERE P_COST >= 1000;

-- c) List product names ordered by customers from Delhi
SELECT DISTINCT O.P_Name
FROM `ORDER` O
JOIN CUSTOMER C ON O.C_ID = C.C_ID
WHERE C.City = 'Delhi';

-- d) Add Email column to CUSTOMER table
ALTER TABLE CUSTOMER
ADD COLUMN Email_id VARCHAR(100);

-- e) User-defined function to calculate total amount spent by a customer
DELIMITER //
CREATE FUNCTION GetTotalSpent(customer_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT COALESCE(SUM(P_COST), 0) INTO total
    FROM `ORDER`
    WHERE C_ID = customer_id;
    RETURN total;
END //
DELIMITER ;

-- Example usage:
SELECT C_ID, Name, GetTotalSpent(C_ID) AS Total_Spent FROM CUSTOMER;
