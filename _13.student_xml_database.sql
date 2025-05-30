-- Create STUDENT table
CREATE TABLE STUDENT (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_Of_Birth DATE,
    Email VARCHAR(100) UNIQUE,
    Major VARCHAR(50),
    Enrollment_Date DATE,
    GPA DECIMAL(3,2),
    Is_Active BOOLEAN DEFAULT TRUE
);

-- Create COURSES table
CREATE TABLE COURSES (
    Course_ID INT PRIMARY KEY,
    Course_Code VARCHAR(20),
    Course_Name VARCHAR(100),
    Credits INT
);

-- Create STUDENT_COURSES table
CREATE TABLE STUDENT_COURSES (
    Enrollment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    Grade VARCHAR(2),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES COURSES(Course_ID)
);

-- a) Retrieve all students enrolled in a specific course
SELECT s.First_Name, s.Last_Name, c.Course_Name
FROM STUDENT s
JOIN STUDENT_COURSES sc ON s.Student_ID = sc.Student_ID
JOIN COURSES c ON sc.Course_ID = c.Course_ID
WHERE c.Course_Code = 'CS101';

-- b) Create a view for student course enrollment details
CREATE VIEW StudentCourseView AS
SELECT s.Student_ID, s.First_Name, s.Last_Name, c.Course_Name, sc.Enrollment_Date, sc.Grade
FROM STUDENT s
JOIN STUDENT_COURSES sc ON s.Student_ID = sc.Student_ID
JOIN COURSES c ON sc.Course_ID = c.Course_ID;

-- c) Stored procedure to get student details by ID
DELIMITER $$
CREATE PROCEDURE GetStudentDetails(IN student_id INT)
BEGIN
    SELECT * FROM STUDENT WHERE Student_ID = student_id;
END$$
DELIMITER ;

-- Usage:
CALL GetStudentDetails(101);
