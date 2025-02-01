-- this query creates a transaction to add a new column named " NAME " in the students table using admins credentials
-- Variables for admin credentials
DECLARE @AdminLoginID1 VARCHAR(50);
DECLARE @AdminPassword1 CHAR(8);

-- Assigning values to variables
SET @AdminLoginID1 = 'alice.johnson';
SET @AdminPassword1 = 'pass1234';

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

-- Beginning transaction T1
BEGIN TRANSACTION T1;

-- Verify admin credentials for T1
IF EXISTS (SELECT 1 FROM Admin WHERE Login_ID = @AdminLoginID1 AND Password = @AdminPassword1)
BEGIN
    -- Add new column
    ALTER TABLE Student ADD Name VARCHAR(100);

        -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (2, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);


    -- Commit transaction T1
    COMMIT TRANSACTION T1;
    PRINT 'New column "Name" added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction T1 if credentials are invalid
    ROLLBACK TRANSACTION T1;
    PRINT 'Invalid admin credentials for T1. Transaction aborted.';
END;
