USE [WGGC]
GO

/****** Object:  Table [dbo].[T_Integration_RecognizeParam]    Script Date: 12/14/2018 14:25:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[T_Integration_RecognizeParam]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	DROP TABLE [dbo].[T_Integration_RecognizeParam]
END
GO

IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[T_Integration_RecognizeParam]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[T_Integration_RecognizeParam](
		[ID] [int] IDENTITY(1,1) NOT NULL,
		[StoredDT] [datetime] NOT NULL,
		[RecognizeParam] [nvarchar](max) NOT NULL
	) ON [PRIMARY]
END
GO




