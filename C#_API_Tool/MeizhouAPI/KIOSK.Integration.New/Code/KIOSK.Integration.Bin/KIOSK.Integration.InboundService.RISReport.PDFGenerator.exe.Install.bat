
@echo off

%~dp0InstallUtil.exe %~dp0KIOSK.Integration.InboundService.RISReport.PDFGenerator.exe /u
%~dp0InstallUtil.exe %~dp0KIOSK.Integration.InboundService.RISReport.PDFGenerator.exe

::echo 当前盘符：%~d0
::echo 当前盘符和路径：%~dp0
::echo 当前批处理全路径：%~f0
::echo 当前盘符和路径的短文件名格式：%~sdp0
::echo 当前CMD默认目录：%cd%

::sc stop KIOSK.Integration.InboundService.RISReport.PDFGenerator
::sc start KIOSK.Integration.InboundService.RISReport.PDFGenerator

::net stop KIOSK.Integration.InboundService.RISReport.PDFGenerator
::net start KIOSK.Integration.InboundService.RISReport.PDFGenerator

pause

echo on