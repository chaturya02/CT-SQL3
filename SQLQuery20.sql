-- Drop existing tables if they exist
DROP TABLE IF EXISTS TableA;
DROP TABLE IF EXISTS TableB;

-- Step 1: Create TableA
CREATE TABLE TableA (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Step 2: Create TableB
CREATE TABLE TableB (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Step 3: Insert sample data into TableA
INSERT INTO TableA (id, name, age) VALUES
(1, 'Alice', 25),
(2, 'Bob', 30),
(3, 'Charlie', 28);

-- Step 4: Insert existing record into TableB to simulate duplicates
INSERT INTO TableB (id, name, age) VALUES
(2, 'Bob', 30);  -- Already exists in both

-- Step 5: Copy only non-existing records from TableA to TableB
INSERT INTO TableB (id, name, age)
SELECT A.id, A.name, A.age
FROM TableA A
WHERE NOT EXISTS (
    SELECT 1 FROM TableB B WHERE B.id = A.id
);

-- Step 6: Output TableB content to verify
SELECT * FROM TableB;
