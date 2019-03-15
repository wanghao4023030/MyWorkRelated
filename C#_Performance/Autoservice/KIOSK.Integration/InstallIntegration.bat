@echo off
echo Start install kiosk integration module
set insdir=InstallLog
set sqldir=SQLScript
mkdir %insdir%
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.LinkedServer.MSSQL.RISDB.SQL -o %insdir%\WGGC.dbo.LinkedServer.MSSQL.RISDB.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetExamInfo.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetExamInfo.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetExamInfoEx.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetExamInfoEx.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetPatientInfo.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetPatientInfo.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetReportInfo.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetReportInfo.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_SetExamInfo.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_SetExamInfo.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.T_Integration_Dictionary.Table.SQL -o %insdir%\WGGC.dbo.T_Integration_Dictionary.Table.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.T_Integration_ExamInfo.Table.SQL -o %insdir%\WGGC.dbo.WGGC.dbo.T_Integration_Dictionary.Table.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.T_Integration_Dictionary.Table.Insert.CN.SQL -o %insdir%\WGGC.dbo.T_Integration_Dictionary.Table.Insert.CN.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetPatientInfoGlobal.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetExamInfo.StoredProcedure.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.sp_Integration_GetPrintMode.StoredProcedure.SQL -o %insdir%\WGGC.dbo.sp_Integration_GetPrintMode.StoredProcedure.Log

echo Create application in IIS
%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/Kiosk.Integration" /physicalpath:%cd%\KIOSK.Integration.WSProxy
%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/Kiosk.Integration" /applicationpool:DefaultAppPool

echo Grant permission for folder %cd%
icacls %cd% /grant Everyone:(OI)(CI)F /T

echo Configure ODBC DSN
Rem odbcconf configsysdsn "SQL Server" "DSN=RISDB|Server=localhost\gcpacsws|Database=WGGC|Trusted_Connection=No"
@echo on