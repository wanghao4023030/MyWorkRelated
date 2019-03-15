USE WGGC
GO


DECLARE @SerialNo              VARCHAR(100)
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
DECLARE @PatientGUID           VARCHAR(100)
DECLARE @SeriesCount           VARCHAR(100)
DECLARE @ImageCount            VARCHAR(100)
DECLARE @Reserved              VARCHAR(100)
DECLARE @InstanceAvailability  VARCHAR(100)
DECLARE @Hide                  VARCHAR(100)
DECLARE @OperateServerAE       VARCHAR(100)
DECLARE @OperateStatus         VARCHAR(100)
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
DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)


WHILE @LOOPNUMBER <= 500000
BEGIN

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
SET @PatientGUID           = (SELECT TOP 1 PATIENTGUID FROM WGGC.DBO.PATIENT ORDER BY NEWID())
SET @SeriesCount           = 1
SET @ImageCount            = 1
SET @Reserved              = 'Y'
SET @InstanceAvailability  = 'ONLINE'
SET @Hide                  = 0
SET @OperateServerAE       = ''
SET @OperateStatus         = 0
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