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

$waitTimeScecond = 1000
; List all the files and folders in the desktop directory using the default parameters and return the full path.
Local $aFileList = _FileListToArray(@ScriptDir, '*.msu')

$fHandle = Fileopen(@ScriptDir & '\log.txt', $FO_OVERWRITE )
FileWriteLine($fHandle,'**********************Search file****************************')
FileWriteLine($fHandle,'Start query the patch files, the file list is follow:')

for $i=1 to $aFileList[0] step 1
	FileWriteLine($fHandle,$aFileList[$i])
Next
FileWriteLine($fHandle,'******************************************************')



FileWriteLine($fHandle,'**********************Install patch****************************')
FileWriteLine($fHandle,'Start install the patch files, the file list is follow:')

for $i=1 to $aFileList[0] step 1
	$cmd = "wusa " & @ScriptDir & '\' & $aFileList[$i] &  " /quiet /norestart"
;~ 	FileWriteLine($fHandle,$cmd)
	RunWait(@ComSpec & " /c" & $cmd,"",@SW_HIDE)
	MsgBox(1,"installing","Install " &$i&"/"&$aFileList[0]&" name is: " & $aFileList[$i],10)
	FileWriteLine($fHandle,'Try to install patch '& $aFileList[$i])
Next
FileWriteLine($fHandle,'******************************************************')



$systeminfotxt = GetSysinfo()

FileWriteLine($fHandle,'**********************Install Check****************************')
for $i=1 to $aFileList[0] step 1
	Local $aArray = StringRegExp($aFileList[$i],'KB\d+',$STR_REGEXPARRAYFULLMATCH)
;~ 	MsgBox(1,1,$aArray[0])
	If UBound($aArray) == 1 then
			If StringInStr($systeminfotxt,$aArray[0]) > 0 Then
				FileWriteLine($fHandle,$aFileList[$i] & " install successfully.")
			Else
				FileWriteLine($fHandle,$aFileList[$i] & " install failed.")
			EndIf
		Else
			FileWriteLine($fHandle,"Error: reg from patch file - " & $aFileList[$i] & " with parrten KB\d+ failed.Please check by manual...")
	EndIf
Next

FileWriteLine($fHandle,'******************************************************')


FileClose($fHandle)


MsgBox(1,"Install","Patch is install finsihed.You can restart server manually...")


func GetSysinfo()
	$systemInfo = "systeminfo > " &@ScriptDir& "\systeminfo.txt"
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

