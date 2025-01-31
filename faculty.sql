-- create a entity faculty in the database
CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Login_ID VARCHAR(50) UNIQUE,
    Contact_Info VARCHAR(255),
    Assigned_Classes TEXT,
    Timetable TEXT
);
