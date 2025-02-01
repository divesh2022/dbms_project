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
    -- Insert data for admins 1 to 6
    INSERT INTO Admin (Admin_ID, Name, Role, Login_ID, Password)
    VALUES
    (2, 'Bob Smith', 'Database Administrator', 'bob.smith', 'dbadmin8'),
    (3, 'Charlie Brown', 'Network Administrator', 'charlie.brown', 'net12345'),
    (4, 'Diana Evans', 'Security Administrator', 'diana.evans', 'sec12345'),
    (5, 'Edward Green', 'Application Administrator', 'edward.green', 'admin789'),
    (6, 'Fiona White', 'IT Support Administrator', 'fiona.white', 'itsupp12');

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Admin data and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
