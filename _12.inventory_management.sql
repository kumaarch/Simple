-- Create Product table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Customer table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100)
);

-- Create Orders table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Create Order_Details table
CREATE TABLE Order_Details (
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- a) Retrieve all products in a specific category
SELECT * FROM Product WHERE Category = 'Groceries';

-- b) Update stock after an order is placed
DELIMITER $$
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON Order_Details
FOR EACH ROW
BEGIN
    UPDATE Product
    SET Stock = Stock - NEW.Quantity
    WHERE Product_ID = NEW.Product_ID;
END$$
DELIMITER ;

-- c) View for customer order history
CREATE VIEW CustomerOrderHistory AS
SELECT c.Name, o.Order_ID, o.Order_Date, o.Total_Amount
FROM Customer c
JOIN Orders o ON c.Customer_ID = o.Customer_ID;

-- d) Stored procedure to calculate total sales for a given date
DELIMITER $$
CREATE PROCEDURE GetTotalSales(IN order_date DATE)
BEGIN
    SELECT SUM(Total_Amount) AS Total_Sales
    FROM Orders
    WHERE Order_Date = order_date;
END$$
DELIMITER ;

-- Usage:
CALL GetTotalSales('2025-05-30');
