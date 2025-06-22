CREATE TABLE OCCUPATIONS (
    Name VARCHAR(50),
    Occupation VARCHAR(50)
);

INSERT INTO OCCUPATIONS VALUES ('Samantha', 'Doctor');
INSERT INTO OCCUPATIONS VALUES ('Julia', 'Actor');
INSERT INTO OCCUPATIONS VALUES ('Maria', 'Actor');
INSERT INTO OCCUPATIONS VALUES ('Meera', 'Singer');
INSERT INTO OCCUPATIONS VALUES ('Ashley', 'Professor');
INSERT INTO OCCUPATIONS VALUES ('Ketty', 'Professor');
INSERT INTO OCCUPATIONS VALUES ('Chritseen', 'Professor');
INSERT INTO OCCUPATIONS VALUES ('Jane', 'Actor');
INSERT INTO OCCUPATIONS VALUES ('Jenny', 'Doctor');
INSERT INTO OCCUPATIONS VALUES ('Priya', 'Singer');
SELECT
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
    SELECT 
        Name, Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) AS ranked
GROUP BY rn
ORDER BY rn;
