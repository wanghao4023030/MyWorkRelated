USE WGGC
GO

DECLARE @StudyInstanceUID     VARCHAR(100)
DECLARE @FilmFlag     VARCHAR(100)
DECLARE @ForbidReason     VARCHAR(100)
DECLARE @FilmPrintTime     VARCHAR(100)
DECLARE @AccessionNumber     VARCHAR(100)
DECLARE @PatientName     VARCHAR(100)
DECLARE @PatientID     VARCHAR(100)
DECLARE @PatientSex     VARCHAR(100)
DECLARE @PatientType     VARCHAR(100)
DECLARE @StudyDate     VARCHAR(100)
DECLARE @StudyTime     VARCHAR(100)
DECLARE @Modalities     VARCHAR(100)
DECLARE @CallingAE     VARCHAR(100)
DECLARE @CallingIP     VARCHAR(100)
DECLARE @ImageCount     VARCHAR(100)
DECLARE @PrintCount     VARCHAR(100)
DECLARE @DeleteStatus     VARCHAR(100)
DECLARE @FilmSizeID     VARCHAR(100)
DECLARE @MediumType     VARCHAR(100)
DECLARE @FilmOrientation     VARCHAR(100)
DECLARE @FilmSessionLabel     VARCHAR(100)
DECLARE @FilmDestination     VARCHAR(100)
DECLARE @Priority     VARCHAR(100)
DECLARE @Copies     VARCHAR(100)
DECLARE @BorderDensity     VARCHAR(100)
DECLARE @EmptyImageDensity     VARCHAR(100)
DECLARE @MinDensity     VARCHAR(100)
DECLARE @MaxDensity     VARCHAR(100)
DECLARE @Trim     VARCHAR(100)
DECLARE @Configuration     VARCHAR(100)
DECLARE @MagnificationType     VARCHAR(100)
DECLARE @SmoothingType     VARCHAR(100)
DECLARE @CreatedTime     VARCHAR(100)
DECLARE @StatusTime     VARCHAR(100)
DECLARE @DepartmentID     INT
DECLARE @ExamName     VARCHAR(100)
DECLARE @BodyPart     VARCHAR(100)
DECLARE @PhotoMetric     VARCHAR(100)
DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)


WHILE @LOOPNUMBER <= 500000
BEGIN
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')


SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')

SET @StudyInstanceUID     = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';
SET @FilmFlag     = 0 
SET @ForbidReason     = 0
SET @FilmPrintTime     = @RANDTIME
SET @AccessionNumber     = 'DIRTY'+@TIME
SET @PatientName     = 'DIRTY'+@TIME
SET @PatientID     = 'DIRTY'+@TIME

IF @LOOPNUMBER%2 = 0 
SET @PatientSex = 'ÄÐ'

IF @LOOPNUMBER%2 = 1 
SET @PatientSex = 'Å®'


SET @PatientType     = 3
SET @StudyDate     = LEFT(@DATEForInstanceUID,8)
SET @StudyTime     = LEFT(@DATEForInstanceUID,6)
IF @LOOPNUMBER%5 = 0 
SET @Modalities = 'CR'

IF @LOOPNUMBER%5 = 1 
SET @Modalities = 'CT'

IF @LOOPNUMBER%5 = 2 
SET @Modalities = 'DX'

IF @LOOPNUMBER%5 = 3 
SET @Modalities = 'MR'

IF @LOOPNUMBER%5 = 4 
SET @Modalities = 'US'

SET @CallingAE     = 'IMAGESUITE' + CAST(CAST(RAND()*(10-1)+1 AS INT) AS VARCHAR(2))
SET @CallingIP     = '10.184.128.21' + CAST(CAST(RAND()*(9-1)+1 AS INT) AS VARCHAR(2))
SET @ImageCount     = 1
SET @PrintCount     = 1
SET @DeleteStatus     = 0

IF @LOOPNUMBER%5 = 0 

SET @FilmSizeID     = '8INX10IN'

IF @LOOPNUMBER%5 = 1 

SET @FilmSizeID     = '10INX12IN'

IF @LOOPNUMBER%5 = 2 

SET @FilmSizeID     = '11INX14IN'

IF @LOOPNUMBER%5 = 3 

SET @FilmSizeID     = '14INX14IN'

IF @LOOPNUMBER%5 = 4 

SET @FilmSizeID     = '14INX17IN'


SET @MediumType     = 'BLUE FILM'
SET @FilmOrientation     = 'PORTRAIT'
SET @FilmSessionLabel     = @CallingAE
SET @FilmDestination     =' BIN_1'
SET @Priority     = 'HIGH'
SET @Copies     = 1
SET @BorderDensity     = 'BLACK'
SET @EmptyImageDensity     = 'BLACK'
SET @MinDensity     = 21
SET @MaxDensity     = 300
SET @Trim     = 'NO' 
SET @Configuration     = ''
SET @MagnificationType     = ''
SET @SmoothingType     = '' 
SET @CreatedTime     = CONVERT(varchar,GETDATE(),121)
SET @StatusTime     = CONVERT(varchar,GETDATE(),121)
SET @DepartmentID     = @LOOPNUMBER%10
SET @ExamName     =  'DIRTY'+@TIME
SET @PhotoMetric     = NULL

IF @LOOPNUMBER%5 = 0 
SET @BodyPart = 'CHEST'

IF @LOOPNUMBER%5 = 1 
SET @BodyPart = 'HEAD'

IF @LOOPNUMBER%5 = 2 
SET @BodyPart = 'LEG'

IF @LOOPNUMBER%5 = 3 
SET @BodyPart = 'HAND'

IF @LOOPNUMBER%5 = 4 
SET @BodyPart = 'OTHER'

INSERT [WGGC].[dbo].[AFP_FilmInfo] (
[StudyInstanceUID],[FilmFlag],[ForbidReason],[FilmPrintTime],[AccessionNumber],[PatientName],[PatientID],[PatientSex],[PatientType],[StudyDate],[StudyTime]
,[Modalities],[CallingAE],[CallingIP],[ImageCount],[PrintCount],[DeleteStatus],[FilmSizeID],[MediumType],[FilmOrientation],[FilmSessionLabel],[FilmDestination]
,[Priority],[Copies],[BorderDensity],[EmptyImageDensity],[MinDensity],[MaxDensity],[Trim],[Configuration],[MagnificationType],[SmoothingType],[CreatedTime]
,[StatusTime],[DepartmentID],[ExamName],[BodyPart],[PhotoMetric]

)
  VALUES(
  @StudyInstanceUID,@FilmFlag,@ForbidReason,@FilmPrintTime,@AccessionNumber,@PatientName,@PatientID,@PatientSex,@PatientType,@StudyDate,@StudyTime
,@Modalities,@CallingAE,@CallingIP,@ImageCount,@PrintCount,@DeleteStatus,@FilmSizeID,@MediumType,@FilmOrientation,@FilmSessionLabel,@FilmDestination
,@Priority,@Copies,@BorderDensity,@EmptyImageDensity,@MinDensity,@MaxDensity,@Trim,@Configuration,@MagnificationType,@SmoothingType,@CreatedTime
,@StatusTime,@DepartmentID,@ExamName,@BodyPart,@PhotoMetric

  )






SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;