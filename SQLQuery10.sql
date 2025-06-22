-- Company Table
CREATE TABLE Company (
    company_code VARCHAR(10),
    founder VARCHAR(50)
);

INSERT INTO Company VALUES ('C1', 'Monika');
INSERT INTO Company VALUES ('C2', 'Samantha');

-- Lead_Manager Table
CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

INSERT INTO Lead_Manager VALUES ('LM1', 'C1');
INSERT INTO Lead_Manager VALUES ('LM2', 'C2');

-- Senior_Manager Table
CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

INSERT INTO Senior_Manager VALUES ('SM1', 'LM1', 'C1');
INSERT INTO Senior_Manager VALUES ('SM2', 'LM1', 'C1');
INSERT INTO Senior_Manager VALUES ('SM3', 'LM2', 'C2');

-- Manager Table
CREATE TABLE Manager (
    manager_code VARCHAR(10),
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

INSERT INTO Manager VALUES ('M1', 'SM1', 'LM1', 'C1');
INSERT INTO Manager VALUES ('M2', 'SM3', 'LM2', 'C2');
INSERT INTO Manager VALUES ('M3', 'SM3', 'LM2', 'C2');

-- Employee Table
CREATE TABLE Employee (
    employee_code VARCHAR(10),
    manager_code VARCHAR(10),
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

INSERT INTO Employee VALUES ('E1', 'M1', 'SM1', 'LM1', 'C1');
INSERT INTO Employee VALUES ('E2', 'M1', 'SM1', 'LM1', 'C1');
INSERT INTO Employee VALUES ('E3', 'M2', 'SM3', 'LM2', 'C2');
INSERT INTO Employee VALUES ('E4', 'M3', 'SM3', 'LM2', 'C2');
SELECT 
    C.company_code,
    C.founder,
    COUNT(DISTINCT LM.lead_manager_code) AS lead_manager_count,
    COUNT(DISTINCT SM.senior_manager_code) AS senior_manager_count,
    COUNT(DISTINCT M.manager_code) AS manager_count,
    COUNT(DISTINCT E.employee_code) AS employee_count
FROM Company C
LEFT JOIN Lead_Manager LM ON C.company_code = LM.company_code
LEFT JOIN Senior_Manager SM ON C.company_code = SM.company_code
LEFT JOIN Manager M ON C.company_code = M.company_code
LEFT JOIN Employee E ON C.company_code = E.company_code
GROUP BY C.company_code, C.founder
ORDER BY C.company_code;
