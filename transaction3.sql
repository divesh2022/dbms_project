-- this query creates a transaction to add datavalues in column NAME the students table using admins credentials
-- Variables for admin credentials
DECLARE @AdminLoginID2 VARCHAR(50);
DECLARE @AdminPassword2 CHAR(8);

-- Assigning values to variables
SET @AdminLoginID2 = 'alice.johnson';
SET @AdminPassword2 = 'pass1234';

-- Variables for transaction record
DECLARE @TransactionTimestamp DATETIME;
DECLARE @TransactionID VARCHAR(50);
DECLARE @TransactionStatus VARCHAR(10);
DECLARE @AdminName VARCHAR(100);

-- Assigning values to transaction record
SET @TransactionTimestamp = GETDATE();
SET @TransactionID = NEWID();
SET @TransactionStatus = 'success';
SET @AdminName = 'alice.johnson';

-- Beginning transaction T2
BEGIN TRANSACTION T2;

-- Verify admin credentials for T2
IF EXISTS (SELECT 1 FROM Admin WHERE Login_ID = @AdminLoginID2 AND Password = @AdminPassword2)
BEGIN
    -- Update new column with data values
    UPDATE Student SET Name = 
    CASE Roll_No
        WHEN 1 THEN 'John Doe'
        WHEN 2 THEN 'Jane Smith'
        WHEN 3 THEN 'Robert Brown'
        WHEN 4 THEN 'Emily Davis'
        WHEN 5 THEN 'Michael Wilson'
        WHEN 6 THEN 'Olivia Johnson'
        WHEN 7 THEN 'William Jones'
        WHEN 8 THEN 'Ava Martinez'
        WHEN 9 THEN 'James Garcia'
        WHEN 10 THEN 'Sophia Anderson'
        WHEN 11 THEN 'Benjamin Thomas'
        WHEN 12 THEN 'Isabella Lee'
        WHEN 13 THEN 'Lucas Harris'
        WHEN 14 THEN 'Mia Clark'
        WHEN 15 THEN 'Alexander Young'
        ELSE 'Unnamed Student'
    END;
        -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);


    -- Commit transaction T2
    COMMIT TRANSACTION T2;
    PRINT 'Data values updated successfully.';
END
ELSE
BEGIN
    -- Rollback transaction T2 if credentials are invalid
    ROLLBACK TRANSACTION T2;
    PRINT 'Invalid admin credentials for T2. Transaction aborted.';
END;
