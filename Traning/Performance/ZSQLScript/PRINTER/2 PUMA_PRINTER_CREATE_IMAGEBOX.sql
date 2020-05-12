USE Printer
GO

DECLARE @LOOPNUMBER INT = 1;
DECLARE @ImageBoxIntanceUID        VARCHAR(100)
DECLARE @CreateDateTime            VARCHAR(100)
DECLARE @PageInstanceUID           VARCHAR(100)
DECLARE @ImageBoxPosition          VARCHAR(100)
DECLARE @Polarity                  VARCHAR(100)
DECLARE @MagnificationType         VARCHAR(100)
DECLARE @SmoothingType             VARCHAR(100)
DECLARE @ConfigurationInformation  VARCHAR(100)
DECLARE @RequestedImageSize        VARCHAR(100)
DECLARE @RequestedBehavior         VARCHAR(100)
DECLARE @FilePath                  VARCHAR(255)
DECLARE @SamplesPerPixel           VARCHAR(100)
DECLARE @PhotometricInterpretation VARCHAR(100)
DECLARE @Rows                      VARCHAR(100)
DECLARE @Columns                   VARCHAR(100)
DECLARE @PixelAspectRatio          VARCHAR(100)
DECLARE @BitsAllocated             VARCHAR(100)
DECLARE @BitsStored                VARCHAR(100)
DECLARE @HighBit                   VARCHAR(100)
DECLARE @PixelRepresentation       VARCHAR(100)
DECLARE @PlanarConfiguration       VARCHAR(100)
DECLARE @AnnotationTextString      VARCHAR(100)
DECLARE @PLutInstanceUID           VARCHAR(100)
DECLARE @DATEForInstanceUID           VARCHAR(100)

WHILE @LOOPNUMBER <= 1000000
BEGIN
SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ','')
SET @ImageBoxIntanceUID = '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';

SET @CreateDateTime            =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @PageInstanceUID           = @ImageBoxIntanceUID
SET @ImageBoxPosition          = '1'
SET @Polarity                  = 'NORMAL'
SET @MagnificationType         = 'CUBIC'
SET @SmoothingType             = 'NORMAL'
SET @ConfigurationInformation  = ''
SET @RequestedImageSize        = ''
SET @RequestedBehavior         = ''
SET @FilePath                  = 'E:\GX Platform\PrintImages\'+ CAST(NEWID() AS VARCHAR(50)) + 'job1\' + @ImageBoxIntanceUID+ '.raw'
SET @SamplesPerPixel           = '1'
SET @PhotometricInterpretation = 'MONOCHROME2'
SET @Rows                      = '2392'
SET @Columns                   = '1956'
SET @PixelAspectRatio          = '1/1'
SET @BitsAllocated             = '16'
SET @BitsStored                = '12'
SET @HighBit                   = '11'
SET @PixelRepresentation       = '0'
SET @PlanarConfiguration       = '-1'
SET @AnnotationTextString      = ''
SET @PLutInstanceUID           = ''


INSERT [Printer].[dbo].[ImageBox] (
		[ImageBoxIntanceUID],[CreateDateTime],[PageInstanceUID] ,[ImageBoxPosition] ,[Polarity] ,[MagnificationType] ,[SmoothingType],[ConfigurationInformation]
      ,[RequestedImageSize],[RequestedBehavior],[FilePath],[SamplesPerPixel],[PhotometricInterpretation],[Rows],[Columns],[PixelAspectRatio],[BitsAllocated]
      ,[BitsStored],[HighBit],[PixelRepresentation],[PlanarConfiguration],[AnnotationTextString],[PLutInstanceUID]
	)
VALUES(
		@ImageBoxIntanceUID,@CreateDateTime,@PageInstanceUID ,@ImageBoxPosition ,@Polarity ,@MagnificationType ,@SmoothingType,@ConfigurationInformation
      ,@RequestedImageSize,@RequestedBehavior,@FilePath,@SamplesPerPixel,@PhotometricInterpretation,@Rows,@Columns,@PixelAspectRatio,@BitsAllocated
      ,@BitsStored,@HighBit,@PixelRepresentation,@PlanarConfiguration,@AnnotationTextString,@PLutInstanceUID
);



SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;