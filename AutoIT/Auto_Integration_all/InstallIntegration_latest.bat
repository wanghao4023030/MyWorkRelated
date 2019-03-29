
echo Start install kiosk integration module
set insdir=Integration_InstallLog
set sqldir=SQLScript
mkdir %insdir%

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.LinkedServer.MSSQL.RISDB.SQL  > %insdir%\Install.Log 
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\WGGC.dbo.LinkedServer.MSSQL.RISDB.SQL  >> %insdir%\Install.Log
rem echo:>> %insdir%\Install.Log
echo:  >> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\00_sp_Integration_GetExamInfo.sql >> %insdir%\Install.Log 
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\00_sp_Integration_GetExamInfo.sql >> %insdir%\Install.Log 
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\01_T_Integration_ExamInfo_Create.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\01_T_Integration_ExamInfo_Create.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\02_T_Integration_RecognizeParam_Create.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\02_T_Integration_RecognizeParam_Create.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\03_Func_Integration_SplitString.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\03_Func_Integration_SplitString.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\04_AFP_View_StudyAllowPrintTime.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\04_AFP_View_StudyAllowPrintTime.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\05_sp_Integration_GetExamInfoEx.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\05_sp_Integration_GetExamInfoEx.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\07_sp_Integration_GetReportInfo.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\07_sp_Integration_GetReportInfo.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\sp_Integration_GetReportInfoFromRis_reportdownload.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\sp_Integration_GetReportInfoFromRis_reportdownload.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\09_sp_Integration_GetUnPrintedStudy.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\09_sp_Integration_GetUnPrintedStudy.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\10_sp_Integration_GetPrintMode.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\10_sp_Integration_GetPrintMode.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\11_sp_Integration_SetExamInfo.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\11_sp_Integration_SetExamInfo.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\12_sp_Integration_QueryParam.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\12_sp_Integration_QueryParam.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\13_sp_Integration_SaveParam.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\13_sp_Integration_SaveParam.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\14_sp_Integration_GetAllowPrint.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\14_sp_Integration_GetAllowPrint.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\15_sp_Integration_SetPrintMode.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\15_sp_Integration_SetPrintMode.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\16_sp_Integration_GetPrintStatusAndPrintMode.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\16_sp_Integration_GetPrintStatusAndPrintMode.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\17_sp_Integration_GetPatientInfo.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\17_sp_Integration_GetPatientInfo.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Create.sql >> %insdir%\Install.Log 
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Create.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Insert.CN.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Insert.CN.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Insert.EN.sql >> %insdir%\Install.Log
sqlcmd -E -S localhost\gcpacsws -i %sqldir%\T_Integration_Dictionary_Insert.EN.sql >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log



            

echo Create application in IIS >> %insdir%\Install.Log
echo Create Kiosk.Integration application in IIS >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/Kiosk.Integration" /physicalpath:%cd%Kiosk.Integration\KIOSK.Integration.WSProxy >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/Kiosk.Integration" /applicationpool:DefaultAppPool >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo Create Kiosk.Integration.OCR application in IIS >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/Kiosk.Integration.OCR" /physicalpath:%cd%Kiosk.Integration.OCR\KIOSK.Integration.WSProxy >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/Kiosk.Integration.OCR" /applicationpool:DefaultAppPool >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log


echo Create Kiosk.Integration.PDF application in IIS >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/Kiosk.Integration.PDF" /physicalpath:%cd%Kiosk.Integration.PDF\KIOSK.Integration.WSProxy >> %insdir%\Install.Log
%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/Kiosk.Integration.PDF" /applicationpool:DefaultAppPool >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log


echo Grant permission for folder >> %insdir%\Install.Log
echo Grant permission for folder %cd% Kiosk.Integration >> %insdir%\Install.Log
icacls %cd%Kiosk.Integration /grant Everyone:(OI)(CI)F /T >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo Grant permission for folder %cd% Kiosk.Integration.OCR >> %insdir%\Install.Log
icacls %cd%Kiosk.Integration.OCR /grant Everyone:(OI)(CI)F /T >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

echo Grant permission for folder %cd% Kiosk.Integration.PDF >> %insdir%\Install.Log
icacls %cd%Kiosk.Integration.PDF /grant Everyone:(OI)(CI)F /T >> %insdir%\Install.Log
echo:>> %insdir%\Install.Log

pause


