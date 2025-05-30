-- Create STUDENT table
CREATE TABLE STUDENT (
    RegNo INT PRIMARY KEY,
    StudName VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(15),
    Gender ENUM('M', 'F')
);

-- Create SUBJECT table
CREATE TABLE SUBJECT (
    Subcode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    Sem INT,
    Credits INT
);

-- Create MARKS table
CREATE TABLE MARKS (
    RegNo INT,
    Subcode VARCHAR(10),
    Test1 DECIMAL(5,2),
    Test2 DECIMAL(5,2),
    Test3 DECIMAL(5,2),
    Finalmark DECIMAL(5,2),
    PRIMARY KEY (RegNo, Subcode),
    FOREIGN KEY (RegNo) REFERENCES STUDENT(RegNo),
    FOREIGN KEY (Subcode) REFERENCES SUBJECT(Subcode)
);

-- a) Total Male/Female Students in Each Semester
SELECT
    s.Sem,
    st.Gender,
    COUNT(DISTINCT st.RegNo) AS Total_Students
FROM SUBJECT s
JOIN MARKS m ON s.Subcode = m.Subcode
JOIN STUDENT st ON m.RegNo = st.RegNo
GROUP BY s.Sem, st.Gender;

-- b) Update Finalmark as Average of Best Two Tests
UPDATE MARKS
SET Finalmark = (
    (Test1 + Test2 + Test3 - LEAST(Test1, Test2, Test3)) / 2
);

-- c) Categorize Students Based on Finalmark
SELECT
    RegNo,
    Subcode,
    Finalmark,
    CASE
        WHEN Finalmark BETWEEN 81 AND 100 THEN 'Outstanding'
        WHEN Finalmark BETWEEN 51 AND 80 THEN 'Average'
        ELSE 'Weak'
    END AS CAT
FROM MARKS;

-- d) View for Test3 Marks of a Specific Student
CREATE VIEW StudentTest3View AS
SELECT
    st.StudName,
    s.Title AS Subject,
    m.Test3
FROM MARKS m
JOIN STUDENT st ON m.RegNo = st.RegNo
JOIN SUBJECT s ON m.Subcode = s.Subcode;

-- Example usage for student with RegNo=101:
SELECT * FROM StudentTest3View WHERE RegNo = 101;

-- e) Stored Procedure to Add a New Student
DELIMITER $$
CREATE PROCEDURE AddStudent(
    IN p_RegNo INT,
    IN p_StudName VARCHAR(100),
    IN p_Address VARCHAR(200),
    IN p_Phone VARCHAR(15),
    IN p_Gender ENUM('M', 'F')
)
BEGIN
    INSERT INTO STUDENT (RegNo, StudName, Address, Phone, Gender)
    VALUES (p_RegNo, p_StudName, p_Address, p_Phone, p_Gender);
END$$
DELIMITER ;

-- Usage:
CALL AddStudent(101, 'John Doe', '123 Main St', '555-1234', 'M');
