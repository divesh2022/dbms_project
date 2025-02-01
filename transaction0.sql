-- Variables for admin credentials
DECLARE @AdminLoginID VARCHAR(50);
DECLARE @AdminPassword CHAR(8);

-- Assigning values to variables
SET @AdminLoginID = 'bob.smith';
SET @AdminPassword = 'dbadmin8';

-- Variables for transaction record
DECLARE @TransactionTimestamp DATETIME;
DECLARE @TransactionID VARCHAR(50);
DECLARE @TransactionStatus VARCHAR(10);
DECLARE @AdminName VARCHAR(100);

-- Assigning values to transaction record
SET @TransactionTimestamp = GETDATE();
SET @TransactionID = NEWID();
SET @TransactionStatus = 'success';
SET @AdminName = 'bob.smith';

-- Beginning transaction
BEGIN TRANSACTION;

-- Verify admin credentials
IF EXISTS (SELECT 1 FROM Admin WHERE Login_ID = @AdminLoginID AND Password = @AdminPassword)
BEGIN
    -- Delete the Faculty table
    DROP TABLE IF EXISTS Faculty;

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (2, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Faculty table deleted and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
