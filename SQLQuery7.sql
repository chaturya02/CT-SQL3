DECLARE @i INT = 2, @j INT, @isPrime BIT, @output VARCHAR(MAX) = '';

WHILE @i <= 1000
BEGIN
    SET @isPrime = 1;
    SET @j = 2;
    WHILE @j * @j <= @i
    BEGIN
        IF @i % @j = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @j += 1;
    END

    IF @isPrime = 1
        SET @output += CAST(@i AS VARCHAR) + '&';

    SET @i += 1;
END

-- Remove last '&' and print
SELECT LEFT(@output, LEN(@output) - 1) AS Prime_Numbers;
