CREATE DATABASE PT_Online_ASM
USE PT_Online_ASM


--Create Table:

--01.Role:
CREATE TABLE tblRole(
	RoleID VARCHAR(10) not null,
	RoleName NVARCHAR(255) not null
)
--Primary Key
ALTER TABLE tblRole
	ADD CONSTRAINT PK_tblRole PRIMARY KEY (RoleID)
--Data
INSERT INTO tblRole
	VALUES ('RL001','Customer')
INSERT INTO tblRole
	VALUES ('RL002','Trainer')

--02.User:
CREATE TABLE tblUser(
	UserID VARCHAR(10) not null,
	UserName varchar(25) not null,
	Password VARCHAR(20) not null,
	FullName NVARCHAR(255) not null,
	Phone VARCHAR(15) not null,
	RoleID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblUser
	ADD CONSTRAINT PK_tblUser PRIMARY KEY (UserID)
--Foreign Key
ALTER TABLE tblUser
	ADD CONSTRAINT FK_tblUser FOREIGN KEY (RoleID) REFERENCES tblRole(RoleID) ON DELETE CASCADE
--Unique
ALTER TABLE tblUser
	ADD CONSTRAINT UQ_tblUser_password UNIQUE (Password)
ALTER TABLE tblUser 
	ADD CONSTRAINT UQ_tblUser_UserName UNIQUE (UserName)
	select * from tblUser
--DATA
INSERT INTO tblUser
	VALUES ('US1412','quych1412','5546556aD',N'Cao Hoàng Quy','09146824232','RL001')
INSERT INTO tblUser
	VALUES ('US1757','dat093124','142421aD',N'Lê Quốc Đạt','09451644223','RL002')
INSERT INTO tblUser
	VALUES ('US1642','duchieupro9x','leBong9x',N'Bành Đức Hiếu','09166423167','RL001')
INSERT INTO tblUser
	VALUES ('US1235','ngoctran14','20112000hQ',N'Phùng Ngọc Trân','09146873748','RL001')
INSERT INTO tblUser
	VALUES ('US1892','nguyen1999','056837Tn',N'Lý Khánh Nguyên','09451688992','RL002')
INSERT INTO tblUser
	VALUES ('US1980','trungkien9x','892914Tnng',N'Lưu Trung Kiên','09234543125','RL001')
INSERT INTO tblUser
	VALUES ('US1421','trangdepgai9x','89315732Tava',N'Trần Thị Thảo Trang','0989755423','RL001')
INSERT INTO tblUser
	VALUES ('US1425','trangdesfa','8931a57g32Tava',N'Lê Đức Anh','0989755423','RL002')
	select * from tblUser
-- Meeting

CREATE TABLE tblTimeTable(
	TimetableID varchar(10) not null,
	StartTime DATETIME,
	EndTime DATETIME,
	DayOfWeek nvarchar(255) not null,
	StatusOfMeeting nvarchar(255) not null,
	BookingID varchar(10) not null,
	TrainerID varchar(10) not null
)
ALTER TABLE tblTimeTable
	ADD CONSTRAINT PK_tblTimeTable PRIMARY KEY (TimetableID)
ALTER TABLE tblTimeTable
	ADD CONSTRAINT FK_tblTimeTable_booking FOREIGN KEY (BookingID) REFERENCES tblBooking(BookingID)
ALTER TABLE tblTimeTable
	ADD CONSTRAINT FK_tblTimeTable_Trainer FOREIGN KEY (TrainerID) REFERENCES tblUser(UserID) on delete cascade

ALTER TABLE tblTimeTable
	ADD CONSTRAINT check_tgian_gapmat CHECK (EndTime > StartTime)
ALTER TABLE tblTimeTable
	ADD CONSTRAINT UNIQUE_tblTimeTalbe UNIQUE (StartTime, EndTime,DayOfWeek)
	select * from tblBooking
	select * from tblServiceTrainer
	
--DATA

INSERT INTO tblTimeTable
	VALUES('TT0001','2020-10-26 07:00:00','2020-10-26 08:00:00',N'Monday',N'Attended','BK0001','US1757')
INSERT INTO tblTimeTable
	VALUES('TT0002','2020-10-26 13:00:00','2020-10-26 15:00:00',N'Monday',N'Not Yet','BK0001','US1757')
INSERT INTO tblTimeTable
	VALUES('TT0003','2020-10-27 07:00:00','2020-10-27 08:00:00',N'Tuesday',N'Not Yet','BK0002','US1892')
INSERT INTO tblTimeTable
	VALUES('TT0004','2020-10-27 16:00:00','2020-10-27 17:00:00',N'Tuesday',N'Not Yet','BK0002','US1892')
INSERT INTO tblTimeTable
	VALUES('TT0005','2020-10-31 07:00:00','2020-10-31 08:00:00',N'Saturday',N'Attended','BK0003','US1892')
INSERT INTO tblTimeTable
	VALUES('TT0006','2020-11-01 09:00:00','2020-11-01 10:00:00',N'Sunday',N'Not Yet','BK0004','US1757')
INSERT INTO tblTimeTable
	VALUES('TT0007','2020-10-30 09:00:00','2020-10-30 10:00:00',N'Friday',N'Not Yet','BK0004','US1757')
INSERT INTO tblTimeTable
	VALUES('TT0008','2020-11-02 09:00:00','2020-11-02 10:00:00',N'Monday',N'Not Yet','BK0005','US1757')
INSERT INTO tblTimeTable
	VALUES('TT0009','2020-11-04 07:00:00','2020-11-04 08:00:00',N'Thursday',N'Not Yet','BK0005','US1757')
	select * from tblTimeTable
--03.Message:
CREATE TABLE tblMessage(
	MessageID VARCHAR(10) not null,
	Author NVARCHAR(255) not null,
	TimeSend DATETIME not null,
	Content NVARCHAR(255) not null,
	CustomerID VARCHAR(10) not null,
	TrainerID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblMessage
	ADD CONSTRAINT PK_tblMessage PRIMARY KEY (MessageID)
--Foreign Key
ALTER TABLE tblMessage
	ADD CONSTRAINT FK_tblMessage_Customer FOREIGN KEY (CustomerID) REFERENCES tblUser(UserID) ON DELETE CASCADE
ALTER TABLE tblMessage
	ADD CONSTRAINT FK_tblMessage_Trainer FOREIGN KEY (TrainerID) REFERENCES tblUser(UserID)
--Data

INSERT INTO tblMessage
	VALUES ('MS0001',N'Customer','2020-10-25 01:05:10 PM',N'Hi! Could you talk about service?','US1412','US1757')
INSERT INTO tblMessage
	VALUES ('MS0002',N'Trainer','2020-10-25 01:10:10 PM',N'I provide many service you can see','US1412','US1757')
INSERT INTO tblMessage
	VALUES ('MS0003',N'Customer','2020-10-25 01:15:10 PM',N'Ok. Thanks.','US1412','US1757')
INSERT INTO tblMessage
	VALUES ('MS0004',N'Customer','2020-10-26 05:02:10 PM',N'Hi! Could you have free time in saturday?','US1642','US1892')
INSERT INTO tblMessage
	VALUES ('MS0005',N'Trainer','2020-10-26 05:05:10 PM',N'Uh hmmm. I am free at 2pm','US1642','US1892')
INSERT INTO tblMessage
	VALUES ('MS0006',N'Customer','2020-10-26 05:07:10 PM',N'Ok. Help me practice','US1642','US1892')
INSERT INTO tblMessage
	VALUES ('MS0007',N'Trainer','2020-10-26 05:08:10 PM',N'See you at the gym','US1642','US1892')

--04.Service:
select * from tblServiceTrainer
CREATE TABLE tblService(
	ServiceID VARCHAR(10) not null,
	Category NVARCHAR(255) not null,
	ServiceName NVARCHAR(255) not null
)
--Primary Key
ALTER TABLE tblService
	ADD CONSTRAINT PK_tblService PRIMARY KEY (ServiceID)
--Data
INSERT INTO tblService
	VALUES ('SV001',N'Yoga',N'Hatha Yoga')
INSERT INTO tblService
	VALUES ('SV002',N'Yoga',N'Vinyasa')
INSERT INTO tblService
	VALUES ('SV003',N'Yoga',N'Ashtanga Yoga')
INSERT INTO tblService
	VALUES ('SV004',N'Upper Body',N'Complex Upper Body')
INSERT INTO tblService
	VALUES ('SV005',N'Upper Body',N'Chest & Arms')
INSERT INTO tblService
	VALUES ('SV006',N'Upper Body',N'Shoulders & Upper Back')
INSERT INTO tblService
	VALUES ('SV007',N'Dance',N'Sexy Dance')
	select * from tblService


--05.ServiceTrainer
CREATE TABLE tblServiceTrainer(
	STID VARCHAR(10) not null,
	PRICE FLOAT not null,
	TimeStudy NVARCHAR(255) not null,
	ServiceID VARCHAR(10) not null,
	TrainerID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblServiceTrainer
	ADD CONSTRAINT PK_tblServiceTrainer PRIMARY KEY (STID)
--Foreign Key
ALTER TABLE tblServiceTrainer
	ADD CONSTRAINT FK_tblServiceTrainer_Service FOREIGN KEY (ServiceID) REFERENCES tblService(ServiceID) ON DELETE CASCADE
ALTER TABLE tblServiceTrainer
	ADD CONSTRAINT FK_tblServiceTrainer_Trainer FOREIGN KEY (TrainerID) REFERENCES tblUser(UserID) ON DELETE CASCADE
--Data
INSERT INTO tblServiceTrainer
	VALUES ('ST001',100,N'4 Week','SV001','US1757')
INSERT INTO tblServiceTrainer
	VALUES ('ST002',200,N'2 Month','SV002','US1757')
INSERT INTO tblServiceTrainer
	VALUES ('ST003',150,N'3 Week','SV003','US1757')
INSERT INTO tblServiceTrainer
	VALUES ('ST004',300,N'6 Week','SV001','US1892')
INSERT INTO tblServiceTrainer
	VALUES ('ST005',120,N'3 Month','SV004','US1892')
INSERT INTO tblServiceTrainer
	VALUES ('ST006',100,N'3 Week','SV005','US1892')
INSERT INTO tblServiceTrainer
	VALUES ('ST007',500,N'6 Month','SV007','US1892')
	select * from tblServiceTrainer
--06.Booking

CREATE TABLE tblBooking(
	BookingID VARCHAR(10) not null,
	ContentBooking NVARCHAR(255) not null,
	TimeBooking DATETIME not null,
	StatusBooking NVARCHAR(255) not null,
	ContentReview NVARCHAR(255) null,
	Rate int null,
	TimeReview DATETIME null,
	CustomerID VARCHAR(10) not null,
	STID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblBooking
	ADD CONSTRAINT PK_tblBooking PRIMARY KEY (BookingID)
--Foreign Key
ALTER TABLE tblBooking
	ADD CONSTRAINT FK_tblBooking_Customer FOREIGN KEY (CustomerID) REFERENCES tblUser(UserID) ON DELETE CASCADE
ALTER TABLE tblBooking
	ADD CONSTRAINT FK_tblBooking_STID FOREIGN KEY (STID) REFERENCES tblServiceTrainer(STID)
--Data
INSERT INTO tblBooking
	VALUES ('BK0001',N'Hi!I want to lose fat','2020-10-20 01:15:10 PM',N'Accepted',N'Service so good!',5,'2020-10-22 02:15:15 PM','US1642','ST003')
INSERT INTO tblBooking
	VALUES ('BK0002',N'Hi! Reply me','2020-09-21 02:15:10 PM',N'Waiting',NULL,NULL,NULL,'US1412','ST005')
INSERT INTO tblBooking
	VALUES ('BK0003',N'Hello! I want to study dance','2020-10-21 03:15:10 PM',N'Accepted',N'Trainer is very good!',5,'2020-10-29 02:15:15 PM','US1235','ST007')
INSERT INTO tblBooking
	VALUES ('BK0004',N'Hi! I want to be strong','2020-10-22 04:15:10 PM',N'Waiting',NULL,NULL,NULL,'US1980','ST002')
INSERT INTO tblBooking
	VALUES ('BK0005',N'Hi!I want to be healthy','2020-08-20 05:15:10 PM',N'Accepted',N'Service so good!',5,'2020-10-21 02:15:15 PM','US1421','ST001')
INSERT INTO tblBooking
	VALUES ('BK0006',N'Lorem is amaaaa','2020-09-20 05:15:10 PM',N'Accepted',N'Good!',5,'2020-09-21 02:15:15 PM','US1421','ST004')
INSERT INTO tblBooking
	VALUES ('BK0007',N'Lois ama ka','2020-10-20 05:15:10 PM',N'Accepted',N'Good!',5,'2020-10-21 02:15:15 PM','US1642','ST004')
	select * from tblBooking
	select * from tblUser
--07.Lesson
CREATE TABLE tblLesson(
	LessonID VARCHAR(10) not null,
	Title NVARCHAR(255) not null,

	Decription NVARCHAR(255) not null,
	STID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblLesson
	ADD CONSTRAINT PK_tblLesson PRIMARY KEY (LessonID)
--Foreign Key
ALTER TABLE tblLesson
	ADD CONSTRAINT FK_tblLesson FOREIGN KEY (STID) REFERENCES tblServiceTrainer(STID) ON DELETE CASCADE
	select * from tblServiceTrainer
--Data
INSERT INTO tblLesson
	VALUES ('LS001',N'Weight Loss Starter',N'Training about burning fat and calories','ST001')
INSERT INTO tblLesson
	VALUES ('LS002',N'Yoga Starter',N'Reduce weight, hold efficiency for a long term','ST002')
INSERT INTO tblLesson
	VALUES ('LS003',N'Yoga Power',N'Reduce weight, healthy','ST003')
INSERT INTO tblLesson
	VALUES ('LS004',N'Balanced Weight',N'Training about burning fat and calories','ST001')
INSERT INTO tblLesson
	VALUES ('LS005',N'Dynamic Stretching',N'Restores the body, helps you relax','ST004')
INSERT INTO tblLesson
	VALUES ('LS006',N'Gentle',N'Restores the body.','ST005')

--08.UserLesson
CREATE TABLE tblUserLesson(
	ULID VARCHAR(10) not null,
	TimeStart DATETIME not null,
	TimeEnd DATETIME not null,
	StatusLesson NVARCHAR(255) not null,
	CustomerID VARCHAR(10) not null,
	LessonID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblUserLesson
	ADD CONSTRAINT PK_tblUserLesson PRIMARY KEY (ULID)
--Foreign Key
ALTER TABLE tblUserLesson
	ADD CONSTRAINT FK_tblUserLesson_Customer FOREIGN KEY (CustomerID) REFERENCES tblUser(UserID) ON DELETE CASCADE
ALTER TABLE tblUserLesson
	ADD CONSTRAINT FK_tblUserLesson_Lesson FOREIGN KEY (LessonID) REFERENCES tblLesson(LessonID) ON DELETE NO ACTION
--Data

INSERT INTO tblUserLesson
	VALUES ('UL001','2020-10-20 01:20:01 PM','2020-12-20 01:20:01 PM',N'Pass','US1642','LS003')

INSERT INTO tblUserLesson
	VALUES ('UL002','2020-10-19 01:20:01 PM','2020-12-21 01:20:01 PM',N'Not Pass','US1642','LS002')

INSERT INTO tblUserLesson
	VALUES ('UL003','2020-10-22 01:20:01 PM','2020-11-20 01:20:01 PM',N'Pass','US1421','LS005')

INSERT INTO tblUserLesson
	VALUES ('UL004','2020-10-18 01:20:01 PM','2020-11-15 01:20:01 PM',N'Not Pass','US1421','LS006')
INSERT INTO tblUserLesson
	VALUES ('UL005','2020-10-16 01:20:01 PM','2020-11-16 01:20:01 PM',N'Pass','US1421','LS004')

--09.Excercise
CREATE TABLE tblExcercise(
	ExcerciseID VARCHAR(10) not null,
	Content NVARCHAR(255) not null,
	LessonID VARCHAR(10) not null,
	TrainerID VARCHAR(10) not null
)
--Primary Key
ALTER TABLE tblExcercise
	ADD CONSTRAINT PK_tblExcercise PRIMARY KEY (ExcerciseID)
--Foreign Key
ALTER TABLE tblExcercise
	ADD CONSTRAINT FK_Excercise FOREIGN KEY (LessonID) REFERENCES tblLesson(LessonID) ON DELETE CASCADE
ALTER TABLE tblExcercise
	ADD CONSTRAINT FK_Excercise_Trainer FOREIGN KEY (TrainerID) REFERENCES tblUser(UserID) 
--Data
select * from tblLesson
select * from tblUser
INSERT INTO tblExcercise
	VALUES ('E001',N'Make a video clip follow the Lesson','LS001','US1757')
INSERT INTO tblExcercise
	VALUES ('E002',N'Make a video clip report','LS002','US1757')
INSERT INTO tblExcercise
	VALUES ('E003',N'Make a video clip do all the excercise','LS003','US1757')
INSERT INTO tblExcercise
	VALUES ('E004',N'Make a video clip follow the Lesson','LS004','US1892')
INSERT INTO tblExcercise
	VALUES ('E005',N'Make a video clip follow the Lesson','LS004','US1757')
INSERT INTO tblExcercise
	VALUES ('E006',N'Make a video clip follow the Lesson','LS005','US1892')
INSERT INTO tblExcercise
	VALUES ('E007',N'Make a video clip follow the Lesson','LS006','US1892')

--10.UserExcercise
CREATE TABLE tblUserExcercise(
	ExcerciseID VARCHAR(10) not null,
	CustomerID VARCHAR(10) not null,
	Comment NVARCHAR(255) not null,
	TimeUpExcercise DATETIME not null,
	Grade FLOAT not null
	
)
--Primary Key
ALTER TABLE tblUserExcercise
	ADD CONSTRAINT PK_tblUserExcercise PRIMARY KEY (ExcerciseID,CustomerID)
--Foreign Key
ALTER TABLE tblUserExcercise
	ADD CONSTRAINT FK_tblUserExcercise_Excercise FOREIGN KEY (ExcerciseID) REFERENCES tblExcercise(ExcerciseID) ON DELETE CASCADE
ALTER TABLE tblUserExcercise
	ADD CONSTRAINT FK_tblUserExcercise_Customer FOREIGN KEY (CustomerID) REFERENCES tblUser(UserID)

--DATA
INSERT INTO tblUserExcercise
	VALUES ('E001','US1642',N'Verry good!','2020-10-25 05:30:10 PM',10)
INSERT INTO tblUserExcercise
	VALUES ('E002','US1642',N'Not Bad!','2020-10-26 05:30:10 PM',9)
INSERT INTO tblUserExcercise
	VALUES ('E006','US1421',N'Verry good!','2020-10-25 05:30:10 PM',10)
INSERT INTO tblUserExcercise
	VALUES ('E005','US1421',N'Not good!! Should do again','2020-10-27 05:30:10 PM',5)
select * from tblMessage

--Liệt kê xem trainer Lê Quốc Đạt có những service nào
SELECT ST.ServiceID, SV.ServiceName   
	FROM tblServiceTrainer ST INNER JOIN tblUser US on ST.TrainerID = US.UserID INNER JOIN tblService SV ON ST.ServiceID = SV.ServiceID 
		WHERE US.FullName = N'Lê Quốc Đạt'


--Xem customer book những service nào của trainer nào

SELECT US.UserID, US.FullName, SV.ServiceName, ST.TrainerID, tblUser.FullName  
	FROM tblBooking BK INNER JOIN tblUser US ON BK.CustomerID = US.UserID 
	INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID INNER JOIN tblService SV 
	ON ST.ServiceID = SV.ServiceID  INNER JOIN tblUser ON ST.TrainerID = tblUser.UserID 

--In ra danh sách Trainer

SELECT * FROM tblUser INNER JOIN tblRole on tblUser.RoleID = tblRole.RoleID WHERE tblRole.RoleID = 'RL002'

--In ra danh sách booking đã được chấp nhận
SELECT * FROM tblBooking WHERE StatusBooking = N'Accepted'
--In ra danh sách khách hàng đã có khóa học tại app
SELECT DISTINCT US.UserID, US.FullName FROM tblUserLesson UL INNER JOIN tblUser US ON UL.CustomerID = US.UserID

--In ra danh sách service

SELECT DISTINCT SV.ServiceID, SV.ServiceName
	FROM tblService SV INNER JOIN tblServiceTrainer ST ON SV.ServiceID = ST.ServiceID

--In ra danh mỗi trainer có bao nhiêu học sinh

SELECT ST.TrainerID, COUNT(BK.CustomerID) AS 'NumberStudent' FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID 
			WHERE BK.StatusBooking = N'Accepted' GROUP BY ST.TrainerID

--In ra trainer da cham diem nhung bai tap nao
select tblUserExcercise.CustomerID,usn.FullName ,tblUserExcercise.ExcerciseID,tblUserExcercise.Grade, tblUser.UserID , tblUser.FullName 
from tblUserExcercise inner join tblExcercise on tblUserExcercise.ExcerciseID = tblExcercise.ExcerciseID 
	inner join tblUser on tblUser.UserID = tblExcercise.TrainerID 
		inner join tblUser usn on tblUserExcercise.CustomerID = usn.UserID

--IN ra thoi gian bieu cua các trainer
SELECT TT.TrainerID, US.FullName, TT.StartTime, TT.EndTime, TT.DayOfWeek 
	FROM tblUser US inner join tblTimeTable TT on US.UserID = TT.TrainerID
---------------------------------------------------------------------------------------------------------------------------------------

--Những dịch vụ được book trong 1 tháng trước
SELECT SV.ServiceID as 'Service ID', SV.ServiceName as 'Service Name', BK.TimeBooking as 'Time Booking' 
	FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID
			INNER JOIN tblService SV ON ST.ServiceID = SV.ServiceID  
				WHERE MONTH(TimeBooking) = (SELECT MONTH(GETDATE())-1)
--Tổng tiền dịch vụ được book trong tháng rồi
SELECT SUM(ST.PRICE) as 'Total Money'
	FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID
			INNER JOIN tblService SV ON ST.ServiceID = SV.ServiceID  
				WHERE MONTH(TimeBooking) = (SELECT MONTH(GETDATE())-1)
--Top 3 dịch vụ được book nhiều nhất
 
SELECT ST.ServiceID, COUNT(ST.ServiceID) FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID GROUP BY ST.ServiceID
			
SELECT Top 3 A.ServiceID, SV.Category, SV.ServiceName, A.[So Lan Book] FROM 
	(SELECT ST.ServiceID, COUNT(ST.ServiceID) as 'So Lan Book'  FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID GROUP BY ST.ServiceID)
	 as A INNER JOIN tblService SV ON A.ServiceID = SV.ServiceID
--Dịch vụ có doanh thu cao nhất trong tháng rồi
SELECT ST.ServiceID, SUM(ST.PRICE) as 'Tong Tien', COUNT(ST.ServiceID) as 'So Lan Book' 
	FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID 
		GROUP BY ST.ServiceID 
SELECT SV.ServiceID as 'Service ID'
	FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID
			INNER JOIN tblService SV ON ST.ServiceID = SV.ServiceID  
				WHERE MONTH(TimeBooking) = (SELECT MONTH(GETDATE())-1)

SELECT TOP 1 ST.ServiceID, SUM(ST.PRICE) as 'Tong Tien', COUNT(ST.ServiceID) as 'So Lan Book' 
	FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID 
		GROUP BY ST.ServiceID 
			HAVING ST.ServiceID in (SELECT SV.ServiceID as 'Service ID'
				FROM tblBooking BK INNER JOIN tblServiceTrainer ST ON BK.STID = ST.STID
					INNER JOIN tblService SV ON ST.ServiceID = SV.ServiceID  
						WHERE MONTH(TimeBooking) = (SELECT MONTH(GETDATE())-1)) 

