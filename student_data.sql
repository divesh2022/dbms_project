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
    -- Insert data for all students
    INSERT INTO Student (Roll_No, Branch, Semester, Subjects, Marks, Attendance, CGPA, SGPA, Projects, Career_Preference)
    VALUES
    (1, 'Computer Science', 1, 'Math, Physics, Chemistry', 85.50, 95.00, 8.5, 8.3, 'Project A', 'Software Engineer'),
    (2, 'Mechanical Engineering', 1, 'Thermodynamics, Mechanics, Drawing', 78.25, 89.00, 7.8, 7.5, 'Project B', 'Mechanical Engineer'),
    (3, 'Electrical Engineering', 2, 'Circuits, Machines, Power Systems', 88.00, 92.50, 8.8, 8.7, 'Project C', 'Electrical Engineer'),
    (4, 'Civil Engineering', 2, 'Structures, Materials, Surveying', 80.75, 90.25, 8.0, 8.1, 'Project D', 'Civil Engineer'),
    (5, 'Electronics', 3, 'Digital, Analog, Communication', 82.30, 94.75, 8.3, 8.2, 'Project E', 'Electronics Engineer'),
    (6, 'Information Technology', 3, 'Programming, Networks, Databases', 90.50, 96.50, 9.0, 8.9, 'Project F', 'Data Scientist'),
    (7, 'Chemical Engineering', 4, 'Process, Fluid Mechanics, Heat Transfer', 76.80, 85.00, 7.6, 7.7, 'Project G', 'Chemical Engineer'),
    (8, 'Aerospace Engineering', 4, 'Aerodynamics, Propulsion, Materials', 89.60, 91.75, 8.9, 8.8, 'Project H', 'Aerospace Engineer'),
    (9, 'Biotechnology', 5, 'Genetics, Microbiology, Biochemistry', 84.25, 93.50, 8.4, 8.5, 'Project I', 'Biotechnologist'),
    (10, 'Materials Science', 5, 'Metallurgy, Polymers, Ceramics', 77.75, 87.25, 7.7, 7.8, 'Project J', 'Materials Engineer'),
    (11, 'Environmental Engineering', 6, 'Water Resources, Waste Management, Climate', 81.30, 88.75, 8.1, 8.0, 'Project K', 'Environmental Engineer'),
    (12, 'Biomedical Engineering', 6, 'Biomaterials, Medical Imaging, Biomechanics', 86.50, 92.00, 8.6, 8.4, 'Project L', 'Biomedical Engineer'),
    (13, 'Petroleum Engineering', 7, 'Reservoir, Drilling, Production', 79.40, 84.25, 7.9, 8.0, 'Project M', 'Petroleum Engineer'),
    (14, 'Robotics', 7, 'Control, Sensing, AI', 91.20, 95.50, 9.1, 9.0, 'Project N', 'Robotics Engineer'),
    (15, 'Automotive Engineering', 8, 'Engines, Powertrain, Design', 87.75, 90.50, 8.7, 8.6, 'Project O', 'Automotive Engineer');

    -- Insert transaction record
    INSERT INTO TransactionRecord (s_no, timestamp, transaction_id, status, admin)
    VALUES (1, @TransactionTimestamp, @TransactionID, @TransactionStatus, @AdminName);

    -- Commit transaction
    COMMIT TRANSACTION;
    PRINT 'Student data and transaction record added successfully.';
END
ELSE
BEGIN
    -- Rollback transaction if credentials are invalid
    ROLLBACK TRANSACTION;
    PRINT 'Invalid admin credentials. Transaction aborted.';
END;
