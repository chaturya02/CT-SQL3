CREATE TABLE Employees (
    emp_id INT,
    salary FLOAT
);
SELECT emp_id, salary
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employees
) AS ranked
WHERE rnk <= 5;
