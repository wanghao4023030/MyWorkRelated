USE [OCRConfigDB]
GO
/****** Object:  Table [dbo].[SCUIdentity]    Script Date: 11/28/2019 22:44:33 ******/
SET IDENTITY_INSERT [dbo].[SCUIdentity] ON
INSERT [dbo].[SCUIdentity] ([FileType], [CallingAE], [CalledAE], [IPAddress], [ModalitySource], [PixelSizeTolerance], [RotationPriority], [RotationType], [StripOrder], [AutoZone], [SCUIdentity_Id], [Recognition]) VALUES (N'JPG', N'DCMPSTATE1', N'ImageSuite', N'10.112.20.146', N'', 200, N'Never', N'None', N'Top;Bottom;MiddleTop;MiddleBottom', N'Default', 114, N'Auto                            ')
SET IDENTITY_INSERT [dbo].[SCUIdentity] OFF
/****** Object:  Table [dbo].[KeyFields]    Script Date: 11/28/2019 22:44:33 ******/
SET IDENTITY_INSERT [dbo].[KeyFields] ON
INSERT [dbo].[KeyFields] ([KeyFields_Id], [SCUIdentity_Id]) VALUES (114, 114)
SET IDENTITY_INSERT [dbo].[KeyFields] OFF
/****** Object:  Table [dbo].[KeyField]    Script Date: 11/28/2019 22:44:33 ******/
SET IDENTITY_INSERT [dbo].[KeyField] ON
INSERT [dbo].[KeyField] ([Grammar], [Template], [GrammarType], [OCRField], [KeyField_Id], [KeyFields_Id]) VALUES (N'([PDF0R9p]\s*)(\d{10,20})\s*', N'~~P~~10-20~~~~~~~~', 1, N'PatientId', 227, 114)
INSERT [dbo].[KeyField] ([Grammar], [Template], [GrammarType], [OCRField], [KeyField_Id], [KeyFields_Id]) VALUES (N'([A4X]\s*)(\d{10,20})\s*', N'~~A~~10-20~~~~~~~~', 1, N'AccessionNumber', 228, 114)
SET IDENTITY_INSERT [dbo].[KeyField] OFF
/****** Object:  Table [dbo].[ROI]    Script Date: 11/28/2019 22:44:33 ******/
/****** Object:  Table [dbo].[ROICoord]    Script Date: 11/28/2019 22:44:33 ******/
