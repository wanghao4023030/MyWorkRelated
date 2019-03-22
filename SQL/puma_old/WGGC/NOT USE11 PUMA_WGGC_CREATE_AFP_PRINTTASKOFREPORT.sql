USE WGGC
GO

DECLARE @TaskSN      INT
DECLARE @StudyInstanceUID      VARCHAR(100)
DECLARE @AccessionNumber      VARCHAR(100)

DECLARE @TIME VARCHAR(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)

WHILE @LOOPNUMBER <= 1000000
BEGIN

SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')

SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')
SET @StudyInstanceUID   =   '1.2.840.113564.86.3.0.18467.'+  @DATEForInstanceUID + '.1234'
SET  @AccessionNumber   = 'DIRTYA' + LEFT(@TIME,14)

SET  @TaskSN = (SELECT MAX(TaskSN) FROM WGGC.DBO.AFP_PrintTaskOfReport)
IF @TaskSN IS NULL
	SET @TaskSN=1
ELSE
	SET @TaskSN = (SELECT MAX(TaskSN) FROM WGGC.DBO.AFP_PrintTaskOfReport)+1

INSERT  WGGC.DBO.AFP_PrintTaskOfReport (
      [TaskSN],[StudyInstanceUID],[AccessionNumber]
)
VALUES(
      @TaskSN,@StudyInstanceUID,@AccessionNumber
)


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;