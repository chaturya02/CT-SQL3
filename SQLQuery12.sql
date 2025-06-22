CREATE TABLE Job_Costs (
    job_family VARCHAR(50),
    region VARCHAR(50),  -- 'India' or 'International'
    cost FLOAT
);
SELECT 
    job_family,
    SUM(CASE WHEN region = 'India' THEN cost ELSE 0 END) * 100.0 / SUM(cost) AS india_pct,
    SUM(CASE WHEN region = 'International' THEN cost ELSE 0 END) * 100.0 / SUM(cost) AS intl_pct
FROM Job_Costs
GROUP BY job_family;
