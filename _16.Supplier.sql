-- 1. Create the Supplier table
CREATE TABLE Supplier (
    Sup_No INT PRIMARY KEY,
    Sup_Name VARCHAR(50) NOT NULL,
    Item_Supplied VARCHAR(50),
    Item_Price DECIMAL(10,2),
    City VARCHAR(50)
);

-- 2a. Display Supplier numbers and names whose names start with 'S'
SELECT Sup_No, Sup_Name
FROM Supplier
WHERE Sup_Name LIKE 'S%';

-- 2b. Add a new column called CONTACTNO
ALTER TABLE Supplier
ADD COLUMN CONTACTNO VARCHAR(15);

-- 2c. Display supplier numbers, names, and item prices for suppliers in Chennai
-- sorted in ascending order of item price
SELECT Sup_No, Sup_Name, Item_Price
FROM Supplier
WHERE City = 'Chennai'
ORDER BY Item_Price ASC;

-- 2d. Create a view to display only supplier numbers and names
CREATE VIEW SupplierBasicInfo AS
SELECT Sup_No, Sup_Name
FROM Supplier;

-- 2e. Create a stored procedure to display all records from Supplier table
DELIMITER //

CREATE PROCEDURE GetSuppliers()
BEGIN
    SELECT * FROM Supplier;
END //

DELIMITER ;

-- (Optional) To call the stored procedure and display suppliers:
-- CALL GetSuppliers();
