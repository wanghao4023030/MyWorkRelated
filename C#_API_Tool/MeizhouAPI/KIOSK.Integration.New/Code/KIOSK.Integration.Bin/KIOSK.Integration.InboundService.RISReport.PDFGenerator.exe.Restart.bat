@echo off
::echo ��ǰ�̷���%~d0
::echo ��ǰ�̷���·����%~dp0
::echo ��ǰ������ȫ·����%~f0
::echo ��ǰ�̷���·���Ķ��ļ�����ʽ��%~sdp0
::echo ��ǰCMDĬ��Ŀ¼��%cd%

sc stop KIOSK.Integration.InboundService.RISReport.PDFGenerator

sc start KIOSK.Integration.InboundService.RISReport.PDFGenerator

pause

echo on