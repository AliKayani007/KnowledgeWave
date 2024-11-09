INSERT INTO userType VALUES (1, 'Admin')
INSERT INTO userType VALUES (2, 'Faculty')
INSERT INTO userType VALUES (3, 'Alumni')
INSERT INTO userType VALUES (4, 'Students')

INSERT INTO department VALUES (10, 'Computer Science')
INSERT INTO department VALUES (20, 'Civil Engineering')

INSERT INTO posts VALUES (1, 2, 'Meow Meow !! I am Cat.', NULL, '2023-04-16')
INSERT INTO posts VALUES (2, 1, 'Hi! I am almost done with project.', NULL, GETDATE())
INSERT INTO posts VALUES (3, 3, 'Very Very Easy !!!', NULL, GETDATE())
INSERT INTO posts VALUES (4, 1, 'Its a beautiful day!!!', NULL, GETDATE())

EXEC AddStudents '21L-7622', 'Taha123', 'Taha Ahmad', 'Muhammad Taha', 'Ahmad', 'M', '2003-6-21', 10, 2021, 'l217622@lhr.nu.edu.pk', '0322-4181707', 'Lahore'
EXEC AddStudents '21L-7590', 'blossom', 'Rijja', 'Rijja', 'Masood', 'F', '2003-10-5', 10, 2021, 'l217590@lhr.nu.edu.pk', '0334-4567699', 'Sheikhupura'
EXEC AddStudents '21L-5168', 'wazzah', 'Wazzah', 'Wazzah', 'Zaidi', 'M', '2002-1-22', 10, 2021, 'l215168@lhr.nu.edu.pk', '0000-0000000', 'Lahore'
EXEC AddStudents '21L-5315', '123', 'Hafsahxzulqarnain', 'Hafsah', 'Zulqarnain', 'F', '2003-01-02', 10, 2021, 'l215315@lhr.nu.edu.pk', '0306-4593678', 'Lahore'

EXEC AddAdmin 'admin', 'admin123'

Select * from Users
select * from followers where followerID = 1
select * from Posts_for_student WHERE userID = 1 OR userID IN (SELECT followingID userID FROM followers WHERE followerID = 1)
SELECT * FROM Users WHERE username= 'admin'
select * from userType
select * from users
select * from posts
select * from societies

INSERT INTO societies VALUES(1, 'Creative Society', 3, NULL)
INSERT INTO societies VALUES(2, 'SOFTEC', 1, NULL)
INSERT INTO societies VALUES(3, 'ACM', 5, NULL)
INSERT INTO societies VALUES(4, 'Music Society', 4, NULL)
INSERT INTO societies VALUES(5, 'Voice - Debating Society', 3, NULL)
INSERT INTO societies VALUES(6, 'IEEE', 3, NULL)

INSERT INTO courses VALUES(1, 'Programming Fundamentals', NULL)
INSERT INTO courses VALUES(2, 'Object Oriented Programming', 1)
INSERT INTO courses VALUES(3, 'Data Structures', 2)
INSERT INTO courses VALUES(4, 'Computer Architecture and Organizational Language', 2)
INSERT INTO courses VALUES(5, 'DataBase Systems', 3)
INSERT INTO courses VALUES(6, 'Design And Analysis of Algorithms', 3)
INSERT INTO courses VALUES(7, 'English And Grammar Composition', NULL)
INSERT INTO courses VALUES(8, 'Communication and Presentation Skills', NULL)
INSERT INTO courses VALUES(9, 'Islamyat Studies', NULL)
INSERT INTO courses VALUES(10, 'Pakistan Studies', NULL)

INSERT INTO types_teachers VALUES(1, 'Head of Deaprtment')
INSERT INTO types_teachers VALUES(2, 'Professor')
INSERT INTO types_teachers VALUES(3, 'Lecturer')
INSERT INTO types_teachers VALUES(4, 'Visiting')

select * from types_teachers
EXEC AddTeacher 'FST_ishaqraza', 'ishaq123', 'Ishaq Raza', 'Ishaq', 'Raza', 'M', '1-1-1976', 10, '1-1-1999', 'ishaqraza@nu.edu.pk', '0000-0000000', 'Lahore', 1
EXEC AddTeacher 'FST_raziuddin', 'razi123', 'Razi Uddin', 'Razi', 'Uddin', 'M', '1-10-1980', 10, '1-1-2016', 'raziuddin@nu.edu.pk', '0000-0000000', 'Lahore', 1

select * from users
select * from Students
SELECT U.*, CONCAT(S.fname,' ',S.lname) name, S.bio FROM Users U JOIN Students S ON U.id = S.userID 
delete from users where username = '21L-1886'
select * from types_teachers
go
CREATE VIEW Posts_for_teachers AS
SELECT GetTeachers.id userID, T.username, T.displayName, T.profilePic, creation_time, [text] as post, [link] FROM Posts JOIN GetTeachers T ON Posts.userID = GetTeachers.id
UNION 
SELECT userID, 'admin' as username, 'Admin' AS displayName, NULL as profilePic, creation_time, [text] as post, [link] FROM Posts WHERE userID IN (SELECT id FROM Users Where username='admin')
go


select * from GetTeachers