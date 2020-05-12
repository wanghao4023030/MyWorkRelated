-- =============================================
-- Author:  <Gary Shi>
-- Create date: <2014-08-21>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get GetPrintMode>
/*
declare @AccessionNumber nvarchar(128)='JSDR201412171320' 
declare @StudyInstanceUID nvarchar(128)=''
declare @OutputInfo xml=''
exec sp_Integration_GetPrintMode @AccessionNumber,@StudyInstanceUID,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetPrintMode]
	@AccessionNumber nvarchar(128),
	@StudyInstanceUID nvarchar(128),
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
	SET @StudyInstanceUID = LTRIM(RTRIM(ISNULL(@StudyInstanceUID,'')))
	SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Success</OutputInfo>'

	-- PatientType:
	-- 1: in patient;
	-- 2: out patient;
	-- 3: emergency;
	-- 4: physical examination;
	-- 5: other.
	-- Default: print when both film and report are ready;
	-- 0: print when both film and report are ready;
	-- 1: print film only;
	-- 2: print report only;
	-- 3: print any available;
	-- 4: do not print.

	DECLARE @PatientType nvarchar(32) = ''
	DECLARE @PrintMode nvarchar(32) = ''
	DECLARE @Modality	nvarchar(32) = ''
	
	SELECT TOP 1 @PatientType=[PatientType]
	FROM [dbo].[T_Integration_ExamInfo]
	WHERE (''<>@AccessionNumber) AND ([AccessionNumber]=@AccessionNumber)

	SELECT TOP 1 @PatientType=[Value]
	FROM [dbo].[T_Integration_Dictionary]
	WHERE ([TagType]='PatientType') AND ([Key]=@PatientType)

	SELECT TOP 1 @PrintMode=[Key]
	FROM [dbo].[T_Integration_Dictionary]
	WHERE ([TagType]='PrintMode') AND ([Value]=@PatientType OR [Value]='Other')

	--BEGIN TRANSACTION TGetPrintMode
	BEGIN TRY
		SELECT DISTINCT [PatientID]
			,[AccessionNumber]
			,[StudyInstanceUID]
			,[NameCN]
			,[NameEN]
			,[Gender]
			,[Birthday]
			,[Modality]
			,[ModalityName]
			,[PatientType]
			,[VisitID]
			,[RequestID]
			,[RequestDepartment]
			,[RequestDT]
			,[RegisterDT]
			,[ExamDT]
			,[SubmitDT]
			,[ApproveDT]
			,[PDFReportURL]
			,[StudyStatus]
			,[ReportStatus]
			,[PDFFlag]
			,[PDFDT]
			,[VerifyFilmFlag]
			,[VerifyFilmDT]
			,[VerifyReportFlag]
			,[VerifyReportDT]
			,[FilmStoredFlag]
			,[FilmStoredDT]
			,[ReportStoredFlag]
			,[ReportStoredDT]
			,[NotifyReportFlag]
			,[NotifyReportDT]
			,[SetPrintModeFlag]
			,[SetPrintModeDT]
			,[FilmPrintFlag]
			,[FilmPrintDoctor]
			,[FilmPrintDT]
			,[ReportPrintFlag]
			,[ReportPrintDoctor]
			,[ReportPrintDT]
			,[Optional0]
			,[Optional1]
			,[Optional2]
			,[Optional3]
			,[Optional4]
			,[Optional5]
			,[Optional6]
			,[Optional7]
			,[Optional8]
			,[Optional9]
			,@PrintMode AS [PrintMode]
		FROM [dbo].[T_Integration_ExamInfo]
		WHERE (''<>@AccessionNumber) AND ([AccessionNumber]=@AccessionNumber)

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Success AccessionNumber['+@AccessionNumber+'] StudyInstanceUID['+@StudyInstanceUID+']</OutputInfo>'
		--COMMIT TRANSACTION TGetPrintMode
	END TRY
	BEGIN CATCH
		--ROLLBACK TRANSACTION TGetPrintMode
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Error AccessionNumber['+@AccessionNumber+'] StudyInstanceUID['+@StudyInstanceUID+']</OutputInfo>'
	END CATCH
END

go
