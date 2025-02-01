-- Variables for admin credentials
DECLARE @AdminLoginID VARCHAR(50);
DECLARE @AdminPassword CHAR(8);

-- Assigning values to variables
SET @AdminLoginID = 'alice.johnson';
SET @AdminPassword = 'pass1234';

-- Variables for transaction record
DECLARE @TransactionTimestamp DATETIME;
DECLARE @TransactionID UNIQUEIDENTIFIER;
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
    -- Insert course data
    INSERT INTO Course (Course_Code, Branch, Semester, Course_Outcome, Subject, Credits, Syllabus, Marking_Scheme)
    VALUES
    ('CS101', 'Computer Science', 1, 'Understanding of basic programming', 'Programming 101', 4, '', 'Assignments, Midterm, Final Exam'),
    ('ME102', 'Mechanical Engineering', 1, 'Basics of Thermodynamics', 'Thermodynamics', 3, '', 'Quizzes, Projects, Final Exam'),
    ('EE103', 'Electrical Engineering', 2, 'Circuit Analysis Skills', 'Circuit Theory', 4, '', 'Homework, Labs, Final Exam'),
    ('CE104', 'Civil Engineering', 2, 'Structural Analysis Techniques', 'Structures', 4, '', 'Assignments, Projects, Final Exam'),
    ('EC105', 'Electronics', 3, 'Digital Logic Design', 'Digital Electronics', 4, '', 'Quizzes, Labs, Final Exam'),
    ('IT106', 'Information Technology', 3, 'Database Management Skills', 'Databases', 4, '', 'Projects, Midterm, Final Exam'),
    ('CH107', 'Chemical Engineering', 4, 'Chemical Process Design', 'Process Engineering', 4, '', 'Assignments, Projects, Final Exam'),
    ('AE108', 'Aerospace Engineering', 4, 'Aerodynamics Principles', 'Aerodynamics', 4, '', 'Quizzes, Projects, Final Exam'),
    ('BT109', 'Biotechnology', 5, 'Genetic Engineering Techniques', 'Genetic Engineering', 4, '', 'Homework, Labs, Final Exam'),
    ('MS110', 'Materials Science', 5, 'Metallurgical Processes', 'Metallurgy', 4, '', 'Assignments, Midterm, Final Exam'),
    ('EN111', 'Environmental Engineering', 6, 'Water Resource Management', 'Water Resources', 4, '', 'Projects, Quizzes, Final Exam'),
    ('BM112', 'Biomedical Engineering', 6, 'Biomedical Imaging Techniques', 'Medical Imaging', 4, '', 'Homework, Labs, Final Exam'),
    ('PE113', 'Petroleum Engineering', 7, 'Reservoir Engineering Principles', 'Reservoir Engineering', 4, '', 'Assignments, Projects, Final Exam'),
    ('RO114', 'Robotics', 7, 'Robotics Control Systems', 'Control Systems', 4, '', 'Quizzes, Labs, Final Exam'),
    ('AU115', 'Automotive Engineering', 8, 'Automotive Design Principles', 'Automotive Design', 4, '', 'Projects, Midterm, Final Exam');

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Course data and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
