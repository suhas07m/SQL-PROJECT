CREATE DATABASE result;   -- create the database...

USE result;               -- use the database...

-- create student table..

CREATE TABLE student(
PRN VARCHAR(10) PRIMARY KEY,
name VARCHAR(30) NOT NULL,
class VARCHAR(20) NOT NULL,
email VARCHAR(20) UNIQUE NOT NULL,
contact_no VARCHAR(10) UNIQUE NOT NULL
);

-- create se1 exam table..
CREATE TABLE se1 (
    PRN VARCHAR(10),
    CA INT NOT NULL,
    CN INT NOT NULL,
    Java INT NOT NULL,
    Python INT NOT NULL,
    FOREIGN KEY (PRN) REFERENCES student(PRN) ON DELETE CASCADE
);

-- create se2 exam table..

CREATE TABLE se2 (
    PRN VARCHAR(10),
    CA INT NOT NULL,
    CN INT NOT NULL,
    Java INT NOT NULL,
    Python INT NOT NULL,
    FOREIGN KEY (PRN) REFERENCES student(PRN) ON DELETE CASCADE
);

-- create see exam table..

CREATE TABLE see (
    PRN VARCHAR(10),
    CA INT NOT NULL,
    CN INT NOT NULL,
    Java INT NOT NULL,
    Python INT NOT NULL,
    FOREIGN KEY (PRN) REFERENCES student(PRN) ON DELETE CASCADE
);

-- create practical marks table..

CREATE TABLE practical_marks (
    PRN VARCHAR(10),
    CA_practical INT NOT NULL,
    CN_practical INT NOT NULL,
    Java_practical INT NOT NULL,
    Python_practical INT NOT NULL,
    FOREIGN KEY (PRN) REFERENCES student(PRN) ON DELETE CASCADE
);

-- create cgpa table..

CREATE TABLE cgpa (
    PRN VARCHAR(10),
    semester INT NOT NULL,
    CGPA DECIMAL(3, 2) NOT NULL,
    FOREIGN KEY (PRN) REFERENCES student(PRN) ON DELETE CASCADE
);

-- create teacher table..

CREATE TABLE teachers (
    teacher_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(20) UNIQUE NOT NULL,
    contact_no VARCHAR(10) NOT NULL
    
);


-- BASIC QUESTIONS AND QUERIES :

 -- Retrieve all student details :
 
SELECT * FROM student;

-- Retrieve all students' names and emails:

SELECT name, email FROM student;

-- Insert a new student:


INSERT INTO student (PRN, name, class, email, contact_no) 
VALUES 
    ('PRN001', 'Suhas Masale', 'TY AI & DS', 'suhas@gmail.com', '9876543210'),
    ('PRN002', 'Sohal Dhavale', 'TY AI & DS', 'sohal@gmail.com', '9876543211'),
    ('PRN003', 'Sarvesh Koshti', 'TY AI & DS', 'sarvesh@gmail.com', '9876543212'),
    ('PRN004', 'Pradeep Mali', 'TY AI & DS', 'pradeep@gmail.com', '9876543213'),
    ('PRN005', 'Pranav Mete', 'TY AI & DS', 'pranav@gmail.com', '9876543214');

-- Retrieve details of a specific student using PRN :

SELECT * FROM student WHERE PRN = 'PRN001';

-- Insert marks for a student in se1.

INSERT INTO se1 (PRN, CA, CN, Java, Python)
VALUES 
('PRN001', 85, 90, 88, 92),
('PRN002', 86, 90, 88, 91),
('PRN003', 89, 90, 83, 93),
('PRN004', 89, 90, 88, 95),
('PRN005', 85, 90, 88, 92);

-- Retrieve marks for all students from se1.

SELECT * FROM se1;

-- Update a student's contact number:

UPDATE student
SET contact_no = '9876543220'
WHERE PRN = 'PRN001';

-- Delete a student record.

DELETE FROM student WHERE PRN = 'PRN006';

-- Count the total number of students.

SELECT COUNT(*) AS TotalStudents FROM student;

-- Retrieve all teacher details.

SELECT * FROM teachers;


-- INTERMEDIATE QUESTIONS AND QUERIES :

-- Retrieve the list of students along with their se1 marks.

SELECT student.name, se1.*
FROM student
LEFT JOIN se1 ON student.PRN = se1.PRN;

-- Get the average marks in each subject from se1.

SELECT AVG(CA) AS Avg_CA, AVG(CN) AS Avg_CN, AVG(Java) AS Avg_Java, AVG(Python) AS Avg_Python
FROM se1;

-- Get the highest marks in Python in se1.

SELECT MAX(Python) AS HighestPython FROM se1;

-- Find students who scored above 90 in Java in se1.

SELECT student.name, se1.Java
FROM student
JOIN se1 ON student.PRN = se1.PRN
WHERE se1.Java > 90;

-- Calculate the total marks for each student in se1.

SELECT PRN, (CA + CN + Java + Python) AS TotalMarks
FROM se1;

-- Retrieve a list of students along with their se2 marks.

SELECT student.name, se2.*
FROM student
LEFT JOIN se2 ON student.PRN = se2.PRN;

-- Update the marks of a student in see.

UPDATE see
SET CA = 95, CN = 89, Java = 90, Python = 85
WHERE PRN = 'PRN001';

-- Find students who failed in any subject (marks < 40) in se1.

SELECT student.name, se1.*
FROM student
JOIN se1 ON student.PRN = se1.PRN
WHERE CA < 40 OR CN < 40 OR Java < 40 OR Python < 40;

-- Retrieve CGPA of all students for a specific semester.

SELECT student.name, cgpa.CGPA
FROM student
JOIN cgpa ON student.PRN = cgpa.PRN
WHERE semester = 1;

-- Count the number of students in each class.

SELECT class, COUNT(*) AS StudentCount
FROM student
GROUP BY class;

-- Creating a View for Student Results

CREATE VIEW student_results AS
SELECT student.PRN, student.name,
       (IFNULL(se1.CA, 0) + IFNULL(se2.CA, 0) + IFNULL(see.CA, 0)) AS Total_CA,
       (IFNULL(se1.CN, 0) + IFNULL(se2.CN, 0) + IFNULL(see.CN, 0)) AS Total_CN,
       (IFNULL(se1.Java, 0) + IFNULL(se2.Java, 0) + IFNULL(see.Java, 0)) AS Total_Java,
       (IFNULL(se1.Python, 0) + IFNULL(se2.Python, 0) + IFNULL(see.Python, 0)) AS Total_Python
FROM student
LEFT JOIN se1 ON student.PRN = se1.PRN
LEFT JOIN se2 ON student.PRN = se2.PRN
LEFT JOIN see ON student.PRN = see.PRN;

-- Using the View

SELECT * FROM student_results;


-- DIFFICULT QUESTIONS AND QUERIES :


-- Retrieve the overall performance of each student across all exams.

SELECT student.PRN, student.name,
       (IFNULL(se1.CA, 0) + IFNULL(se2.CA, 0) + IFNULL(see.CA, 0)) AS Total_CA,
       (IFNULL(se1.CN, 0) + IFNULL(se2.CN, 0) + IFNULL(see.CN, 0)) AS Total_CN,
       (IFNULL(se1.Java, 0) + IFNULL(se2.Java, 0) + IFNULL(see.Java, 0)) AS Total_Java,
       (IFNULL(se1.Python, 0) + IFNULL(se2.Python, 0) + IFNULL(see.Python, 0)) AS Total_Python
FROM student
LEFT JOIN se1 ON student.PRN = se1.PRN
LEFT JOIN se2 ON student.PRN = se2.PRN
LEFT JOIN see ON student.PRN = see.PRN;

-- Find the top 5 students based on their CGPA.

SELECT student.name, cgpa.CGPA
FROM student
JOIN cgpa ON student.PRN = cgpa.PRN
ORDER BY cgpa.CGPA DESC
LIMIT 5;

-- Find students with missing marks in any subject in se1.

SELECT student.name, se1.*
FROM student
LEFT JOIN se1 ON student.PRN = se1.PRN
WHERE se1.CA IS NULL OR se1.CN IS NULL OR se1.Java IS NULL OR se1.Python IS NULL;

-- Get the name of the student with the highest CGPA.

SELECT student.name, cgpa.CGPA
FROM student
JOIN cgpa ON student.PRN = cgpa.PRN
WHERE cgpa.CGPA = (SELECT MAX(CGPA) FROM cgpa);

-- Calculate the average CGPA for all semesters.

SELECT AVG(CGPA) AS AverageCGPA FROM cgpa;

-- Get the details of students who scored the highest marks in Python in see.

SELECT student.name, see.Python
FROM student
JOIN see ON student.PRN = see.PRN
WHERE see.Python = (SELECT MAX(Python) FROM see);

-- Generate a report of students with total marks and CGPA.

SELECT student.name, 
       (IFNULL(se1.CA, 0) + IFNULL(se1.CN, 0) + IFNULL(se1.Java, 0) + IFNULL(se1.Python, 0)) AS TotalMarks,
       cgpa.CGPA
FROM student
LEFT JOIN se1 ON student.PRN = se1.PRN
LEFT JOIN cgpa ON student.PRN = cgpa.PRN;

-- Find students who scored above the class average in se1.

SELECT student.name, se1.*
FROM student
JOIN se1 ON student.PRN = se1.PRN
WHERE (CA + CN + Java + Python) / 4 > 
      (SELECT AVG((CA + CN + Java + Python) / 4) FROM se1);
      
-- Count the number of students with a CGPA above 8.0.

SELECT COUNT(*) AS HighScorers
FROM cgpa
WHERE CGPA > 8.0;

-- Generate a list of students sorted by their total marks in se1.

SELECT student.name, (CA + CN + Java + Python) AS TotalMarks
FROM student
JOIN se1 ON student.PRN = se1.PRN
ORDER BY TotalMarks DESC;






