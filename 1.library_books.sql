CREATE DATABASE library;
USE library;

-- Create PUBLISHER table
CREATE TABLE PUBLISHER (
    Name VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(255),
    Phone VARCHAR(15)
);

-- Create BOOK table
CREATE TABLE BOOK (
    Book_id INT PRIMARY KEY,
    Title VARCHAR(255),
    Publisher_Name VARCHAR(100),
    Pub_Year YEAR,
    No_of_copies INT,
    FOREIGN KEY (Publisher_Name) REFERENCES PUBLISHER(Name)
);

-- Create BOOK_AUTHORS table
CREATE TABLE BOOK_AUTHORS (
    Book_id INT,
    Author_Name VARCHAR(100),
    PRIMARY KEY (Book_id, Author_Name),
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
);

-- Retrieve book details
SELECT
    b.Book_id,
    b.Title,
    b.Publisher_Name,
    GROUP_CONCAT(a.Author_Name SEPARATOR ', ') AS Authors
FROM BOOK b
LEFT JOIN BOOK_AUTHORS a ON b.Book_id = a.Book_id
GROUP BY b.Book_id;

-- Create a stored procedure to get books by an author
DELIMITER $$
CREATE PROCEDURE GetBooksByAuthor(IN author_name VARCHAR(100))
BEGIN
    SELECT
        b.Book_id,
        b.Title,
        b.Publisher_Name,
        b.Pub_Year,
        b.No_of_copies
    FROM BOOK b
    JOIN BOOK_AUTHORS a ON b.Book_id = a.Book_id
    WHERE a.Author_Name = author_name;
END$$
DELIMITER ;

-- Usage 
CALL GetBooksByAuthor('J.K. Rowling'); 
