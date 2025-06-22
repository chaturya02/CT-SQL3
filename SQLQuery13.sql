CREATE TABLE BU_Financials (
    BU VARCHAR(50),
    month VARCHAR(7), -- 'YYYY-MM'
    cost FLOAT,
    revenue FLOAT
);
SELECT 
    BU,
    month,
    cost,
    revenue,
    LAG(cost) OVER (PARTITION BY BU ORDER BY month) AS prev_cost,
    LAG(revenue) OVER (PARTITION BY BU ORDER BY month) AS prev_revenue,
    (cost - LAG(cost) OVER (PARTITION BY BU ORDER BY month)) AS cost_diff,
    (revenue - LAG(revenue) OVER (PARTITION BY BU ORDER BY month)) AS revenue_diff
FROM BU_Financials;
