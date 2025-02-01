-- Variables for admin credentials
DECLARE @AdminLoginID VARCHAR(50);
DECLARE @AdminPassword CHAR(8);

-- Assigning values to variables
SET @AdminLoginID = 'bob.smith';
SET @AdminPassword = 'dbadmin8';

-- Variables for transaction record
DECLARE @TransactionTimestamp DATETIME;
DECLARE @TransactionID UNIQUEIDENTIFIER;
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
    -- Insert course data
-- this query updates the value of syllabus column in the course table in the database
UPDATE Course 
    SET Syllabus = 'Introduction to Programming, Basics of C++, Data Structures' 
    WHERE Course_Code = 'CS101';
UPDATE Course 
    SET Syllabus = 'Basic Concepts of Thermodynamics, Thermodynamic Systems, Laws of Thermodynamics' 
    WHERE Course_Code = 'ME102';
UPDATE Course 
    SET Syllabus = 'Circuit Elements, Ohm\s Law, Kirchhoff\s Laws, AC/DC Circuits' 
    WHERE Course_Code = 'EE103';
UPDATE Course 
    SET Syllabus = 'Types of Structures, Analysis Techniques, Load Calculations' 
    WHERE Course_Code = 'CE104';
UPDATE Course 
    SET Syllabus = 'Binary Systems, Logic Gates, Digital Circuits' 
    WHERE Course_Code = 'EC105';
UPDATE Course 
    SET Syllabus = 'Database Models, SQL, Database Design, Transactions'
    WHERE Course_Code = 'IT106';
UPDATE Course 
    SET Syllabus = 'Process Design, Fluid Mechanics, Chemical Reactions' 
    WHERE Course_Code = 'CH107';
UPDATE Course 
    SET Syllabus = 'Fundamentals of Aerodynamics, Airfoil Design, Wind Tunnels' 
    WHERE Course_Code = 'AE108';
UPDATE Course 
    SET Syllabus = 'Genetic Modification, Cloning, CRISPR Technology' 
    WHERE Course_Code = 'BT109';
UPDATE Course 
    SET Syllabus = 'Metallurgical Processes, Heat Treatment, Metal Alloys' 
    WHERE Course_Code = 'MS110';
UPDATE Course 
    SET Syllabus = 'Water Cycle, Resource Management, Pollution Control' 
    WHERE Course_Code = 'EN111';
UPDATE Course 
    SET Syllabus = 'Medical Imaging Techniques, MRI, Ultrasound, X-rays' 
    WHERE Course_Code = 'BM112';
UPDATE Course 
    SET Syllabus = 'Reservoir Characterization, Drilling Techniques, Fluid Flow' 
    WHERE Course_Code = 'PE113';
UPDATE Course 
    SET Syllabus = 'Control Systems, Sensors, Actuators, Robotics Programming' 
    WHERE Course_Code = 'RO114';
UPDATE Course 
    SET Syllabus = 'Automotive Design Principles, Engine Mechanics, Vehicle Dynamics' 
    WHERE Course_Code = 'AU115';

-- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (2, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Course data has been updated and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
