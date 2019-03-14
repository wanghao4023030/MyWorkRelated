#include <File.au3>
#include <Date.au3>
#include <GuiListBox.au3>
#include <GuiComboBox.au3>
#include <Process.au3>
;workpath, database path and preCD path
Dim $strWorkPath,$strDatabase,$strPreCD

Global $Drivers
Global $_InstallToolName
Global $_InstallToolPath
Global $_szCurPath
Global $_IsSkip
Global $_InstallationLanguage
Global $_delay


Func GetTheDriveIndex(const $strDriverName)
	For $i=1 to $Drivers[0]
		If StringLeft($Drivers[$i],2) == $strDriverName Then
			Return $i-1
		Endif
	Next
EndFunc

Func Init()
	Dim $szDrive,$szDir,$szFileName,$szExt,$szCurPath
	_PathSplit(@ScriptFullPath,$szDrive,$szDir,$szFileName,$szExt)
	$szCurPath=$szDrive & $szDir
	$_szCurPath=$szCurPath
EndFunc

Func LoadAutoBatCfg()
	FileWriteLine($LogFile,"$_szCurPath is " & $_szCurPath)
	Dim $strCfgFileName
	$strCfgFileName="AutoBat.cfg"
	$strPlatformCfg="Global"
	FileWriteLine($LogFile,"$strCfgFileName is " & $strCfgFileName)
	FileWriteLine($LogFile,"$strPlatformCfg is " & $strPlatformCfg)
	$_InstallToolName=IniRead($_szCurPath & "\" & $strCfgFileName,$strPlatformCfg,"ToolName","PrinterServer2.0-Setup.exe")
	FileWriteLine($LogFile,"$_InstallToolName is " & $_InstallToolName)
	$_InstallToolPath=IniRead($_szCurPath & "\" & $strCfgFileName,$strPlatformCfg,"Path",$_szCurPath)
	FileWriteLine($LogFile,"$_InstallToolPath is " & $_InstallToolPath)
	$_IsSkip=IniRead($_szCurPath & "\" & $strCfgFileName,$strPlatformCfg,"Skip","0")
	FileWriteLine($LogFile,"$_IsSkip is " & $_IsSkip)
	$_InstallationLanguage=IniRead($_szCurPath & "\" & $strCfgFileName,$strPlatformCfg,"Language","2")
	FileWriteLine($LogFile,"$_InstallationLanguage is " & $_InstallationLanguage)
	$_delay=IniRead($_szCurPath & "\" & $strCfgFileName,$strPlatformCfg,"Delay","250")
	FileWriteLine($LogFile,"$_delay is " & $_delay)
EndFunc

Func UpdateLocalPath(Const $strPath, $optionalVal1=TRUE)
	Dim $strDriverChangedTo
	Dim $totalFree1,$totalFree2
	$strDriverChangedTo=""
	$totalFree1=""
	$totalFree2=""
	$strDriverName=StringLeft($strPath,2)
	;如果当前盘存在，使用当前盘
	For $i=1 to $Drivers[0]
		If $Drivers[$i] == $strDriverName Then
			FileWriteLine($LogFile,"Find the driver, use the default name[" & $strPath & "].")
			Return $strPath
		Endif
	Next
	;不存在，更换盘符
	If $optionalVal1 Then
		For $i=2 to $Drivers[0]
			$totalFree2=DriveSpaceFree($Drivers[$i])
			If $totalFree1<$totalFree2 Then
				$totalFree1=$totalFree2
				$strDriverChangedTo=$Drivers[$i]
			EndIf
		Next
		If $strDriverChangedTo=="" Then
			$strDriverChangedTo=$Drivers[1]
		EndIf
	Else
		$totalFree1=1048576
		For $i=2 to $Drivers[0]
			$totalFree2=DriveSpaceFree($Drivers[$i])
			If $totalFree1>$totalFree2 Then
				$totalFree1=$totalFree2
				$strDriverChangedTo=$Drivers[$i]
			EndIf
		Next
		If $strDriverChangedTo=="" Then
			$strDriverChangedTo=$Drivers[1]
		EndIf
	EndIf
	$strDriverChangedTo=$strDriverChangedTo & StringTrimLeft($strPath,2)
	FileWriteLine($LogFile,"Can not find the driver, use the changed name[" & $strDriverChangedTo & "].")
	return $strDriverChangedTo
EndFunc

Func LogReport(const $objFile, const $strLog, const $Exit=TRUE)
	FileWriteLine($LogFile,$strLog)
	If $Exit==TRUE Then
		$Bad=FileOpen("InstallError",2)
		FileClose($Bad)
		MsgBox(0,"AutoBat","Installation Failed.")
		Exit
	EndIf
EndFunc

Func FindWindowFunc(const $objFile, const $strWindowTitle, const $strWindowText, const $iTimeOut ,const $Exit=TRUE)
	Dim $hldWnd

	$hldWnd=0
	$hldWnd=WinWait($strWindowTitle,$strWindowText,$iTimeOut)
	If $hldWnd==0 Then
		LogReport($objFile,"Failed to Find Window [" & $strWindowText & "].",$Exit)
		Return FALSE
	Else
		WinActivate($strWindowTitle,$strWindowText)
		LogReport($objFile,"Find Window [" & $strWindowText & "].",FALSE)
	EndIf
	Return TRUE
EndFunc

Func FindButtonToClick(const $objFile, const $strWindowTitle, const $strWindowText, const $controlID, const $strButtonInfo=TRUE, const $Exit=TRUE)
	Dim $Result

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$Result=ControlClick($strWindowTitle,$strWindowText,$controlID)
	If $Result Then
	Else
		LogReport($objFile,"Failed to Click Button [" & $strButtonInfo & "] with [" & $controlID & "][" & $strWindowTitle & "][" & $strWindowText & "].",$Exit)
		Return FALSE
	EndIf
	Return TRUE
EndFunc

Func FindEditToSet(const $objFile, const $strWindowTitle, const $strWindowText, const $controlID, const $strValue, const $strButtonInfo=TRUE, const $Exit=TRUE)
	Dim $Result

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$Result=ControlSetText($strWindowTitle,$strWindowText,$controlID,$strValue)
	If $Result Then
	Else
		LogReport($objFile,"Failed to Set Edit [" & $strButtonInfo & "] with [" & $controlID & "][" & $strWindowTitle & "][" & $strWindowText & "] to [" & $strValue & "].",$Exit)
		Return FALSE
	EndIf
	Return TRUE
EndFunc

Func FindCtrlListToClick(const $objFile, const $strWindowTitle, const $strWindowText, const $controlID, const $listIndex, const $Exit=TRUE)
	Dim $hldContrlBox

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$hldContrlBox=ControlGetHandle($strWindowTitle,$strWindowText,$controlID)
	If $hldContrlBox==0 Then
		LogReport($objFile,"Failed to find ListBox [" & $strWindowText & "].",$Exit)
		Return FALSE
	Else
		LogReport($objFile,"Find ListBox [" & $strWindowText & "] and will choose Index [" & $listIndex & "].",FALSE)
	EndIf

	_GUICtrlListBox_ClickItem($hldContrlBox,$listIndex)
	Return TRUE
EndFunc

Func FindComboBoxToClick(const $objFile, const $strWindowTitle, const $strWindowText, const $controlID, const $listIndex, const $listText, const $Exit=TRUE)
	Dim $hldComboBox

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$hldComboBox=ControlGetHandle($strWindowTitle,$strWindowText,$controlID)
	If $hldComboBox==0 Then
		LogReport($objFile,"Failed to find ComboBox [" & $strWindowText & "].",$Exit)
		Return FALSE
	Else
		LogReport($objFile,"Find ComboBox [" & $strWindowText & "] and will choose [" & $listText & "] with Index [" & $listIndex & "].",FALSE)
	EndIf

	_GUICtrlComboBox_SelectString($hldComboBox,$listText,$listIndex)
	Return TRUE
EndFunc

Func FindPosToClick(const $objFile,const $strWindowTitle,const $strWindowText,const $pos1, const $pos2)

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$size=WinGetPos($strWindowTitle)
	FileWriteLine($objFile,"Window Pos : " & $size[0] & " " & $size[1] & " " & $size[2] & " " & $size[3])
	MouseClick("Left",$size[0]+$pos1,$size[1]+$pos2)
EndFunc


Func RedirectFolder(const $objFile, const $strWindowTitle, const $strWindowText, const $controlIDForSelect, const $controlIDForText, const $DiskType=TRUE , $Exit=TRUE)
	Dim $strRtn
	Dim $InstallDriver
	Dim $driverIndex

	$dlgChgDirShieldWindow="Select Hard Disk Drive"
	$dlgChgDirShieldWindowText="Select a hard disk drive from the list below"
	$controlIDForChgDirOK="[ID:1]"
	$controlIDForChgDirComboBox="[ID:1002]"

	WinActivate($strWindowTitle,$strWindowText)
	Sleep($_delay)

	$InstallDriver=ControlGetText($strWindowTitle,$strWindowText,$controlIDForText)
	FileWriteLine($LogFile,"Get installation path[" & $InstallDriver & "] for [" & $controlIDForText & "] with [" & $strWindowTitle & "][" & $strWindowText & "].")
	$InstallDriver=StringLeft(UpdateLocalPath(StringLower($InstallDriver),$DiskType),2)
	FileWriteLine($LogFile,"Redirect path to [" & $InstallDriver & "] for [" & $controlIDForText & "].")
	$strRtn=FindButtonToClick($objFile,$strWindowTitle,$strWindowText,$controlIDForSelect,$controlIDForSelect,$Exit)
	If $strRtn==FALSE Then
		Return $strRtn
	EndIf
	$strRtn=FindWindowFunc($objFile, $dlgChgDirShieldWindow, $dlgChgDirShieldWindowText,5)
	If $strRtn==FALSE Then
		Return $strRtn
	EndIf

	$driverIndex=GetTheDriveIndex($InstallDriver)
	FileWriteLine($LogFile,"The Finded String is [ " & $InstallDriver & "] and the location is [" & $driverIndex & "].")
	$strRtn=FindComboBoxToClick($objFile, $dlgChgDirShieldWindow, $dlgChgDirShieldWindowText, $controlIDForChgDirComboBox, $driverIndex, StringUpper($InstallDriver), $Exit)
	If $strRtn==FALSE Then
		Return $strRtn
	EndIf
	$strRtn=FindButtonToClick($objFile,$dlgChgDirShieldWindow,$dlgChgDirShieldWindowText,$controlIDForChgDirOK,"OK button",$Exit)
	If $strRtn==FALSE Then
		Return $strRtn
	EndIf
	Return TRUE
EndFunc

;记录日志
$LogFile=FileOpen("Platform.log",2)

Init()
FileWriteLine($LogFile,"Current Working Dir is[" & $_szCurPath & "].")

LoadAutoBatCfg()

If $_IsSkip==1 Then
	FileWriteLine($LogFile,"Skip installing RadSuite.")
	Exit
EndIf

$strCurTime=_Date_Time_GetLocalTime()
FileWriteLine($LogFile,_Date_Time_SystemTimeToDateTimeStr($strCurTime) & "	Begin to auto install Printer Server.")


Dim $ClearDirArray[8]
$ClearDirArray[0]="Backup"
$ClearDirArray[1]="DB_PRECD"
$ClearDirArray[2]="Database"
$ClearDirArray[3]="PRECD"
$ClearDirArray[4]="JP2Cache"
$ClearDirArray[5]="Images"
$ClearDirArray[6]="GX Platform"
$ClearDirArray[7]="Report"
$Drivers=DriveGetDrive("FIXED")
IF Not @error Then
	For $i=1 to $Drivers[0]
		FileWriteLine($LogFile,"Drive[" & $Drivers[$i] & "]finded.")
		For $ClearDir In $ClearDirArray
			If FileExists($Drivers[$i] & "\" & $ClearDir) Then
				FileWriteLine($LogFile,"Dir[" & $Drivers[$i] & "\" & $ClearDir & "]finded.")
				$Result=DirRemove($Drivers[$i] & "\" & $ClearDir,1)
				If $Result Then
					FileWriteLine($LogFile,"Dir[" & $Drivers[$i] & "\" & $ClearDir & "]Deleted.")
				Else
					FileWriteLine($LogFile,"Dir[" & $Drivers[$i] & "\" & $ClearDir & "]Delete Failed.")
				EndIf
			Endif
		Next
	Next
EndIf
FileWriteLine($LogFile,"All the unused files have been deleted.")


If Fileexists($_InstallToolPath & "\" & $_InstallToolName) Then
	ShellExecute($_InstallToolPath & "\" & $_InstallToolName)
	If @error Then
		LogReport($LogFile,"System erros occurs[" & @error &"] when execute [" & $_InstallToolPath & "\" & $_InstallToolName & "].")
	Endif
Else
	ShellExecute($_szCurPath & $_InstallToolName)
	If @error Then
		LogReport($LogFile,"System erros occurs[" & @error &"] when execute [" & $_szCurPath & $_InstallToolName & "].")
		Exit
	EndIf
EndIf

;handle the .net4 setup dlg
;$dlgInstallShieldWindow="Microsoft .NET Framework 4 安装程序"
;$dlgInstallShieldWindowText="我已阅读并接受许可条款(&A)。"
;$controlIDForCheckBox="[ID:104]"
;$controlIDForNext="[ID:1]"
;$strRtn=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800)
;If $strRtn==TRUE Then
;	;alt+A
;	send("!A")
;	sleep(2000)
;	;alt+I
;	Send("!I")
;	;FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForInstall,"Next Button")
;	$dlgInstallShieldWindowText="安装完毕"
;	$strRtn2=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800)
;	If $strRtn2==TRUE Then
;		;alt+A
;		send("!F")
;	EndIf
;EndIf

$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="Welcome to the InstallShield Wizard for Carestream Print Server"
$controlIDForInstall="[ID:1]"
$strRtn=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800,FALSE)
If $strRtn==TRUE Then
	FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForInstall,"Next Button")
EndIf

;Select the language
$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="Choose Setup Language"
$listIndex=$_InstallationLanguage
$controlIDForListBox="[ID:1001]"
$controlIDForNext="[ID:1]"
FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,10)
FindCtrlListToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForListBox,$listIndex)
Sleep(2000)
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForNext,"Next Button")
Sleep(2000)



;Select the Typical
$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="Setup Type"
$controlIDForTypical="[ID:1014]"
$controlIDForNext="[ID:1]"
FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,10)
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForTypical,"Typical Button")
Sleep(2000)
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForNext,"Next Button")

;Choose Directories
$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="Choose Directories"
$controlIDForNext="[ID:1]"
FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,10)
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForNext,"Next Button")

;Click Next to start the installation
$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="Start Copying Files"
$controlIDForNext="[ID:1]"
FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,10)
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForNext,"Next Button")

;handle the Microsoft Report setup dlg
$dlgInstallShieldWindow="Microsoft 报表查看器可再发行组件 2008 (KB952241) 安装程序"
$dlgInstallShieldWindowText="此向导将引导您完成整个安装过程。"
$strRtn=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800)
If $strRtn==TRUE Then
	;alt+N
	send("!N")

	$dlgInstallShieldWindowText="许可条款"
	$strRtn1=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800)


	If $strRtn1==True Then
		;alt+A
		send("!A")
		sleep(2000)
		;alt+I
		Send("!I")
	EndIf
	$dlgInstallShieldWindowText="安装完成"
	$strRtn2=FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,1800)
	If $strRtn2==TRUE Then
		;alt+A
		send("!F")
	EndIf
EndIf

sleep(60000)
WinActivate("KIOSK.Integration - InstallShield Wizard","")
sleep(5000)
ControlClick("KIOSK.Integration - InstallShield Wizard","","&Next >")
;ControlClick("KIOSK.Integration - InstallShield Wizard","&Next >","Button1")
sleep(2000)
ControlClick("KIOSK.Integration - InstallShield Wizard","&Install","Button1")
Sleep(10000)

;Restart the machine!
$dlgInstallShieldWindow="Carestream Print Server - InstallShield Wizard"
$dlgInstallShieldWindowText="InstallShield Wizard Complete"
$controlIDForFinish="[ID:1]"
$controlIDForNotRestart="[ID:503]"
FindWindowFunc($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,2400)

FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForNotRestart,"Not Restart Button")
FindButtonToClick($LogFile,$dlgInstallShieldWindow,$dlgInstallShieldWindowText,$controlIDForFinish,"Finish Button")

$strCurTime=_Date_Time_GetLocalTime()
FileWriteLine($LogFile,_Date_Time_SystemTimeToDateTimeStr($strCurTime) & "	The installation of Printer Server has been successful.")
FileClose($LogFile)

