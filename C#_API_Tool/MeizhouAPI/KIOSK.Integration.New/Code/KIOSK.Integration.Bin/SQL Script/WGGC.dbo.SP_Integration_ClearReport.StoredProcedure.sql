USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_ClearReport]    Script Date: 05/12/2016 15:23:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select * from sysobjects where id = object_id(N'sp_Integration_ClearReport') and OBJECTPROPERTY(id, N'IsProcedure') = 1)  
  drop procedure sp_Integration_ClearReport
GO

/*
DECLARE @PatientID nvarchar(max) = '1605119512'
DECLARE @AccessionNumber nvarchar(max) = 'DR1605110035'
DECLARE @OutPutInfo xml = ''
exec dbo.SP_Integration_ClearReport @PatientID,@AccessionNumber,@OutputInfo output
*/
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_Integration_ClearReport] 
	@PatientID nvarchar(max),
	@AccessionNumber nvarchar(max),
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @PatientID = LTRIM(RTRIM(ISNULL(@PatientID,'')))
	SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
	SET @OutPutInfo = '<OutPutInfo>SP_Integration_ClearReport:Success</OutPutInfo>'
	
	DECLARE @WHERE nvarchar(max) = ''
	DECLARE @SQL nvarchar(max) = ''
	BEGIN TRANSACTION TClearReort
	BEGIN TRY
	   IF (0 < LEN(@PatientID))
	   BEGIN
	     SET @WHERE = @WHERE + ' AND PATIENTID = ''' + @PatientID + ''''
	   END
	   IF (0 < LEN(@AccessionNumber))
	   BEGIN
	     SET @WHERE = @WHERE + ' AND ACCESSIONNUMBER = ''' +@AccessionNumber+ ''''
	   END
	   
	   IF (0 < LEN(@WHERE))
	   BEGIN
	     SET @SQL = 'UPDATE dbo.AFP_REPORTINFO SET DeleteStatus = 1 WHERE 1= 1 ' + @WHERE
	     --SELECT @SQL
	     EXEC(@SQL)
	     
	     SET @SQL = 'UPDATE dbo.T_Integration_ExamInfo SET NotifyReportFlag = -10, PDFReportURL = '', ReportStoredFlag = -10 WHERE 1=1 ' + @WHERE 
	     --SELECT @SQL
	     EXEC (@SQL)
	   END
	   
	   SET @OutputInfo = '<OutputInfo>SP_Integration_ClearReport:Success PatientID['+@PatientID+'] AccessionNumber['+@AccessionNumber+']</OutputInfo>'
		COMMIT TRANSACTION TClearReort
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TClearReort
		SET @OutputInfo = '<OutputInfo>SP_Integration_ClearReport:Error PatientID['+@PatientID+'] AccessionNumber['+@AccessionNumber+']</OutputInfo>'
	END CATCH
END
