show databases;

create database sunbeam_db;

use sunbeam_db;

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(30),
    des VARCHAR(200),
    fees INT,
    start_date DATE,
    end_date DATE,
    video_exp_date DATE
);

alter table course change video_exp_date video_exp_day int;
insert into course values (1,'IIT-MERN-2025','MERN',4000,'2025-12-20',
'2025-01-20',30);

select * from course;

create table users(
    email varchar(60) primary key,
    password varchar(20),
    role enum("admin","student","teacher")
    );
drop table users;

create table students(
     regi_no int primary key ,
     student_name varchar(30),
     email varchar(50),
     course_id int,
     mobile_no int,
     profile_pic blob,
     foreign key(email) references users(email),
     foreign key(course_id) references course(course_id)
     );
     
 use sunbeam_db;
 
 create table videos(
     video_id int primary key,
     course_id int,
     title varchar(50),
     des varchar(200),
     youtube_url varchar(50),
     added_at date,
     foreign key(course_id) references course(course_id)
     );
 
INSERT INTO users (email, password, role) VALUES
('alice@example.com', 'pass123', 'student'),
('bob@example.com', 'admin456', 'admin'),
('carol@example.com', 'teach789', 'teacher'),
('dave@example.com', 'stud321', 'student');

ALTER TABLE students MODIFY mobile_no BIGINT;

INSERT INTO users (email, password, role) VALUES
('eve@example.com', 'eve123', 'student'),
('frank@example.com', 'frank123', 'student');

INSERT INTO students (regi_no, student_name, email, course_id, mobile_no, profile_pic) VALUES
(1, 'Alice Smith', 'alice@example.com', 101, 1234567890, NULL),
(2, 'Dave Johnson', 'dave@example.com', 102, 2345678901, NULL),
(3, 'Eve Williams', 'eve@example.com', 103, 3456789012, NULL),
(4, 'Frank Brown', 'frank@example.com', 104, 4567890123, NULL);


INSERT INTO course (course_id, course_name, des, fees, start_date, end_date, video_exp_day) VALUES
(101, 'Mathematics', 'Basic math course covering algebra and geometry', 500, '2025-01-10', '2025-06-10', 180),
(102, 'Physics', 'Introductory physics including mechanics and thermodynamics', 600, '2025-02-01', '2025-07-01', 150),
(103, 'Chemistry', 'Fundamentals of chemistry, atoms, and reactions', 550, '2025-03-01', '2025-08-01', 120),
(104, 'Biology', 'Basic biology covering cells, genetics, and ecosystems', 500, '2025-04-01', '2025-09-01', 200);

INSERT INTO videos (video_id, course_id, title, des, youtube_url, added_at) VALUES
(1, 101, 'Math Basics', 'Introduction to numbers', 'https://youtu.be/math1', '2025-01-15'),
(2, 102, 'Physics Basics', 'Newton laws explained', 'https://youtu.be/phys1', '2025-02-05'),
(3, 103, 'Chemistry Basics', 'Atoms and molecules', 'https://youtu.be/chem1', '2025-03-10'),
(4, 104, 'Biology Basics', 'Cell structure', 'https://youtu.be/bio1', '2025-04-12');

-- Q1
select *
from course
where start_date > curdate();

-- Q2
SELECT 
    s.regi_no,
    s.student_name,
    s.email,
    c.course_name
FROM students s
JOIN course c ON s.course_id = c.course_id;

-- Q3
SELECT 
    s.*,
    c.*
FROM students s
JOIN course c 
    ON s.course_id = c.course_id
WHERE s.email = 'alice@example.com';

-- Q4
SELECT 
    c.course_id,
    c.course_name,
    c.des,
    c.fees,
    c.start_date,
    c.end_date,
    c.video_exp_day,
    v.video_id,
    v.title,
    v.des AS video_description,
    v.youtube_url,
    v.added_at
FROM students s
JOIN course c 
    ON s.course_id = c.course_id
JOIN videos v
    ON c.course_id = v.course_id
WHERE 
    s.email = 'dave@example.com'
    AND DATE_ADD(v.added_at, INTERVAL c.video_exp_day DAY) >= CURDATE();