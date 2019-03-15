USE [GCRIS2]
GO
/****** Object:  StoredProcedure [dbo].[sp_KIOSK_GetExamInfo]    Script Date: 12/29/2014 11:32:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Gary Shi>
-- Create date: <2014-12-03>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get ExamInfo>
/*
declare	@PatientIDs nvarchar(max) ='P000946746,P000833560'
declare	@PatientNames nvarchar(128) =''
declare	@AccessionNumbers nvarchar(max) ='JSDR201412171320,ZHDR201412190831'
declare	@Modalitys nvarchar(128) ='MR,DR'
declare	@StartDT nvarchar(32) =''
declare	@EndDT nvarchar(32) =''
declare	@OutputInfo xml =''
exec dbo.sp_KIOSK_GetExamInfo @PatientIDs,@PatientNames,@AccessionNumbers,@Modalitys,@StartDT,@EndDT,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_KIOSK_GetExamInfo]
	@PatientIDs nvarchar(max),
	@PatientNames nvarchar(max),
	@AccessionNumbers nvarchar(max),
	@Modalitys nvarchar(max),
	@StartDT nvarchar(32),
	@EndDT nvarchar(32),
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @PatientIDs = LTRIM(RTRIM(ISNULL(@PatientIDs,'')))
	SET @PatientNames = LTRIM(RTRIM(ISNULL(@PatientNames,'')))
	SET @AccessionNumbers = LTRIM(RTRIM(ISNULL(@AccessionNumbers,'')))
	SET @Modalitys = LTRIM(RTRIM(ISNULL(@Modalitys,'')))
	SET @StartDT = LTRIM(RTRIM(ISNULL(@StartDT,'')))
	SET @EndDT = LTRIM(RTRIM(ISNULL(@EndDT,'')))
	SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfo:Success</OutputInfo>'

	DECLARE @SQL nvarchar(max) = ''
	DECLARE @PatientIDList nvarchar(max) = ''
	DECLARE @PatientNameList nvarchar(max) = ''
	DECLARE @AccessionNumberList nvarchar(max) = ''
	DECLARE @ModalitysList nvarchar(max) = ''
	DECLARE @WHERE nvarchar(max) = ''

	BEGIN TRANSACTION TGetExamInfo
	BEGIN TRY
		IF ((0 < LEN(@PatientIDs)) AND (0 < LEN(@AccessionNumbers)))
		BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @PatientIDList = REPLACE(@PatientIDs,',',''',''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''' + @PatientIDList + '''))'
			END
			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''',''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''' + @AccessionNumberList + '''))'
			END
		END
		ELSE BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @PatientIDList = REPLACE(@PatientIDs,',',''',''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''' + @PatientIDList + '''))'
			END

			IF(0<LEN(@PatientNames))
			BEGIN
				SET @PatientNameList = REPLACE(@PatientNames,',',''',''')
				SET @WHERE = @WHERE+' AND (NameEN IN (''' + @PatientNameList + ''') OR NameCN IN (''' + @PatientNameList + '''))'
			END
			
			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''',''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''' + @AccessionNumberList + '''))'
			END

			IF(0<LEN(@Modalitys))
			BEGIN
				SET @ModalitysList = REPLACE(@Modalitys,',',''',''')
				SET @WHERE = @WHERE+' AND (Modality IN (''' + @ModalitysList + '''))'
			END
		END

		IF(0<LEN(@AccessionNumbers))
		BEGIN
			SET @SQL = 'SELECT [PatientID],[AccessionNumber],[NameEN],[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(CASE [PatientType] WHEN ''住院病人'' THEN ''1'' WHEN ''门诊病人'' THEN ''2'' WHEN ''急诊病人'' THEN ''3'' WHEN ''体检病人'' THEN ''4'' ELSE ''5'' END) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				 FROM GCRIS2.dbo.vi_KIOSK_ExamInfo_Order WHERE 1=1' + @WHERE + ' ORDER BY ExamDT DESC'
		END
		ELSE
		BEGIN
			SET @SQL = 'SELECT [PatientID],[AccessionNumber],[NameEN],[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(CASE [PatientType] WHEN ''住院病人'' THEN ''1'' WHEN ''门诊病人'' THEN ''2'' WHEN ''急诊病人'' THEN ''3'' WHEN ''体检病人'' THEN ''4'' ELSE ''5'' END) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				 FROM GCRIS2.dbo.vi_KIOSK_ExamInfo_Patient WHERE 1=1' + @WHERE + ' ORDER BY ExamDT DESC'
		END

		--SELECT @SQL
		EXEC (@SQL)

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfo:Success PatientID['+@PatientIDs+'] Name['+@PatientNames+'] AccessionNumber['+@AccessionNumbers+'] Modality['+@Modalitys+']</OutputInfo>'
		COMMIT TRANSACTION TGetExamInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TGetExamInfo
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfo:Error PatientID['+@PatientIDs+'] Name['+@PatientNames+'] AccessionNumber['+@AccessionNumbers+'] Modality['+@Modalitys+']</OutputInfo>'
	END CATCH
END
GO
