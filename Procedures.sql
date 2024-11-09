--Procedure#1
CREATE PROCEDURE Login (@username varchar(50), @pass varchar(50))
AS
BEGIN
	IF EXISTS (SELECT * FROM Users WHERE @username = username AND @pass = [password])
	BEGIN
		UPDATE Users SET status = '1' WHERE @username = [username] AND @pass = [password]
	END
	ELSE
		UPDATE Users SET status = '0' WHERE @username = [username] AND @pass = [password]
END
go

--Procedure#2
CREATE PROCEDURE ProfileUpdate (@username varchar(50), @name varchar(50), @bio text, @picUrl varchar(1024))
AS
BEGIN
	UPDATE ProfileInfo SET displayName = @name, bio = @bio, profilePic = @picUrl WHERE username = @username
END
go
--Procedure#3
CREATE PROCEDURE CreatePost
    @user_id INT,
    @link VARCHAR(2083),
    @content text
AS
BEGIN
	DECLARE @id int 
	SELECT @id = MAX(id) FROM Posts
	if (@id IS NULL)
		SET @id = 1
	ELSE
		SET @id = @id+1
    INSERT INTO [Posts]
    VALUES (@id, @user_id, @content, @link, GETDATE())
END
go
--Procedure#4
CREATE PROCEDURE CreateDiscussion
    @user_id INT,
    @link VARCHAR(2083),
    @content text
AS
BEGIN
	DECLARE @id int 
	SELECT @id = MAX(id) FROM disPosts
	if (@id IS NULL)
		SET @id = 1
	ELSE
		SET @id = @id+1
    INSERT INTO [disPosts]
    VALUES (@id, @user_id, @content, @link, GETDATE())
END
go

--Procedure#4
CREATE PROCEDURE AddStudents(
	@username varchar(50),
	@password varchar(50),
	@displayname varchar(50),
	@fname varchar(50),
	@lname varchar(50),
	@gender varchar(1),
	@dob date,
	@dept int,
	@batch int,
	@email varchar(50),
	@contact varchar(12),
	@address varchar(200)
)   AS
BEGIN
	DECLARE @id int 
	SELECT @id = MAX(id) FROM Users
	if (@id IS NULL)
		SET @id = 1
	ELSE
		SET @id = @id+1

    INSERT INTO Users VALUES(@id, @username, @password, '0', 4, @displayname, NULL)
	INSERT INTO Students VALUES(@id, @fname, @lname, @gender, @dob, @dept, @batch, @email, @contact, @address, NULL)
END
go
--Procedure#5
CREATE PROCEDURE AddAdmin (
	@username varchar(50),
	@password varchar(50)
)
AS
BEGIN
	DECLARE @id int 
	SELECT @id = MAX(id) FROM Users
	if (@id IS NULL)
		SET @id = 1
	ELSE
		SET @id = @id+1

    INSERT INTO Users VALUES(@id, @username, @password, '0', 1, 'Admin', NULL)
END
delete from followers where followingID = 4
go
--Procedure#5
CREATE PROCEDURE NewFollower (
	@username1 varchar(50),
	@username2 varchar(50)
)
As
BEGIN
	INSERT INTO followers VALUES (
	(SELECT id FROM Users WHERE username = @username1),
	(SELECT id FROM Users WHERE username = @username2)
	)
END
go
CREATE PROCEDURE RemoveFollower (
	@username1 varchar(50),
	@username2 varchar(50)
)
As
BEGIN
	DELETE FROM followers WHERE followerID = (SELECT id FROM Users WHERE username = @username1) AND followingID = (SELECT id FROM Users WHERE username = @username2)
END
go
--Procedure%6
CREATE PROCEDURE UpdateProfilePicture
	@link varchar(1024),
	@id int
AS
BEGIN
	UPDATE Users SET profilePic=@link WHERE id = @id
END
go
--Procedure%7
CREATE PROCEDURE UpdateDisplayName
	@name varchar(50),
	@id int
AS
BEGIN
	UPDATE Users SET displayName=@name WHERE id = @id
END
go
--Procedure%8
CREATE PROCEDURE UpdateBio
	@type int,
	@id int,
	@bio text
AS
BEGIN
	IF (@type = 4)
		UPDATE Students SET bio=@bio WHERE userID = @id
	ELSE IF (@type = 2)
		UPDATE Teachers SET bio=@bio WHERE userID = @id
	--ELSE IF (@type = 3)
		--UPDATE Alumni SET bio=@bio WHERE id = @id
END
go
--Procedure%9
CREATE PROCEDURE AddTeacher(
	@username varchar(50),
	@password varchar(50),
	@displayname varchar(50),
	@fname varchar(50),
	@lname varchar(50),
	@gender varchar(1),
	@dob date,
	@dept int,
	@join date,
	@email varchar(50),
	@contact varchar(12),
	@address varchar(200),
	@type int
)   AS
BEGIN
	DECLARE @id int 
	SELECT @id = MAX(id) FROM Users
	if (@id IS NULL)
		SET @id = 1
	ELSE
		SET @id = @id+1

    INSERT INTO Users VALUES(@id, @username, @password, '0', 2, @displayname, NULL)
	INSERT INTO Teachers VALUES(@id, @fname, @lname, @gender, @dob, @dept, @join, @email, @contact, @address, NULL, @type)
END
go
--View#1	
-- yet to be broken down into subclasses concept
CREATE VIEW ProfileInfo
AS
SELECT displayName, profilePic, CONCAT(fname,' ',lname) AS [Full name], bio,
	   dob, gender, email, contactNo, [address], 
	   (SELECT Dname FROM department WHERE Dno = DeptNo) AS Dept,
	   CASE
		WHEN [status] = '1' THEN 'Online'
		ELSE 'Offline'
	   END AS [Status]
	   , username
FROM Users
WITH CHECK OPTION
go
--View#2
CREATE VIEW Posts_for_student AS
SELECT GetStudents.id userID, GetStudents.username, GetStudents.displayName, GetStudents.profilePic, creation_time, [text] as post, [link] FROM Posts JOIN GetStudents ON Posts.userID = GetStudents.id
UNION 
SELECT userID, 'admin' as username, 'Admin' AS displayName, NULL as profilePic, creation_time, [text] as post, [link] FROM Posts WHERE userID IN (SELECT id FROM Users Where username='admin')
go
CREATE VIEW Posts_for_teachers AS
SELECT T.id userID, T.username, T.displayName, T.profilePic, creation_time, [text] as post, [link] FROM Posts JOIN GetTeachers T ON Posts.userID = GetTeachers.id
UNION 
SELECT userID, 'admin' as username, 'Admin' AS displayName, NULL as profilePic, creation_time, [text] as post, [link] FROM Posts WHERE userID IN (SELECT id FROM Users Where username='admin')
go
--View#3
CREATE VIEW Post_comments_view AS
SELECT Users.displayName, Users.profilePic, [text], reply_time
FROM [replies to posts]
JOIN Users ON userID = Users.id
ORDER BY reply_time DESC;
go
--View#4
CREATE VIEW GetStudents AS
SELECT U.*, CONCAT(S.fname,' ',S.lname) name, S.gender, S.dob, S.DeptNo, S.Batch, S.email, S.contactNo, S.address, S.bio FROM Users U JOIN Students S ON U.id = S.userID
WITH CHECK OPTION
go
CREATE VIEW GetTeachers AS
SELECT U.*, CONCAT(T.fname,' ',T.lname) name, T.gender, T.dob, T.DeptNo, T.Join_date, T.TeacherType, T.email, T.contactNo, T.address, T.bio FROM Users U JOIN Teachers T ON U.id = T.userID
WITH CHECK OPTION
go
CREATE VIEW GetProfilesAll AS
SELECT U.*, CONCAT(S.fname,' ',S.lname) name, S.bio FROM Users U JOIN Students S ON U.id = S.userID 
UNION
SELECT U.*, CONCAT(T.fname,' ',T.lname) name, T.bio FROM Users U JOIN Teachers T ON U.id = T.userID
WITH CHECK OPTION
go
--View#5
CREATE VIEW DiscussionPosts AS
SELECT disPosts.*,displayName, profilePic FROM disPosts JOIN Users ON disPosts.userID = Users.id
go
--View#6
CREATE VIEW GetCoursesAndPreReq AS
SELECT C.Cname, P.Cname as Pname FROM Courses C LEFT OUTER JOIN Courses P ON C.PreReqID = P.id
go
--View#7
create view viewTeacher AS
SELECT CONCAT(fname,' ',lname) Name, department.Dname, Join_date Date FROM Teachers JOIN department ON Teachers.DeptNo = department.Dno
go
-- Trigger#1
CREATE TRIGGER noDrop ON DATABASE
FOR drop_table
AS BEGIN
PRINT 'Cannot drop Table'
END
Go
-- Trigger#2
CREATE TRIGGER update_comments
ON [replies to posts]
AFTER INSERT
AS
BEGIN
  DECLARE @post_id INT, @comments_count INT
  
  -- Get the post ID and number of comments
  SELECT @post_id = PostID, @comments_count = COUNT(*) FROM [replies to posts] WHERE PostID  = inserted.PostID GROUP BY PostID 
  
  -- Update the post with the new number of comments
  UPDATE [Posts] SET comments = @comments_count WHERE PostID  = @post_id
END
go
-- Trigger#3
CREATE TRIGGER log_user_activity
ON user_table
AFTER INSERT, UPDATE
AS
BEGIN
  DECLARE @activity_message VARCHAR(MAX)
  
  -- Check if it's a login attempt
  IF UPDATE(last_login)
  BEGIN
    SELECT @activity_message = 'User ' + inserted.username + ' logged in.'
  END
  -- Check if it's a new account
  ELSE IF inserted.date_created = updated.date_created
  BEGIN
    SELECT @activity_message = 'User ' + inserted.username + ' created a new account.'
  END
  -- Check if it's a profile update
  ELSE IF UPDATE(profile_pic) OR UPDATE(bio) OR UPDATE(location)
  BEGIN
    SELECT @activity_message = 'User ' + inserted.username + ' updated their profile.'
  END
  
  -- Insert the activity log into the database
  INSERT INTO activity_log_table (user_id, activity_message, activity_timestamp) VALUES (inserted.user_id, @activity_message, GETDATE())
END

select * from followers where
followerID = (select id from users where username = '21L-7622')
AND
followingID = (select id from users where username = '21L-5168')
select * from posts
select * from followers;
select * from users