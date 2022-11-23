CREATE DATABASE MyUniversityDb

USE MyUniversityDb

CREATE TABLE Groups
(Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30)
)

CREATE TABLE Students
(Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30),
Surname NVARCHAR(30),
GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)
CREATE TABLE Subjects
(Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30)
)

CREATE TABLE Exams
(Id INT PRIMARY KEY IDENTITY,
SubjectId INT FOREIGN KEY REFERENCES Subjects(Id),
Date DATETIME2
)

CREATE TABLE StudentExams
(Id INT PRIMARY KEY IDENTITY,
StudentId INT FOREIGN KEY REFERENCES Students(Id),
ExamId INT FOREIGN KEY REFERENCES Exams(Id),
Result TINYINT
)

INSERT INTO Groups
VALUES
('P121'),('P123'),('P125'),('P127'),('P128'),('P132')

INSERT INTO Students
VALUES
('Eli', 'Abbasov', 1),
('Abbas', 'Babayev', 1),
('Bextiyar', 'Cabbarlı', 1),
('Cahangir', 'Efəndiyev', 2),
('Çingiz', 'Ferecov', 2),
('David', 'Hesenov', 2),
('Eldar', 'Xıdırlı', 3),
('Ehmed', 'İmanov', 3),
('Faiq', 'Eliyev', 3),
('Heyder', 'Kazımov', 4),
('Ilqar', 'Qarayev', 4),
('Kamal', 'Məmmədli', 4),
('Qurban', 'Novruzov', 5),
('Lale', 'Resulova', 5),
('Mahir', 'Semedov', 5),
('Nazim', 'Şukurov', 6),
('Orxan', 'Quluzade', 6),
('Senan', 'Ezimov', 6)

INSERT INTO Subjects
VALUES
('English'),('Mathematics'),('Programming'),('Physics')

INSERT INTO Exams
VALUES
(1,'2022-11-23 16:00'),
(2,'2022-11-23 17:00'),
(3,'2022-11-24 14:00'),
(1,'2022-11-23 15:00'),
(3,'2022-11-24 16:00')

INSERT INTO StudentExams
VALUES
(1,1,75),(2,1,80),(3,1,85),(4,1,90),(5,1,95),(6,1,80),
(7,2,85),(8,2,75),(9,2,80),(10,2,85),(11,2,90),(12,2,95),
(13,3,75),(14,3,90),(15,3,80),(16,3,85),(17,3,95),(18,3,85),
(13,4,55),(14,4,60),(15,4,65),(16,4,70),(17,4,75),(18,4,80),
(7,5,50),(8,5,55),(9,5,60),(10,5,55),(11,5,65),(12,5,75)

SELECT S.Id, CONCAT(S.Name, ' ', S.Surname) AS 'FullName', G.Name FROM Students AS S
LEFT JOIN Groups AS G
ON S.GroupId = G.Id

SELECT *, (SELECT COUNT(Id) FROM StudentExams WHERE StudentId=S.Id) AS 'ExamsCount' FROM Students AS S

SELECT Subjects.Name FROM Subjects WHERE (SELECT COUNT(Id) FROM Exams WHERE SubjectId = Subjects.Id)=0

SELECT SE.id,SE.Result, CONCAT(S.Name, ' ', S.Surname) AS 'FullName',G.Name FROM StudentExams AS SE
JOIN Students AS S
ON S.Id = StudentId
	JOIN Groups AS G
	ON GroupId = G.Id

SELECT *, (SELECT AVG(Result) FROM StudentExams WHERE StudentId = Students.Id) AS 'AVGResault' FROM Students

SELECT *, (SELECT COUNT(Id) FROM Students) FROM Exams WHERE DAY(Exams.Date) = DAY(DATEADD(DAY,-1,GETDATE()))