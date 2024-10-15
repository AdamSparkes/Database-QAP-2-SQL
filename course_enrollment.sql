CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    enrollment_date DATE
);

CREATE TABLE professors (
    id SERIAL  PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    department VARCHAR(100)
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR (50),
    course_description TEXT,
    professor_id INTEGER,
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

CREATE TABLE enrollments(
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO students (first_name,last_name,email,enrollment_date) VALUES
('Olivia', 'Williams', 'olivia.williams@example.com', '2022-09-12'),
('Liam', 'Thompson', 'liam.thompson@example.com', '2021-01-20'),
('Emma', 'Garcia', 'emma.garcia@example.com', '2023-05-17'),
('Noah', 'Anderson', 'noah.anderson@example.com', '2020-11-30'),
('Sophia', 'Martinez', 'sophia.martinez@example.com', '2021-08-23');

INSERT INTO professors (first_name, last_name, department) VALUES
('Alan', 'Turing', 'Computer Science'),
('Marie', 'Curie', 'Physics'),
('Ada', 'Lovelace', 'Mathematics'); 

INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introduction to Physics', 2), 
('Computer Science 101', 'Basics of Computer Science', 1), 
('Calculus I', 'Introduction to Calculus', 3); 

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-09-01'),
(2, 1, '2023-09-02'),
(3, 2, '2023-09-03'),
(4, 3, '2023-09-04'),
(5, 1, '2023-09-05');

SELECT CONCAT (students.first_name, ' ', students.last_name) AS student_name
FROM students
JOIN enrollments ON students.id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.id
WHERE courses.course_name = 'Physics 101';

SELECT courses.course_name, 
       CONCAT(professors.first_name, ' ', professors.last_name) AS professor_name
FROM courses
JOIN professors ON courses.professor_id = professors.id;

SELECT DISTINCT courses.course_name
FROM courses
JOIN enrollments ON courses.id = enrollments.course_id;

UPDATE students
SET email = 'updatedemail@example.com'
WHERE id = 1

DELETE FROM enrollments
WHERE student_id =1 AND course_id = 1