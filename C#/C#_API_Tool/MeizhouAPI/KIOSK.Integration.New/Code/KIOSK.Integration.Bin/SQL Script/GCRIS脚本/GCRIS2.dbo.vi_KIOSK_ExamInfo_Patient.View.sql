USE [GCRIS2]
GO
/****** Object:  View [dbo].[vi_KIOSK_ExamInfo_Patient]    Script Date: 12/29/2014 11:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  <Gary Shi>
-- Create date: <2014-08-30>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get RIS ExamInfo>
-- ============================================= 
CREATE VIEW [dbo].[vi_KIOSK_ExamInfo_Patient]
AS                        
	SELECT DISTINCT p.PatientID AS PatientID
		,o.AccNo AS AccessionNumber
		,p.EnglishName AS NameEN
		,p.LocalName AS NameCN
		,p.Gender AS Gender
		,p.Birthday AS Birthday
		,pro.ModalityType AS Modality
		,pro.Modality AS ModalityName
		,o.PatientType AS PatientType
		,'0' AS VisitID
		,o.RemoteAccNo AS RequestID
		,o.ApplyDept AS RequestDepartment
		,'' AS RequestDT
		,pro.RegisterDt AS RegisterDT
		,pro.ExamineDt AS ExamDT
		,'' AS ReportDT
		,'' AS SubmitDT
		,'' AS ApproveDT
		,'' AS PDFReportURL
		,pro.Status AS StudyStatus
		
		,o.InHospitalNo AS InHospitalNo
		,o.ClinicNo AS OutHospitalNo
		,'' AS PhysicalNumber
		,cod.Bodypart AS ExamBodyPart
		,cod.CheckingItem AS ExamName

		,o.CardNo AS Optional0
		,o.HisID AS Optional1
		,o.IsEmergency AS Optional2
		,o.StudyInstanceUID AS Optional3
		,'' AS Optional4
		,'' AS Optional5
		,'' AS Optional6
		,'' AS Optional7
		,'' AS Optional8
		,'' AS Optional9
	FROM tRegPatient p
	INNER JOIN tRegOrder o ON p.PatientGuid=o.PatientGuid
	INNER JOIN tRegProcedure pro ON o.OrderGuid=pro.OrderGuid
	LEFT JOIN tProcedureCode cod ON pro.ProcedureCode=cod.ProcedureCode
GO
