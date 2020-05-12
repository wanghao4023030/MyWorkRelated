USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetExamInfo]    Script Date: 08/31/2014 23:56:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id(N'sp_Integration_GetExamInfo') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN  
  DROP PROCEDURE sp_Integration_GetExamInfo
END
GO
-- =============================================
-- Author: <Gary Shi>
-- Create date: <2014-08-21>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get ExamInfo>
/*
declare	@PatientIDs nvarchar(max) ='P20140403094904,P000000071'
declare	@PatientNames nvarchar(128) ='E20140403094904,¿Ó≈‡–˘'
declare	@AccessionNumbers nvarchar(max) ='A20140403094904,201105140073'
declare	@Modalitys nvarchar(128) ='CR,DR'
declare	@StartDT nvarchar(32) =''
declare	@EndDT nvarchar(32) =''
declare	@OutputInfo xml =''
exec dbo.sp_Integration_GetExamInfo @PatientIDs,@PatientNames,@AccessionNumbers,@Modalitys,@StartDT,@EndDT,@OutputInfo output
*/
-- =============================================

CREATE PROCEDURE [dbo].[sp_Integration_GetExamInfo]
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
	DECLARE @PatientIDList nvarchar(max) = ''
	DECLARE @PatientNameList nvarchar(max) = ''
	DECLARE @AccessionNumberList nvarchar(max) = ''
	DECLARE @ModalitysList nvarchar(max) = ''
	DECLARE @WHERE nvarchar(max) = ''

	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfo:Success</OutputInfo>'
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
				SET @PatientIDList = REPLACE(@PatientIDs,',',''''',''''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''''' + @PatientIDList + '''''))'
			END

			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''''',''''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''''' + @AccessionNumberList + '''''))'
			END
		END
		ELSE BEGIN
			IF(0<LEN(@PatientIDs))
			BEGIN
				SET @PatientIDList = REPLACE(@PatientIDs,',',''''',''''')
				SET @WHERE = @WHERE+' AND (PatientID IN (''''' + @PatientIDList + '''''))'
			END

			IF(0<LEN(@PatientNames))
			BEGIN
				SET @PatientNameList = REPLACE(@PatientNames,',',''''',''''')
				--SET @WHERE = @WHERE+' AND (NameEN IN (''''' + @PatientNameList + ''''') OR NameCN IN (''''' + @PatientNameList + '''''))'
				DECLARE @i int
				SET @i=PATINDEX('%[A-Za-z]%',@PatientNameList)
				IF(@i>0)
				BEGIN
					SET @WHERE = @WHERE+' AND (NameEN IN (''''' + @PatientNameList + '''''))'
				END
				ELSE
				BEGIN
					SET @WHERE = @WHERE+' AND (NameCN IN (''''' + @PatientNameList + '''''))'
				END
			END

			IF(0<LEN(@AccessionNumbers))
			BEGIN
				SET @AccessionNumberList = REPLACE(@AccessionNumbers,',',''''',''''')
				SET @WHERE = @WHERE+' AND (AccessionNumber IN (''''' + @AccessionNumberList + '''''))'
			END

			IF(0<LEN(@Modalitys))
			BEGIN
				SET @ModalitysList = REPLACE(@Modalitys,',',''''',''''')
				SET @WHERE = @WHERE+' AND (Modality IN (''''' + @ModalitysList + '''''))'
			END
		END

		IF(0<LEN(@WHERE))
		BEGIN
			SET @SQL = 'SELECT [PatientID],[AccessionNumber],[NameEN],[NameCN],[Gender],[Birthday],[Modality],[ModalityName]
				,(SELECT TOP 1 [KEY] FROM [dbo].[T_Integration_Dictionary] WHERE [TagType]=''PatientType'' AND ([Value]=ISNULL(LTRIM(RTRIM([PatientType])),'''') OR [Value]=''Other'')) AS [PatientType]
				,[VisitID],[RequestID],[RequestDepartment],[RequestDT],[RegisterDT],[ExamDT],[SubmitDt],[ApproveDT],[PDFReportURL],[StudyStatus]
				,'''' AS [OutHospitalNo],'''' AS [InHospitalNo],'''' AS [PhysicalNumber],[ExamName],'''' AS [ExamBodyPart]
				,[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]
				FROM OPENQUERY(RISDB,''SELECT * FROM WGGC.dbo.vi_KIOSK_ExamInfo_Order WHERE 1=1' + @WHERE + ''') AS DS ORDER BY REGISTERDT DESC, EXAMDT DESC'
			EXEC (@SQL)
		END
		
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetExamInfo:Error</OutputInfo>'
		
	END CATCH

END
GO



