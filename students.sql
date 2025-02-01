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
    -- Create Student table
    CREATE TABLE Students (
        Roll_No INT PRIMARY KEY,
        Branch VARCHAR(50),
        Semester INT,
        Subjects VARCHAR(255),
        Marks DECIMAL(5, 2),
        Attendance DECIMAL(4, 2),
        CGPA DECIMAL(4, 2),
        SGPA DECIMAL(4, 2),
        Projects VARCHAR(255),
        Career_Preference VARCHAR(255)
    );

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Student table created and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
