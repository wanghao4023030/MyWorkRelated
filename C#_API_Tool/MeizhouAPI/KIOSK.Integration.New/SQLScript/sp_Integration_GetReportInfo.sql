USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetReportInfo]    Script Date: 03/31/2017 11:04:53 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetReportInfo') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetReportInfo
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:  <Shiye Yang>
-- Create date: <2017-03-31>
-- Alter date: <2017-03-31>
-- Description: <For KIOSK Get ReportInfo>
/*
declare @OutputInfo xml=''
exec sp_Integration_GetReportInfo @OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetReportInfo]
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(1000) = ''
	DECLARE @AfterDateTime datetime=Dateadd(DAY,-7,GETDATE())
	
	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfo:Success</OutputInfo>'

		SET @SQL=N'SELECT DISTINCT [PatientID],[AccessionNumber],[NameCN]
		FROM [dbo].[T_Integration_ExamInfo]
		WHERE FilmStoredFlag= 9 AND ReportStoredFlag <> 9 AND CreateDT>=@p'
		EXEC sp_executesql @SQL , N'@p AS datetime',@p = @AfterDateTime
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfo:Error</OutputInfo>'
	END CATCH
END

