USE PT_Online_ASM

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
use PT_Online_ASM

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