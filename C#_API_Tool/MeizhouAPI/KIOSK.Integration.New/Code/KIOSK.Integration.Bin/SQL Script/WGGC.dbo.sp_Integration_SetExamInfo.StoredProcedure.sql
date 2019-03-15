USE [WGGC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Integration_SetExamInfo]    Script Date: 12/29/2014 11:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if exists (select * from sysobjects where id = object_id(N'sp_Integration_SetExamInfo') and OBJECTPROPERTY(id, N'IsProcedure') = 1)  
  drop procedure sp_Integration_SetExamInfo
GO

-- =============================================
-- Author:<Gary,Shi>
-- Create date:<2014-08-21>
-- Alter date:<2014-12-18>
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
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Warning: value is eliminated by an aggregate or other SET operation.
	-- SET ANSI_WARNINGS OFF;

	DECLARE @CurrentDT datetime = GETDATE()

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
	SET @Optional9 = LTRIM(RTRIM(ISNULL(@Optional8,'')))
	SET @OutputInfo = '<OutputInfo>sp_Integration_SetExamInfo:Success AccessionNumber['+@AccessionNumber+']</OutputInfo>'

	BEGIN TRANSACTION TSetExamInfo
	BEGIN TRY
		INSERT INTO [dbo].[T_Integration_ExamInfo]
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
		SELECT DISTINCT @CurrentDT
			,@CurrentDT
			,@PatientID
            ,@AccessionNumber
            ,@StudyInstanceUID
            ,@NameCN
            ,@NameEN
            ,@Gender
            ,@Birthday
            ,@Modality
            ,@ModalityName
			,@PatientType
			,@VisitID
			,@RequestID
			,@RequestDepartment
			,@RequestDT
			,@RegisterDT
			,@ExamDT
			,@SubmitDT
			,@ApproveDT
			,@PDFReportURL
			,@StudyStatus
            ,@ReportStatus
            ,@PDFFlag
            ,(CASE WHEN @PDFFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@VerifyFilmFlag
            ,(CASE WHEN @VerifyFilmFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@VerifyReportFlag
            ,(CASE WHEN @VerifyReportFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@FilmStoredFlag
            ,(CASE WHEN @FilmStoredFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@ReportStoredFlag
            ,(CASE WHEN @ReportStoredFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@NotifyReportFlag
            ,(CASE WHEN @NotifyReportFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@SetPrintModeFlag
            ,(CASE WHEN @SetPrintModeFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@FilmPrintFlag
            ,@FilmPrintDoctor
            ,(CASE WHEN @FilmPrintFlag<>-10 THEN @CurrentDT ELSE NULL END)
            ,@ReportPrintFlag
            ,@ReportPrintDoctor
            ,(CASE WHEN @ReportPrintFlag<>-10 THEN @CurrentDT ELSE NULL END)
			
			,@OutHospitalNo
		    ,@InHospitalNo
		    ,@PhysicalNumber
		    ,@ExamName
		    ,@ExamBodyPart
			
            ,@Optional0
            ,@Optional1
            ,@Optional2
            ,@Optional3
            ,@Optional4
            ,@Optional5
            ,@Optional6
            ,@Optional7
            ,@Optional8
            ,@Optional9
		WHERE NOT EXISTS (SELECT 1 FROM [dbo].[T_Integration_ExamInfo] WHERE [AccessionNumber]=@AccessionNumber)
		
		
		SELECT @FilmStoredFlag= (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) WHEN 2 THEN -10 ELSE 9 END)
				,@ReportStoredFlag=(CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN 2 THEN -10 ELSE 9 END)
				,@FilmPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber)WHEN 2 THEN -10 ELSE [WGGC].[dbo].[AFP_F_GetFilmPrintStatus]('',@AccessionNumber) END)
				,@ReportPrintFlag = (CASE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) WHEN 2 THEN -10 ELSE [WGGC].[dbo].[AFP_F_GetReportPrintStatus](@AccessionNumber) END)
		
		UPDATE [dbo].[T_Integration_ExamInfo]
		SET [UpdateDT] = @CurrentDT

           ,[PatientID] = (CASE WHEN @PatientID='' THEN [PatientID] ELSE @PatientID END)
           ,[AccessionNumber] = (CASE WHEN @AccessionNumber='' THEN [AccessionNumber] ELSE @AccessionNumber END)
           ,[StudyInstanceUID] = (CASE WHEN @StudyInstanceUID='' THEN [StudyInstanceUID] ELSE @StudyInstanceUID END)
           ,[NameCN] = (CASE WHEN @NameCN='' THEN [NameCN] ELSE @NameCN END)
           ,[NameEN] = (CASE WHEN @NameEN='' THEN [NameEN] ELSE @NameEN END)
           ,[Gender] = (CASE WHEN @Gender='' THEN [Gender] ELSE @Gender END)
           ,[Birthday] = (CASE WHEN @Birthday='' THEN [Birthday] ELSE @Birthday END)
           ,[Modality] = (CASE WHEN @Modality='' THEN [Modality] ELSE @Modality END)
           ,[ModalityName] = (CASE WHEN @ModalityName='' THEN [ModalityName] ELSE @ModalityName END)
           ,[PatientType] = (CASE WHEN @PatientType='' THEN [PatientType] ELSE @PatientType END)
           ,[VisitID] = (CASE WHEN @VisitID='' THEN [VisitID] ELSE @VisitID END)
           ,[RequestID] = (CASE WHEN @RequestID='' THEN [RequestID] ELSE @RequestID END)
           ,[RequestDepartment] = (CASE WHEN @RequestDepartment='' THEN [RequestDepartment] ELSE @RequestDepartment END)
           ,[RequestDT] = (CASE WHEN @RequestDT='' THEN [RequestDT] ELSE @RequestDT END)
           ,[RegisterDT] = (CASE WHEN @RegisterDT='' THEN [RegisterDT] ELSE @RegisterDT END)
           ,[ExamDT] = (CASE WHEN @ExamDT='' THEN [ExamDT] ELSE @ExamDT END)
           ,[SubmitDT] = (CASE WHEN @SubmitDT='' THEN [SubmitDT] ELSE @SubmitDT END)
           ,[ApproveDT] = (CASE WHEN @ApproveDT='' THEN [ApproveDT] ELSE @ApproveDT END)
           ,[PDFReportURL] = (CASE WHEN @PDFReportURL='' THEN [PDFReportURL] ELSE @PDFReportURL END)
           ,[StudyStatus] = (CASE WHEN @StudyStatus='' THEN [StudyStatus] ELSE @StudyStatus END)

           ,[ReportStatus] = (CASE WHEN @ReportStatus=-10 THEN [ReportStatus] ELSE @ReportStatus END)

           ,[PDFFlag] = (CASE WHEN @PDFFlag=-10 THEN [PDFFlag] ELSE @PDFFlag END)
           ,[PDFDT] = (CASE WHEN @PDFFlag=-10 THEN [PDFDT] ELSE @CurrentDT END)

           ,[VerifyFilmFlag] = (CASE WHEN @VerifyFilmFlag=-10 THEN [VerifyFilmFlag] ELSE @VerifyFilmFlag END)
           ,[VerifyFilmDT] = (CASE WHEN @VerifyFilmFlag=-10 THEN [VerifyFilmDT] ELSE @CurrentDT END)

           ,[VerifyReportFlag] = (CASE WHEN @VerifyReportFlag=-10 THEN [VerifyReportFlag] ELSE @VerifyReportFlag END)
           ,[VerifyReportDT] = (CASE WHEN @VerifyReportFlag='' THEN [VerifyReportDT] ELSE @CurrentDT END)

           ,[FilmStoredFlag] = (CASE WHEN @FilmStoredFlag IN (-10,0) THEN [FilmStoredFlag] ELSE @FilmStoredFlag END)
		   
           ,[FilmStoredDT] = (CASE WHEN @FilmStoredFlag IN (-10,0) THEN [FilmStoredDT] ELSE @CurrentDT END)		   

           ,[ReportStoredFlag] = (CASE WHEN @ReportStoredFlag IN (-10,0) THEN [ReportStoredFlag] ELSE @ReportStoredFlag END)
		   
           ,[ReportStoredDT] = (CASE WHEN @ReportStoredFlag IN (-10,0) THEN [ReportStoredDT] ELSE @CurrentDT END)

           ,[NotifyReportFlag] = (CASE WHEN @NotifyReportFlag IN (-10,0) THEN [NotifyReportFlag] ELSE @NotifyReportFlag END)
           ,[NotifyReportDT] = (CASE WHEN @NotifyReportFlag=-10 THEN [NotifyReportDT] ELSE @CurrentDT END)

           ,[SetPrintModeFlag] = (CASE WHEN @SetPrintModeFlag=-10 THEN [SetPrintModeFlag] ELSE @SetPrintModeFlag END)
           ,[SetPrintModeDT] = (CASE WHEN @SetPrintModeFlag=-10 THEN [SetPrintModeDT] ELSE @CurrentDT END)

           ,[FilmPrintFlag] = (CASE WHEN @FilmPrintFlag IN (-10,0) THEN [FilmPrintFlag] ELSE @FilmPrintFlag END)
           ,[FilmPrintDoctor] = (CASE WHEN @FilmPrintDoctor = '' THEN [FilmPrintDoctor] ELSE @FilmPrintDoctor END)
           ,[FilmPrintDT] = (CASE WHEN @FilmPrintFlag IN (-10,0) THEN [FilmPrintDT] ELSE @CurrentDT END)

           ,[ReportPrintFlag] = (CASE WHEN @ReportPrintFlag IN (-10,0) THEN [ReportPrintFlag] ELSE @ReportPrintFlag END)
           ,[ReportPrintDoctor] = (CASE WHEN @ReportPrintDoctor = '' THEN [ReportPrintDoctor] ELSE @ReportPrintDoctor END)
           ,[ReportPrintDT] = (CASE WHEN @ReportPrintFlag IN (-10,0) THEN [ReportPrintDT] ELSE @CurrentDT END)

		   ,[OutHospitalNo] = (CASE WHEN @OutHospitalNo = '' THEN [OutHospitalNo] ELSE @OutHospitalNo END)
		   ,[InHospitalNo] = (CASE WHEN @InHospitalNo = '' THEN [InHospitalNo] ELSE @InHospitalNo END)
		   ,[PhysicalNumber] = (CASE WHEN @PhysicalNumber = '' THEN [PhysicalNumber] ELSE @PhysicalNumber END)
		   ,[ExamName] = (CASE WHEN @ExamName = '' THEN [ExamName] ELSE @ExamName END)
		   ,[ExamBodyPart] = (CASE WHEN @ExamBodyPart = '' THEN [ExamBodyPart] ELSE @ExamBodyPart END)
		   
           ,[Optional0] = (CASE WHEN @Optional0='' THEN [Optional0] ELSE @Optional0 END)
           ,[Optional1] = (CASE WHEN @Optional1='' THEN [Optional1] ELSE @Optional1 END)
           ,[Optional2] = (CASE WHEN @Optional2='' THEN [Optional2] ELSE @Optional2 END)
           ,[Optional3] = (CASE WHEN @Optional3='' THEN [Optional3] ELSE @Optional3 END)
           ,[Optional4] = (CASE WHEN @Optional4='' THEN [Optional4] ELSE @Optional4 END)
           ,[Optional5] = (CASE WHEN @Optional5='' THEN [Optional5] ELSE @Optional5 END)
           ,[Optional6] = (CASE WHEN @Optional6='' THEN [Optional6] ELSE @Optional6 END)
           ,[Optional7] = (CASE WHEN @Optional7='' THEN [Optional7] ELSE @Optional7 END)
           ,[Optional8] = (CASE WHEN @Optional8='' THEN [Optional8] ELSE @Optional8 END)
           ,[Optional9] = (CASE WHEN @Optional9='' THEN [Optional9] ELSE @Optional9 END)
		WHERE [AccessionNumber]=@AccessionNumber

		COMMIT TRANSACTION TSetExamInfo
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION TSetExamInfo
		SET @OutputInfo = '<OutputInfo>sp_Integration_SetExamInfo:Error</OutputInfo>'
	END CATCH
END
GO
