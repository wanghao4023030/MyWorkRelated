USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetPrintMode]    Script Date: 03/31/2017 13:57:09 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetPrintMode') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetPrintMode
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
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(3000) = ''
	DECLARE @PatientType nvarchar(32) = ''
	DECLARE @PrintMode nvarchar(32) = ''

	BEGIN TRY
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
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Success</OutputInfo>'

		SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
		SET @StudyInstanceUID = LTRIM(RTRIM(ISNULL(@StudyInstanceUID,'')))

		IF(''<>@AccessionNumber)
		BEGIN
			SET @SQL=N'SELECT TOP 1 @Type=[PatientType]
			FROM [dbo].[T_Integration_ExamInfo]
			WHERE [AccessionNumber]=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Type AS varchar(32) OUTPUT',@p = @AccessionNumber,@Type = @PatientType OUTPUT
		
			SET @SQL=N'SELECT TOP 1 @Type=[Value]
			FROM [dbo].[T_Integration_Dictionary]
			WHERE [TagType]=''PatientType'' AND [Key]=@p'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Type AS varchar(32) OUTPUT',@p = @PatientType,@Type = @PatientType OUTPUT

			SET @SQL=N'SELECT TOP 1 @Mode=[Key]
			FROM [dbo].[T_Integration_Dictionary]
			WHERE [TagType]=''PrintMode'' AND ([Value]=@p OR [Value]=''Other'')'
			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Mode AS varchar(32) OUTPUT',@p = @PatientType,@Mode = @PrintMode OUTPUT
		
			SET @SQL=N'SELECT DISTINCT [PatientID]
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
				,@Mode AS [PrintMode]
			FROM [dbo].[T_Integration_ExamInfo]
			WHERE [AccessionNumber]=@p'

			EXEC sp_executesql @SQL , N'@p AS varchar(128),@Mode AS varchar(32)',@p = @AccessionNumber,@Mode = @PrintMode
		END
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Success AccessionNumber['+@AccessionNumber+'] PrintMode['+@PrintMode+'] StudyInstanceUID['+@StudyInstanceUID+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetPrintMode:Error AccessionNumber['+@AccessionNumber+'] PrintMode['+@PrintMode+'] StudyInstanceUID['+@StudyInstanceUID+']</OutputInfo>'
	END CATCH
END
