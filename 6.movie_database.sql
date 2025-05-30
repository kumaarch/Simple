-- Create ACTOR table
CREATE TABLE ACTOR (
    Act_id INT PRIMARY KEY,
    Act_Name VARCHAR(100),
    Act_Gender ENUM('M', 'F')
);

-- Create DIRECTOR table
CREATE TABLE DIRECTOR (
    Dir_id INT PRIMARY KEY,
    Dir_Name VARCHAR(100),
    Dir_Phone VARCHAR(15)
);

-- Create MOVIES table
CREATE TABLE MOVIES (
    Mov_id INT PRIMARY KEY,
    Mov_Title VARCHAR(100),
    Mov_Year YEAR,
    Mov_Lang VARCHAR(50),
    Dir_id INT,
    FOREIGN KEY (Dir_id) REFERENCES DIRECTOR(Dir_id)
);

-- Create MOVIE_CAST table
CREATE TABLE MOVIE_CAST (
    Act_id INT,
    Mov_id INT,
    Role VARCHAR(50),
    PRIMARY KEY (Act_id, Mov_id),
    FOREIGN KEY (Act_id) REFERENCES ACTOR(Act_id),
    FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id)
);

-- a) List Titles of Movies Directed by ‘XXXX’
SELECT m.Mov_Title
FROM MOVIES m
JOIN DIRECTOR d ON m.Dir_id = d.Dir_id
WHERE d.Dir_Name = 'XXXX';

-- b) Find Movie Names Where Actors Acted in ≥2 Movies
SELECT DISTINCT m.Mov_Title
FROM MOVIES m
JOIN MOVIE_CAST mc ON m.Mov_id = mc.Mov_id
WHERE mc.Act_id IN (
    SELECT Act_id
    FROM MOVIE_CAST
    GROUP BY Act_id
    HAVING COUNT(Mov_id) >= 2
);

-- c) List Actors in Movies Before 2010 AND After 2015 (Using JOIN)
SELECT DISTINCT a.Act_Name
FROM ACTOR a
JOIN MOVIE_CAST mc1 ON a.Act_id = mc1.Act_id
JOIN MOVIES m1 ON mc1.Mov_id = m1.Mov_id AND m1.Mov_Year < 2010
JOIN MOVIE_CAST mc2 ON a.Act_id = mc2.Act_id
JOIN MOVIES m2 ON mc2.Mov_id = m2.Mov_id AND m2.Mov_Year > 2015;

-- d) Create a View Linking Movies, Director, and a Specific Actor (e.g., 'John Doe')
CREATE VIEW MovieDirectorActorView AS
SELECT m.Mov_Title, d.Dir_Name, a.Act_Name
FROM MOVIES m
JOIN DIRECTOR d ON m.Dir_id = d.Dir_id
JOIN MOVIE_CAST mc ON m.Mov_id = mc.Mov_id
JOIN ACTOR a ON mc.Act_id = a.Act_id
WHERE a.Act_Name = 'John Doe';

-- e) User-Defined Function to Count Movies by Director
DELIMITER $$
CREATE FUNCTION GetMovieCountByDirector(dir_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE movie_count INT;
    SELECT COUNT(*) INTO movie_count
    FROM MOVIES
    WHERE Dir_id = dir_id;
    RETURN movie_count;
END$$
DELIMITER ;

-- Usage Example:
SELECT GetMovieCountByDirector(5); -- Returns the number of movies by director with Dir_id=5
