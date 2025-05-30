-- Create Event table
CREATE TABLE Event (
    eventid INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    city VARCHAR(100)
);

-- Create Participant table with CHECK constraint for playerid
CREATE TABLE Participant (
    playerid VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    eventid INT,
    gender ENUM('M', 'F'),
    year INT,
    FOREIGN KEY (eventid) REFERENCES Event(eventid),
    CHECK (playerid REGEXP '[0-9]') -- At least one digit
);

-- Create Prizes table
CREATE TABLE Prizes (
    prizeid INT PRIMARY KEY,
    prize_money DECIMAL(10,2),
    eventid INT,
    rank INT,
    year INT,
    FOREIGN KEY (eventid) REFERENCES Event(eventid)
);

-- Create Winners table (junction table)
CREATE TABLE Winners (
    prizeid INT,
    playerid VARCHAR(20),
    PRIMARY KEY (prizeid, playerid),
    FOREIGN KEY (prizeid) REFERENCES Prizes(prizeid),
    FOREIGN KEY (playerid) REFERENCES Participant(playerid)
);

-- a) Events where all prize winners are female
SELECT e.name AS event_name
FROM Event e
WHERE NOT EXISTS (
    SELECT 1
    FROM Prizes p
    JOIN Winners w ON p.prizeid = w.prizeid
    JOIN Participant pt ON w.playerid = pt.playerid
    WHERE p.eventid = e.eventid AND pt.gender = 'M'
);

-- b) Non-updatable view of 1st prize winners with event names
CREATE VIEW FirstPrizeWinners AS
SELECT p.name AS participant_name, e.name AS event_name
FROM Participant p
JOIN Winners w ON p.playerid = w.playerid
JOIN Prizes pr ON w.prizeid = pr.prizeid
JOIN Event e ON pr.eventid = e.eventid
WHERE pr.rank = 1;

-- c) Trigger to auto-create 3 prizes when a new event is inserted
DELIMITER $$
CREATE TRIGGER after_event_insert
AFTER INSERT ON Event
FOR EACH ROW
BEGIN
    INSERT INTO Prizes (prize_money, eventid, rank, year)
    VALUES
        (1500, NEW.eventid, 1, YEAR(CURDATE())),
        (1000, NEW.eventid, 2, YEAR(CURDATE())),
        (500, NEW.eventid, 3, YEAR(CURDATE()));
END$$
DELIMITER ;
