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


--STUDY


DECLARE @StudyInstanceUID      VARCHAR(100)
DECLARE @StudyDate             VARCHAR(100)
DECLARE @StudyTime             VARCHAR(100)
DECLARE @StudyID               VARCHAR(100)
DECLARE @StudyDescription      VARCHAR(100)
DECLARE @AccessionNo           VARCHAR(100)
DECLARE @Modalities            VARCHAR(100)
DECLARE @ReferPhysician        VARCHAR(100)
DECLARE @Printed               VARCHAR(100)
DECLARE @Readed                VARCHAR(100)
--DECLARE @PatientGUID           VARCHAR(100)
--DECLARE @SeriesCount           VARCHAR(100)
--DECLARE @ImageCount            VARCHAR(100)
DECLARE @Reserved              VARCHAR(100)
DECLARE @InstanceAvailability  VARCHAR(100)
DECLARE @Hide                  VARCHAR(100)
--DECLARE @OperateServerAE       VARCHAR(100)
--DECLARE @OperateStatus         VARCHAR(100)
DECLARE @Problemed             VARCHAR(100)
DECLARE @StudyDir              VARCHAR(100)
DECLARE @AcqDateTime           VARCHAR(100)
DECLARE @QCStatus              VARCHAR(100)
DECLARE @Matched               VARCHAR(100)
DECLARE @Send                  VARCHAR(100)
DECLARE @AcquireStatus         VARCHAR(100)
DECLARE @ErrStatus             VARCHAR(100)
DECLARE @Reordered             VARCHAR(100)
DECLARE @DICOMStorageAE        VARCHAR(100)
DECLARE @BackupAE              VARCHAR(100)
--DECLARE @TIME varchar(100)
--DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
--DECLARE @RANDTIME VARCHAR(100)



WHILE @LOOPNUMBER <= 1000000
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


--STUDY
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')


SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')
SET @StudyInstanceUID = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';
SET @StudyDate             = LEFT(@DATEForInstanceUID,8)
SET @StudyTime             = LEFT(@DATEForInstanceUID,6)
SET @StudyID               = ''
SET @StudyDescription      = ''
SET @AccessionNo           = 'DIRTY'+@TIME

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


SET @ReferPhysician        = '^^^^'
SET @Printed               = 'N'
SET @Readed                = 'N' 
--SET @PatientGUID           = (SELECT TOP 1 PATIENTGUID FROM WGGC.DBO.PATIENT ORDER BY NEWID())
--SET @SeriesCount           = 1
--SET @ImageCount            = 1
SET @Reserved              = 'Y'
SET @InstanceAvailability  = 'ONLINE'
SET @Hide                  = 0
--SET @OperateServerAE       = ''
--SET @OperateStatus         = 0
SET @Problemed             = 'N'
SET @StudyDir              = @StudyDate + '\' + @AccessionNo
SET @AcqDateTime           = CONVERT(varchar,GETDATE(),121)
SET @QCStatus              = 0
SET @Matched               = 'O'
SET @Send                  = 0
SET @AcquireStatus         = 1
SET @ErrStatus             = 0
SET @Reordered             = 0
SET @DICOMStorageAE        = NULL
SET @BackupAE              = NULL



INSERT [WGGC].[dbo].[Study] (
[StudyInstanceUID],[StudyDate],[StudyTime],[StudyID],[StudyDescription],[AccessionNo],[Modalities],[ReferPhysician],[Printed]
,[Readed],[PatientGUID],[SeriesCount],[ImageCount],[Reserved],[InstanceAvailability],[Hide],[OperateServerAE],[OperateStatus],[Problemed]
,[StudyDir],[AcqDateTime],[QCStatus],[Matched],[Send],[AcquireStatus],[ErrStatus],[Reordered],[DICOMStorageAE],[BackupAE]
  )
  VALUES (
@StudyInstanceUID,@StudyDate,@StudyTime,@StudyID,@StudyDescription,@AccessionNo,@Modalities,@ReferPhysician,@Printed
  ,@Readed,@PatientGUID,@SeriesCount,@ImageCount,@Reserved,@InstanceAvailability,@Hide,@OperateServerAE,@OperateStatus,@Problemed
,@StudyDir,@AcqDateTime,@QCStatus,@Matched,@Send,@AcquireStatus,@ErrStatus,@Reordered,@DICOMStorageAE,@BackupAE
  )


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;