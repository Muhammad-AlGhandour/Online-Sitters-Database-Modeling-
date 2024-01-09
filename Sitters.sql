-- Drop the database if it exists
DROP DATABASE IF EXISTS Sitters;

-- Create the database
CREATE DATABASE Sitters1;

-- Activating Sitters
USE Sitters1;

-- Create the User table
CREATE TABLE [User] (
    userID INT Primary Key identity(1,1),
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    mobile_number VARCHAR(15) NOT NULL,
  
);

-- Create the Family_rep table
CREATE TABLE Family_rep (
    userID INT NOT NULL,
    occupation VARCHAR(255) NOT NULL,
    marital_status VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(userID),
	FOREIGN KEY (userID) REFERENCES [User] (userID) ON DELETE CASCADE
);

-- Create the Nanny table
CREATE TABLE Nanny (
    userID INT PRIMARY KEY,
    ssn VARCHAR(11) NOT NULL,
    highest_edu VARCHAR(255),
    gender VARCHAR(10) NOT NULL,
    availability VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (userID) REFERENCES [User](userID) ON DELETE CASCADE
);

-- Create the Nanny_skill table
CREATE TABLE Nanny_skill (
    userID INT,
    skill VARCHAR(255),
    
    PRIMARY KEY (userID, skill),
    FOREIGN KEY (userID) REFERENCES [User] (userID) ON DELETE CASCADE
);

-- Create the Contract table
CREATE TABLE Contract (
    contractID INT Identity(1,1),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    pay_per_hour DECIMAL(10, 2) NOT NULL,
    
    PRIMARY KEY(contractID)
);

-- Create the Contract_schedule table
CREATE TABLE Contract_schedule (
    contractID INT,
    start_date_time DATETIME,
    end_date_time DATETIME NOT NULL,
    description VARCHAR(255),
    
    PRIMARY KEY (contractID, start_date_time),
    FOREIGN KEY (contractID) REFERENCES Contract(contractID) ON DELETE CASCADE
);

-- Create the Child table
CREATE TABLE Child (
    child_key INT IDENTITY(1,1),
    userID INT,
    birth_date DATE NOT NULL,
    child_name VARCHAR(255) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    
	PRIMARY KEY (child_key, userID),
    FOREIGN KEY (userID) REFERENCES [User](userID) ON DELETE CASCADE
);

-- Create the Child_Preferences table
CREATE TABLE Child_Preferences (
    child_key INT,
    userID INT,
    preference VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (child_key, userID, preference),
    FOREIGN KEY (child_key,userID) REFERENCES Child(child_key,userID) ON DELETE CASCADE,
    
);

-- Create the Child_Disability table
CREATE TABLE Child_Disability (
    child_key INT,
    userID INT,
    disability VARCHAR(255),
    
    PRIMARY KEY (child_key, userID, disability),
    FOREIGN KEY (child_key,userID) REFERENCES Child(child_key,userID) ON DELETE CASCADE,
);

-- Create the Family_rep_sign_contract table
CREATE TABLE Family_rep_sign_contract (
    child_key INT,
    userID INT,
    contractID INT,
    
    PRIMARY KEY (contractID),
    FOREIGN KEY (child_key,userID) REFERENCES Child(child_key,userId) ON DELETE CASCADE,
    FOREIGN KEY (contractID) REFERENCES Contract(contractID) ON DELETE CASCADE
);

-- Create the Nanny_sign_contract table
CREATE TABLE Nanny_sign_contract (
    userID INT,
    contractID INT,
    
    PRIMARY KEY (contractID),
    FOREIGN KEY (userID) REFERENCES [User](userID) ON DELETE CASCADE,
    FOREIGN KEY (contractID) REFERENCES Contract(contractID) ON DELETE CASCADE
);

-- Inserting data into the User table
INSERT INTO [User] (email, address, fullname, birthdate, mobile_number) VALUES 
('user1@example.com', '23 Main St', 'John Wick', '1990-01-15', '123-456-7890'),
('user2@example.com', '123 Main St', 'Mary', '1995-01-15', '123-456-790');

-- Inserting data into the Family_rep table
INSERT INTO Family_rep (userID, occupation, marital_status)
VALUES (1, 'Engineer', 'Married');

-- Inserting data into the Nanny table
INSERT INTO Nanny (userID, ssn, highest_edu, gender, availability)
VALUES (2, '123-45-6789', 'Bachelor of Science', 'Female', 'Full-time');

-- Inserting  data into the Nanny_skill table
INSERT INTO Nanny_skill (userID, skill) VALUES
(2, 'Child Care'),
(2, 'First Aid');

-- Insert data into Contract table
INSERT INTO Contract (start_date, end_date, pay_per_hour)
VALUES ('2023-01-01', '2023-12-31', 32.50);

-- Insert sample data into the Contract_schedule table
INSERT INTO Contract_schedule (contractID, start_date_time, end_date_time, description)
VALUES (1, '2023-01-01 08:00:00', '2023-01-01 17:00:00', 'Monday Schedule please walk john for 1 hour');

-- Insert sample data into the Child table
INSERT INTO Child (userID, birth_date, child_name, gender)
VALUES (1, '2010-05-10', 'John Wick Jr', 'Male');

-- Insert sample data into the Child_Preferences table
INSERT INTO Child_Preferences (child_key, userID, preference) VALUES 
(1, 1, 'Play outdoors'),
(1,1,'Likes watching tv shows');

-- Insert sample data into the Child_Disability table
INSERT INTO Child_Disability (child_key, userID, disability)
VALUES (1, 1, 'Allergy to peanuts');

-- Insert sample data into the Family_rep_sign_contract table
INSERT INTO Family_rep_sign_contract (child_key, userID, contractID)
VALUES (1, 1, 1);

-- Insert sample data into the Nanny_sign_contract table
INSERT INTO Nanny_sign_contract (userID, contractID)
VALUES (2, 1);
