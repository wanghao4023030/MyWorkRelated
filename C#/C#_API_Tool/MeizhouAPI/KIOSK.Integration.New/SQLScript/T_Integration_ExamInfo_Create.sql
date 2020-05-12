USE [WGGC]
GO

/****** Object:  Table [dbo].[T_Integration_ExamInfo]    Script Date: 10/25/2017 1:25:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[T_Integration_ExamInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[T_Integration_ExamInfo](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[CreateDT] [datetime] NOT NULL,
		[UpdateDT] [datetime] NOT NULL,
		[PatientID] [nvarchar](128) NOT NULL,
		[AccessionNumber] [nvarchar](128) NOT NULL,
		[StudyInstanceUID] [nvarchar](128) NULL,
		[NameCN] [nvarchar](128) NULL,
		[NameEN] [nvarchar](128) NULL,
		[Gender] [nvarchar](32) NULL,
		[Birthday] [nvarchar](32) NULL,
		[Modality] [nvarchar](32) NULL,
		[ModalityName] [nvarchar](128) NULL,
		[PatientType] [nvarchar](32) NULL,
		[VisitID] [nvarchar](32) NULL,
		[RequestID] [nvarchar](128) NULL,
		[RequestDepartment] [nvarchar](128) NULL,
		[RequestDT] [nvarchar](32) NULL,
		[RegisterDT] [nvarchar](32) NULL,
		[ExamDT] [nvarchar](32) NULL,
		[SubmitDT] [nvarchar](32) NULL,
		[ApproveDT] [nvarchar](32) NULL,
		[PDFReportURL] [nvarchar](256) NULL,
		[StudyStatus] [nvarchar](32) NULL,
		[ReportStatus] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_ReportStatus]  DEFAULT ((-10)),
		[PDFFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_PDFFlag]  DEFAULT ((-10)),
		[PDFDT] [datetime] NULL,
		[VerifyFilmFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_VerifyFilmFlag]  DEFAULT ((-10)),
		[VerifyFilmDT] [datetime] NULL,
		[VerifyReportFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_VerifyReportFlag]  DEFAULT ((-10)),
		[VerifyReportDT] [datetime] NULL,
		[FilmStoredFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_FilmStoredFlag]  DEFAULT ((-10)),
		[FilmStoredDT] [datetime] NULL,
		[ReportStoredFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_ReportStoredFlag]  DEFAULT ((-10)),
		[ReportStoredDT] [datetime] NULL,
		[NotifyReportFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_NotifyReportFlag]  DEFAULT ((-10)),
		[NotifyReportDT] [datetime] NULL,
		[SetPrintModeFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_SetPrintModeFlag]  DEFAULT ((-10)),
		[SetPrintModeDT] [datetime] NULL,
		[FilmPrintFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_FilmPrintFlag]  DEFAULT ((-10)),
		[FilmPrintDoctor] [nvarchar](128) NULL,
		[FilmPrintDT] [datetime] NULL,
		[ReportPrintFlag] [int] NULL CONSTRAINT [DF_T_Integration_ExamInfo_ReportPrintFlag]  DEFAULT ((-10)),
		[ReportPrintDoctor] [nvarchar](128) NULL,
		[ReportPrintDT] [datetime] NULL,
		[OutHospitalNo] [nvarchar](128) NULL,
		[InHospitalNo] [nvarchar](128) NULL,
		[PhysicalNumber] [nvarchar](128) NULL,
		[ExamName] [nvarchar](256) NULL,
		[ExamBodyPart] [nvarchar](256) NULL,
		[Optional0] [nvarchar](256) NULL,
		[Optional1] [nvarchar](256) NULL,
		[Optional2] [nvarchar](256) NULL,
		[Optional3] [nvarchar](256) NULL,
		[Optional4] [nvarchar](256) NULL,
		[Optional5] [nvarchar](256) NULL,
		[Optional6] [nvarchar](256) NULL,
		[Optional7] [nvarchar](256) NULL,
		[Optional8] [nvarchar](256) NULL,
		[Optional9] [nvarchar](256) NULL
	) ON [PRIMARY]
END
GO

IF NOT EXISTS (select * from syscolumns where id=object_id('T_Integration_ExamInfo') and name='PrintStatus' )
BEGIN
	ALTER TABLE T_Integration_ExamInfo ADD  PrintStatus int DEFAULT 1;
END
GO



