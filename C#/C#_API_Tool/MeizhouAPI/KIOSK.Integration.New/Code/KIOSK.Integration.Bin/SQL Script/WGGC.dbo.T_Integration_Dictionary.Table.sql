USE [WGGC]
GO
/****** Object:  Table [dbo].[T_Integration_Dictionary]    Script Date: 12/29/2014 11:34:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Integration_Dictionary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TagType] [nvarchar](128) NOT NULL,
	[Key] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[Optional0] [nvarchar](256) NULL,
	[Optional1] [nvarchar](256) NULL,
	[Optional2] [nvarchar](256) NULL,
 CONSTRAINT [PK_T_Integration_Dictionary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
