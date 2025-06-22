DROP TABLE IF EXISTS Projects;

CREATE TABLE Projects (
    Task_ID INT,
    Start_Date DATE,
    End_Date DATE
);


INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');


WITH WithLag AS (
    SELECT *,
           LAG(End_Date) OVER (ORDER BY Start_Date) AS Prev_End_Date
    FROM Projects
),
Flags AS (
    SELECT *,
           CASE 
               WHEN Prev_End_Date = DATEADD(DAY, -1, Start_Date) THEN 0
               ELSE 1
           END AS Is_New_Project
    FROM WithLag
),
ProjectGroups AS (
    SELECT *,
           SUM(Is_New_Project) OVER (ORDER BY Start_Date ROWS UNBOUNDED PRECEDING) AS Project_ID
    FROM Flags
),
FinalProjects AS (
    SELECT 
        MIN(Start_Date) AS Start_Project,
        MAX(End_Date) AS End_Project,
        DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)) + 1 AS Duration
    FROM ProjectGroups
    GROUP BY Project_ID
)

SELECT Start_Project, End_Project
FROM FinalProjects
ORDER BY Duration ASC, Start_Project ASC;
