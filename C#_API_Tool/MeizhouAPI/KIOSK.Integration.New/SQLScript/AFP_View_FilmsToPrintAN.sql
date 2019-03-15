USE [WGGC]
GO

/****** Object:  View [dbo].[AFP_View_FilmsToPrintAN]    Script Date: 09/22/2017 19:44:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	Song.Yang
-- Create date: <2015-04-23>
-- Description:	Collect all films that can be printed 
-- =============================================
ALTER VIEW [dbo].[AFP_View_FilmsToPrintAN]
AS
SELECT  DISTINCT  FI.PatientName,FI.PatientID,FI.AccessionNumber AS AccessionNo, FI.StudyInstanceUID,
FI.CallingAE,FI.CallingIP, fi.StudyDate, fi.StudyTime,FI.Modalities, FI.PatientType, FI.StatusTime
FROM dbo.AFP_FilmInfo FI
LEFT OUTER JOIN	dbo.AFP_ReportInfo ON FI.AccessionNumber = dbo.AFP_ReportInfo.AccessionNumber 
LEFT OUTER JOIN	dbo.AFP_PrintMode ON dbo.AFP_PrintMode.AccessionNumber = FI.AccessionNumber
INNER JOIN	        dbo.AFP_View_StudyAllowPrintTime V_SAPT ON V_SAPT.AccessionNumber = FI.AccessionNumber
WHERE (FI.DeleteStatus is null or FI.DeleteStatus = 0) 
AND FI.FilmFlag = 0 
AND LEN(ISNULL(FI.AccessionNumber, '')) > 0
AND (dbo.AFP_PrintMode.HoldFlag = 0 OR 1 = dbo.AFP_F_StudyAcqReady(FI.AccessionNumber)) 
AND (
		((dbo.AFP_F_ExamPrintMode(AFP_PrintMode.PrintMode) = 0) 
			AND (dbo.AFP_ReportInfo.ReportStatus > 0)
			AND (dbo.AFP_ReportInfo.PrintStatus != 2 OR dbo.AFP_ReportInfo.PrintCount > 0)
			AND (dbo.AFP_PrintMode.HoldFlag = 0 OR 1 = dbo.AFP_F_ReportAcqReady(dbo.AFP_ReportInfo.AccessionNumber)) )
		OR (dbo.AFP_F_ExamPrintMode(AFP_PrintMode.PrintMode) = 1) 
		OR (dbo.AFP_F_ExamPrintMode(AFP_PrintMode.PrintMode) = 2) AND (1 = 2) 
		OR (dbo.AFP_F_ExamPrintMode(AFP_PrintMode.PrintMode) = 3) 
     )
 AND V_SAPT.AllowTime<=GETDATE() 




GO


