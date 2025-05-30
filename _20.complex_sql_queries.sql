-- Create a sample table for demonstration
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Amount DECIMAL(10,2),
    Transaction_Date DATE
);

-- a) Retrieve transactions where Amount is above the average transaction amount
SELECT * FROM Transactions
WHERE Amount > (SELECT AVG(Amount) FROM Transactions);

-- b) Find customers who have made more than 3 transactions
SELECT Customer_Name, COUNT(*) AS Transaction_Count
FROM Transactions
GROUP BY Customer_Name
HAVING COUNT(*) > 3;

-- c) Rank transactions based on Amount using RANK()
SELECT Transaction_ID, Customer_Name, Amount,
       RANK() OVER (ORDER BY Amount DESC) AS Rank
FROM Transactions;

-- d) Create a stored procedure to update transaction amount based on ID
DELIMITER $$
CREATE PROCEDURE UpdateTransaction(IN transaction_id INT, IN new_amount DECIMAL(10,2))
BEGIN
    UPDATE Transactions
    SET Amount = new_amount
    WHERE Transaction_ID = transaction_id;
END$$
DELIMITER ;

-- Usage:
CALL UpdateTransaction(1, 1000.00);
