CREATE TABLE EmployeeSalaries (
    emp_id INT,
    recorded_salary FLOAT
);
SELECT emp_id,
       recorded_salary,
       CAST(REPLACE(CAST(recorded_salary AS VARCHAR), '0', '') AS FLOAT) AS actual_salary,
       CEILING(ABS(recorded_salary - CAST(REPLACE(CAST(recorded_salary AS VARCHAR), '0', '') AS FLOAT))) AS error
FROM EmployeeSalaries;
