-- this query creates a transaction to add a new student in the students table using admin credentials
-- Variables for admin credentials and new student data
DECLARE @AdminLoginID VARCHAR(50);
DECLARE @AdminPassword CHAR(8);
DECLARE @RollNo INT;
DECLARE @Branch VARCHAR(50);
DECLARE @Semester INT;
DECLARE @Subjects VARCHAR(255);
DECLARE @Marks DECIMAL(5, 2);
DECLARE @Attendance DECIMAL(4, 2);
DECLARE @CGPA DECIMAL(4, 2);
DECLARE @SGPA DECIMAL(4, 2);
DECLARE @Projects VARCHAR(255);
DECLARE @CareerPreference VARCHAR(255);

-- Assigning values to variables
SET @AdminLoginID = 'alice.johnson';
SET @AdminPassword = 'pass1234';
SET @RollNo = 16;
SET @Branch = 'Data Science';
SET @Semester = 1;
SET @Subjects = 'Statistics, Machine Learning, Programming';
SET @Marks = 88.50;
SET @Attendance = 96.00;
SET @CGPA = 8.9;
SET @SGPA = 8.8;
SET @Projects = 'Project P';
SET @CareerPreference = 'Data Scientist';

-- Beginning transaction
BEGIN TRANSACTION;

-- Verify admin credentials
IF EXISTS (SELECT 1 FROM Admin WHERE Login_ID = @AdminLoginID AND Password = @AdminPassword)
BEGIN
    -- Insert new student data
    INSERT INTO Students (Roll_No, Branch, Semester, Subjects, Marks, Attendance, CGPA, SGPA, Projects, Career_Preference)
    VALUES (@RollNo, @Branch, @Semester, @Subjects, @Marks, @Attendance, @CGPA, @SGPA, @Projects, @CareerPreference);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'New student data inserted successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
