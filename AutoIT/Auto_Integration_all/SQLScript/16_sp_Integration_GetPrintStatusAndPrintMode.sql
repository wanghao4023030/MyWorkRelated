USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPrintStatusAndPrintMode]    Script Date: 10/12/2017 14:31:38 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetPrintStatusAndPrintMode') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetPrintStatusAndPrintMode
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2017-05-18>
-- Alter date:<2017-05-18>
-- Description:Get Film And Report Status.
-- <param name="@AccessionNumber">Input</param>
-- <param name="@FilmStoredFlag">Output</param>
-- <param name="@ReportStoredFlag">Output</param>
-- <param name="@FilmPrintFlag">Output</param>
-- <param name="@ReportPrintFlag">Output</param>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetPrintStatusAndPrintMode]
	@AccessionNumber nvarchar(32),
	@FilmStoredFlag int output,
	@ReportStoredFlag int output,
	@FilmPrintFlag int output,
	@ReportPrintFlag int output,
	@PrintMode int output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MaxFilmFlag  int
	DECLARE @MinFilmFlag  int
	DECLARE @MaxReportFlag  int
	DECLARE @MinReportFlag  int
	DECLARE @SQL NVarchar(2000)
	DECLARE @OutputInfo xml
	
	SET @PrintMode=-1
	SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))

	SET @SQL=N'SELECT @MaxFlag=CASE WHEN Max(FilmFlag) IS NULL THEN -1 ELSE Max(FilmFlag) END,
	@MinFlag=CASE WHEN Min(FilmFlag) IS NULL THEN -1 ELSE Min(FilmFlag) END 
	FROM AFP_FilmInfo  
	WHERE (DeleteStatus = 0 or DeleteStatus is null) AND AccessionNumber =@p'
	EXEC sp_executesql @SQL , N'@p AS varchar(100),@MaxFlag AS int OUTPUT,@MinFlag AS int OUTPUT',
	@p = @AccessionNumber,
	@MaxFlag=@MaxFilmFlag OUTPUT,
	@MinFlag=@MinFilmFlag OUTPUT

	SET @SQL=N'SELECT @MaxFlag=CASE WHEN Max(PrintStatus) IS NULL THEN -1 ELSE Max(PrintStatus) END,
	@MinFlag=CASE WHEN Min(PrintStatus) IS NULL THEN -1 ELSE Min(PrintStatus) END 
	FROM AFP_ReportInfo 
	WHERE (DeleteStatus = 0 or DeleteStatus is null) AND AccessionNumber =@p'
	EXEC sp_executesql @SQL , N'@p AS varchar(100),@MaxFlag AS int OUTPUT,@MinFlag AS int OUTPUT',
	@p = @AccessionNumber,
	@MaxFlag=@MaxReportFlag OUTPUT,
	@MinFlag=@MinReportFlag OUTPUT

	IF(@MaxFilmFlag=-1 AND @MinFilmFlag=-1)
	BEGIN
		SET @FilmStoredFlag=0
		SET @FilmPrintFlag=-10
	END
	ELSE
	BEGIN
		SET @FilmStoredFlag=9

		IF(@MaxFilmFlag=3)
		BEGIN
			SET @FilmPrintFlag=3
		END
		ELSE IF(@MinFilmFlag=0 OR @MinFilmFlag=1)
		BEGIN
			SET @FilmPrintFlag=@MinFilmFlag
		END
		ELSE
		BEGIN
			SET @FilmPrintFlag=2
		END
	END

	IF(@MaxReportFlag=-1 AND @MinReportFlag=-1)
	BEGIN
		SET @ReportStoredFlag=0
		SET @ReportPrintFlag=-10
	END
	ELSE
	BEGIN
		SET @ReportStoredFlag=9

		IF(@MaxReportFlag=3)
		BEGIN
			SET @ReportPrintFlag=3
		END
		ELSE IF(@MinReportFlag=0 OR @MinReportFlag=1)
		BEGIN
			SET @ReportPrintFlag=@MinReportFlag
		END
		ELSE
		BEGIN
			SET @ReportPrintFlag=2
		END
	END

	SET @SQL=N'UPDATE T_Integration_ExamInfo 
	SET FilmStoredFlag = @pFilmStoredFlag,
		ReportStoredFlag = @pReportStoredFlag,
		FilmPrintFlag = @pFilmPrintFlag,
		ReportPrintFlag = @pReportPrintFlag
	WHERE AccessionNumber=@p'
	EXEC sp_executesql @SQL ,N'@p AS varchar(100),
	@pFilmStoredFlag AS int,@pReportStoredFlag AS int,
	@pFilmPrintFlag AS int,@pReportPrintFlag AS int',
	@p = @AccessionNumber,
	@pFilmStoredFlag = @FilmStoredFlag,@pReportStoredFlag = @ReportStoredFlag,
	@pFilmPrintFlag = @FilmPrintFlag,@pReportPrintFlag = @ReportPrintFlag

	SET @SQL=N'SELECT @Mode=CONVERT(INT,ISNULL([PrintMode],-1))
	FROM [AFP_PrintMode]
	WHERE [AccessionNumber]=@p'
	EXEC sp_executesql @SQL , N'@p AS varchar(100),@Mode AS int OUTPUT',@p = @AccessionNumber,@Mode=@PrintMode OUTPUT
		
	IF(@PrintMode=-1 AND (@FilmStoredFlag=9 OR @ReportStoredFlag=9))
	BEGIN
		SET @SQL=N'EXEC sp_Integration_SetPrintMode @p,@Mode output,@Info output'
		EXEC sp_executesql @SQL , N'@p AS varchar(100),@Mode AS int OUTPUT,@Info AS xml OUTPUT',
		@p = @AccessionNumber,@Mode=@PrintMode OUTPUT,@Info=@OutputInfo OUTPUT
	END
END
