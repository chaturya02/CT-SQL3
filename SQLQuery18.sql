CREATE TABLE EmployeeCost (
    month VARCHAR(7),
    BU VARCHAR(20),
    cost FLOAT,
    headcount INT
);
SELECT 
    month,
    BU,
    SUM(cost * headcount) / SUM(headcount) AS weighted_avg_cost
FROM EmployeeCost
GROUP BY month, BU;
