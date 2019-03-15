USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_GetunPrintFilmExam]    Script Date: 03/09/2017 10:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
declare @CardType nvarchar(128)='PATIENT_ID'
declare @CardNumber nvarchar(128)='1192742' 
declare @PrintLevel nvarchar(128)='PATIENT_ID'
exec sp_Integration_GetunPrintFilmExam @CardType,@CardNumber,@PrintLevel
*/


CREATE PROCEDURE [dbo].[sp_Integration_GetunPrintFilmExam] 
	-- Add the parameters for the stored procedure here
	@CardType	nvarchar(128),
	@CardNumber	nvarchar(128),
	@PrintLevel nvarchar(128)
	--@OutputInfo	xml output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SET @CardType = LTRIM(RTRIM(ISNULL(@CardType, '')))
	SET @CardNumber = LTRIM(RTRIM(ISNULL(@CardNumber, '')))
	SET @PrintLevel = LTRIM(RTRIM(ISNULL(@PrintLevel, '')))
	--SET @OutputInfo = '<OutputInfo>sp_Integration_GetPatientInfo:Success</OutputInfo>'
	
	DECLARE @PatientID nvarchar(max) = ''
	DECLARE @AccessionNumber nvarchar(max) = ''
	DECLARE @FilmStoredFlag int =0
	DECLARE @ReportStoredFlag int =0
	DECLARE @FilmPrintFlag int =0
	DECLARE @ReportPrintFlag int =0
	
	IF ('ACCESSION_NUMBER' = @CardType AND 'PATIENT_ID' = @PrintLevel)
	BEGIN		
		SELECT @CardNumber = PatientID FROM WGGC.dbo.T_Integration_ExamInfo WHERE AccessionNumber = @CardNumber
	END
	
	
	DECLARE CurPatientID CURSOR
	FOR SELECT PatientID,AccessionNumber FROM T_Integration_ExamInfo WHERE ('PATIENT_ID' = @PrintLevel AND PatientID = @CardNumber) OR ('ACCESSION_NUMBER' = @PrintLevel AND AccessionNumber = @CardNumber)
	OPEN CurPatientID
	FETCH NEXT FROM CurPatientID INTO @PatientID,@AccessionNumber
	WHILE (@@FETCH_STATUS = 0) 
    BEGIN
		IF ((@PatientID <> '') AND (@AccessionNumber <> ''))
		BEGIN
			SELECT @FilmStoredFlag= (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) WHEN 2 THEN 0 ELSE 9 END)
				,@ReportStoredFlag=(CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN 2 THEN 0 ELSE 9 END)
				,@FilmPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) WHEN 2 THEN 0 ELSE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) END)
				,@ReportPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN 2 THEN 0 ELSE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) END)
			
			UPDATE [WGGC].[dbo].[T_Integration_ExamInfo] 
			SET FilmStoredFlag = @FilmStoredFlag,
				ReportStoredFlag = @ReportStoredFlag,
				FilmPrintFlag = @FilmPrintFlag,
				ReportPrintFlag = @ReportPrintFlag
			WHERE (''<>@AccessionNumber) AND ([AccessionNumber]=@AccessionNumber)
		END
		FETCH NEXT FROM CurPatientID INTO @PatientID,@AccessionNumber
    END

	CLOSE CurPatientID
	DEALLOCATE CurPatientID
	
	SELECT T_Integration_ExamInfo.PatientID AS PatientID,T_Integration_ExamInfo.AccessionNumber AS AccessionNumber,T_Integration_ExamInfo.NameCN AS NameCN,
		T_Integration_ExamInfo.VerifyReportDT,T_Integration_ExamInfo.ApproveDT,T_Integration_ExamInfo.ReportStoredFlag,T_Integration_ExamInfo.NotifyReportFlag
	FROM T_Integration_ExamInfo 
	LEFT JOIN [AFP_PrintMode] ON [T_Integration_ExamInfo].[AccessionNumber]=[AFP_PrintMode].[AccessionNumber]
	WHERE 1 =1 
		AND (([T_Integration_ExamInfo].PatientID = @CardNumber AND 'PATIENT_ID' = @PrintLevel) OR ([T_Integration_ExamInfo].AccessionNumber = @CardNumber AND 'ACCESSION_NUMBER' = @PrintLevel)) 
		AND ReportPrintFlag <> 1 AND [T_Integration_ExamInfo].AccessionNumber IN (SELECT AccessionNumber FROM AFP_FILMINFO WHERE FilmFlag = 0)
		AND ((0=ISNULL([AFP_PrintMode].[PrintMode],0) )
			  OR (2=ISNULL([AFP_PrintMode].[PrintMode],0))
			  OR (3=ISNULL([AFP_PrintMode].[PrintMode],0)))
END
