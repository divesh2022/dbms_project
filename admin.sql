-- create a entity admin in database
CREATE TABLE Admin (
    Admin_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Login_ID VARCHAR(50) UNIQUE,
    Password CHAR(8)
);
