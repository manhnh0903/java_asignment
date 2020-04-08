-- Create database testingmanagement
drop database testingmanagement;
CREATE DATABASE IF NOT EXISTS TestingManagement;
USE TestingManagement;

-- Create table with constraint and datatype
CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE IF NOT EXISTS Position (
    PositionID INT AUTO_INCREMENT PRIMARY KEY,
    PositionName NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE IF NOT EXISTS `Account` (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE KEY,
    UserName NVARCHAR(50) NOT NULL UNIQUE KEY,
    FullName NVARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    PositionID INT NOT NULL,
    CreateDate DATE DEFAULT (CURRENT_DATE), 
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE,
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `Group` (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID INT NOT NULL UNIQUE KEY,
    CreateDate DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS GroupAccount (
	GroupID INT AUTO_INCREMENT ,
	AccountID INT NOT NULL,
	JoinDate DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY(GroupID, AccountID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE,
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS TypeQuestion (
    TypeID INT AUTO_INCREMENT PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE IF NOT EXISTS CategoryQuestion (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);

CREATE TABLE IF NOT EXISTS Question (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    Content NVARCHAR(50) NOT NULL,
    TypeID INT NOT NULL,
    CreatorID INT NOT NULL UNIQUE KEY,
    CreateDate DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE,
    FOREIGN KEY(CreatorID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Answer (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    Content NVARCHAR(50) NOT NULL,
    QuestionID INT NOT NULL,
    IsCorrect ENUM('Y', 'N'),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Exam (
    ExamID INT AUTO_INCREMENT PRIMARY KEY,
    `Code` NVARCHAR(20) NOT NULL UNIQUE KEY,
    Title NVARCHAR(50) NOT NULL,
    CategoryID INT NOT NULL,
    Duration TIME,
    CreatorID INT NOT NULL,
    CreateDate DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (CreatorID) REFERENCES Question(CreatorID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ExamQuestion (
    ExamID INT NOT NULL,
    QuestionID INT NOT NULL,
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE,
    FOREIGN KEY(QuestionID) REFERENCES Answer(QuestionID) ON DELETE CASCADE
);





