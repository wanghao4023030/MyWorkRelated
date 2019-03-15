USE WGGC
GO 

DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)

DECLARE @PatientID      VARCHAR(100)
DECLARE @TerminalID      VARCHAR(100)
DECLARE @Status      VARCHAR(100)
DECLARE @ImageCount      VARCHAR(100)
DECLARE @ReportCount      VARCHAR(100)
DECLARE @EstimateTime      VARCHAR(100)
DECLARE @ErrorCode      VARCHAR(100)
DECLARE @ErrorDesc      VARCHAR(100)
DECLARE @CreateTime      VARCHAR(100)
DECLARE @ExecuteTime      VARCHAR(100)
DECLARE @FinishTime      VARCHAR(100)
DECLARE @ImagePrinted      VARCHAR(100)
DECLARE @ReportPrinted      VARCHAR(100)
DECLARE @EnableReportPrint      VARCHAR(100)
DECLARE @UserID      VARCHAR(100)
DECLARE @Type      VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)


WHILE @LOOPNUMBER <= 500000
BEGIN

SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')

SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ','')

SET @PatientID      = 'DIRTYP'+@TIME
SET @TerminalID      = (SELECT TOP 1 [TerminalID] FROM [WGGC].[dbo].[AFP_PrintTerminalInfo] ORDER BY NEWID())
SET @Status      = 4
SET @ImageCount      = 1
SET @ReportCount      = 1
SET @EstimateTime      = 110 
SET @ErrorCode      = 0
SET @ErrorDesc      = NULL
SET @CreateTime      = @RANDTIME
SET @ExecuteTime      = @RANDTIME
SET @FinishTime      = @RANDTIME
SET @ImagePrinted      = 1
SET @ReportPrinted      = 1
SET @EnableReportPrint      = 0
SET @UserID      = ''
SET @Type      = 0

INSERT [WGGC].[dbo].[AFP_PrintTask] (
[PatientID],[TerminalID],[Status],[ImageCount],[ReportCount],[EstimateTime],[ErrorCode],[ErrorDesc],[CreateTime],[ExecuteTime]
,[FinishTime],[ImagePrinted],[ReportPrinted],[EnableReportPrint],[UserID],[Type]

)
  VALUES(
@PatientID,@TerminalID,@Status,@ImageCount,@ReportCount,@EstimateTime,@ErrorCode,@ErrorDesc,@CreateTime,@ExecuteTime
,@FinishTime,@ImagePrinted,@ReportPrinted,@EnableReportPrint,@UserID,@Type
  )
  
  





SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;