CREATE TABLE Employees (
    emp_id INT,
    sub_band VARCHAR(10)
);
SELECT 
    COUNT(*) AS total_headcount,
    COUNT(CASE WHEN sub_band = 'A1' THEN 1 END) AS A1_count,
    COUNT(CASE WHEN sub_band = 'B1' THEN 1 END) AS B1_count,
    COUNT(CASE WHEN sub_band = 'C1' THEN 1 END) AS C1_count
FROM Employees;
