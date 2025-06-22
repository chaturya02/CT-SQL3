DROP TABLE IF EXISTS Hackers;
DROP TABLE IF EXISTS Submissions;

CREATE TABLE Hackers (
    hacker_id INT,
    name VARCHAR(100)
);

CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT,
    hacker_id INT,
    score INT
);

INSERT INTO Hackers (hacker_id, name) VALUES
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

INSERT INTO Submissions VALUES
-- 2016-03-01
('2016-03-01', 1001, 20703, 30),
('2016-03-01', 1002, 20703, 50),
('2016-03-01', 1003, 15758, 40),
('2016-03-01', 1004, 36396, 20),
('2016-03-01', 1005, 79722, 10),

-- 2016-03-02
('2016-03-02', 1006, 79722, 60),
('2016-03-02', 1007, 79722, 30),
('2016-03-02', 1008, 15758, 20),

-- 2016-03-03
('2016-03-03', 1009, 20703, 20),
('2016-03-03', 1010, 20703, 15),
('2016-03-03', 1011, 62529, 10),

-- 2016-03-04
('2016-03-04', 1012, 20703, 10),
('2016-03-04', 1013, 20703, 15),
('2016-03-04', 1014, 53473, 25),

-- 2016-03-05
('2016-03-05', 1015, 36396, 45),

-- 2016-03-06
('2016-03-06', 1016, 20703, 80);
WITH submission_counts AS (
    SELECT submission_date, hacker_id, COUNT(*) AS submission_count
    FROM Submissions
    GROUP BY submission_date, hacker_id
),
ranked_submissions AS (
    SELECT
        submission_date,
        hacker_id,
        submission_count,
        RANK() OVER (
            PARTITION BY submission_date 
            ORDER BY submission_count DESC, hacker_id ASC
        ) AS rnk
    FROM submission_counts
),
top_hackers AS (
    SELECT 
        r.submission_date,
        r.hacker_id,
        h.name,
        (SELECT COUNT(DISTINCT s.hacker_id)
         FROM Submissions s
         WHERE s.submission_date = r.submission_date) AS total_unique
    FROM ranked_submissions r
    JOIN Hackers h ON r.hacker_id = h.hacker_id
    WHERE r.rnk = 1
)
SELECT 
    submission_date, 
    total_unique, 
    hacker_id, 
    name
FROM top_hackers
ORDER BY submission_date;
