USE [WGGC]
GO
/****** Object:  Table [dbo].[T_Integration_ExamInfo]    Script Date: 12/29/2014 11:34:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[ReportStatus] [int] NULL,
	[PDFFlag] [int] NULL,
	[PDFDT] [datetime] NULL,
	[VerifyFilmFlag] [int] NULL,
	[VerifyFilmDT] [datetime] NULL,
	[VerifyReportFlag] [int] NULL,
	[VerifyReportDT] [datetime] NULL,
	[FilmStoredFlag] [int] NULL,
	[FilmStoredDT] [datetime] NULL,
	[ReportStoredFlag] [int] NULL,
	[ReportStoredDT] [datetime] NULL,
	[NotifyReportFlag] [int] NULL,
	[NotifyReportDT] [datetime] NULL,
	[SetPrintModeFlag] [int] NULL,
	[SetPrintModeDT] [datetime] NULL,
	[FilmPrintFlag] [int] NULL,
	[FilmPrintDoctor] [nvarchar](128) NULL,
	[FilmPrintDT] [datetime] NULL,
	[ReportPrintFlag] [int] NULL,
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
	[Optional9] [nvarchar](256) NULL,
 CONSTRAINT [PK_T_Integration_ExamInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_ReportStatus]  DEFAULT ((-10)) FOR [ReportStatus]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_PDFFlag]  DEFAULT ((-10)) FOR [PDFFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_VerifyFilmFlag]  DEFAULT ((-10)) FOR [VerifyFilmFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_VerifyReportFlag]  DEFAULT ((-10)) FOR [VerifyReportFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_FilmStoredFlag]  DEFAULT ((-10)) FOR [FilmStoredFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_ReportStoredFlag]  DEFAULT ((-10)) FOR [ReportStoredFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_NotifyReportFlag]  DEFAULT ((-10)) FOR [NotifyReportFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_SetPrintModeFlag]  DEFAULT ((-10)) FOR [SetPrintModeFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_FilmPrintFlag]  DEFAULT ((-10)) FOR [FilmPrintFlag]
GO
ALTER TABLE [dbo].[T_Integration_ExamInfo] ADD  CONSTRAINT [DF_T_Integration_ExamInfo_ReportPrintFlag]  DEFAULT ((-10)) FOR [ReportPrintFlag]
GO
