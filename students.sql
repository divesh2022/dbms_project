-- create a table student
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
