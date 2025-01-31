-- create a entity course in database
CREATE TABLE Course (
    Course_Code VARCHAR(20) PRIMARY KEY,
    Branch VARCHAR(50),
    Semester INT,
    Course_Outcome VARCHAR(255),
    Subject VARCHAR(255),
    Credits INT,
    Syllabus TEXT,
    Marking_Scheme VARCHAR(255)
);
