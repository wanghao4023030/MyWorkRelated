
@echo off

%~dp0InstallUtil.exe %~dp0KIOSK.Integration.InboundService.MWL.SCU.exe /u
%~dp0InstallUtil.exe %~dp0KIOSK.Integration.InboundService.MWL.SCU.exe

::echo 当前盘符：%~d0
::echo 当前盘符和路径：%~dp0
::echo 当前批处理全路径：%~f0
::echo 当前盘符和路径的短文件名格式：%~sdp0
::echo 当前CMD默认目录：%cd%

::sc stop KIOSK.Integration.InboundService.MWL.SCU
::sc start KIOSK.Integration.InboundService.MWL.SCU

::net stop KIOSK.Integration.InboundService.MWL.SCU
::net start KIOSK.Integration.InboundService.MWL.SCU

pause

echo on