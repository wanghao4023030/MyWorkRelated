@echo off
echo Start install kiosk film create webservice module
echo Create application in IIS
%systemroot%\system32\inetsrv\appcmd delete app "Default Web Site/PerformanceTest"
%systemroot%\system32\inetsrv\appcmd delete apppool  "PerformanceTest"

%systemroot%\system32\inetsrv\appcmd add apppool /name:"PerformanceTest" /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated
%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/PerformanceTest" /physicalpath:%cd%\CreateFilmDataService
%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/PerformanceTest" /applicationpool:PerformanceTest

echo Grant permission for folder %cd%
icacls %cd% /grant Everyone:(OI)(CI)F /T

