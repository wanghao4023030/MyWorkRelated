/* Insert the patient from HIS patient table to ECS subscribedPatient table*/
   DECLARE @PATIENTID VARCHAR(50)
   DECLARE Cur Cursor For  Select PatientID from Openquery(HIS1,'SELECT *  FROM [ECS].[dbo].[Patient]')
   OPEN Cur 
   FETCH NEXT FROM Cur INTO @PATIENTID
   WHILE @@FETCH_STATUS = 0
   BEGIN
	INSERT INTO ECS.dbo.SubscribedPatient VALUES (@PATIENTID,'2016-12-01 17:04:45.320')
	FETCH NEXT FROM Cur INTO @PATIENTID
   END
   CLOSE Cur
   DEALLOCATE Cur
