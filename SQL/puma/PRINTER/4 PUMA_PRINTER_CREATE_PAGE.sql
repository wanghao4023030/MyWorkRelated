
USE Printer
GO

DECLARE @LOOPNUMBER INT = 1;
DECLARE @PageInstanceUID            varchar(100)
DECLARE @CreateDateTime             varchar(100)
DECLARE @PageStatus                 varchar(100)
DECLARE @PageNumber                 varchar(100)
DECLARE @JobInstanceUID             varchar(100)
DECLARE @ImageDisplayFormat         varchar(100)
DECLARE @AnnotationDisplayFormatID  varchar(100)
DECLARE @AnnotationTextString       varchar(100)
DECLARE @PLutInstanceUID            varchar(100)
DECLARE @FilmOrientation            varchar(100)
DECLARE @FilmSizeID                 varchar(100)
DECLARE @BorderDensity              varchar(100)
DECLARE @EmptyImageDensity          varchar(100)
DECLARE @MinDensity                 varchar(100)
DECLARE @MaxDensity                 varchar(100)
DECLARE @Trim                       varchar(100)
DECLARE @ConfigurationInformation   varchar(100)
DECLARE @Illumination               varchar(100)
DECLARE @ReflectedAmbientLight      varchar(100)
DECLARE @RequestedResolutionID      varchar(100)
DECLARE @ICCProfile                 varchar(100)
DECLARE @AnnotationTextString2      varchar(100)
DECLARE @AnnotationTextString3      varchar(100)
DECLARE @AnnotationTextString4      varchar(100)
DECLARE @AnnotationTextString5      varchar(100)
DECLARE @AnnotationTextString6      varchar(100)
DECLARE @DATEForInstanceUID varchar(100)

WHILE @LOOPNUMBER <= 500000
BEGIN

SET @DATEForInstanceUID = REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),121),':',''),'-',''),' ','')
SET @PageInstanceUID            =  '1.2.840.113564.86.3.0.41.' + @DATEForInstanceUID + '.1234';
SET @CreateDateTime             =  CONVERT(varchar,(DATEADD(DD,-(RAND()*(365-1)+1),GETDATE())),121)
SET @PageStatus                 = 1
SET @PageNumber                 = 1 
SET @JobInstanceUID             = @PageInstanceUID
SET @ImageDisplayFormat         = 'STANDARD\1,1'
SET @AnnotationDisplayFormatID  = ''
SET @AnnotationTextString       = ''
SET @PLutInstanceUID            = ''
SET @FilmOrientation            = 'PORTRAIT'
SET @FilmSizeID                 = '14INX17IN'
SET @BorderDensity              = 'BLACK'
SET @EmptyImageDensity          = 'BLACK'
SET @MinDensity                 = '21'
SET @MaxDensity                 = '300'
SET @Trim                       = 'NO'
SET @ConfigurationInformation   = ''
SET @Illumination               = '2000'
SET @ReflectedAmbientLight      = '10'
SET @RequestedResolutionID      = ''
SET @ICCProfile                 = ''
SET @AnnotationTextString2      = ''
SET @AnnotationTextString3      = ''
SET @AnnotationTextString4      = ''
SET @AnnotationTextString5      = ''
SET @AnnotationTextString6      = ''

INSERT  [Printer].[dbo].[Page](
	   [PageInstanceUID],[CreateDateTime],[PageStatus],[PageNumber],[JobInstanceUID],[ImageDisplayFormat],[AnnotationDisplayFormatID],[AnnotationTextString],[PLutInstanceUID]
      ,[FilmOrientation],[FilmSizeID],[BorderDensity],[EmptyImageDensity],[MinDensity],[MaxDensity],[Trim],[ConfigurationInformation],[Illumination],[ReflectedAmbientLight]
      ,[RequestedResolutionID],[ICCProfile],[AnnotationTextString2],[AnnotationTextString3],[AnnotationTextString4],[AnnotationTextString5],[AnnotationTextString6])

VALUES (
		@PageInstanceUID,@CreateDateTime,@PageStatus,@PageNumber,@JobInstanceUID,@ImageDisplayFormat,@AnnotationDisplayFormatID,@AnnotationTextString,
		@PLutInstanceUID,@FilmOrientation,@FilmSizeID,@BorderDensity,@EmptyImageDensity,@MinDensity,@MaxDensity,@Trim,@ConfigurationInformation,
		@Illumination,@ReflectedAmbientLight,@RequestedResolutionID,@ICCProfile,@AnnotationTextString2,@AnnotationTextString3,@AnnotationTextString4,
		@AnnotationTextString5,@AnnotationTextString6
)  ;

SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;