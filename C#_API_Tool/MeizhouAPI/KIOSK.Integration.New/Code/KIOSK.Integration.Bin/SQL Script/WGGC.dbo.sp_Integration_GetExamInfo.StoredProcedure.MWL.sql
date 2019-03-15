USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetExamInfoMWL]    Script Date: 12/18/2014 15:41:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Gary Shi>
-- Create date: <2014-08-21>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get ExamInfo>
/*
declare	@PatientIDs nvarchar(max) ='P000000006,123,456'
declare	@PatientNames nvarchar(128) ='王旭,123,456'
declare	@AccessionNumbers nvarchar(max) ='201105140006,123,456'
declare	@Modalitys nvarchar(128) ='DR,123,456'
declare	@StartDT nvarchar(32) =''
declare	@EndDT nvarchar(32) =''
declare	@OutputInfo xml =''
exec dbo.sp_Integration_GetExamInfoMWL @PatientIDs,@PatientNames,@AccessionNumbers,@Modalitys,@StartDT,@EndDT,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetExamInfoMWL]
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
	SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoMWL:Success</OutputInfo>'

	DECLARE @SQL nvarchar(max) = ''
	DECLARE @PatientIDList nvarchar(max) = ''
	DECLARE @PatientNameList nvarchar(max) = ''
	DECLARE @AccessionNumberList nvarchar(max) = ''
	DECLARE @ModalitysList nvarchar(max) = ''
	DECLARE @WHERE nvarchar(max) = ''
	DECLARE @NameEN nvarchar(max) = ''

	BEGIN TRANSACTION TGetExamInfo
	BEGIN TRY
		IF(0<LEN(@PatientIDs))
		BEGIN
			SET @PatientIDList = REPLACE(@PatientIDs,',',''',''')
			SET @WHERE = @WHERE+' AND ([PatientID] IN (''' + @PatientIDList + '''))'
		END

		IF(0<LEN(@PatientNames))
		BEGIN
			-- MWL校验时通过PDF报告获取病人中文姓名。
			UPDATE [dbo].[T_Integration_ExamInfo]
			SET [NameCN]=(CASE WHEN PATINDEX('%[吖-做]%',@PatientNames)>0 THEN @PatientNames ELSE [NameCN] END)
			WHERE (0<LEN(@PatientIDs) AND [PatientID]=@PatientIDs)
			OR (0<LEN(@AccessionNumbers) AND [AccessionNumber]=@AccessionNumbers)

			SET @PatientNameList = REPLACE(@PatientNames,',',''',''')
			SET @WHERE = @WHERE+' AND ([NameEN] IN (''' + @PatientNameList + ''') OR [NameCN] IN (''' + @PatientNameList + '''))'
		END

		IF(0<LEN(@AccessionNumbers))
		BEGIN
			SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''',''')
			SET @WHERE = @WHERE+' AND ([AccessionNumber] IN (''' + @AccessionNumberList + '''))'
		END

		IF(0<LEN(@Modalitys))
		BEGIN
			SET @ModalitysList = REPLACE(@Modalitys,',',''',''')
			SET @WHERE = @WHERE+' AND ([Modality] IN (''' + @ModalitysList + '''))'
		END

		IF(0<LEN(@WHERE))
		BEGIN
			SET @SQL = 'SELECT DISTINCT [PatientID],[AccessionNumber]
				,(CASE WHEN ISNULL(LTRIM(RTRIM([NameCN])),'''')='''' THEN [NameEN] ELSE [NameCN] END) AS [NameEN]
				,[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(SELECT TOP 1 [Key] FROM [dbo].[T_Integration_Dictionary] WHERE [TagType]=''PatientType'' AND ([Value]=ISNULL(LTRIM(RTRIM([PatientType])),'''') OR [Value]=''Other'')) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,'''' AS [OutHospitalNo],'''' AS [InHospitalNo],'''' AS [PhysicalNumber],'''' AS [ExamName],'''' AS [ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				FROM [dbo].[T_Integration_ExamInfo]
				WHERE 1=1' + @WHERE
			--SELECT @SQL
			EXEC (@SQL)
		END

		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoMWL:Success PatientID['+@PatientIDs+'] Name['+@PatientNames+'] AccessionNumber['+@AccessionNumbers+'] Modality['+@Modalitys+']</OutputInfo>'
		COMMIT TRANSACTION TGetExamInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TGetExamInfo
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfoMWL:Error PatientID['+@PatientIDs+'] Name['+@PatientNames+'] AccessionNumber['+@AccessionNumbers+'] Modality['+@Modalitys+']</OutputInfo>'
	END CATCH
END
