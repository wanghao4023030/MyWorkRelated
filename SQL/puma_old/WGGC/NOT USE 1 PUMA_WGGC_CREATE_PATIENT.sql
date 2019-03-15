USE WGGC
GO

DECLARE @SerialNo               numeric(12,0)
DECLARE @PatientGUID            VARCHAR(100)
DECLARE @PatientID              VARCHAR(100)
DECLARE @PatientName            VARCHAR(100)
DECLARE @LocalName              VARCHAR(100)
DECLARE @PatientBirthDate       VARCHAR(100)
DECLARE @PatientAge             VARCHAR(100)
DECLARE @PatientSex             VARCHAR(100)
DECLARE @Comments               VARCHAR(100)
DECLARE @StudyCount             VARCHAR(100)
DECLARE @SeriesCount            VARCHAR(100)
DECLARE @ImageCount             VARCHAR(100)
DECLARE @LatestStudyDateTime    VARCHAR(100)
DECLARE @patientaddress         VARCHAR(100)
DECLARE @contactinfo            VARCHAR(100)
DECLARE @OperateServerAE        VARCHAR(100)
DECLARE @OperateStatus          VARCHAR(100)
DECLARE @vip                    VARCHAR(100)
DECLARE @PhoneticName           VARCHAR(100)
DECLARE @PatientSize            VARCHAR(100)
DECLARE @PatientWeight          VARCHAR(100)
DECLARE @Neutered               VARCHAR(100)
DECLARE @Breed                  VARCHAR(100)
DECLARE @Species                VARCHAR(100)
DECLARE @Owner                  VARCHAR(100)
DECLARE @LOOPNUMBER INT = 1
DECLARE @TIME VARCHAR(1000)
DECLARE @RANDTIME VARCHAR(100)

WHILE @LOOPNUMBER <= 500000
BEGIN
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')
--SET @SerialNo               = ''
SET @PatientGUID            = '{'+ CAST(NEWID()AS VARCHAR(50)) +'}'
SET @PatientID              = 'DIRTY'+@TIME
SET @PatientName            = 'DIRTY'+@TIME
SET @LocalName              = 'DIRTY'+@TIME
--SET @PatientBirthDate       = CONVERT(datetime2, GETDATE() - RAND()*36000);
SET @PatientBirthDate       =  CAST(CAST(RAND()*(2017-1920)+1920 AS int) AS VARCHAR(4)) + '0101'
SET @PatientAge             = CAST(CAST(RAND()*(120-1)+1 AS int) AS VARCHAR(4))+'y'
IF @LOOPNUMBER%2=0
	SET @PatientSex             = 'ÄÐ'
ELSE
	SET @PatientSex             = 'Å®'	
SET @Comments               = ''
SET @StudyCount             = 1
SET @SeriesCount            = 1
SET @ImageCount             = 1
SET @LatestStudyDateTime    = LEFT(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ',''),14)
SET @patientaddress         = NULL
SET @contactinfo            = NULL 
SET @OperateServerAE        = ''
SET @OperateStatus          = 0
SET @vip                    = 0
SET @PhoneticName           = ''
SET @PatientSize            = NULL
SET @PatientWeight          = NULL
SET @Neutered               = NULL
SET @Breed                  = NULL
SET @Species                = NULL
SET @Owner                  = NULL 

/****** Script for SelectTopNRows command from SSMS  ******/
INSERT [WGGC].[dbo].[Patient] (
	[PatientGUID],[PatientID],[PatientName],[LocalName],[PatientBirthDate],[PatientAge],[PatientSex],[Comments]
      ,[StudyCount],[SeriesCount],[ImageCount],[LatestStudyDateTime],[patientaddress],[contactinfo],[OperateServerAE],[OperateStatus]
      ,[vip],[PhoneticName],[PatientSize],[PatientWeight],[Neutered],[Breed],[Species],[Owner]
	  )
VALUES(
		@PatientGUID,@PatientID,@PatientName,@LocalName,@PatientBirthDate,@PatientAge,@PatientSex,@Comments
      ,@StudyCount,@SeriesCount,@ImageCount,@LatestStudyDateTime,@patientaddress,@contactinfo,@OperateServerAE,@OperateStatus
      ,@vip,@PhoneticName,@PatientSize,@PatientWeight,@Neutered,@Breed,@Species,@Owner
)



SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;