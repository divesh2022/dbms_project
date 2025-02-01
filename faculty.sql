-- Variables for admin credentials
DECLARE @AdminLoginID VARCHAR(50);
DECLARE @AdminPassword CHAR(8);

-- Assigning values to variables
SET @AdminLoginID = 'alice.johnson';
SET @AdminPassword = 'pass1234';

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

-- Beginning transaction
BEGIN TRANSACTION;

-- Verify admin credentials
IF EXISTS (SELECT 1 FROM Admin WHERE Login_ID = @AdminLoginID AND Password = @AdminPassword)
BEGIN
    -- Create Faculty table
    CREATE TABLE Faculty (
        Faculty_ID INT PRIMARY KEY,
        Name VARCHAR(100),
        Specialization VARCHAR(100),
        Login_ID VARCHAR(50),
        Contact_Info VARCHAR(100),
        Assigned_Classes VARCHAR(255),
        Timetable TEXT
    );

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Faculty table created and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
