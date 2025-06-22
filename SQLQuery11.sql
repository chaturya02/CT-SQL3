DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Friends;
DROP TABLE IF EXISTS Packages;
-- Students Table
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO Students VALUES (1, 'Ashley');
INSERT INTO Students VALUES (2, 'Samantha');
INSERT INTO Students VALUES (3, 'Julia');
INSERT INTO Students VALUES (4, 'Scarlet');

-- Friends Table
CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

INSERT INTO Friends VALUES (1, 2);
INSERT INTO Friends VALUES (2, 3);
INSERT INTO Friends VALUES (3, 4);
INSERT INTO Friends VALUES (4, 1);

-- Packages Table
CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

INSERT INTO Packages VALUES (1, 15.20);
INSERT INTO Packages VALUES (2, 10.06);
INSERT INTO Packages VALUES (3, 11.55);
INSERT INTO Packages VALUES (4, 12.12);
SELECT S.Name
FROM Students S
JOIN Friends F ON S.ID = F.ID
JOIN Packages P1 ON S.ID = P1.ID
JOIN Packages P2 ON F.Friend_ID = P2.ID
WHERE P2.Salary > P1.Salary
ORDER BY P2.Salary * 1.0 DESC;


