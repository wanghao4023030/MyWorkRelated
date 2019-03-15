USE WGGC
GO 

DECLARE @ID             INT
DECLARE @ExternalID     VARCHAR(100)
DECLARE @DepartmentName VARCHAR(100)
DECLARE @ExamLocation   VARCHAR(100)
DECLARE @Valid          VARCHAR(100)


DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =2 
DECLARE @DATEForInstanceUID VARCHAR(100)


WHILE @LOOPNUMBER <= 10
BEGIN


SET @ID             = CAST((SELECT MAX(ID) FROM [WGGC].[dbo].[AFP_Department]) AS INT) + @LOOPNUMBER
SET @ExternalID     = NULL
SET @DepartmentName = 'DEPARTMENT' + CAST(@LOOPNUMBER AS VARCHAR(5))
SET @ExamLocation   = NULL
SET @Valid          = 1

INSERT [WGGC].[dbo].[AFP_Department] (
[ExternalID],[DepartmentName],[ExamLocation],[Valid]

)
  VALUES(
	@ExternalID,@DepartmentName,@ExamLocation,@Valid
  )

PRINT @ID
SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;