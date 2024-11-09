--Type
create table [userType]
(
[type] int NOT NULL,
[name] varchar(50) NOT NULL  
primary key([type]) 
);
create table types_teachers
(
	id int Primary Key,
	[type_name] varchar(20) NOT NULL
);

create table department
(
Dno int NOT NULL, 
Dname varchar(50) NOT NULL,
Primary key(Dno)
);

--Users
create table [Users]
(
	[id] int primary key,
	[username] varchar(50) NOT NULL UNIQUE,
	[password] varchar(50) NOT NULL,
	[status] varchar(1) NOT NULL,
	[type] int NOT NULL REFERENCES userType([type]),
	displayName varchar(50) NOT NULL,
	profilePic varchar(1024), --href
);
create table [Students]
(
	[userID] int primary key REFERENCES Users(id),
	[fname] varchar(50) NOT NULL,
	[lname] varchar(50) NOT NULL,
	[gender] varchar(1) NOT NULL,
	[dob] date NOT NULL,
	[DeptNo] int NOT NULL REFERENCES department(Dno),
	[Batch] int NOT NULL,
	[email] varchar(200) NOT NULL UNIQUE,
	[contactNo] varchar(12) NOT NULL,
	[address] varchar(50) NOT NULL,
	[bio] varchar(500)
);
create table [Teachers]
(
	[UserID] int Primary Key REFERENCES Users(id), 
	[fname] varchar(50) NOT NULL,
	[lname] varchar(50) NOT NULL,
	[gender] varchar(1) NOT NULL,
	[dob] date NOT NULL,
	[DeptNo] int NOT NULL REFERENCES department(Dno),
	[Join_date] date NOT NULL,
	[email] varchar(50) NOT NULL UNIQUE,
	[contactNo] varchar(12) NOT NULL,
	[address] varchar(50) NOT NULL,
	[bio] varchar(500),
	[TeacherType] int REFERENCES types_teachers(id)
);
--Catalogue
--Courses/Teachers/
create table courses
(
	id int Primary Key, 
	Cname varchar(50) NOT NULL,
	PreReqID int REFERENCES courses(id)
);
--societies
create table societies
(
	societyID int Primary Key,
	[Name] varchar(50) NOT NULL,
	presidentID int NOT NULL REFERENCES Users(id),
	[info] varchar(5000)
);

--create table [Course-Teacher]
--(
--	Cid int NOT NULL, 
--	Tid int NOT NULL,
--	FOREIGN KEY (Cid) REFERENCES courses(Cid),
--	FOREIGN KEY (Tid) REFERENCES teachers(Tid),
--	Primary key(Cid, Tid)
--);

--Posts
create table [Posts]
(
	id int NOT NULL primary key REFERENCES Users(id),
	userID int NOT NULL,
	[text] varchar(5000) NOT NULL,
	[link] varchar(2083),
	creation_time smalldatetime NOT NULL
);

--create table [replies to posts]
--(
--	id int NOT NULL,
--	userID int NOT NULL,
--	PostID int NOT NULL,
--	[text] text NOT NULL,
--	[link] varchar(2083),
--	reply_time smalldatetime NOT NULL,
--  Primary Key(id),
--  FOREIGN KEY (userID) REFERENCES Users(id),
--  FOREIGN KEY (PostID) REFERENCES Posts(id)
--);

--create table [replies to replies on posts]
--(
--id int NOT NULL,
--userID int NOT NULL,
--ReplyID int NOT NULL,
--[text] text NOT NULL,
--[link] varchar(2083),
--reply_time smalldatetime NOT NULL,
--Primary Key(id),
--FOREIGN KEY (userID) REFERENCES Users(id),
--FOREIGN KEY (ReplyID) REFERENCES [replies to posts](id),
--);

--Discussion Rooms
create table [disPosts]
(
	id int NOT NULL primary key REFERENCES Users(id),
	userID int NOT NULL,
	[text] varchar(5000) NOT NULL,
	[link] varchar(2083),
	creation_time smalldatetime NOT NULL
);

--create drop table [replies to disPosts]
--(
--id int NOT NULL,
--userID int NOT NULL,
--PostID int NOT NULL,
--[text] text NOT NULL,
--[link] varchar(2083),
--reply_time smalldatetime NOT NULL,
--Primary Key(id),
--FOREIGN KEY (userID) REFERENCES Users(id),
--FOREIGN KEY (PostID) REFERENCES disPosts(id)

--);

--create table [replies to replies on discussion]
--(
--id int NOT NULL,
--userID int NOT NULL,
--ReplyID int NOT NULL,
--[text] text NOT NULL,
--[link] varchar(2083),
--reply_time smalldatetime NOT NULL,
--Primary Key(id),
--FOREIGN KEY (userID) REFERENCES Users(id),
--FOREIGN KEY (ReplyID) REFERENCES [replies to disPosts](id)

--);

--followers/follows
create table followers
(
followerID int NOT NULL REFERENCES Users(id),
followingID int NOT NULL REFERENCES Users(id),
Primary Key(followingID, followerID)
);

--likes
--create drop table [likes for posts]
--(
--PostID int   REFERENCES Posts(id),
--userID int REFERENCES Users(id),
--Primary Key(PostID, userID)
--);


--create drop table [likes for disPosts]
--(
--PostID int NOT NULL,
--userID int NOT NULL,
--FOREIGN KEY (userID) REFERENCES Users(id),
--FOREIGN KEY (PostID) REFERENCES disPosts(id),
--Primary Key(PostID, userID)
--);


--resources
--create table resources
--(
--resourceID int NOT NULL,
--userID int NOT NULL,
--Cid int NOT NULL,
--[Resource] text NOT NULL
--FOREIGN KEY (userID) REFERENCES Users(id),
--FOREIGN KEY (Cid) REFERENCES courses(Cid),
--Primary Key(resourceID)
--);
--SELECT * FROM Users
---------------------------
----recommendations
--create table [recs]
--(
--userID int NOT NULL,
--[message] text,
--FOREIGN KEY (userID) REFERENCES Users(id)
--);


--membership
table [members]
(
societyID int NOT NULL,
memberID int NOT NULL,
[role] varchar(20) NOT NULL,
joining_date date NOT NULL,
FOREIGN KEY (societyID) REFERENCES societies(societyID),
FOREIGN KEY (memberID) REFERENCES Users(id),
Primary Key(societyID, memberID)
);



