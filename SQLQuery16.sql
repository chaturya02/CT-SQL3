CREATE TABLE SwapTable (
    col1 INT,
    col2 INT
);
UPDATE SwapTable
SET col1 = col1 + col2,
    col2 = col1 - col2,
    col1 = col1 - col2;
