
--This script is to create the patients in HIS system database.;
--You should use the chinese character is better for simulate the data;
--Ralf Wang


DECLARE @LOOPNUMBER INT = 0;
DECLARE @DOB DATE;
DECLARE @DATE varchar(8);
DECLARE @TIME varchar(16);
DECLARE @PatientID varchar(50);
DECLARE @PatientName varchar(50);
DECLARE @PatientAge varchar(50);
DECLARE @PatientGender varchar(50);
DECLARE @PhoneNumber varchar(50);
DECLARE @IDCard varchar(50);
DECLARE @PatientDOB varchar(50);

SET @TIME =  REPLACE(REPLACE(CONVERT(time,GETDATE()),':',''),'.','');

WHILE @LOOPNUMBER <= 1000000
BEGIN
SET @DATE =  REPLACE(CONVERT(date,GETDATE()),'-','');
SET @TIME =  REPLACE(REPLACE(CONVERT(time,GETDATE()),':',''),'.','');
SET @PatientID = 'PID' + LEFT(@DATE+@TIME,16);
SET @PatientName = '性能'+LEFT(@DATE+@TIME,16);
SET @PatientAge = cast(rand()*100 as int);
SET @PatientGender = cast(rand()*2 as int);
SET @PhoneNumber = '13800138000';

DECLARE @i int = 0
SET @IDCard  = cast(ROUND((9*rand() +1),0)	as varchar(50))
WHILE @i < 18 
	BEGIN
		SET @IDCard = @IDCard + cast(ROUND((9*rand() +1),0)	as varchar(50));
		SET @i = @i + 1;
	END 
SET @IDCard = SUBSTRING(@IDCard,1,18);

SET @PatientDOB =CONVERT(date, GETDATE() - RAND()*36000);
	
INSERT [ECS].[dbo].[Patient] 
  (PatientID,PatientName,PatientAge,PatientGender,PhoneNumber,IDCard,PatientDOB)
  Values
  (@PatientID,@PatientName,@PatientAge,@PatientGender,@PhoneNumber,@IDCard,@PatientDOB);

SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.01';
END;
	

	
