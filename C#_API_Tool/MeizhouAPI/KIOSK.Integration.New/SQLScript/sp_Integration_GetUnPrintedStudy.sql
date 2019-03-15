USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetUnPrintedStudy]    Script Date: 10/13/2017 23:56:46 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_GetUnPrintedStudy') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_GetUnPrintedStudy
END  
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2017-10-11>
-- Alter date:<2017-10-11>
/*
declare @TerminalInfo nvarchar(32)='192.168.1.100'
declare @CardType nvarchar(128)='ACCESSION_NUMBER'
declare @CardNumber nvarchar(128)='JSDR201412171320' 
declare @ReturnType nvarchar(128)='ACCESSION_NUMBER'
declare @OutputInfo xml=''
exec sp_Integration_GetUnPrintedStudy @TerminalInfo,@CardType,@CardNumber,@OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetUnPrintedStudy]
	@TerminalInfo nvarchar(32),
	@CardType nvarchar(128),
	@CardNumber nvarchar(128),
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(max) = ''
	
	BEGIN TRY
		SET @TerminalInfo = LTRIM(RTRIM(ISNULL(@TerminalInfo,'')))
		SET @CardType = LTRIM(RTRIM(ISNULL(@CardType,'')))
		SET @CardNumber = LTRIM(RTRIM(ISNULL(@CardNumber,'')))
		
		IF (@CardType='PATIENT_ID' AND @CardNumber<>'')
		BEGIN
			SET @SQL = 'SELECT T.[PatientID] as [Optional0],T.orderID as [PatientID],T.[AccessionNumber],T.EnglishName as [NameEN],T.Name as [NameCN],T.Sex as [Gender],T.[Birthday],T.[Modality],T.Device as [ModalityName]
			,(SELECT TOP 1 [KEY] FROM [dbo].[T_Integration_Dictionary] WHERE [TagType]=''PatientType'' AND ([Value]=ISNULL(LTRIM(RTRIM(T.[PatientType])),'''') OR [Value]=''Other'')) AS [PatientType]
			,T.cardNumber as [VisitID],T.orderID as [RequestID],T.PatientID AS ReferringDepartment,'''' as [RequestDepartment],'''' as [RequestDT],T.examarrivaldate + '' ''+  T.examarrivaltime as  [RegisterDT]
			,T.studydate + '' '' + T.studytime as  [ExamDT],T.reportdate +'' ''+ T.reporttime as  [SubmitDt],T.confirmdate +'' ''+ T.confirmtime as [ApproveDT],T.ReportPath as [PDFReportURL],T.examStatus as [StudyStatus]
			,T.hospitalID AS [OutHospitalNo],'''' AS [InHospitalNo],'''' AS [PhysicalNumber],T.StudyPart AS [ExamName],T.StudyPart AS [ExamBodyPart]
			,'''' AS [Optional1],'''' AS [Optional2],'''' AS [Optional3],'''' AS [Optional4],'''' AS [Optional5],'''' AS [Optional6],'''' AS [Optional7],T.ReportID AS [Optional8],T.[PatientID] AS [Optional9]
			FROM
			(SELECT * FROM OPENQUERY(RISDB,''SELECT * FROM gecris.RIS_EXAMINFO_SelfPrint where orderid='''''+@CardNumber+''''''') A
			where AccessionNumber in
			(select top 1 AccessionNumber FROM OPENQUERY(RISDB,''SELECT ReportID,AccessionNumber FROM gecris.RIS_EXAMINFO_SelfPrint where orderid='''''+@CardNumber+''''''') B
			where A.ReportID=B.ReportID)) T
			LEFT JOIN T_Integration_ExamInfo TIE ON T.AccessionNumber=TIE.AccessionNumber 
			WHERE TIE.ReportPrintFlag <>1 OR TIE.ReportPrintFlag IS NULL'
			EXEC (@SQL)
		END
		ELSE IF (@CardType='ACCESSION_NUMBER' AND @CardNumber<>'')
		BEGIN
			SET @SQL = 'SELECT T.[PatientID] as [Optional0],T.orderID as [PatientID],T.[AccessionNumber],T.EnglishName as [NameEN],T.Name as [NameCN],T.Sex as [Gender],T.[Birthday],T.[Modality],T.Device as [ModalityName]
			,(SELECT TOP 1 [KEY] FROM [dbo].[T_Integration_Dictionary] WHERE [TagType]=''PatientType'' AND ([Value]=ISNULL(LTRIM(RTRIM(T.[PatientType])),'''') OR [Value]=''Other'')) AS [PatientType]
			,T.cardNumber as [VisitID],T.orderID as [RequestID],T.PatientID AS ReferringDepartment,'''' as [RequestDepartment],'''' as [RequestDT],T.examarrivaldate + '' ''+  T.examarrivaltime as  [RegisterDT]
			,T.studydate + '' '' + T.studytime as  [ExamDT],T.reportdate +'' ''+ T.reporttime as  [SubmitDt],T.confirmdate +'' ''+ T.confirmtime as [ApproveDT],T.ReportPath as [PDFReportURL],T.examStatus as [StudyStatus]
			,T.hospitalID AS [OutHospitalNo],'''' AS [InHospitalNo],'''' AS [PhysicalNumber],T.StudyPart AS [ExamName],T.StudyPart AS [ExamBodyPart]
			,'''' AS [Optional1],'''' AS [Optional2],'''' AS [Optional3],'''' AS [Optional4],'''' AS [Optional5],'''' AS [Optional6],'''' AS [Optional7],T.ReportID AS [Optional8],T.[PatientID] AS [Optional9]
			FROM OPENQUERY(RISDB,''SELECT * FROM gecris.RIS_EXAMINFO_SelfPrint WHERE AccessionNumber='''''+@CardNumber+''''''') T
			LEFT JOIN T_Integration_ExamInfo TIE ON T.AccessionNumber=TIE.AccessionNumber 
			WHERE TIE.ReportPrintFlag <>1 OR TIE.ReportPrintFlag IS NULL'
			EXEC (@SQL)
		END
		
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetUnPrintedStudy:Success. @CardType['+@CardType+'],@CardNumber['+@CardNumber+']</OutputInfo>'
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetUnPrintedStudy:Fail. @CardType['+@CardType+'],@CardNumber['+@CardNumber+']</OutputInfo>'
	END CATCH
END

