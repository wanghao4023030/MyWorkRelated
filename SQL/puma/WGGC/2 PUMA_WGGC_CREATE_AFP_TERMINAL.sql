USE WGGC
GO 

DECLARE @TIME varchar(100)
DECLARE @LOOPNUMBER INT =1
DECLARE @TerminalID                  VARCHAR(100)
DECLARE @TerminalName                VARCHAR(100)
DECLARE @TerminalIP                  VARCHAR(100)
DECLARE @ReportPrinterFullName       VARCHAR(100)
DECLARE @ReportPrinterDisplayName    VARCHAR(100)
DECLARE @ReportPrinterMode           VARCHAR(100)
DECLARE @ReportPrinterType           VARCHAR(100)
DECLARE @ReportPrinterIP             VARCHAR(100)
DECLARE @FilmPrinterID               VARCHAR(100)
DECLARE @EnabledFlag                 VARCHAR(100)
DECLARE @MammoFlag                   VARCHAR(100)
DECLARE @TerminalDesc                VARCHAR(100)
DECLARE @CreateTime                  VARCHAR(100)
DECLARE @UpdateTime                  VARCHAR(100)
DECLARE @InkTime                     VARCHAR(100)
DECLARE @CheckFilmPrinterState       VARCHAR(100)
DECLARE @CheckTerminalState          VARCHAR(100)
DECLARE @PrintReport                 VARCHAR(100)
DECLARE @CallingAET                  VARCHAR(100)
DECLARE @CallingIP                   VARCHAR(100)
DECLARE @Modality                    VARCHAR(100)
DECLARE @TerminalType                VARCHAR(100)
DECLARE @DepartmentID                VARCHAR(100)
DECLARE @CheckReportPrinterState     VARCHAR(100)
DECLARE @RANDTIME VARCHAR(100)


WHILE @LOOPNUMBER <= 50
BEGIN

SET @TerminalID                  = 'Terminal'+CAST(@LOOPNUMBER AS VARCHAR(10))
SET @TerminalName                = @TerminalID  
SET @TerminalIP                  = '10.184.129.' + CAST(@LOOPNUMBER AS VARCHAR(10))
SET @ReportPrinterFullName       = NULL
SET @ReportPrinterDisplayName    = NULL
SET @ReportPrinterMode           = '0'
SET @ReportPrinterType           = NULL
SET @ReportPrinterIP             = NULL
SET @FilmPrinterID               = NULL
SET @EnabledFlag                 = 1
SET @MammoFlag                   = 0 
SET @TerminalDesc                = NULL
SET @CreateTime                  = CONVERT(varchar,(DATEADD(DD,-(RAND()*(2-1)+1),GETDATE())),121)
SET @UpdateTime                  = @CreateTime
SET @InkTime                     = @CreateTime
SET @CheckFilmPrinterState       = 1
SET @CheckTerminalState          = 1
SET @PrintReport                 = 0
SET @CallingAET                  = NULL
SET @CallingIP                   = NULL
SET @Modality                    = 'CR,CT,DX,IO,KO,MG,MR,NM,OT,PR,PT,RF,SR,US,XA'
SET @TerminalType                = 2
SET @DepartmentID                = '1,10,2,3,4,5,6,7,8,9'
SET @CheckReportPrinterState     = 0


INSERT [WGGC].[dbo].[AFP_PrintTerminalInfo] (
TerminalID,TerminalName ,TerminalIP,ReportPrinterFullName,ReportPrinterDisplayName ,ReportPrinterMode,
ReportPrinterType,ReportPrinterIP,FilmPrinterID,EnabledFlag ,MammoFlag ,TerminalDesc,CreateTime,UpdateTime,
InkTime ,CheckFilmPrinterState,CheckTerminalState ,PrintReport ,CallingAET,CallingIP ,Modality,TerminalType,
DepartmentID,CheckReportPrinterState

)
  VALUES(
@TerminalID,@TerminalName ,@TerminalIP,@ReportPrinterFullName,@ReportPrinterDisplayName ,@ReportPrinterMode,
@ReportPrinterType,@ReportPrinterIP,@FilmPrinterID,@EnabledFlag ,@MammoFlag ,@TerminalDesc,@CreateTime,@UpdateTime,
@InkTime ,@CheckFilmPrinterState,@CheckTerminalState ,@PrintReport ,@CallingAET,@CallingIP ,@Modality,@TerminalType,
@DepartmentID,@CheckReportPrinterState
  )
  
  





SET @LOOPNUMBER = @LOOPNUMBER + 1;
WAITFOR DELAY '00:00:00.001';
END;