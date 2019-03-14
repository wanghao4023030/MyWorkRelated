#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>


; Script Start - Add your code below here
Dim $str_cmdContent
Dim $str_fileList
Dim $filePath
$ScriptfilePath = @ScriptDir & "\"


;******************************
; connect Database
;******************************
$Para_Arr = 0
_FileReadToArray(@ScriptDir&"\parameter.txt", $Para_Arr, 0)

$Connstr = $Para_Arr[0]
$Accn = $Para_Arr[1]


$constrim="DRIVER={SQL Server};SERVER=" & $Connstr & "\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
$adCN.Open ($constrim) ; <== Connect with required credentials

$App_flag = Run("C:\Users\Carestream\AppData\Roaming\Carestream\KioskTerminal\Unicorn.exe", "C:\Users\Carestream\AppData\Roaming\Carestream\KioskTerminal\")
$Run_flag = True

If @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!", 30)
EndIf

If $App_flag <> 0 Then
	$adoRecordSet = ObjCreate("ADODB.RecordSet")
	$sql = "Update wggc.dbo.AFP_ReportInfo set PrintStatus = 0 where AccessionNumber = '"&$Accn&"' and PrintStatus <> 0"
	$adoRecordSet.Open($sql,$adCN)
	while $Run_flag
		MouseClick("left", 500, 500, 2)
		Send($Accn)
		MouseClick("left", 500, 500, 2)
		Send("{Enter}")
		sleep(30*1000)
		$adoRecordSet = ObjCreate("ADODB.RecordSet")
		$sql = "Update wggc.dbo.AFP_ReportInfo set PrintStatus = 0 where AccessionNumber = '"&$Accn&"' and PrintStatus <> 0"
		$adoRecordSet.Open($sql,$adCN)

		$ret = MsgBox(1, "continue", "Continue Print Report?\n If you want continue, do not do any choose, the msg will hide after 5 second.", 5)
		If $ret == $IDOK Then
			$Run_flag =False
		EndIf
	WEnd
	Exit

Else
	MsgBox(0, "Failed!", "Start terminal software failed, please try again.")
EndIf

