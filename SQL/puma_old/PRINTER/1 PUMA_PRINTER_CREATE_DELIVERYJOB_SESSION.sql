USE Printer
GO

DECLARE @LOOPNUMBER INT = 1;
DECLARE @DATEForInstanceUID varchar(18)
DECLARE @JobInstanceUID varchar(100);
DECLARE @SessionInstanceUID varchar(100)
DECLARE @CreateDateTime varchar(100)
DECLARE @NumberOfCopy INT = 1
DECLARE @PrintPriority varchar(100)
DECLARE @MediumType varchar(100)
DECLARE @FilmDestination varchar(100)
DECLARE @FilmSessionLabel varchar(100)
DECLARE @MemoryAllocation varchar(100)
DECLARE @OwnerID               varchar(100)
DECLARE @JobStatus             varchar(100)
DECLARE @RetryCount            varchar(100)
DECLARE @CopiesFinished        varchar(100)
DECLARE @StartPage             varchar(100)
DECLARE @PatientName           varchar(100)
DECLARE @PatientID             varchar(100)
DECLARE @StudyInstanceUID      varchar(100)
DECLARE @AccessionNumber       varchar(100)
DECLARE @ModalityType          varchar(100)
DECLARE @CharacterSet          varchar(100)
DECLARE @IsManually            varchar(100)
DECLARE @Gender                varchar(100)
DECLARE @ExamName              varchar(100)
DECLARE @PatientType           varchar(100)
DECLARE @ModalityName          varchar(100)
DECLARE @ExamDateTime          varchar(100)
DECLARE @ReferringDepartment   varchar(100)
DECLARE @VerifyDateTime        varchar(100)
DECLARE @DeleteStatus          varchar(100)
DECLARE @ForwardStatus         varchar(100)
DECLARE @ForwardFlag           varchar(100)
DECLARE @ForwardDestination    varchar(100)
DECLARE @ForwardedDestination  varchar(100)
DECLARE @PrintJobID            varchar(100)
DECLARE @ForwardUpdateDatetime varchar(100)
DECLARE @PrintStatus           varchar(100)
DECLARE @DepartmentID          varchar(100)
DECLARE @TIME varchar(100)

--seesion

DECLARE @CallingAE          VARCHAR(100)
DECLARE @CallingIP          VARCHAR(100)
DECLARE @CalledAE           VARCHAR(100)
DECLARE @PortNo             VARCHAR(100)
DECLARE @NUMBER varchar(100)





WHILE @LOOPNUMBER <= 984000
BEGIN

	SET @TIME =  REPLACE(REPLACE(CONVERT(time,GETDATE()),':',''),'.','');

	
	SET @CreateDateTime =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
	SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@CreateDateTime,':',''),'-',''),' ','')
	SET @JobInstanceUID = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';
	SET @SessionInstanceUID =@JobInstanceUID
	SET @NumberOfCopy = 1

	IF @LOOPNUMBER%10 = 0 
		SET @PrintPriority='MED'
	ELSE 
		SET @PrintPriority='HIGH'



	SET @MediumType = 'BLUE FILM'

	IF @LOOPNUMBER%10 = 0 
		SET @FilmDestination='PROCESSOR'
	ELSE 
		SET @FilmDestination='BIN_1'


	SET @FilmSessionLabel ='DirtyData'+ CONVERT(varchar,@LOOPNUMBER%10)
	SET @MemoryAllocation =''
	SET @OwnerID               = ''
	SET @JobStatus             = 2
	SET @RetryCount            = 0
	SET @CopiesFinished        = 0
	SET @StartPage             = 0
	SET @PatientName           = 'dirty' + @DATEForInstanceUID
	SET @PatientID             = 'dirtyP' + @DATEForInstanceUID
	SET @StudyInstanceUID      = @JobInstanceUID
	SET @AccessionNumber       = 'dirtyA' + @DATEForInstanceUID

	IF @LOOPNUMBER%5 = 0 
	SET @ModalityType = 'CR'

	IF @LOOPNUMBER%5 = 1 
	SET @ModalityType = 'CT'

	IF @LOOPNUMBER%5 = 2 
	SET @ModalityType = 'DX'

	IF @LOOPNUMBER%5 = 3 
	SET @ModalityType = 'MR'

	IF @LOOPNUMBER%5 = 4 
	SET @ModalityType = 'US'

	SET @CharacterSet          = ''
	SET @IsManually            = '0'

	IF @LOOPNUMBER%2 = 0 
		SET @Gender = N'ÄÐ'
	ELSE
		SET @Gender = N'Å®'

	SET @ExamName              = 'dirtyExnam'+ @DATEForInstanceUID
	SET @PatientType           = '3'
	SET @ModalityName          = 'KODAK_' + @ModalityType
	SET @ExamDateTime          =  @CreateDateTime
	SET @ReferringDepartment   = NULL
	SET @VerifyDateTime        = @CreateDateTime
	SET @DeleteStatus          = 0
	SET @ForwardStatus         = 0
	SET @ForwardFlag           = 0
	SET @ForwardDestination    = NULL
	SET @ForwardedDestination  = NULL
	SET @PrintJobID            = NULL
	SET @ForwardUpdateDatetime = @CreateDateTime
	SET @PrintStatus           = 0
	SET @DepartmentID          = @LOOPNUMBER%10


	INSERT [Printer].[dbo].[DeliveryJob] 
  ([JobInstanceUID],[SessionInstanceUID],[CreateDateTime],[NumberOfCopy],[PrintPriority],[MediumType],[FilmDestination],[FilmSessionLabel]
      ,[MemoryAllocation],[OwnerID],[JobStatus],[RetryCount],[CopiesFinished],[StartPage],[PatientName],[PatientID],[StudyInstanceUID],[AccessionNumber]
      ,[ModalityType],[CharacterSet],[IsManually],[Gender],[ExamName],[PatientType],[ModalityName],[ExamDateTime],[ReferringDepartment],[VerifyDateTime],[DeleteStatus]
      ,[ForwardStatus],[ForwardFlag],[ForwardDestination],[ForwardedDestination],[PrintJobID],[ForwardUpdateDatetime],[PrintStatus],[DepartmentID])
Values(
	   @JobInstanceUID,@SessionInstanceUID,@CreateDateTime,@NumberOfCopy,@PrintPriority,@MediumType,@FilmDestination,@FilmSessionLabel,@MemoryAllocation,@OwnerID,@JobStatus
      ,@RetryCount,@CopiesFinished,@StartPage,@PatientName,@PatientID,@StudyInstanceUID,@AccessionNumber,@ModalityType,@CharacterSet,@IsManually,@Gender,@ExamName,@PatientType
      ,@ModalityName,@ExamDateTime,@ReferringDepartment,@VerifyDateTime,@DeleteStatus,@ForwardStatus,@ForwardFlag,@ForwardDestination,@ForwardedDestination,@PrintJobID,@ForwardUpdateDatetime
      ,@PrintStatus,@DepartmentID
)



SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ','')
--SET @SessionInstanceUID     = @SessionInstanceUID
SET @NUMBER = convert(varchar,@LOOPNUMBER%10);

SET @CallingAE = 'AE12' + @NUMBER
SET @CallingIP          = '10.184.129.12' + @NUMBER
SET @CalledAE           = 'ImageSuite' + @NUMBER
SET @PortNo             = '7' + @NUMBER

INSERT   [Printer].[dbo].[Session](
	   [SessionInstanceUID],[CallingAE],[CallingIP],[CalledAE],[PortNo]
	  )
	  VALUES(
	 @SessionInstanceUID,@CallingAE,@CallingIP,@CalledAE,@PortNo
	  );


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;