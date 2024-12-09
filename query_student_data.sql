DROP DATABASE QuanLySinhVien;
CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

CREATE TABLE Class (
	ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ClassName VARCHAR(60) NOT NULL,
	StartDate DATETIME NOT NULL,
	Status BIT
);

CREATE TABLE Student (
	StudentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	StudentName VARCHAR(30) NOT NULL,
	Address VARCHAR(50),
	Phone VARCHAR(20),
	Status BIT,
	ClassID INT NOT NULL,
	FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE Subject (
	SubID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SubName VARCHAR(30) NOT NULL,
	Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
	Status BIT DEFAULT 1
);

CREATE TABLE Mark (
	MarkID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SubID INT NOT NULL,
	StudentID INT NOT NULL,
	Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
	ExamTimes TINYINT DEFAULT 1,
	UNIQUE (SubID, StudentID),
	FOREIGN KEY (SubID) REFERENCES Subject (SubID),
	FOREIGN KEY (StudentID) REFERENCES Student (StudentID)
);

-- Thêm dữ liệu vào bảng Class
INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES 
	(1, 'A1', '2008-12-20', 1),
	(2, 'A2', '2008-12-22', 1),
	(3, 'B3', CURRENT_DATE, 0);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassID)
VALUES 
	('Hung', 'Ha Noi', '0912113113', 1, 1),
	('Hoa', 'Hai phong', NULL, 1, 1),
	('Manh', 'HCM', '0123123123', 0, 2);

-- Thêm dữ liệu vào bảng Subject
INSERT INTO Subject (SubID, SubName, Credit, Status)
VALUES 
	(1, 'CF', 5, 1),
	(2, 'C', 6, 1),
	(3, 'HDJ', 5, 1),
	(4, 'RDBMS', 10, 1);

-- Thêm dữ liệu vào bảng Mark
INSERT INTO Mark (SubID, StudentID, Mark, ExamTimes)
VALUES 
	(1, 1, 8, 1),
	(1, 2, 10, 2),
	(2, 1, 12, 1);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bằng ký tự ‘h’
SELECT * 
FROM Student 
WHERE StudentName LIKE 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
SELECT * 
FROM Class 
WHERE MONTH(StartDate) = 12;

-- Hiển thị tất cả các thông tin môn học có Credit trong khoảng từ 3-5
SELECT * 
FROM Subject 
WHERE Credit BETWEEN 3 AND 5;

-- Thay đổi mã lớp (ClassID) của sinh viên có tên ‘Hung’ thành 2
UPDATE Student 
SET ClassID = 2 
WHERE StudentName = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo Mark giảm dần, nếu trùng sắp theo StudentName tăng dần
SELECT s.StudentName, su.SubName, m.Mark 
FROM Mark m
JOIN Student s ON m.StudentID = s.StudentID
JOIN Subject su ON m.SubID = su.SubID
ORDER BY m.Mark DESC, s.StudentName ASC;


