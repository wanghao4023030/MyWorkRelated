USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_SetExamInfo]    Script Date: 04/01/2017 10:17:07 ******/

IF EXISTS(SELECT 1 FROM sysobjects WHERE id=object_id('sp_Integration_SetExamInfo') and xtype='P')   
BEGIN
	DROP PROCEDURE sp_Integration_SetExamInfo
END  
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:<Shiye Yang>
-- Create date:<2017-03-31>
-- Alter date:<2017-03-31>
-- Description:<Set patient info to T_Integration_ExamInfo.>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Integration_SetExamInfo]
	@PatientID nvarchar (128),
	@AccessionNumber nvarchar (128),
	@StudyInstanceUID nvarchar (128),
	@NameCN nvarchar (128),
	@NameEN nvarchar (128),
	@Gender nvarchar (32),
	@Birthday nvarchar (32),
	@Modality nvarchar (32),
	@ModalityName nvarchar (128),
	@PatientType nvarchar (32),
	@VisitID nvarchar (32),
	@RequestID nvarchar (128),
	@RequestDepartment nvarchar (128),
	@RequestDT nvarchar (32),
	@RegisterDT nvarchar (32),
	@ExamDT nvarchar (32),
	@SubmitDT nvarchar (32),
	@ApproveDT nvarchar (32),
	@PDFReportURL nvarchar (256),
	@StudyStatus nvarchar (32),
	@ReportStatus int,
	@PDFFlag int,
	@VerifyFilmFlag int,
	@VerifyReportFlag int,
	@FilmStoredFlag int,
	@ReportStoredFlag int,
	@NotifyReportFlag int,
	@SetPrintModeFlag int,
	@FilmPrintFlag int,
	@FilmPrintDoctor nvarchar (128),
	@ReportPrintFlag int,
	@ReportPrintDoctor nvarchar (128),
	@OutHospitalNo nvarchar(128),
	@InHospitalNo nvarchar(128),
	@PhysicalNumber nvarchar(128),
	@ExamName nvarchar(256),
	@ExamBodyPart nvarchar(256),
	@Optional0 nvarchar (256),
	@Optional1 nvarchar (256),
	@Optional2 nvarchar (256),
	@Optional3 nvarchar (256),
	@Optional4 nvarchar (256),
	@Optional5 nvarchar (256),
	@Optional6 nvarchar (256),
	@Optional7 nvarchar (256),
	@Optional8 nvarchar (256),
	@Optional9 nvarchar (256),
	@OutputInfo xml output
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @SQL NVARCHAR(max) = ''
	DECLARE @StudyCount int = 0
	DECLARE @CurrentDT datetime = GETDATE()

	BEGIN TRY
		SET @OutputInfo = '<OutputInfo>sp_Integration_SetExamInfo:Success AccessionNumber['+@AccessionNumber+']</OutputInfo>'

		IF (@FilmPrintFlag=-8)
		BEGIN
			SET @FilmStoredFlag=-8
			SET @FilmPrintFlag=-10
		END
	
		IF (@ReportPrintFlag=-8)
		BEGIN
			SET @ReportStoredFlag=-8
			SET @ReportPrintFlag=-10
		END

		SET @PatientID = LTRIM(RTRIM(ISNULL(@PatientID,'')))
		SET @AccessionNumber = LTRIM(RTRIM(ISNULL(@AccessionNumber,'')))
		SET @StudyInstanceUID = LTRIM(RTRIM(ISNULL(@StudyInstanceUID,'')))
		SET @NameCN = LTRIM(RTRIM(ISNULL(@NameCN,'')))
		SET @NameEN = LTRIM(RTRIM(ISNULL(@NameEN,'')))
		SET @Gender = LTRIM(RTRIM(ISNULL(@Gender,'')))
		SET @Birthday = LTRIM(RTRIM(ISNULL(@Birthday,'')))
		SET @Modality = LTRIM(RTRIM(ISNULL(@Modality,'')))
		SET @ModalityName = LTRIM(RTRIM(ISNULL(@ModalityName,'')))
		SET @PatientType = LTRIM(RTRIM(ISNULL(@PatientType,'')))
		SET @VisitID = LTRIM(RTRIM(ISNULL(@VisitID,'')))
		SET @RequestID = LTRIM(RTRIM(ISNULL(@RequestID,'')))
		SET @RequestDepartment = LTRIM(RTRIM(ISNULL(@RequestDepartment,'')))
		SET @RequestDT = LTRIM(RTRIM(ISNULL(@RequestDT,'')))
		SET @RegisterDT = LTRIM(RTRIM(ISNULL(@RegisterDT,'')))
		SET @ExamDT = LTRIM(RTRIM(ISNULL(@ExamDT,'')))
		SET @SubmitDT = LTRIM(RTRIM(ISNULL(@SubmitDT,'')))
		SET @ApproveDT = LTRIM(RTRIM(ISNULL(@ApproveDT,'')))
		SET @PDFReportURL = LTRIM(RTRIM(ISNULL(@PDFReportURL,'')))
		SET @StudyStatus = LTRIM(RTRIM(ISNULL(@StudyStatus,'')))
		SET @FilmPrintDoctor = LTRIM(RTRIM(ISNULL(@FilmPrintDoctor,'')))
		SET @ReportPrintDoctor = LTRIM(RTRIM(ISNULL(@ReportPrintDoctor,'')))
		SET @OutHospitalNo = LTRIM(RTRIM(ISNULL(@OutHospitalNo,'')))
		SET @InHospitalNo = LTRIM(RTRIM(ISNULL(@InHospitalNo,'')))
		SET @PhysicalNumber = LTRIM(RTRIM(ISNULL(@PhysicalNumber,'')))
		SET @ExamName = LTRIM(RTRIM(ISNULL(@ExamName,'')))
		SET @ExamBodyPart = LTRIM(RTRIM(ISNULL(@ExamBodyPart,'')))
		SET @Optional0 = LTRIM(RTRIM(ISNULL(@Optional0,'')))
		SET @Optional1 = LTRIM(RTRIM(ISNULL(@Optional1,'')))
		SET @Optional2 = LTRIM(RTRIM(ISNULL(@Optional2,'')))
		SET @Optional3 = LTRIM(RTRIM(ISNULL(@Optional3,'')))
		SET @Optional4 = LTRIM(RTRIM(ISNULL(@Optional4,'')))
		SET @Optional5 = LTRIM(RTRIM(ISNULL(@Optional5,'')))
		SET @Optional6 = LTRIM(RTRIM(ISNULL(@Optional6,'')))
		SET @Optional7 = LTRIM(RTRIM(ISNULL(@Optional7,'')))
		SET @Optional8 = LTRIM(RTRIM(ISNULL(@Optional8,'')))
		SET @Optional9 = LTRIM(RTRIM(ISNULL(@Optional9,'')))

		SET @SQL=N'SELECT @Num=Count(0) FROM [dbo].[T_Integration_ExamInfo] WHERE [AccessionNumber]=@pAccessionNumber'
		EXEC sp_executesql @SQL , N'@pAccessionNumber AS varchar(128),@Num AS int OUTPUT',@pAccessionNumber = @AccessionNumber,@Num=@StudyCount OUTPUT

		IF (@StudyCount=0)
		BEGIN
			SET @SQL=N'INSERT INTO [dbo].[T_Integration_ExamInfo]
			   ([CreateDT]
			   ,[UpdateDT]
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
			   ,[OutHospitalNo]
			   ,[InHospitalNo]
			   ,[PhysicalNumber]
			   ,[ExamName]
			   ,[ExamBodyPart]
			   ,[Optional0]
			   ,[Optional1]
			   ,[Optional2]
			   ,[Optional3]
			   ,[Optional4]
			   ,[Optional5]
			   ,[Optional6]
			   ,[Optional7]
			   ,[Optional8]
			   ,[Optional9])
			VALUES(@pCurrentDT
				,@pCurrentDT
				,@pPatientID
				,@pAccessionNumber
				,@pStudyInstanceUID
				,@pNameCN
				,@pNameEN
				,@pGender
				,@pBirthday
				,@pModality
				,@pModalityName
				,@pPatientType
				,@pVisitID
				,@pRequestID
				,@pRequestDepartment
				,@pRequestDT
				,@pRegisterDT
				,@pExamDT
				,@pSubmitDT
				,@pApproveDT
				,@pPDFReportURL
				,@pStudyStatus
				,@pReportStatus
				,@pPDFFlag
				,(CASE WHEN @pPDFFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pVerifyFilmFlag
				,(CASE WHEN @pVerifyFilmFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pVerifyReportFlag
				,(CASE WHEN @pVerifyReportFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pFilmStoredFlag
				,(CASE WHEN @pFilmStoredFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pReportStoredFlag
				,(CASE WHEN @pReportStoredFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pNotifyReportFlag
				,(CASE WHEN @pNotifyReportFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pSetPrintModeFlag
				,(CASE WHEN @pSetPrintModeFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pFilmPrintFlag
				,@pFilmPrintDoctor
				,(CASE WHEN @pFilmPrintFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pReportPrintFlag
				,@pReportPrintDoctor
				,(CASE WHEN @pReportPrintFlag<>-10 THEN @pCurrentDT ELSE NULL END)
				,@pOutHospitalNo
				,@pInHospitalNo
				,@pPhysicalNumber
				,@pExamName
				,@pExamBodyPart
				,@pOptional0
				,@pOptional1
				,@pOptional2
				,@pOptional3
				,@pOptional4
				,@pOptional5
				,@pOptional6
				,@pOptional7
				,@pOptional8
				,@pOptional9)'
			END
			ELSE
			BEGIN
				SET @SQL=N'UPDATE [dbo].[T_Integration_ExamInfo]
					SET [UpdateDT] = @pCurrentDT
				   ,[PatientID] = (CASE WHEN @pPatientID='''' THEN [PatientID] ELSE @pPatientID END)
				   ,[AccessionNumber] = (CASE WHEN @pAccessionNumber='''' THEN [AccessionNumber] ELSE @pAccessionNumber END)
				   ,[StudyInstanceUID] = (CASE WHEN @pStudyInstanceUID='''' THEN [StudyInstanceUID] ELSE @pStudyInstanceUID END)
				   ,[NameCN] = (CASE WHEN @pNameCN='''' THEN [NameCN] ELSE @pNameCN END)
				   ,[NameEN] = (CASE WHEN @pNameEN='''' THEN [NameEN] ELSE @pNameEN END)
				   ,[Gender] = (CASE WHEN @pGender='''' THEN [Gender] ELSE @pGender END)
				   ,[Birthday] = (CASE WHEN @pBirthday='''' THEN [Birthday] ELSE @pBirthday END)
				   ,[Modality] = (CASE WHEN @pModality='''' THEN [Modality] ELSE @pModality END)
				   ,[ModalityName] = (CASE WHEN @pModalityName='''' THEN [ModalityName] ELSE @pModalityName END)
				   ,[PatientType] = (CASE WHEN @pPatientType='''' THEN [PatientType] ELSE @pPatientType END)
				   ,[VisitID] = (CASE WHEN @pVisitID='''' THEN [VisitID] ELSE @pVisitID END)
				   ,[RequestID] = (CASE WHEN @pRequestID='''' THEN [RequestID] ELSE @pRequestID END)
				   ,[RequestDepartment] = (CASE WHEN @pRequestDepartment='''' THEN [RequestDepartment] ELSE @pRequestDepartment END)
				   ,[RequestDT] = (CASE WHEN @pRequestDT='''' THEN [RequestDT] ELSE @pRequestDT END)
				   ,[RegisterDT] = (CASE WHEN @pRegisterDT='''' THEN [RegisterDT] ELSE @pRegisterDT END)
				   ,[ExamDT] = (CASE WHEN @pExamDT='''' THEN [ExamDT] ELSE @pExamDT END)
				   ,[SubmitDT] = (CASE WHEN @pSubmitDT='''' THEN [SubmitDT] ELSE @pSubmitDT END)
				   ,[ApproveDT] = (CASE WHEN @pApproveDT='''' THEN [ApproveDT] ELSE @pApproveDT END)
				   ,[PDFReportURL] = (CASE WHEN @pPDFReportURL='''' THEN [PDFReportURL] ELSE @pPDFReportURL END)
				   ,[StudyStatus] = (CASE WHEN @pStudyStatus='''' THEN [StudyStatus] ELSE @pStudyStatus END)
				   ,[ReportStatus] = (CASE WHEN @pReportStatus=-10 THEN [ReportStatus] ELSE @pReportStatus END)
				   ,[PDFFlag] = (CASE WHEN @pPDFFlag=-10 THEN [PDFFlag] ELSE @pPDFFlag END)
				   ,[PDFDT] = (CASE WHEN @pPDFFlag=-10 THEN [PDFDT] ELSE @pCurrentDT END)
				   ,[VerifyFilmFlag] = (CASE WHEN @pVerifyFilmFlag=-10 THEN [VerifyFilmFlag] ELSE @pVerifyFilmFlag END)
				   ,[VerifyFilmDT] = (CASE WHEN @pVerifyFilmFlag=-10 THEN [VerifyFilmDT] ELSE @pCurrentDT END)
				   ,[VerifyReportFlag] = (CASE WHEN @pVerifyReportFlag=-10 THEN [VerifyReportFlag] ELSE @pVerifyReportFlag END)
				   ,[VerifyReportDT] = (CASE WHEN @pVerifyReportFlag='''' THEN [VerifyReportDT] ELSE @pCurrentDT END)
				   ,[FilmStoredFlag] = (CASE WHEN @pFilmStoredFlag=-10 THEN [FilmStoredFlag] WHEN @pFilmStoredFlag=-8 THEN -10 ELSE @pFilmStoredFlag END)
				   ,[FilmStoredDT] = (CASE WHEN @pFilmStoredFlag=-10 THEN [FilmStoredDT] ELSE @pCurrentDT END)
				   ,[ReportStoredFlag] = (CASE WHEN @pReportStoredFlag=-10 THEN [ReportStoredFlag] WHEN @pReportStoredFlag=-8 THEN -10 ELSE @pReportStoredFlag END)
				   ,[ReportStoredDT] = (CASE WHEN @pReportStoredFlag=-10 THEN [ReportStoredDT] ELSE @pCurrentDT END)
				   ,[NotifyReportFlag] = (CASE WHEN @pNotifyReportFlag=-10 THEN [NotifyReportFlag] ELSE @pNotifyReportFlag END)
				   ,[NotifyReportDT] = (CASE WHEN @pNotifyReportFlag=-10 THEN [NotifyReportDT] ELSE @pCurrentDT END)
				   ,[SetPrintModeFlag] = (CASE WHEN @pSetPrintModeFlag=-10 THEN [SetPrintModeFlag] ELSE @pSetPrintModeFlag END)
				   ,[SetPrintModeDT] = (CASE WHEN @pSetPrintModeFlag=-10 THEN [SetPrintModeDT] ELSE @pCurrentDT END)
				   ,[FilmPrintFlag] = (CASE WHEN @pFilmStoredFlag=9 AND [FilmPrintFlag]<>3 THEN 0 WHEN @pFilmPrintFlag= -10 THEN [FilmPrintFlag] ELSE @pFilmPrintFlag END)
				   ,[FilmPrintDoctor] = (CASE WHEN @pFilmStoredFlag=9 AND [FilmPrintFlag]<>3 THEN @pFilmPrintDoctor WHEN @pFilmPrintFlag= -10 THEN [FilmPrintDoctor] ELSE @pFilmPrintDoctor END)
				   ,[FilmPrintDT] = (CASE WHEN @pFilmStoredFlag=9 AND [FilmPrintFlag]<>3 THEN @pCurrentDT WHEN @pFilmPrintFlag= -10 THEN [FilmPrintDT] ELSE @pCurrentDT END)
				   ,[ReportPrintFlag] = (CASE WHEN @pReportStoredFlag=9 AND [ReportPrintFlag]<>3 THEN 0 WHEN @pReportPrintFlag= -10 THEN [ReportPrintFlag] ELSE @pReportPrintFlag END)
				   ,[ReportPrintDoctor] = (CASE WHEN @pReportStoredFlag=9 AND [ReportPrintFlag]<>3 THEN @pReportPrintDoctor WHEN @pReportPrintFlag= -10 THEN [ReportPrintDoctor] ELSE @pReportPrintDoctor END)
				   ,[ReportPrintDT] = (CASE WHEN @pReportStoredFlag=9 AND [ReportPrintFlag]<>3 THEN @pCurrentDT WHEN @pReportPrintFlag= -10 THEN [ReportPrintDT] ELSE @pCurrentDT END)
				   ,[OutHospitalNo] = (CASE WHEN @pOutHospitalNo = '''' THEN [OutHospitalNo] ELSE @pOutHospitalNo END)
				   ,[InHospitalNo] = (CASE WHEN @pInHospitalNo = '''' THEN [InHospitalNo] ELSE @pInHospitalNo END)
				   ,[PhysicalNumber] = (CASE WHEN @pPhysicalNumber = '''' THEN [PhysicalNumber] ELSE @pPhysicalNumber END)
				   ,[ExamName] = (CASE WHEN @pExamName = '''' THEN [ExamName] ELSE @pExamName END)
				   ,[ExamBodyPart] = (CASE WHEN @pExamBodyPart = '''' THEN [ExamBodyPart] ELSE @pExamBodyPart END)
				   ,[Optional0] = (CASE WHEN @pOptional0='''' THEN [Optional0] ELSE @pOptional0 END)
				   ,[Optional1] = (CASE WHEN @pOptional1='''' THEN [Optional1] ELSE @pOptional1 END)
				   ,[Optional2] = (CASE WHEN @pOptional2='''' THEN [Optional2] ELSE @pOptional2 END)
				   ,[Optional3] = (CASE WHEN @pOptional3='''' THEN [Optional3] ELSE @pOptional3 END)
				   ,[Optional4] = (CASE WHEN @pOptional4='''' THEN [Optional4] ELSE @pOptional4 END)
				   ,[Optional5] = (CASE WHEN @pOptional5='''' THEN [Optional5] ELSE @pOptional5 END)
				   ,[Optional6] = (CASE WHEN @pOptional6='''' THEN [Optional6] ELSE @pOptional6 END)
				   ,[Optional7] = (CASE WHEN @pOptional7='''' THEN [Optional7] ELSE @pOptional7 END)
				   ,[Optional8] = (CASE WHEN @pOptional8='''' THEN [Optional8] ELSE @pOptional8 END)
				   ,[Optional9] = (CASE WHEN @pOptional9='''' THEN [Optional9] ELSE @pOptional9 END)
				WHERE [AccessionNumber]=@pAccessionNumber'
		END

		EXEC sp_executesql @SQL , N'@pPatientID as nvarchar (128),
								@pAccessionNumber as nvarchar (128),
								@pStudyInstanceUID as nvarchar (128),
								@pNameCN as nvarchar (128),
								@pNameEN as nvarchar (128),
								@pGender as nvarchar (32),
								@pBirthday as nvarchar (32),
								@pModality as nvarchar (32),
								@pModalityName as nvarchar (128),
								@pPatientType as nvarchar (32),
								@pVisitID as nvarchar (32),
								@pRequestID as nvarchar (128),
								@pRequestDepartment as nvarchar (128),
								@pRequestDT as nvarchar (32),
								@pRegisterDT as nvarchar (32),
								@pExamDT as nvarchar (32),
								@pSubmitDT as nvarchar (32),
								@pApproveDT as nvarchar (32),
								@pPDFReportURL as nvarchar (256),
								@pStudyStatus as nvarchar (32),
								@pReportStatus as int,
								@pPDFFlag as int,
								@pVerifyFilmFlag as int,
								@pVerifyReportFlag as int,
								@pFilmStoredFlag as int,
								@pReportStoredFlag as int,
								@pNotifyReportFlag as int,
								@pSetPrintModeFlag as int,
								@pFilmPrintFlag as int,
								@pFilmPrintDoctor as nvarchar (128),
								@pReportPrintFlag as int,
								@pReportPrintDoctor as nvarchar (128),
								@pOutHospitalNo as nvarchar(128),
								@pInHospitalNo as nvarchar(128),
								@pPhysicalNumber as nvarchar(128),
								@pExamName as nvarchar(256),
								@pExamBodyPart as nvarchar(256),
								@pOptional0 as nvarchar (256),
								@pOptional1 as nvarchar (256),
								@pOptional2 as nvarchar (256),
								@pOptional3 as nvarchar (256),
								@pOptional4 as nvarchar (256),
								@pOptional5 as nvarchar (256),
								@pOptional6 as nvarchar (256),
								@pOptional7 as nvarchar (256),
								@pOptional8 as nvarchar (256),
								@pOptional9 as nvarchar (256),
								@pCurrentDT as datetime',
								@pPatientID = @PatientID,
								@pAccessionNumber = @AccessionNumber,
								@pStudyInstanceUID = @StudyInstanceUID,
								@pNameCN = @NameCN,
								@pNameEN = @NameEN,
								@pGender = @Gender,
								@pBirthday = @Birthday,
								@pModality = @Modality,
								@pModalityName = @ModalityName,
								@pPatientType = @PatientType,
								@pVisitID = @VisitID,
								@pRequestID = @RequestID,
								@pRequestDepartment = @RequestDepartment,
								@pRequestDT = @RequestDT,
								@pRegisterDT = @RegisterDT,
								@pExamDT = @ExamDT,
								@pSubmitDT = @SubmitDT,
								@pApproveDT = @ApproveDT,
								@pPDFReportURL = @PDFReportURL,
								@pStudyStatus = @StudyStatus,
								@pReportStatus = @ReportStatus,
								@pPDFFlag = @PDFFlag,
								@pVerifyFilmFlag = @VerifyFilmFlag,
								@pVerifyReportFlag = @VerifyReportFlag,
								@pFilmStoredFlag = @FilmStoredFlag,
								@pReportStoredFlag = @ReportStoredFlag,
								@pNotifyReportFlag = @NotifyReportFlag,
								@pSetPrintModeFlag = @SetPrintModeFlag,
								@pFilmPrintFlag = @FilmPrintFlag,
								@pFilmPrintDoctor = @FilmPrintDoctor,
								@pReportPrintFlag = @ReportPrintFlag,
								@pReportPrintDoctor = @ReportPrintDoctor,
								@pOutHospitalNo = @OutHospitalNo,
								@pInHospitalNo = @InHospitalNo,
								@pPhysicalNumber = @PhysicalNumber,
								@pExamName = @ExamName,
								@pExamBodyPart = @ExamBodyPart,
								@pOptional0 = @Optional0,
								@pOptional1 = @Optional1,
								@pOptional2 = @Optional2,
								@pOptional3 = @Optional3,
								@pOptional4 = @Optional4,
								@pOptional5 = @Optional5,
								@pOptional6 = @Optional6,
								@pOptional7 = @Optional7,
								@pOptional8 = @Optional8,
								@pOptional9 = @Optional9,
								@pCurrentDT = @CurrentDT
	END TRY
	BEGIN CATCH
		SET @OutputInfo = '<OutputInfo>sp_Integration_SetExamInfo:Error</OutputInfo>'
	END CATCH
END

