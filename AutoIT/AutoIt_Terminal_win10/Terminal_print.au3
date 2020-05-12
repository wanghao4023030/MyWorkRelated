#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         Ralf Wang

 Script Function:
	Simulate the patient to print Image and report in terminal.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <Date.au3>
#include <WindowsConstants.au3>
#include <Excel.au3>

local $ReturnTexttemp
Local $TextArray[20]
local $i
Global $logpath,$logString,$RISData,$PID,$ACCN,$CorrectNumber,$CorrectNumber1

$RISData  = @ScriptDir&"\Patient_ACCN.xls"
$logpath = @ScriptDir&"\log\"&@YEAR&@MON&@MDAY&@HOUR&".txt"
$AppPath = "C:\Program Files (x86)\Carestream\Carestream MyVue Center Terminal UI"

Run("C:\Program Files (x86)\Carestream\Carestream MyVue Center Terminal UI\K2MonUIWPF.exe",$AppPath)
$ACCN = "asdfasdf"
ResetTestDataStatus()
sleep(30000)
Send($ACCN&"{ENTER}")





;~ For $j=1 to 500000 step 1
;~ 	$i=0
;~ 	;Read test data from XLS files
;~ 	ReadPIDandACCN($RISData)
;~ 	$CorrectNumber = checkPrintstatus($PID)

;~ 	WinActivate("[Class:#32770]")
;~ 	;Terminal Print film and report.
;~ 	TerminalPrint()

;~ 	;Chech the print task success or fail in print task
;~ 	$CorrectNumber1 = checkPrintstatus($PID)


;~ 	If ($CorrectNumber1= $CorrectNumber+1 and messageCheck("¥Ú”°ÕÍ±œ£¨«Î»°∆¨")= 1 ) Then
;~ 		MsgBox(1,"","Print success~~",3)
;~ 		$logstring = "Sucess"&@TAB&$logstring&@TAB&"SN:"&@TAB&ReturnSN($PID)&@TAB
;~ 		;~ ResetTestDataStatus()
;~ 		ResetTestDataStatus()

;~ 		for $fortemp =0 to $i Step 1
;~ 			$logString = $logString&$TextArray[$fortemp]
;~ 		Next
;~ 		MonitorApp()
;~ 		WriteLog($logpath,$logString)
;~ 	Else

;~ 		$logstring = "Fail"&@TAB&$logstring&@TAB&"SN:"&@TAB&ReturnSN($PID)&@TAB

;~ 		for $fortemp =0 to $i Step 1
;~ 			$logString = $logString&$TextArray[$fortemp]
;~ 		Next

;~ 		MonitorApp()
;~ 		WriteLog($logpath,$logString)
;~ 		MsgBox(1,"","Print not success~~"&$ACCN)
;~ 		;~ ResetTestDataStatus()
;~ 		ResetTestDataStatus()


;~ 	EndIf




;~ Next

;~ msgbox (1,"","script run Finished")

;~  _ArrayDisplay($TextArray,"Test")


















Func MonitorApp()
	 ; Retrieve memory details about the current process.
    Local $aMemory = ProcessGetStats("AFP6000.exe")
    ; If $aMemory is an array then display the following details about the process.
    If IsArray($aMemory) Then
        $logString = $logString&@TAB&"WorkingSetSize:"& $aMemory[0] &@TAB& "PeakWorkingSetSize: " & $aMemory[1]
    EndIf
EndFunc







Func TerminalPrint()

$ReturnTexttemp = ControlGetText("[Class:#32770]","","[CLASS:Edit; INSTANCE:2]")
$TextArray[0] = $ReturnTexttemp

ControlSetText("[Class:#32770]","","[CLASS:Edit;INSTANCE:1]",$ACCN)
Sleep(1000)
ControlClick("[Class:#32770]","","[CLASS:Button; INSTANCE:2]","left")

Do
	Do
		$ReturnTexttemp = ControlGetText("[Class:#32770]","","[CLASS:Edit; INSTANCE:2]")
	Until	$ReturnTexttemp<>$TextArray[$i]
	$TextArray[$i+1] = $ReturnTexttemp
	$i=$i+1
Until $TextArray[$i] = $TextArray[0]
EndFunc




Func WriteLog($path,$logstring)
	IF FileExists($path) Then
		FileOpen($path,1)
		_FileWriteLog($path,$Logstring)
	Else
		_FileCreate($path)
		FileOpen($path,1)
		_FileWriteLog($path,$Logstring)
	EndIf
EndFunc



Func checkPrintstatus($PID)
	Local $conn,$RS,$query,$commd
	$conn = ObjCreate("ADODB.Connection")
	$RS = ObjCreate("ADODB.Recordset")
	$commd = ObjCreate("ADODB.COMMAND")
 	$conn.open("driver={SQL Server};Server=10.184.129.231\GCPACSWS;uid=sa;pwd=sa20021224$;APP=AUTOIT;WSID=WORKSTATION0001;database=WGGC;")
	;modify the film and report status
	$RS.open("SELECT count(*) as number FROM wggc.dbo.AFP_PrintTask where PatientID = '"&$PID&"' and Status = 4 and ErrorCode =0",$conn)
	If(Not $RS.eof) Then
		If $RS.Fields("number").value = 0  Then

			return $RS.Fields("number").value
		Else

			return $RS.Fields("number").value
		EndIf
	EndIf
	$conn.colse
	$RS.close
EndFunc

Func ReturnSN($PID)
		Local $conn,$RS,$query,$commd
	$conn = ObjCreate("ADODB.Connection")
	$RS = ObjCreate("ADODB.Recordset")
	$commd = ObjCreate("ADODB.COMMAND")
 	$conn.open("driver={SQL Server};Server=10.184.129.231\GCPACSWS;uid=sa;pwd=sa20021224$;APP=AUTOIT;WSID=WORKSTATION0001;database=WGGC;")
	;modify the film and report status
	$RS.open("SELECT SN FROM wggc.dbo.AFP_PrintTask where PatientID = '"&$PID&"'  order by CreateTime desc",$conn)
	If(Not $RS.eof) Then
			return $RS.Fields("SN").value
		Else
			return 0
	EndIf
	$conn.colse
	$RS.close

EndFunc

Func ResetTestDataStatus()
	Local $conn,$RS,$query,$commd
	$conn = ObjCreate("ADODB.Connection")
	$RS = ObjCreate("ADODB.Recordset")
	$commd = ObjCreate("ADODB.COMMAND")
 	$conn.open("driver={SQL Server};Server=10.184.129.231\GCPACSWS;uid=sa;pwd=sa20021224$;APP=AUTOIT;WSID=WORKSTATION0001;database=WGGC;")
	;modify the film and report status
	$RS.open("update wggc.dbo.AFP_FilmInfo set FilmFlag =0 where AccessionNumber = '"&$ACCN&"'",$conn)
	$RS.open("Update wggc.dbo.AFP_ReportInfo Set PrintStatus = 0 where AccessionNumber ='"&$ACCN&"'",$conn)

	$conn.colse
	$RS.close

EndFunc
