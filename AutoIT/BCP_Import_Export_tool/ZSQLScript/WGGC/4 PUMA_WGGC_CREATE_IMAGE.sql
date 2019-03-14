USE WGGC 
GO 

DECLARE @SerialNo         VARCHAR(100)
DECLARE @SOPInstanceUID   VARCHAR(100)
DECLARE @ImageNo          VARCHAR(100)
DECLARE @ImageDate        VARCHAR(100)
DECLARE @ImageTime        VARCHAR(100)
DECLARE @NumberOfFrames   VARCHAR(100)
DECLARE @SamplesPerPixel  VARCHAR(100)
DECLARE @ImageRows        VARCHAR(100)
DECLARE @ImageColumns     VARCHAR(100)
DECLARE @BitsAllocated    VARCHAR(100)
DECLARE @Remarks          VARCHAR(100)
DECLARE @SeriesInstanceUID VARCHAR(100)
DECLARE @ObjectFile       VARCHAR(100)
DECLARE @KeyImage         VARCHAR(100)
DECLARE @Annotation       VARCHAR(100)
DECLARE @ImageType        VARCHAR(100)
DECLARE @SliceLocation    VARCHAR(100)
DECLARE @SeriesNo         VARCHAR(100)
DECLARE @SeriesDescription VARCHAR(100)
DECLARE @EchoID           VARCHAR(100)
DECLARE @AcquisitionNo    VARCHAR(100)
DECLARE @AcquisitionDate  VARCHAR(100)
DECLARE @AcquisitionTime  VARCHAR(100)
DECLARE @PositionerType   VARCHAR(100)
DECLARE @ImageLaterality  VARCHAR(100)
DECLARE @JP2FileName      VARCHAR(100)
DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @DATEForInstanceUID VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)

WHILE @LOOPNUMBER <= 1000000
BEGIN
SET @RANDTIME =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @TIME =  REPLACE(REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'.',''),'-',''),' ','')


SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(@RANDTIME,':',''),'-',''),' ','')
SET @SOPInstanceUID    = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';

SET @ImageNo           = 1 
SET @ImageDate         = LEFT(@DATEForInstanceUID,8)
SET @ImageTime         = LEFT(@DATEForInstanceUID,6)
SET @NumberOfFrames    = 1
SET @SamplesPerPixel   = 1
SET @ImageRows         = '2392'
SET @ImageColumns      = '1956'
SET @BitsAllocated     = '16' 
SET @Remarks           =  ''
SET @SeriesInstanceUID = @SOPInstanceUID
SET @ObjectFile        = LEFT(@DATEForInstanceUID,8) + '/' + 'DIRTY'+@TIME + '/' + @SOPInstanceUID + '.dcm'
SET @KeyImage          = NULL
SET @Annotation        = NULL
SET @ImageType         = 'DERIVED\SECONDARY'
SET @SliceLocation     = ''
SET @SeriesNo          = 1
SET @SeriesDescription = 'Electronic Film'
SET @EchoID            = ''
SET @AcquisitionNo     = ''
SET @AcquisitionDate   = LEFT(@DATEForInstanceUID,8)
SET @AcquisitionTime   = LEFT(@DATEForInstanceUID,8)
SET @PositionerType    = NULL
SET @ImageLaterality   = NULL
SET @JP2FileName       = NULL

INSERT [WGGC].[dbo].[Image] (
[SOPInstanceUID],[ImageNo],[ImageDate],[ImageTime],[NumberOfFrames],[SamplesPerPixel],[ImageRows],[ImageColumns],[BitsAllocated],[Remarks]
,[SeriesInstanceUID],[ObjectFile],[KeyImage],[Annotation],[ImageType],[SliceLocation],[SeriesNo],[SeriesDescription],[EchoID],[AcquisitionNo],[AcquisitionDate]
,[AcquisitionTime],[PositionerType],[ImageLaterality],[JP2FileName]  
)
  VALUES(
  @SOPInstanceUID,@ImageNo,@ImageDate,@ImageTime,@NumberOfFrames,@SamplesPerPixel,@ImageRows,@ImageColumns,@BitsAllocated,@Remarks
,@SeriesInstanceUID,@ObjectFile,@KeyImage,@Annotation,@ImageType,@SliceLocation,@SeriesNo,@SeriesDescription,@EchoID,@AcquisitionNo,@AcquisitionDate
,@AcquisitionTime,@PositionerType,@ImageLaterality,@JP2FileName  
  )


SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;