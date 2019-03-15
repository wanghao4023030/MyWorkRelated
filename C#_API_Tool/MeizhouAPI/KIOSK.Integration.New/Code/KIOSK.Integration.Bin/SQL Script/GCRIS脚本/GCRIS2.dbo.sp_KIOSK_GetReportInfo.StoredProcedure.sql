USE [GCRIS2]
GO
/****** Object:  StoredProcedure [dbo].[sp_KIOSK_GetReportInfo]    Script Date: 12/29/2014 11:32:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  <Gary Shi>
-- Create date: <2014-08-30>
-- Alter date: <2014-12-18>
-- Description: <For KIOSK Get ReportInfo>
/*
declare	@PatientID nvarchar(max) ='PID0000429536'
declare	@PatientName nvarchar(max) =''
declare	@AccessionNumber nvarchar(max) ='MR201510210448'
declare	@Modality nvarchar(max) =''
declare	@ReportID nvarchar(max) =''
declare	@ReportStatus nvarchar(max) =''
declare	@OutputInfo xml =''
declare @OutReport nvarchar(max) = ''
exec dbo.sp_KIOSK_GetReportInfo @PatientID,@PatientName,@AccessionNumber,@Modality,@ReportID,@ReportStatus,@OutputInfo output, @OutReport output
*/
-- =============================================
CREATE PROCEDURE [dbo].[sp_KIOSK_GetReportInfo]
	@PatientID nvarchar(max),
	@PatientName nvarchar(max),
	@AccessionNumber nvarchar(max),
	@Modality nvarchar(max),
	@ReportID nvarchar(max),
	@ReportStatus nvarchar(max),
	@OutputInfo xml output,
	@OutReport nvarchar(max) output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: Null value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	SET @OutputInfo = '<OutputInfo>sp_KIOSK_GetReportInfo:Success</OutputInfo>'
	--SET @AccessionNumber='ZHDR201412190831'
	DECLARE @CheckItem nvarchar(max) = ''
	DECLARE @ReportItem nvarchar(max) = ''
	DECLARE @ItemCount int = 0
	DECLARE @Index int = 0

	BEGIN TRANSACTION TKIOSKGetReportInfo
	BEGIN TRY
		SELECT @ItemCount = COUNT(dbo.tProcedureCode.CheckingItem)
			FROM dbo.tRegOrder INNER JOIN
                 dbo.tRegProcedure ON dbo.tRegOrder.OrderGuid = dbo.tRegProcedure.OrderGuid INNER JOIN
                 dbo.tProcedureCode ON dbo.tRegProcedure.ProcedureCode = dbo.tProcedureCode.ProcedureCode WHERE tRegOrder.AccNo = @AccessionNumber
				 
		DECLARE CurCheckingItem CURSOR
		FOR SELECT  dbo.tProcedureCode.CheckingItem
			FROM dbo.tRegOrder INNER JOIN
                 dbo.tRegProcedure ON dbo.tRegOrder.OrderGuid = dbo.tRegProcedure.OrderGuid INNER JOIN
                 dbo.tProcedureCode ON dbo.tRegProcedure.ProcedureCode = dbo.tProcedureCode.ProcedureCode WHERE tRegOrder.AccNo = @AccessionNumber
		OPEN CurCheckingItem
		FETCH NEXT FROM CurCheckingItem INTO @CheckItem
		WHILE (@@FETCH_STATUS = 0) 
		BEGIN
		     SET @Index = @Index + 1
			IF (@Index < @ItemCount)
			--IF ((@PatientID <> '') AND (@AccessionNumber <> ''))	
			BEGIN
				SET @ReportItem = @ReportItem + @CheckItem + ','
			END
			ELSE IF (@Index = @ItemCount)
			BEGIN
				SET @ReportItem = @ReportItem + @CheckItem
			END
			FETCH NEXT FROM CurCheckingItem INTO @CheckItem
	    END
		
		CLOSE CurCheckingItem
		DEALLOCATE CurCheckingItem
	
		SELECT pat.[PatientGuid] AS tRegPatient__PatientGuid
			,pat.[PatientID] AS tRegPatient__PatientID
			,pat.[LocalName] AS tRegPatient__LocalName
			,pat.[EnglishName] AS tRegPatient__EnglishName
			,pat.[ReferenceNo] AS tRegPatient__ReferenceNo
			,pat.[Birthday] AS tRegPatient__Birthday
			,pat.[Gender] AS tRegPatient__Gender
			,pat.[Address] AS tRegPatient__Address
			,pat.[Telephone] AS tRegPatient__Telephone
			,pat.[IsVIP] AS tRegPatient__IsVIP
			,pat.[CreateDt] AS tRegPatient__CreateDt
			,pat.[Comments] AS tRegPatient__Comments
			,pat.[RemotePID] AS tRegPatient__RemotePID
			,pat.[Optional1] AS tRegPatient__Optional1
			,pat.[Optional2] AS tRegPatient__Optional2
			,pat.[Optional3] AS tRegPatient__Optional3
			,pat.[Alias] AS tRegPatient__Alias
			,pat.[Marriage] AS tRegPatient__Marriage
			,pat.[Domain] AS tRegPatient__Domain
			,pat.[GlobalID] AS tRegPatient__GlobalID
			,pat.[MedicareNo] AS tRegPatient__MedicareNo
			,pat.[ParentName] AS tRegPatient__ParentName
			,pat.[RelatedID] AS tRegPatient__RelatedID
			,pat.[Site] AS tRegPatient__Site
			--------------------------------------------------
			,ord.[OrderGuid] AS tRegOrder__OrderGuid
			,ord.[VisitGuid] AS tRegOrder__VisitGuid
			,ord.[AccNo] AS tRegOrder__AccNo
			,ord.[ApplyDept] AS tRegOrder__ApplyDept
			,ord.[ApplyDoctor] AS tRegOrder__ApplyDoctor
			,ord.[CreateDt] AS tRegOrder__CreateDt
			,ord.[IsScan] AS tRegOrder__IsScan
			,ord.[Comments] AS tRegOrder__Comments
			,ord.[RemoteAccNo] AS tRegOrder__RemoteAccNo
			,ord.[TotalFee] AS tRegOrder__TotalFee
			,ord.[Optional1] AS tRegOrder__Optional1
			,ord.[Optional2] AS tRegOrder__Optional2
			,ord.[Optional3] AS tRegOrder__Optional3
			,ord.[StudyInstanceUID] AS tRegOrder__StudyInstanceUID
			,ord.[HisID] AS tRegOrder__HisID
			,ord.[CardNo] AS tRegOrder__CardNo
			,ord.[PatientGuid] AS tRegOrder__PatientGuid
			,ord.[InhospitalNo] AS tRegOrder__InhospitalNo
			,ord.[ClinicNo] AS tRegOrder__ClinicNo
			,ord.[PatientType] AS tRegOrder__PatientType
			,ord.[Observation] AS tRegOrder__Observation
			,ord.[HealthHistory] AS tRegOrder__HealthHistory
			,ord.[InhospitalRegion] AS tRegOrder__InhospitalRegion
			,ord.[IsEmergency] AS tRegOrder__IsEmergency
			,ord.[BedNo] AS tRegOrder__BedNo
			--,ord.[CurrentAge] AS tRegOrder__CurrentAge
			,REPLACE(REPLACE(REPLACE(REPLACE(UPPER(ord.[CurrentAge]),'YEAR','岁'),'MONTH','月'),'DAY','天'),'HOUR','小时') AS tRegOrder__CurrentAge
			,ord.[AgeInDays] AS tRegOrder__AgeInDays
			,ord.[visitcomment] AS tRegOrder__visitcomment
			,ord.[ChargeType] AS tRegOrder__ChargeType
			,ord.[ErethismType] AS tRegOrder__ErethismType
			,ord.[ErethismCode] AS tRegOrder__ErethismCode
			,ord.[ErethismGrade] AS tRegOrder__ErethismGrade
			,ord.[Domain] AS tRegOrder__Domain
			,ord.[ReferralID] AS tRegOrder__ReferralID
			,ord.[IsReferral] AS tRegOrder__IsReferral
			,ord.[ExamAccNo] AS tRegOrder__ExamAccNo
			,ord.[ExamDomain] AS tRegOrder__ExamDomain
			,ord.[MedicalAlert] AS tRegOrder__MedicalAlert
			,ord.[EXAMALERT1] AS tRegOrder__EXAMALERT1
			,ord.[EXAMALERT2] AS tRegOrder__EXAMALERT2
			,ord.[LMP] AS tRegOrder__LMP
			,ord.[InitialDomain] AS tRegOrder__InitialDomain
			,ord.[ERequisition] AS tRegOrder__ERequisition
			,ord.[CurPatientName] AS tRegOrder__CurPatientName
			,ord.[CurGender] AS tRegOrder__CurGender
			,ord.[Priority] AS tRegOrder__Priority
			,ord.[IsCharge] AS tRegOrder__IsCharge
			,ord.[Bedside] AS tRegOrder__Bedside
			,ord.[IsFilmSent] AS tRegOrder__IsFilmSent
			,ord.[FilmSentOperator] AS tRegOrder__FilmSentOperator
			,ord.[FilmSentDt] AS tRegOrder__FilmSentDt
			,ord.[OrderMessage] AS tRegOrder__OrderMessage
			,ord.[BookingSite] AS tRegOrder__BookingSite
			,ord.[RegSite] AS tRegOrder__RegSite
			,ord.[ExamSite] AS tRegOrder__ExamSite
			--------------------------------------------------
			,pro.[ProcedureGuid] AS tRegProcedure__ProcedureGuid
			,pro.[OrderGuid] AS tRegProcedure__OrderGuid
			,pro.[ProcedureCode] AS tRegProcedure__ProcedureCode
			,pro.[ExamSystem] AS tRegProcedure__ExamSystem
			,pro.[WarningTime] AS tRegProcedure__WarningTime
			,pro.[FilmSpec] AS tRegProcedure__FilmSpec
			,pro.[FilmCount] AS tRegProcedure__FilmCount
			,pro.[ContrastName] AS tRegProcedure__ContrastName
			,pro.[ContrastDose] AS tRegProcedure__ContrastDose
			,pro.[ImageCount] AS tRegProcedure__ImageCount
			,pro.[ExposalCount] AS tRegProcedure__ExposalCount
			,pro.[Deposit] AS tRegProcedure__Deposit
			,pro.[Charge] AS tRegProcedure__Charge
			,pro.[ModalityType] AS tRegProcedure__ModalityType
			,pro.[Modality] AS tRegProcedure__Modality
			,pro.[Registrar] AS tRegProcedure__Registrar
			,pro.[RegisterDt] AS tRegProcedure__RegisterDt
			,pro.[Priority] AS tRegProcedure__Priority
			,pro.[Technician] AS tRegProcedure__Technician
			,pro.[TechDoctor] AS tRegProcedure__TechDoctor
			,pro.[TechNurse] AS tRegProcedure__TechNurse
			,pro.[OperationStep] AS tRegProcedure__OperationStep
			,pro.[ExamineDt] AS tRegProcedure__ExamineDt
			,pro.[Mender] AS tRegProcedure__Mender
			,pro.[ModifyDt] AS tRegProcedure__ModifyDt
			,pro.[IsPost] AS tRegProcedure__IsPost
			,pro.[IsExistImage] AS tRegProcedure__IsExistImage
			,pro.[Status] AS tRegProcedure__Status
			,pro.[Comments] AS tRegProcedure__Comments
			,pro.[BookingBeginDt] AS tRegProcedure__BookingBeginDt
			,pro.[BookingEndDt] AS tRegProcedure__BookingEndDt
			,pro.[Booker] AS tRegProcedure__Booker
			,pro.[IsCharge] AS tRegProcedure__IsCharge
			,pro.[RemoteRPID] AS tRegProcedure__RemoteRPID
			,pro.[Optional1] AS tRegProcedure__Optional1
			,pro.[Optional2] AS tRegProcedure__Optional2
			,pro.[Optional3] AS tRegProcedure__Optional3
			,pro.[QueueNo] AS tRegProcedure__QueueNo
			,pro.[BookingNotice] AS tRegProcedure__BookingNotice
			,pro.[BookingTimeAlias] AS tRegProcedure__BookingTimeAlias
			,pro.[CreateDt] AS tRegProcedure__CreateDt
			,pro.[ReportGuid] AS tRegProcedure__ReportGuid
			,pro.[MedicineUsage] AS tRegProcedure__MedicineUsage
			,pro.[Posture] AS tRegProcedure__Posture
			,pro.[Technician1] AS tRegProcedure__Technician1
			,pro.[Technician2] AS tRegProcedure__Technician2
			,pro.[Technician3] AS tRegProcedure__Technician3
			,pro.[Technician4] AS tRegProcedure__Technician4
			,pro.[Domain] AS tRegProcedure__Domain
			--------------------------------------------------
			,cod.[ProcedureCode] AS tProcedureCode__ProcedureCode
			,cod.[Description] AS tProcedureCode__Description
			,cod.[EnglishDescription] AS tProcedureCode__EnglishDescription
			,cod.[ModalityType] AS tProcedureCode__ModalityType
			,cod.[BodyPart] AS tProcedureCode__BodyPart
			--,cod.[CheckingItem] AS tProcedureCode__CheckingItem
			,@ReportItem AS tProcedureCode__CheckingItem
			,cod.[Charge] AS tProcedureCode__Charge
			,cod.[Preparation] AS tProcedureCode__Preparation
			,cod.[Frequency] AS tProcedureCode__Frequency
			,cod.[BodyCategory] AS tProcedureCode__BodyCategory
			,cod.[Duration] AS tProcedureCode__Duration
			,cod.[FilmSpec] AS tProcedureCode__FilmSpec
			,cod.[FilmCount] AS tProcedureCode__FilmCount
			,cod.[ContrastName] AS tProcedureCode__ContrastName
			,cod.[ContrastDose] AS tProcedureCode__ContrastDose
			,cod.[ImageCount] AS tProcedureCode__ImageCount
			,cod.[ExposalCount] AS tProcedureCode__ExposalCount
			,cod.[BookingNotice] AS tProcedureCode__BookingNotice
			,cod.[ShortcutCode] AS tProcedureCode__ShortcutCode
			,cod.[Enhance] AS tProcedureCode__Enhance
			,cod.[ApproveWarningTime] AS tProcedureCode__ApproveWarningTime
			,cod.[Effective] AS tProcedureCode__Effective
			,cod.[Domain] AS tProcedureCode__Domain
			,cod.[Externals] AS tProcedureCode__Externals
			,cod.[BodypartFrequency] AS tProcedureCode__BodypartFrequency
			,cod.[CheckingItemFrequency] AS tProcedureCode__CheckingItemFrequency
			,cod.[UniqueID] AS tProcedureCode__UniqueID
			--------------------------------------------------
			,rep.[ReportGuid] AS tReport__ReportGuid
			,rep.[ReportName] AS tReport__ReportName
			,rep.[WYS] AS tReport__WYS_
			,rep.[WYG] AS tReport__WYG_
			,rep.[AppendInfo] AS tReport__AppendInfo
			,rep.[ReportText] AS tReport__ReportText
			,rep.[DoctorAdvice] AS tReport__DoctorAdvice
			-- 阳性标识：0=阴性 1=阳性 2=未知
			,rep.[IsPositive] AS tReport__IsPositive
			,rep.[AcrCode] AS tReport__AcrCode
			,rep.[AcrAnatomic] AS tReport__AcrAnatomic
			,rep.[AcrPathologic] AS tReport__AcrPathologic
			,rep.[Creater] AS tReport__Creater_
			,rep.[CreateDt] AS tReport__CreateDt_
			,rep.[Submitter] AS tReport__Submitter_
			,rep.[SubmitDt] AS tReport__SubmitDt_
			,rep.[FirstApprover] AS tReport__FirstApprover_
			,rep.[FirstApproveDt] AS tReport__FirstApproveDt_
			,rep.[SecondApprover] AS tReport__SecondApprover
			,rep.[SecondApproveDt] AS tReport__SecondApproveDt
			,rep.[IsDiagnosisRight] AS tReport__IsDiagnosisRight
			,rep.[KeyWord] AS tReport__KeyWord
			,rep.[ReportQuality] AS tReport__ReportQuality
			,rep.[RejectToObject] AS tReport__RejectToObject
			,rep.[Rejecter] AS tReport__Rejecter
			,rep.[RejectDt] AS tReport__RejectDt
			,rep.[Status] AS tReport__Status
			,rep.[Comments] AS tReport__Comments
			,rep.[DeleteMark] AS tReport__DeleteMark
			,rep.[Deleter] AS tReport__Deleter
			,rep.[DeleteDt] AS tReport__DeleteDt
			,rep.[Recuperator] AS tReport__Recuperator
			,rep.[ReconvertDt] AS tReport__ReconvertDt
			,rep.[Mender] AS tReport__Mender
			,rep.[ModifyDt] AS tReport__ModifyDt
			,rep.[IsPrint] AS tReport__IsPrint
			,rep.[CheckItemName] AS tReport__CheckItemName
			,rep.[Optional1] AS tReport__Optional1
			,rep.[Optional2] AS tReport__Optional2
			,rep.[Optional3] AS tReport__Optional3
			,rep.[IsLeaveWord] AS tReport__IsLeaveWord
			,rep.[WYSText] AS tReport__WYSText
			,rep.[WYGText] AS tReport__WYGText
			,rep.[IsDraw] AS tReport__IsDraw
			,rep.[DrawerSign] AS tReport__DrawerSign
			,rep.[DrawTime] AS tReport__DrawTime
			,rep.[IsLeaveSound] AS tReport__IsLeaveSound
			,rep.[TakeFilmDept] AS tReport__TakeFilmDept
			,rep.[TakeFilmRegion] AS tReport__TakeFilmRegion
			,rep.[TakeFilmComment] AS tReport__TakeFilmComment
			,rep.[PrintCopies] AS tReport__PrintCopies
			,rep.[PrintTemplateGuid] AS tReport__PrintTemplateGuid
			,rep.[Domain] AS tReport__Domain
			,rep.[ReadOnly] AS tReport__ReadOnly
			,rep.[SubmitDomain] AS tReport__SubmitDomain
			,rep.[RejectDomain] AS tReport__RejectDomain
			,rep.[FirstApproveDomain] AS tReport__FirstApproveDomain
			,rep.[SecondApproveDomain] AS tReport__SecondApproveDomain
			,rep.[ReportTextApprovedSign] AS tReport__ReportTextApprovedSign
			,rep.[ReportTextSubmittedSign] AS tReport__ReportTextSubmittedSign
			,rep.[CombinedForCertification] AS tReport__CombinedForCertification
			,rep.[SignCombinedForCertification] AS tReport__SignCombinedForCertification
			,rep.[RejectSite] AS tReport__RejectSite
			,rep.[SubmitSite] AS tReport__SubmitSite
			,rep.[FirstApproveSite] AS tReport__FirstApproveSite
			,rep.[SecondApproveSite] AS tReport__SecondApproveSite
			,rep.[RebuildMark] AS tReport__RebuildMark
			,rep.[TechInfo] AS tReport__TechInfo
			--------------------------------------------------
			,'' AS tReport__WYS
			,'' AS tReport__WYG
			,(SELECT TOP 1 LoginName FROM tUser WHERE UserGuid=rep.[Creater]) AS tReport__CreaterID
			,(SELECT TOP 1 LocalName FROM tUser WHERE UserGuid=rep.[Creater]) AS tReport__Creater
			,(SELECT TOP 1 ISNULL(SignImage,0x) FROM tUser WHERE UserGuid=rep.[Creater]) AS CreaterSign
			-- 日期：yyyyMMdd mm:hh:ss
			,(CONVERT(VARCHAR(32), rep.[CreateDt], 120)) AS tReport__CreateDt
			,(SELECT TOP 1 LoginName FROM tUser WHERE UserGuid=rep.[Submitter]) AS tReport__SubmitterID
			,(SELECT TOP 1 LocalName FROM tUser WHERE UserGuid=rep.[Submitter]) AS tReport__Submitter
			,(SELECT TOP 1 ISNULL(SignImage,0x) FROM tUser WHERE UserGuid=rep.[Submitter]) AS SubmitterSign
			-- 日期：yyyyMMdd mm:hh:ss
			,(CONVERT(VARCHAR(32), rep.[SubmitDt], 120)) AS tReport__SubmitDt
			,(SELECT TOP 1 LoginName FROM tUser WHERE UserGuid=rep.[FirstApprover]) AS tReport__FirstApproverID
			,(SELECT TOP 1 LocalName FROM tUser WHERE UserGuid=rep.[FirstApprover]) AS tReport__FirstApprover
			,(SELECT TOP 1 ISNULL(SignImage,0x) FROM tUser WHERE UserGuid=rep.[FirstApprover]) AS FirstApproverSign
			-- 日期：yyyyMMdd mm:hh:ss
			,(CONVERT(VARCHAR(32), rep.[FirstApproveDt], 120)) AS tReport__FirstApproveDt
			--------------------------------------------------
			,(SELECT TOP 1 tem.[TemplateInfo] FROM [dbo].[tPrintTemplate] tem WITH(READPAST) 
			WHERE (tem.[TemplateGuid]=ISNULL(rep.[PrintTemplateGuid],''))
			OR ([TYPE] = 3 AND LTRIM(RTRIM(UPPER(ModalityType)))=cod.[ModalityType])
			ORDER BY [IsDefaultByModality] DESC) AS tPrintTemplate__TemplateInfo
			--------------------------------------------------
		FROM [dbo].[tRegOrder] ord WITH(READPAST)
		INNER JOIN [dbo].[tRegPatient] pat WITH(READPAST) ON ord.[PatientGuid]=pat.[PatientGuid]
		INNER JOIN [dbo].[tRegProcedure] pro WITH(READPAST) ON ord.[OrderGuid]=pro.[OrderGuid]
		INNER JOIN [dbo].[tProcedureCode] cod WITH(READPAST) ON pro.[ProcedureCode]=cod.[ProcedureCode]
		LEFT  JOIN [dbo].[tReport] rep WITH(READPAST) ON pro.[ReportGuid]=rep.[ReportGuid]
		WHERE NOT EXISTS( SELECT 1 FROM [dbo].[tRegOrder] ord WITH(READPAST)
			INNER JOIN [dbo].[tRegProcedure] pro WITH(READPAST) ON ord.[OrderGuid]=pro.[OrderGuid]
			WHERE pro.[Status]<120 AND ord.[AccNo]=@AccessionNumber)
		AND ord.[AccNo]=@AccessionNumber
		ORDER BY rep.[ReportGuid] ASC

		SET @OutputInfo = '<OutputInfo>sp_KIOSK_GetReportInfo:Success AccessionNumber='+@AccessionNumber+'</OutputInfo>'
		SET @OutReport = ''
		
		COMMIT TRANSACTION TKIOSKGetReportInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TKIOSKGetReportInfo
		SET @OutputInfo = '<OutputInfo>sp_KIOSK_GetReportInfo:Error AccessionNumber='+@AccessionNumber+'</OutputInfo>'
		SET @OutReport = ''
	END CATCH
END
GO
