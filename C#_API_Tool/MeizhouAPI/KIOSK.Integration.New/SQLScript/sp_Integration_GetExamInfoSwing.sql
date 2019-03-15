USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetExamInfoSwing]    Script Date: 5/18/2017 3:21:09 PM ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetExamInfoSwing') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetExamInfoSwing
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Shiye Yang>
-- Create date: <2017-04-13>
-- Alter date: <2017-04-13>
-- Description: <For KIOSK Get ExamInfo>
/*
declare	@PatientIDs nvarchar(max) ='P20140403094904,P000000071'
declare	@PatientNames nvarchar(128) ='E20140403094904,李培轩'
declare	@AccessionNumbers nvarchar(max) ='A20140403094904,201105140073'
declare	@Modalitys nvarchar(128) ='CR,DR'
declare	@StartDT nvarchar(32) =''
declare	@EndDT nvarchar(32) =''
declare	@OutputInfo xml =''
exec dbo.sp_Integration_GetExamInfo @PatientIDs,@PatientNames,@AccessionNumbers,@Modalitys,@StartDT,@EndDT,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetExamInfoSwing]
	@PatientIDs nvarchar(max),
	@PatientNames nvarchar(max),
	@AccessionNumbers nvarchar(max),
	@Modalitys nvarchar(max),
	@StartDT nvarchar(32),
	@EndDT nvarchar(32),
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL nvarchar(max) = ''
	DECLARE @WHERE nvarchar(max) = ''

	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoSwing:Success</OutputInfo>'
		SET @PatientIDs = LTRIM(RTRIM(ISNULL(@PatientIDs,'')))
		SET @PatientNames = LTRIM(RTRIM(ISNULL(@PatientNames,'')))
		SET @AccessionNumbers = LTRIM(RTRIM(ISNULL(@AccessionNumbers,'')))
		SET @Modalitys = LTRIM(RTRIM(ISNULL(@Modalitys,'')))
		SET @StartDT = LTRIM(RTRIM(ISNULL(@StartDT,'')))
		SET @EndDT = LTRIM(RTRIM(ISNULL(@EndDT,'')))

		IF ((0 < LEN(@PatientIDs)) AND (0 < LEN(@AccessionNumbers)))
		BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @WHERE = @WHERE+' AND (PatientID IN (select value from  Func_Integration_SplitString(@pPatientIDs,'','')))'
			END

			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (select value from  Func_Integration_SplitString(@pAccessionNumbers,'','')))'
			END
		END
		ELSE BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @WHERE = @WHERE+' AND (PatientID IN (select value from  Func_Integration_SplitString(@pPatientIDs,'','')))'
			END

			IF(0<LEN(@PatientNames))
			BEGIN
				DECLARE @i int
				SET @i=PATINDEX('%[A-Za-z]%',@PatientNames)
				IF(@i>0)
				BEGIN
					SET @WHERE = @WHERE+' AND (NameEN IN (select value from  Func_Integration_SplitString(@pPatientNames,'','')))'
				END
				ELSE
				BEGIN
					SET @WHERE = @WHERE+' AND (NameCN IN (select value from  Func_Integration_SplitString(@pPatientNames,'','')))'
				END
			END

			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (select value from  Func_Integration_SplitString(@pAccessionNumbers,'','')))'
			END

			IF(0<LEN(@Modalitys))
			BEGIN
				SET @WHERE = @WHERE+' AND (Modality IN (select value from  Func_Integration_SplitString(@pModalitys,'','')))'
			END
		END

		IF(LEN(@WHERE)>0)
		BEGIN
			SET @SQL = 'SELECT [CreateDT]
					  ,[UpdateDT]
					  ,[PatientID]
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
					  ,[OutHospitalNo]
					  ,[InHospitalNo]
					  ,[PhysicalNumber]
					  ,[ExamName]
					  ,[ExamBodyPart]
					 FROM dbo.T_Integration_ExamInfo WHERE 1=1 '+ @WHERE + ' ORDER BY EXAMDT DESC'

			EXEC sp_executesql @SQL , N'@pPatientIDs AS VARCHAR(max),@pAccessionNumbers AS VARCHAR(max),@pPatientNames AS VARCHAR(max),@pModalitys AS VARCHAR(max)',
			@pPatientIDs = @PatientIDs,@pAccessionNumbers = @AccessionNumbers,@pPatientNames = @PatientNames,@pModalitys = @Modalitys
		END

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoSwing:Success PatientID['+@PatientIDs+'] Name['+@PatientNames+'] AccessionNumber['+@AccessionNumbers+'] Modality['+@Modalitys+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		set @OutputInfo = @SQL
	END CATCH
END
