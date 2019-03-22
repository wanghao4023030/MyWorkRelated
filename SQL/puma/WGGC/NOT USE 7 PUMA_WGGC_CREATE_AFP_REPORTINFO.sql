USE WGGC
GO

DECLARE @StudyInstanceUID        VARCHAR(100)
DECLARE @ReportStatus           VARCHAR(100)
DECLARE @StatusTime              VARCHAR(100)
DECLARE @AccessionNumber         VARCHAR(100)
DECLARE @FileName                VARCHAR(100)
DECLARE @PatientID               VARCHAR(100)
DECLARE @PatientName             VARCHAR(100)
DECLARE @PrintTime               VARCHAR(100)
DECLARE @PrintStatus             VARCHAR(100)
DECLARE @DeleteStatus            VARCHAR(100)
DECLARE @PrintCount              VARCHAR(100)
DECLARE @Gender                  VARCHAR(100)
DECLARE @ExamName                VARCHAR(100)
DECLARE @PatientType             VARCHAR(100)
DECLARE @ModalityName            VARCHAR(100)
DECLARE @ExamDateTime            VARCHAR(100)
DECLARE @ReferringDepartment     VARCHAR(100)
DECLARE @VerifyDateTime          VARCHAR(100)
DECLARE @ModalityType            VARCHAR(100)
DECLARE @ForwardDestination      VARCHAR(100)
DECLARE @ForwardDateTime         VARCHAR(100)
DECLARE @BodyPart                VARCHAR(100)
DECLARE @AAccessionNumber        VARCHAR(100)
DECLARE @AStudyInstanceUID       VARCHAR(100)
DECLARE @CreatedTime             VARCHAR(100)
DECLARE @DepartmentID            VARCHAR(100)
DECLARE @PageCount               VARCHAR(100)
DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)

WHILE @LOOPNUMBER <= 500000
BEGIN
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')

SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')

SET @StudyInstanceUID     = NEWID()
SET @ReportStatus     = 2
SET @StatusTime     = @RANDTIME
SET @AccessionNumber     = 'DIRTYA'+@TIME
SET @FileName     = 'E:\Report\Archive\'+ LEFT(@DATEForInstanceUID,8) + '\' + LEFT(@DATEForInstanceUID,14) + '.pdf'
SET @PatientName     = 'DIRTYN'+@TIME
SET @PatientID     = 'DIRTYP'+@TIME
SET @PrintTime = NULL

SET @PrintStatus = 0
SET @DeleteStatus = 0
SET @PrintCount = 1
IF @LOOPNUMBER%2 = 0 
SET @Gender = '��'

IF @LOOPNUMBER%2 = 1 
SET @Gender = 'Ů'


SET @ExamName                = 'DIRTYP'+@TIME
SET @PatientType             = 3 
IF @LOOPNUMBER%5 = 0 
SET @ModalityName = 'CR'

IF @LOOPNUMBER%5 = 1 
SET @ModalityName = 'CT'

IF @LOOPNUMBER%5 = 2 
SET @ModalityName = 'DX'

IF @LOOPNUMBER%5 = 3 
SET @ModalityName = 'MR'

IF @LOOPNUMBER%5 = 4 
SET @ModalityName = 'US'


SET @ExamDateTime            = @RANDTIME
SET @ReferringDepartment     = ''
SET @VerifyDateTime          = @RANDTIME
SET @ModalityType            = @ModalityName
SET @ForwardDestination      = NULL
SET @ForwardDateTime         = NULL

IF @LOOPNUMBER%5 = 0 
SET @BodyPart = 'CHEST'

IF @LOOPNUMBER%5 = 1 
SET @BodyPart = 'HEAD'

IF @LOOPNUMBER%5 = 2 
SET @BodyPart = 'LEG'

IF @LOOPNUMBER%5 = 3 
SET @BodyPart = 'FOOT'

IF @LOOPNUMBER%5 = 4 
SET @BodyPart = 'HAND'

SET @AAccessionNumber        = NULL
SET @AStudyInstanceUID       = NULL
SET @CreatedTime             = @RANDTIME
SET @DepartmentID            = @LOOPNUMBER%10 +1
SET @PageCount               = 1


INSERT [WGGC].[dbo].[AFP_ReportInfo] (
[StudyInstanceUID],[ReportStatus],[StatusTime],[AccessionNumber],[FileName],[PatientID],[PatientName],[PrintTime],[PrintStatus],[DeleteStatus],[PrintCount],[Gender],[ExamName]
,[PatientType],[ModalityName],[ExamDateTime],[ReferringDepartment],[VerifyDateTime],[ModalityType],[ForwardDestination],[ForwardDateTime],[BodyPart],[AAccessionNumber],[AStudyInstanceUID]
,[CreatedTime],[DepartmentID],[PageCount]

)
  VALUES(
@StudyInstanceUID,@ReportStatus,@StatusTime,@AccessionNumber,@FileName,@PatientID,@PatientName,@PrintTime,@PrintStatus,@DeleteStatus,@PrintCount,@Gender,@ExamName
,@PatientType,@ModalityName,@ExamDateTime,@ReferringDepartment,@VerifyDateTime,@ModalityType,@ForwardDestination,@ForwardDateTime,@BodyPart,@AAccessionNumber,@AStudyInstanceUID
,@CreatedTime,@DepartmentID,@PageCount
  )
   

SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;