DROP TABLE IF EXISTS Contests;
DROP TABLE IF EXISTS Colleges;
DROP TABLE IF EXISTS Challenges;
DROP TABLE IF EXISTS View_Stats;
DROP TABLE IF EXISTS Submission_Stats;

CREATE TABLE Contests (
    contest_id INT,
    hacker_id INT,
    name VARCHAR(50)
);

CREATE TABLE Colleges (
    college_id INT,
    contest_id INT
);

CREATE TABLE Challenges (
    challenge_id INT,
    college_id INT
);

CREATE TABLE View_Stats (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
);

CREATE TABLE Submission_Stats (
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

INSERT INTO Contests VALUES
(66406, 17973, 'Rose'),
(66556, 79153, 'Angela'),
(94828, 80275, 'Frank');

INSERT INTO Colleges VALUES
(11219, 66406),
(32473, 66556),
(56685, 94828);

INSERT INTO Challenges VALUES
(18765, 11219),
(47127, 11219),
(60292, 32473),
(72974, 56685),
(75516, 56685);

INSERT INTO View_Stats VALUES
(47127, 26, 19),
(47127, 15, 14),
(18765, 43, 10),
(18765, 72, 13),
(75516, 35, 17),
(60292, 11, 10),
(72974, 41, 15),
(75516, 75, 11);

INSERT INTO Submission_Stats VALUES
(75516, 34, 12),
(47127, 27, 10),
(47127, 56, 18),
(75516, 74, 12),
(75516, 83, 8),
(72974, 68, 24),
(72974, 82, 14),
(47127, 28, 11);

WITH SubmissionAgg AS (
    SELECT ch.challenge_id, col.contest_id,
           SUM(s.total_submissions) AS total_submissions,
           SUM(s.total_accepted_submissions) AS total_accepted_submissions
    FROM Challenges ch
    JOIN Colleges col ON ch.college_id = col.college_id
    LEFT JOIN Submission_Stats s ON ch.challenge_id = s.challenge_id
    GROUP BY ch.challenge_id, col.contest_id
),
ViewAgg AS (
    SELECT ch.challenge_id, col.contest_id,
           SUM(v.total_views) AS total_views,
           SUM(v.total_unique_views) AS total_unique_views
    FROM Challenges ch
    JOIN Colleges col ON ch.college_id = col.college_id
    LEFT JOIN View_Stats v ON ch.challenge_id = v.challenge_id
    GROUP BY ch.challenge_id, col.contest_id
),
Combined AS (
    SELECT 
        COALESCE(sa.contest_id, va.contest_id) AS contest_id,
        COALESCE(sa.total_submissions, 0) AS total_submissions,
        COALESCE(sa.total_accepted_submissions, 0) AS total_accepted_submissions,
        COALESCE(va.total_views, 0) AS total_views,
        COALESCE(va.total_unique_views, 0) AS total_unique_views
    FROM SubmissionAgg sa
    FULL OUTER JOIN ViewAgg va 
        ON sa.challenge_id = va.challenge_id
)

SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    SUM(co.total_submissions) AS total_submissions,
    SUM(co.total_accepted_submissions) AS total_accepted_submissions,
    SUM(co.total_views) AS total_views,
    SUM(co.total_unique_views) AS total_unique_views
FROM Contests c
JOIN Combined co ON c.contest_id = co.contest_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
    SUM(co.total_submissions) > 0 OR
    SUM(co.total_accepted_submissions) > 0 OR
    SUM(co.total_views) > 0 OR
    SUM(co.total_unique_views) > 0
ORDER BY c.contest_id;

