CREATE DATABASE SampleDB;

USE SampleDB;

CREATE TABLE IF NOT EXISTS SampleTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

INSERT INTO SampleTable (ID, Name, Age) VALUES
(1, 'Alice', 30),   -- 1 + 0
(2, 'Bob', 25),     -- 0 + 0
(3, 'Charlie', 35), -- 1 + 0
(4, 'David', 28),   -- 1 + 1
(5, 'Eve', 22);     -- 0 + 1

SELECT * FROM SampleTable ORDER BY (Age > 25) + (ID > 3) DESC;
