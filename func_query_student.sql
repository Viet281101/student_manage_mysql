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


-- Hiển thị tất cả các thông tin môn học (bảng Subject) có Credit lớn nhất
SELECT * 
FROM Subject 
WHERE Credit = (SELECT MAX(Credit) FROM Subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất
SELECT su.* 
FROM Mark m
JOIN Subject su ON m.SubID = su.SubID
WHERE m.Mark = (SELECT MAX(Mark) FROM Mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT s.StudentName, AVG(m.Mark) AS AverageMark
FROM Mark m
JOIN Student s ON m.StudentID = s.StudentID
GROUP BY s.StudentID, s.StudentName
ORDER BY AverageMark DESC;

