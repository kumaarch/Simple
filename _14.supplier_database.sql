-- Create Supplier table
CREATE TABLE Supplier (
    Sup_No INT PRIMARY KEY,
    Sup_Name VARCHAR(50) NOT NULL,
    Item_Supplied VARCHAR(50),
    Item_Price DECIMAL(10,2),
    City VARCHAR(50)
);

-- a) Suppliers with names starting with 'S'
SELECT Sup_No, Sup_Name
FROM Supplier
WHERE Sup_Name LIKE 'S%';

-- b) Add contact number column
ALTER TABLE Supplier
ADD COLUMN CONTACTNO VARCHAR(15);

-- c) Chennai suppliers sorted by price
SELECT Sup_No, Sup_Name, Item_Price
FROM Supplier
WHERE City = 'Chennai'
ORDER BY Item_Price ASC;

-- d) Create supplier view
CREATE VIEW SupplierBasicInfo AS
SELECT Sup_No, Sup_Name
FROM Supplier;

-- e) Stored procedure demonstration
DELIMITER //
CREATE PROCEDURE GetSuppliers()
BEGIN
    SELECT * FROM Supplier;
END //
DELIMITER ;
