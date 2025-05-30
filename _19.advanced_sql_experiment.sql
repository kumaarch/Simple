-- Create a sample table for demonstration
CREATE TABLE SampleData (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(50),
    Value DECIMAL(10,2)
);

-- a) Retrieve records where Value is greater than the average Value
SELECT * FROM SampleData
WHERE Value > (SELECT AVG(Value) FROM SampleData);

-- b) Find duplicate entries based on Name
SELECT Name, COUNT(*) AS DuplicateCount
FROM SampleData
GROUP BY Name
HAVING COUNT(*) > 1;

-- c) Rank records based on Value using ROW_NUMBER()
SELECT ID, Name, Value,
       ROW_NUMBER() OVER (ORDER BY Value DESC) AS Rank
FROM SampleData;

-- d) Create a stored procedure to update a record based on ID
DELIMITER $$
CREATE PROCEDURE UpdateRecord(IN record_id INT, IN new_value DECIMAL(10,2))
BEGIN
    UPDATE SampleData
    SET Value = new_value
    WHERE ID = record_id;
END$$
DELIMITER ;

-- Usage:
CALL UpdateRecord(1, 500.00);
