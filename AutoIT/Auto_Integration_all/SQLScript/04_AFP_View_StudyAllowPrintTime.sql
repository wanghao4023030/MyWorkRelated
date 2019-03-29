USE [WGGC]
GO

/****** Object:  View [dbo].[AFP_View_StudyAllowPrintTime]    Script Date: 10/12/2017 17:06:58 ******/

IF EXISTS(SELECT 1 FROM sys.views WHERE name='AFP_View_StudyAllowPrintTime')
	DROP VIEW AFP_View_StudyAllowPrintTime
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AFP_View_StudyAllowPrintTime]
AS
SELECT DISTINCT PatientID,NameCN,AccessionNumber,ExamDT,PatientType,Modality,Examname,PrintStatus,
 CASE
WHEN Modality='MR' THEN '请在检查24小时后取结果！'
--以下请填写急诊检查
--WHEN PatientType='3' AND Examname='部位' THEN '请在检查10小时后取结果！'

--以下请填写门诊住院检查
--WHEN PatientType IN ('2','1') AND Examname='部位' THEN '请在检查24小时后取结果！'

WHEN PatientType='3' THEN '请在检查30分钟后取结果！'
WHEN PatientType IN ('2','1') THEN '请在检查60分钟后取结果！'
--WHEN PatientType='1' AND Modality='MR' THEN '请在第二天14时后取结果！'
ELSE '请在检查60分钟后取结果！' END
AS MSGValue,

CASE
WHEN Modality='MR' THEN DATEADD(HH,24,ExamDT)
--以下请填写急诊检查
--WHEN PatientType='3' AND Examname='部位' THEN DATEADD(HH,10,ExamDT)

--以下请填写门诊住院检查
--WHEN PatientType IN ('2','1') AND Examname='部位' THEN DATEADD(HH,24,ExamDT)

WHEN PatientType='3' THEN DATEADD(MI,30,ExamDT) 
WHEN PatientType IN ('2','1') THEN DATEADD(MI,60,ExamDT)
--WHEN PatientType='1' AND Modality='MR' THEN DATEADD(HH,14,CONVERT(datetime,CONVERT(date,DATEADD(DAY,1,ExamDT))))
ELSE DATEADD(MI,60,ExamDT) END  
AS AllowTime

FROM T_Integration_ExamInfo 
WHERE AccessionNumber <>'' AND PatientID <>'' AND ExamDT<>'' --And CreateDT >DATEADD(DAY,-30,GETDATE())

GO


