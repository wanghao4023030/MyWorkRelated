#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstants.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>


$From1 = GUICreate("Install Patches......",400,400)
$progress1 = GUICtrlCreateProgress(40,64,300,17,$PBS_SMOOTH)
$FromText = GUICtrlCreateLabel("Installing....",10,10,400,40,$SS_LEFT) ; first cell 70 width
GUISetState(@SW_SHOW)


$waitTimeScecond = 1000
; List all the files and folders in the desktop directory using the default parameters and return the full path.
Local $aFileList = _FileListToArray(@ScriptDir, '*.msu')

$fHandle = Fileopen(@ScriptDir & '\log.txt', $FO_OVERWRITE )
FileWriteLine($fHandle,'**********************Search file****************************')
FileWriteLine($fHandle,'Start query the patch files, the file list is follow:')

for $i=1 to $aFileList[0] step 1
	FileWriteLine($fHandle,$i &": "& $aFileList[$i])
Next
FileWriteLine($fHandle,'******************************************************')



FileWriteLine($fHandle,'**********************Install patch****************************')
FileWriteLine($fHandle,'Start install the patch files, the file list is follow:')

for $i=1 to $aFileList[0] step 1
	$idMsg = GUIGetMsg()
    Select
        Case $idMsg = $GUI_EVENT_CLOSE
            MsgBox($MB_SYSTEMMODAL, "", "Dialog was closed")
            ExitLoop
	EndSelect
	GUICtrlSetData($progress1, ($i/$aFileList[0])*100)
	GUICtrlSetData($FromText,"Install " &$i&"/"&$aFileList[0]&" name is: " & $aFileList[$i])
	GUISetState(@SW_SHOW)

	$cmd = "wusa " & '"' & @ScriptDir & '\' & $aFileList[$i] & '"'& " /quiet /norestart"
	RunWait(@ComSpec & " /c" & $cmd,"",@SW_HIDE)
;~ 	;;;MsgBox(1,"installing","Install " &$i&"/"&$aFileList[0]&" name is: " & $aFileList[$i],10)
	FileWriteLine($fHandle,$i &": "&'Try to install patch '& $aFileList[$i])

Next

	GUIDelete()

FileWriteLine($fHandle,'******************************************************')



$systeminfotxt = GetSysinfo()

$errorPathes = 0

FileWriteLine($fHandle,'**********************Install Check****************************')
for $i=1 to $aFileList[0] step 1
	Local $aArray = StringRegExp($aFileList[$i],'KB\d+|kb\d+',$STR_REGEXPARRAYFULLMATCH)
;~  	MsgBox(1,1,$aArray[0])
	If UBound($aArray) == 1 then
			If StringInStr($systeminfotxt,$aArray[0]) > 0 Then
				FileWriteLine($fHandle,$i &": "& $aFileList[$i] & " install successfully.")
			Else
				FileWriteLine($fHandle,$i &": "& $aFileList[$i] & " install failed.")

				$errorPathes = $errorPathes + 1
			EndIf
		Else
			FileWriteLine($fHandle,"Error: reg from patch file - " & $aFileList[$i] & " with parrten KB\d+|kb\d+ failed.Please check by manual...")
	EndIf
Next

FileWriteLine($fHandle,'******************************************************')


FileClose($fHandle)

If $errorPathes == 0 Then
	MsgBox(1,"Install","Patch is install finsihed.Pease view the log and make sure the pathes has installed successfully.You can restart server manually...")
Else
	Msgbox(1,"Install","Patch is install finsihed.There are "&$errorPathes&" pathes install failed.Pease view the log at current folder.You can install them manually and restart server ...")
EndIf





func GetSysinfo()
	$systemInfo = "systeminfo > " & '"'& @ScriptDir &'"' & "\systeminfo.txt"
	RunWait(@ComSpec & " /c" & $systemInfo,"",@SW_HIDE)
	$syslogHandle = FileOpen(@ScriptDir & '\systeminfo.txt')
	$systeminfotxt = FileRead($syslogHandle)
	FileClose($syslogHandle)
	return $systeminfotxt
EndFunc









; Display the results returned by _FileListToArray.
;~ _ArrayDisplay($aFileList, "$aFileList")
;~ _ArraySort($aFileList)
;~ _ArrayDisplay($aFileList, "$aFileList")

