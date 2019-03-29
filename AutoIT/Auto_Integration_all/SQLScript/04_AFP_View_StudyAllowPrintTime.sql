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
WHEN Modality='MR' THEN '���ڼ��24Сʱ��ȡ�����'
--��������д������
--WHEN PatientType='3' AND Examname='��λ' THEN '���ڼ��10Сʱ��ȡ�����'

--��������д����סԺ���
--WHEN PatientType IN ('2','1') AND Examname='��λ' THEN '���ڼ��24Сʱ��ȡ�����'

WHEN PatientType='3' THEN '���ڼ��30���Ӻ�ȡ�����'
WHEN PatientType IN ('2','1') THEN '���ڼ��60���Ӻ�ȡ�����'
--WHEN PatientType='1' AND Modality='MR' THEN '���ڵڶ���14ʱ��ȡ�����'
ELSE '���ڼ��60���Ӻ�ȡ�����' END
AS MSGValue,

CASE
WHEN Modality='MR' THEN DATEADD(HH,24,ExamDT)
--��������д������
--WHEN PatientType='3' AND Examname='��λ' THEN DATEADD(HH,10,ExamDT)

--��������д����סԺ���
--WHEN PatientType IN ('2','1') AND Examname='��λ' THEN DATEADD(HH,24,ExamDT)

WHEN PatientType='3' THEN DATEADD(MI,30,ExamDT) 
WHEN PatientType IN ('2','1') THEN DATEADD(MI,60,ExamDT)
--WHEN PatientType='1' AND Modality='MR' THEN DATEADD(HH,14,CONVERT(datetime,CONVERT(date,DATEADD(DAY,1,ExamDT))))
ELSE DATEADD(MI,60,ExamDT) END  
AS AllowTime

FROM T_Integration_ExamInfo 
WHERE AccessionNumber <>'' AND PatientID <>'' AND ExamDT<>'' --And CreateDT >DATEADD(DAY,-30,GETDATE())

GO


