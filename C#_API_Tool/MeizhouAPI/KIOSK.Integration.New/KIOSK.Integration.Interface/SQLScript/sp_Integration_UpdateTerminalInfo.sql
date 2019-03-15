USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_UpdateTerminalInfo]    Script Date: 09/28/2017 17:57:09 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_UpdateTerminalInfo') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_UpdateTerminalInfo
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  <Shiye Yang>
-- Create date: <2017-09-28>
-- Alter date: <2017-09-28>
-- Description: <For 3rd Update TerminalInfo>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_UpdateTerminalInfo]
	@TerminalIP nvarchar(40),
	@TerminalStatus int,
	@PaperPrinterStatus int,
	@FilmPrinterIP nvarchar(40),
	@FilmPrinterStatus int,
	@FilmPrinterPrintStatus int,
	@FilmSize1 int,
	@FilmType1 int,
	@FilmCount1 int,
	@FilmSize2 int,
	@FilmType2 int,
	@FilmCount2 int,
	@FilmSize3 int,
	@FilmType3 int,
	@FilmCount3 int,
	@OutputInfo xml output
AS
BEGIN
	DECLARE @SQL NVARCHAR(3000) = ''
	DECLARE @FilmPrinterID int
	DECLARE @TerminalID VARCHAR(20)
	DECLARE @CurrentTime datetime

	BEGIN TRY
		BEGIN TRAN

		SET NOCOUNT ON;

		SET @TerminalIP = LTRIM(RTRIM(ISNULL(@TerminalIP,'')))
		SET @FilmPrinterIP = LTRIM(RTRIM(ISNULL(@FilmPrinterIP,'')))

		IF(@TerminalIP<>'')
		BEGIN
			SET @CurrentTime=GETDATE()

			SET @SQL=N'SELECT @TID=TerminalID,@FID=FilmPrinterID FROM AFP_PrintTerminalInfo WHERE TerminalIP=@TIP'
			EXEC sp_executesql @SQL , N'@TIP AS varchar(40),@TID AS varchar(20) OUTPUT,@FID AS int OUTPUT',
			@TIP = @TerminalIP,@TID = @TerminalID OUTPUT,@FID = @FilmPrinterID OUTPUT
		
			SET @SQL=N'UPDATE AFP_ReportPrinterStatus SET Status=@Status,StatusTime=@RefreshTime WHERE TerminalID=@TID'
			EXEC sp_executesql @SQL , N'@TID AS varchar(20),@Status AS int,@RefreshTime AS datetime',
			@TID = @TerminalID,@Status = @PaperPrinterStatus,@RefreshTime = @CurrentTime

			SET @SQL=N'UPDATE AFP_FilmPrinterStatus SET MediaSize1=@MS1,MediaType1=@MT1,FilmCount1=@FC1,
			MediaSize2=@MS2,MediaType2=@MT2,FilmCount2=@FC2,MediaSize3=@MS3,MediaType3=@MT3,FilmCount3=@FC3,
			Status=@Status,StatusTime=@RefreshTime WHERE PrinterID=@FID'
			EXEC sp_executesql @SQL , N'@FID AS int,@MS1 AS int,@MT1 AS int,@FC1 AS int,@MS2 AS int,@MT2 AS int,@FC2 AS int,
			@MS3 AS int,@MT3 AS int,@FC3 AS int,@Status AS int,@RefreshTime AS datetime',
			@FID = @FilmPrinterID,@MS1=@FilmSize1,@MT1=@FilmType1,@FC1=@FilmCount1,@MS2=@FilmSize2,@MT2=@FilmType2,@FC2=@FilmCount2,
			@MS3=@FilmSize3,@MT3=@FilmType3,@FC3=@FilmCount3,@Status = @FilmPrinterStatus,@RefreshTime = @CurrentTime

			SET @SQL=N'UPDATE AFP_TerminalStatus SET Status=@Status,StatusTime=@RefreshTime WHERE TerminalID=@TID'
			EXEC sp_executesql @SQL , N'@TID AS varchar(20),@Status AS int,@RefreshTime AS datetime',
			@TID = @TerminalID,@Status = @TerminalStatus,@RefreshTime = @CurrentTime
		END

		SELECT 0 AS RunTag

		SET @OutputInfo = '<OutputInfo>sp_Integration_UpdateTerminalInfo:Success</OutputInfo>'
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT 1 AS RunTag
		ROLLBACK TRAN
		SET @OutputInfo = '<OutputInfo>sp_Integration_UpdateTerminalInfo:Fail</OutputInfo>'
	END CATCH
END
