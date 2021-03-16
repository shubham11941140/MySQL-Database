/* Insert Data */ 

/* Query that inserts 3 students */

insert into Student 
values ('Abhishek', 'Kumar', 'Undergraduate', 'EECS', 'AK47','ak47');

insert into Student 
values ('Vempala', 'Surya', 'Graduate', 'EECS', 'Vesu','teja');

insert into Student 
values ('Aayush', 'Deshmukh', 'Undergraduate', 'ME', 'Ads','deshkh');

/* Query Completed */

/* Query that inserts 1 instructor */ 

insert into instructor 
values ('Mohit', 'Mathur', 'MMathur', 'Mohitm');

/* Query Completed */

/* Query that inserts a course includes inserting modules, lessons, lesson resources,
quizzes, exams, and the instructor who is teaching the course */ 

insert into courses 
values ('Algorithms', 'Optimisation is Real World problems', 'Mohit');

insert into modules
values ('Time Complexity', 'Algorithms');

insert into lessons
values ('Recap of DSA', 'Discuss previous DSA of the prev semester', 'D:\CS254 DBMS', 1, 'Time Complexity');

insert into lessons
values ('Big Oh Notation', 'Worst case Running Time' , 'https://www.youtube.com/watch?v=AI7asbV5A-s', 0, 'Time Complexity'); 

insert into comments
values ('test comment', '2010-12-31 01:15:00', 'shubham', 'Recap of DSA', '2010-12-31 01:15:00');

insert into quiz
values ('111', 'Assessment of Recap of DSA', 'Recap of DSA');

insert into quiz
values ('112','Assessment of Big Oh Notation', 'Big Oh Notation');

insert into quiz
values ('122','Tierce 1 Revision', 'Big Oh Notation');

insert into resources
values ('https://www.youtube.com/watch?v=c_wUBeeJV9U' , 'Recap of DSA');

/* Query Completed */

/* Query that enrolls all 3 students in the course */ 

insert into course_of_students
values ('Algorithms','Abhishek');

insert into course_of_students
values ('Algorithms','Vempala');

insert into course_of_students
values ('Algorithms','Aayush');

/* Query Completed */

/* Retrieve Data */

/* Query that lists how many students are in the database (Count number of students) */

select count(*) 
from student;

/* Query Completed */

/* Query that lists the courses for the instructor */ 

select * 
from courses 
where Instructor_First_Name = 'Mohit';

/* Query Completed */

/* Query that lists all modules and lessons for a particular course */

select * 
from modules 
join lessons 
on lessons.Modules_Module_Name = modules.Module_Name
where Courses_CName = 'Algorithms';

/* Query Completed */

/* Query that lists the lessons of a particular course that has comments */

select *
from modules, lessons, comments
where Courses_CName = 'Algorithms' 
and comments.Lessons_LName = lessons.LName;

/* Query Completed */

/* Query that lists how many students are registered for a particular course */

select distinct * 
from course_of_students
join student
on course_of_students.Student_SFirst_Name = student.SFirst_Name
where Courses_CName = 'Algorithms';

/* Query Completed */