-- Create SALESMAN table
CREATE TABLE SALESMAN (
    Salesman_id INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    Commission DECIMAL(10,2) DEFAULT 0
);

-- Create CUSTOMER table
CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Cust_Name VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    Grade INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id) ON DELETE SET NULL
);

-- Create ORDERS table
CREATE TABLE ORDERS (
    Ord_No INT PRIMARY KEY,
    Purchase_Amt DECIMAL(10,2) NOT NULL,
    Ord_Date DATE NOT NULL,
    Customer_id INT,
    Salesman_id INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id),
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id) ON DELETE CASCADE
);

-- a) Find salesmen with more than one customer
SELECT S.Salesman_id, S.Name, S.City, COUNT(C.Customer_id) AS Customer_Count
FROM SALESMAN S
JOIN CUSTOMER C ON S.Salesman_id = C.Salesman_id
GROUP BY S.Salesman_id
HAVING COUNT(C.Customer_id) > 1;

-- b) Salesmen with/without local customers using UNION
SELECT S.Salesman_id, S.Name, 'Has Customer in City' AS Status
FROM SALESMAN S
WHERE EXISTS (
    SELECT 1 FROM CUSTOMER C WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City
)
UNION
SELECT S.Salesman_id, S.Name, 'No Customer in City'
FROM SALESMAN S
WHERE NOT EXISTS (
    SELECT 1 FROM CUSTOMER C WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City
);

-- c) View for highest daily order salesman
CREATE VIEW TopDailySalesman AS
SELECT O.Ord_Date, S.Salesman_id, S.Name, MAX(O.Purchase_Amt) AS Max_Purchase
FROM ORDERS O
JOIN SALESMAN S ON O.Salesman_id = S.Salesman_id
GROUP BY O.Ord_Date;

-- d) Delete salesman 1000 and all his orders
DELETE FROM SALESMAN WHERE Salesman_id = 1000;

-- e) Triggers
-- Trigger 1: Update commission on new order
DELIMITER //
CREATE TRIGGER UpdateCommission
AFTER INSERT ON ORDERS
FOR EACH ROW
BEGIN
    UPDATE SALESMAN
    SET Commission = Commission + (NEW.Purchase_Amt * 0.05)
    WHERE Salesman_id = NEW.Salesman_id;
END//
DELIMITER ;

-- Trigger 2: Prevent negative purchase amounts
DELIMITER //
CREATE TRIGGER ValidatePurchaseAmount
BEFORE INSERT ON ORDERS
FOR EACH ROW
BEGIN
    IF NEW.Purchase_Amt < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Purchase amount cannot be negative';
    END IF;
END//
DELIMITER ;
