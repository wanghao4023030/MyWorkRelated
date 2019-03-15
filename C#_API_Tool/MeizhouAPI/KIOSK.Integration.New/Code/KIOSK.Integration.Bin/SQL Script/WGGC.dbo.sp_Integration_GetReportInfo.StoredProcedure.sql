USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetReportInfo]    Script Date: 12/29/2014 11:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (SELECT * FROM sysobjects WHERE id = object_id(N'sp_Integration_GetReportInfo') and OBJECTPROPERTY(id, N'IsProcedure') = 1)  
  DROP PROCEDURE sp_Integration_GetReportInfo
GO

-- =============================================
-- Author:  <Gary Shi>
-- Create date: <2014-03-02>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get ReportInfo>
/*
declare @OutputInfo xml=''
exec sp_Integration_GetReportInfo @OutputInfo output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_GetReportInfo]
	@OutputInfo xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfo:Success</OutputInfo>'

	DECLARE @Days int = 7
	DECLARE @MinutesForMR int = 15 -- 2Hour
	DECLARE @MinutesForCT int = 15 -- 2Hour
	DECLARE @MinutesForDX int = 10 -- 1Hour
	DECLARE @CurrentDT datetime = GETDATE()
	DECLARE @PatientID nvarchar(128) = ''
	DECLARE @AccessionNumber nvarchar(128) = ''

	BEGIN TRANSACTION TGetReportInfo
	BEGIN TRY
		SELECT TOP 10 [CreateDT]
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
		FROM [dbo].[T_Integration_ExamInfo]
		WHERE DATEDIFF(DAY,[CreateDT],@CurrentDT)<=@Days
		AND ISNULL([NotifyReportFlag],0) IN (-10,0)
		AND [AccessionNumber] IN (SELECT AccessionNumber FROM AFP_FILMINFO)
		ORDER BY (CASE WHEN ISDATE(Optional9)=1 THEN CONVERT(DATETIME,Optional9) ELSE GETDATE()-8 END) ASC, [CreateDT] ASC;

		SELECT TOP 1 @PatientID=[PatientID],@AccessionNumber=[AccessionNumber]
		FROM [dbo].[T_Integration_ExamInfo]
		WHERE DATEDIFF(DAY,[CreateDT],@CurrentDT)<=@Days
		AND ISNULL([NotifyReportFlag],0) IN (-10,0)
		AND [AccessionNumber] IN (SELECT AccessionNumber FROM AFP_FILMINFO)
		ORDER BY (CASE WHEN ISDATE(Optional9)=1 THEN CONVERT(DATETIME,Optional9) ELSE GETDATE()-8 END) ASC, [CreateDT] ASC;

		UPDATE [dbo].[T_Integration_ExamInfo]
		SET [Optional8]=CONVERT(INT,ISNULL(LTRIM(RTRIM([Optional8])),0))+1,[Optional9]=GETDATE()
		WHERE [PatientID]=@PatientID AND [AccessionNumber]=@AccessionNumber;

		/*
		DECLARE GetReportInfo_Cursor CURSOR FOR
			SELECT TOP 5 [PatientID],[AccessionNumber]
			FROM [dbo].[T_Integration_ExamInfo]
			WHERE DATEDIFF(DAY,[CreateDT],@CurrentDT)<=@Days
			AND ISNULL([NotifyReportFlag],0) IN (-10,0)
			--AND CONVERT(INT,ISNULL([Optional8],0))<'10000'
			--AND LTRIM(RTRIM([PatientType]))='1' -- 1门诊 2住院 3体检 4急诊
			AND (CASE WHEN ISDATE([ExamDT])=1 THEN
					CASE
						WHEN UPPER([Modality]) LIKE '%CR%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForDX THEN 1
						WHEN UPPER([Modality]) LIKE '%CT%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForCT THEN 1
						WHEN UPPER([Modality]) LIKE '%MR%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForMR THEN 1
						WHEN UPPER([Modality]) LIKE '%磁%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForMR THEN 1
					END
				 END)=1
			ORDER BY [Optional8] ASC,[CreateDT] ASC;
		OPEN GetReportInfo_Cursor;
		FETCH NEXT FROM GetReportInfo_Cursor INTO @PatientID,@AccessionNumber;
		WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE [dbo].[T_Integration_ExamInfo]
				SET [Optional8]=CONVERT(INT,ISNULL([Optional8],0))+1,[Optional9]=GETDATE()
				WHERE [PatientID]=@PatientID AND [AccessionNumber]=@AccessionNumber;

				FETCH NEXT FROM GetReportInfo_Cursor INTO @PatientID,@AccessionNumber;
			END;
		CLOSE GetReportInfo_Cursor;
		DEALLOCATE GetReportInfo_Cursor;
		*/
		/*
		UPDATE [dbo].[T_Integration_ExamInfo]
		SET [Optional8]=CONVERT(INT,ISNULL([Optional8],0))+1
		WHERE DATEDIFF(DAY,[CreateDT],@CurrentDT)<=@Days
		AND ISNULL([NotifyReportFlag],0) IN (-10,0)
		AND CONVERT(INT,ISNULL([Optional8],0))<'10000'
		--AND LTRIM(RTRIM([PatientType]))='1' -- 1门诊 2住院 3体检 4急诊
		AND (CASE WHEN ISDATE([ExamDT])=1 THEN
				CASE
					WHEN UPPER([Modality]) LIKE '%CR%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForDX THEN 1
					WHEN UPPER([Modality]) LIKE '%CT%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForCT THEN 1
					WHEN UPPER([Modality]) LIKE '%MR%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForMR THEN 1
					WHEN UPPER([Modality]) LIKE '%磁%' AND DATEDIFF(MINUTE,CONVERT(datetime,[ExamDT]),@CurrentDT)>@MinutesForMR THEN 1
				END
			 END)=1
		*/
		COMMIT TRANSACTION TGetReportInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TGetReportInfo
		SET @OutputInfo = '<OutputInfo>sp_Integration_GetReportInfo:Error</OutputInfo>'
	END CATCH
END
GO
