USE [master]
GO

/****** Object:  LinkedServer [RISDB]    Script Date: 2017/7/13 17:08:19 ******/
EXEC master.dbo.sp_dropserver @server=N'RISDB', @droplogins='droplogins'
GO

/****** Object:  LinkedServer [RISDB]    Script Date: 2017/7/13 17:08:19 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'RISDB', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'localhost\gcpacsws'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'RISDB',@useself=N'false',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword=N'sa20021224$'

GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'RISDB', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


