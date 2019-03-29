USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetReportInfoFromRis]    Script Date: 01/03/2019 15:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id(N'sp_Integration_GetReportInfoFromRis') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN  
  DROP PROCEDURE sp_Integration_GetReportInfoFromRis
END
GO

Create PROCEDURE [dbo].[sp_Integration_GetReportInfoFromRis]
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
			SET @SQL=N'SELECT @Path=PDFReportURL,@ReportID=ReportID FROM OPENQUERY(RISDB,''SELECT PDFReportURL AS PDFReportURL,AccessionNumber AS ReportID FROM wggc.dbo.vi_KIOSK_ExamInfo_Order WHERE PatientID='''''+@PatientID+''''' AND AccessionNumber='''''+@AccessionNumber+''''' '')'
			EXEC sp_executesql @SQL , N'@Path AS varchar(200) OUTPUT,@ReportID AS varchar(200) OUTPUT',@Path=@OutReport OUTPUT,@ReportID=@rReportID OUTPUT
			SET @OutReport=ISNULL(@OutReport,'')
			SET @rReportID=ISNULL(@rReportID,'')
			
			IF(@OutReport<>'')
			BEGIN
				SET @SQL=N'SELECT DISTINCT '''+ @Server +''' AS Server,'''+ @ShareName +''' AS ShareName,'''+ @UserName +''' AS UserName,'''+ @Password +''' AS Password,T.PatientID,T.NameCN,T.AccessionNumber,T.PDFReportURL,T.ReportID FROM OPENQUERY(RISDB,''SELECT PatientID AS PatientID,NameCN AS NameCN,AccessionNumber AS AccessionNumber,PDFReportURL AS PDFReportURL,AccessionNumber AS ReportID FROM wggc.dbo.vi_KIOSK_ExamInfo_Order WHERE PatientID='''''+@PatientID+''''' AND AccessionNumber='''''+@rReportID+''''' '') AS T '
				EXEC sp_executesql @SQL
			END
			ELSE
			BEGIN
				SET @SQL=N'SELECT DISTINCT '''+ @Server +''' AS Server,'''+ @ShareName +''' AS ShareName,'''+ @UserName +''' AS UserName,'''+ @Password +''' AS Password,'''' AS PatientID,'''' AS NameCN,'''' AS AccessionNumber,'''' AS PDFReportURL,'''' AS ReportID'
				EXEC sp_executesql @SQL
			END
		END

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfoFromRis:Success PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+'] ReportURL['+@OutReport+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfoFromRis:Error PatientID['+@PatientID+'] Name['+@PatientName+'] AccessionNumber['+@AccessionNumber+']</OutputInfo>'
	END CATCH
END