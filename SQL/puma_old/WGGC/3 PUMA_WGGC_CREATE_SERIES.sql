USE WGGC
GO

DECLARE @SerialNo             VARCHAR(100)
DECLARE @SeriesInstanceUID    VARCHAR(100)
DECLARE @SeriesNo             VARCHAR(100)
DECLARE @SeriesDate           VARCHAR(100)
DECLARE @SeriesTime           VARCHAR(100)
DECLARE @SeriesDescription    VARCHAR(100)
DECLARE @BodyPart             VARCHAR(100)
DECLARE @PatientPosition      VARCHAR(100)
DECLARE @ViewPosition         VARCHAR(100)
DECLARE @ContrastBolus        VARCHAR(100)
DECLARE @Modality             VARCHAR(100)
DECLARE @ReferHospital        VARCHAR(100)
DECLARE @StationName          VARCHAR(100)
DECLARE @ReferDepartment      VARCHAR(100)
DECLARE @StudyInstanceUID     VARCHAR(100)
DECLARE @NetAEName            VARCHAR(100)
DECLARE @ImageCount           VARCHAR(100)
DECLARE @OperatorName         VARCHAR(100)
DECLARE @ForwardStatus        VARCHAR(100)
DECLARE @Laterality           VARCHAR(100)
DECLARE @Grade                VARCHAR(100)
DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)

WHILE @LOOPNUMBER <= 500000
BEGIN
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')
SET @SeriesInstanceUID    = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';
SET @SeriesNo             = '1'
SET @SeriesDate           = LEFT(@DATEForInstanceUID,8)
SET @SeriesTime           = LEFT(@DATEForInstanceUID,6)
SET @SeriesDescription    = 'Electronic Film'
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


SET @PatientPosition      = ''
SET @ViewPosition         = ''
SET @ContrastBolus        = ''

IF @LOOPNUMBER%5 = 0 
SET @Modality = 'CR'

IF @LOOPNUMBER%5 = 1 
SET @Modality = 'CT'

IF @LOOPNUMBER%5 = 2 
SET @Modality = 'DX'

IF @LOOPNUMBER%5 = 3 
SET @Modality = 'MR'

IF @LOOPNUMBER%5 = 4 
SET @Modality = 'US'

SET @ReferHospital        = ''
SET @StationName          = ''
SET @ReferDepartment      = ''
SET @StudyInstanceUID     = @SeriesInstanceUID 
SET @NetAEName            = ''
SET @ImageCount           = 1 
SET @OperatorName         = '' 
SET @ForwardStatus        = 0
SET @Laterality           = NULL
SET @Grade                = 'F'


  
  INSERT [WGGC].[dbo].[Series] (
  [SeriesInstanceUID],[SeriesNo],[SeriesDate],[SeriesTime],[SeriesDescription],[BodyPart],[PatientPosition],[ViewPosition],[ContrastBolus]
,[Modality],[ReferHospital],[StationName],[ReferDepartment],[StudyInstanceUID],[NetAEName],[ImageCount],[OperatorName],[ForwardStatus],[Laterality],[Grade]
  )
  VALUES(
    @SeriesInstanceUID,@SeriesNo,@SeriesDate,@SeriesTime,@SeriesDescription,@BodyPart,@PatientPosition,@ViewPosition,@ContrastBolus
,@Modality,@ReferHospital,@StationName,@ReferDepartment,@StudyInstanceUID,@NetAEName,@ImageCount,@OperatorName,@ForwardStatus,@Laterality,@Grade
  )



SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;