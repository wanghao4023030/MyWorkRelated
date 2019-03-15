USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetReportInfoFromRis]    Script Date: 10/14/2017 10:01:49 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetReportInfoFromRis') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetReportInfoFromRis
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Integration_GetReportInfoFromRis]
	@PatientID nvarchar(20),
	@PatientName nvarchar(100),
	@AccessionNumber nvarchar(20),
	@Modality nvarchar(10),
	@ReportID nvarchar(32),
	@ReportStatus nvarchar(32),
	@OutputInfo xml output,
	@OutReport nvarchar(500) output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL nvarchar(max) = ''
	DECLARE @rReportID nvarchar(15)
	DECLARE @Server  nvarchar(30) = N'127.0.0.1'
	DECLARE @ShareName  nvarchar(30) = N'pdf'
	DECLARE @UserName  nvarchar(30) = N'guest'
	DECLARE @Password  nvarchar(30) = N'guest'

	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfoFromRis:Fail</OutputInfo>'

		SET @PatientID = LTRIM(RTRIM(ISNULL(@PatientID,'')))
		SET @PatientName = LTRIM(RTRIM(ISNULL(@PatientName,'')))
		SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
		SET @Modality = LTRIM(RTRIM(ISNULL(@Modality,'')))
		SET @ReportID = LTRIM(RTRIM(ISNULL(@ReportID,'')))
		SET @ReportStatus = LTRIM(RTRIM(ISNULL(@ReportStatus,'')))
		SET @OutReport = ''

		IF(0<LEN(@PatientID) AND 0<LEN(@AccessionNumber))
		BEGIN
			SET @SQL=N'SELECT @Path=PDFReportURL,@ReportID=ReportID FROM OPENQUERY(RISDB,''SELECT ReportPath as PDFReportURL,ReportID FROM gecris.RIS_EXAMINFO_SelfPrint WHERE ExamStatus=''''6'''' AND OrderID='''''+@PatientID+''''' AND AccessionNumber='''''+@AccessionNumber+''''' '')'
			EXEC sp_executesql @SQL , N'@Path AS varchar(200) OUTPUT,@ReportID AS varchar(200) OUTPUT',@Path=@OutReport OUTPUT,@ReportID=@rReportID OUTPUT
			SET @OutReport=ISNULL(@OutReport,'')
			SET @rReportID=ISNULL(@rReportID,'')
			
			SET @SQL=N'SELECT DISTINCT '''+ @Server +''' AS Server,'''+ @ShareName +''' AS ShareName,'''+ @UserName +''' AS UserName,'''+ @Password +''' AS Password,T.PatientID,T.NameCN,T.AccessionNumber,T.PDFReportURL,T.ReportID FROM OPENQUERY(RISDB,''SELECT PatientID,Name AS NameCN,AccessionNumber,ReportPath as PDFReportURL,ReportID FROM gecris.RIS_EXAMINFO_SelfPrint WHERE ExamStatus=''''6'''' AND OrderID='''''+@PatientID+''''' AND ReportID='''''+@rReportID+''''' '') AS T '
			EXEC sp_executesql @SQL
		END

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfoFromRis:Success PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+'] ReportURL['+@OutReport+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfoFromRis:Error PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+']</OutputInfo>'
	END CATCH
END