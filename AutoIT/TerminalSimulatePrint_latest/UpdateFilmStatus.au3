#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>


; Script Start - Add your code below here
Dim $str_cmdContent
Dim $str_fileList
Dim $filePath
Dim $PID
$ScriptfilePath = @ScriptDir & "\"


;******************************
; connect Database
;******************************
$Para_Arr = 0
_FileReadToArray(@ScriptDir&"\parameter.txt", $Para_Arr, 0)

$Connstr = $Para_Arr[0]
$Accn = $Para_Arr[1]
$Terminal_type = $Para_Arr[2]
$LoopCount = $Para_Arr[3]

Switch StringUpper($Terminal_type)
	Case "PUMA"
		Local $aFileList = _FileListToArrayRec("C:\Users\Carestream\AppData\Roaming\Carestream\KioskTerminal", "Unicorn.exe" ,  $FLTA_FILES, $FLTAR_RECUR , $FLTAR_NOSORT,  $FLTAR_FULLPATH)
			If @error = 1 Then
				MsgBox($MB_SYSTEMMODAL, "", "PUMA Path was invalid.")
				Exit
			EndIf
			If @error = 4 Then
				MsgBox($MB_SYSTEMMODAL, "", "The application cannot find, please confirm it has installed")
				Exit
			EndIf

		$App_path = $aFileList[1]
		$work_folder = StringReplace($App_path,"Unicorn.exe","")

		$PID = Run($App_path, $work_folder)

	Case "K2"
			Local $aFileList = _FileListToArrayRec("c:\Program Files (x86)\", "K2MonUIWPF.exe" ,  $FLTA_FILES, $FLTAR_RECUR , $FLTAR_NOSORT,  $FLTAR_FULLPATH)
			If @error = 1 Then
				MsgBox($MB_SYSTEMMODAL, "", "K2 Path was invalid.")
				Exit
			EndIf
			If @error = 4 Then
				MsgBox($MB_SYSTEMMODAL, "", "The application cannot find, please confirm it has installed")
				Exit
			EndIf

			$App_path = $aFileList[1]
			$work_folder = StringReplace($App_path,"K2MonUIWPF.exe","")

			$PID = Run($App_path, $work_folder)


$Run_flag = True
EndSwitch


For $i = 0 to $LoopCount step 1
	PrintFilm()

Next

msgbox(1,1,"Finsihed")



Func PrintFilm()

	$constrim="DRIVER={SQL Server};SERVER=" & $Connstr & "\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
	$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
	$adCN.Open ($constrim) ; <== Connect with required credentials
	If @error Then
			MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
			Exit
		Else
			MsgBox(0, "Success!", "Connection to database successful!", 5)
	EndIf


	If $PID <> 0 Then
;~ 		MsgBox(1,1,"start to print")
		$adoRecordSet = ObjCreate("ADODB.RecordSet")


		$s_currentDateTime = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" &@SEC & "." & @MSEC
;~ 		MsgBox(1,1,$s_currentDateTime)

		$sql = "Update wggc.dbo.AFP_Filminfo set filmflag = 0 where AccessionNumber = '"&$Accn&"' "
		$adoRecordSet.Open($sql,$adCN)
;~ 		while $Run_flag
			MouseClick("left", 500, 500, 2)
			Send($Accn)
			MouseClick("left", 500, 500, 2)
			Send("{Enter}")

			Sleep(10* 1000)

			$b_PrintFinished = True

			While $b_PrintFinished
				$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
				$s_temp_sql = "select top 1 Status from wggc.dbo.AFP_PrintTask where PatientID = (select PatientID from wggc.dbo.AFP_FilmInfo where AccessionNumber = '"&$Accn&"')  and CreateTime > '" & $s_currentDateTime& "' order by SN desc"
				$adoRecordSet2.Open($s_temp_sql,$adCN)
				$s_result = $adoRecordSet2.Fields("Status").Value

				If $s_result == "4" or $s_result == "3" Then
					$b_PrintFinished = False
				EndIf
				Sleep(10* 1000)

			WEnd

;~ 			MsgBox(1,1 ,"Print task finsihed.")
			$adoRecordSet = ObjCreate("ADODB.RecordSet")
			$sql = "Update wggc.dbo.AFP_Filminfo set filmflag = 0 where AccessionNumber = '"&$Accn&"' "
			$adoRecordSet.Open($sql,$adCN)

			Sleep(10 * 1000)
			_FileWriteLog(@ScriptDir & "\log.txt", "try to print report...")
			GetProcessInformation($PID)

	Else
		MsgBox(0, "Failed!", "Start terminal software failed, please try with administrator role again.")
	EndIf

EndFunc


Func GetProcessInformation($ProcessID)
	$wbemFlagReturnImmediately = 0x10
	$wbemFlagForwardOnly = 0x20
	$colItems = ""
	$strComputer = "localhost"

	$Output=""
	$Output = $Output & "Computer: " & $strComputer  & @CRLF
	$Output = $Output & "==========================================" & @CRLF
	$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
	$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_Process where ProcessID = '" & $ProcessID& "'", "WQL", _
											  $wbemFlagReturnImmediately + $wbemFlagForwardOnly)

	If IsObj($colItems) then
	   For $objItem In $colItems
		  $Output = $Output & "Caption: " & $objItem.Caption & @CRLF
		  $Output = $Output & "CommandLine: " & $objItem.CommandLine & @CRLF
		  $Output = $Output & "CreationClassName: " & $objItem.CreationClassName & @CRLF
		  $Output = $Output & "CreationDate: " & WMIDateStringToDate($objItem.CreationDate) & @CRLF
		  $Output = $Output & "CSCreationClassName: " & $objItem.CSCreationClassName & @CRLF
		  $Output = $Output & "CSName: " & $objItem.CSName & @CRLF
		  $Output = $Output & "Description: " & $objItem.Description & @CRLF
		  $Output = $Output & "ExecutablePath: " & $objItem.ExecutablePath & @CRLF
		  $Output = $Output & "ExecutionState: " & $objItem.ExecutionState & @CRLF
		  $Output = $Output & "Handle: " & $objItem.Handle & @CRLF
		  $Output = $Output & "HandleCount: " & $objItem.HandleCount & @CRLF
		  $Output = $Output & "InstallDate: " & WMIDateStringToDate($objItem.InstallDate) & @CRLF
		  $Output = $Output & "KernelModeTime: " & $objItem.KernelModeTime & @CRLF
		  $Output = $Output & "MaximumWorkingSetSize: " & $objItem.MaximumWorkingSetSize & @CRLF
		  $Output = $Output & "MinimumWorkingSetSize: " & $objItem.MinimumWorkingSetSize & @CRLF
		  $Output = $Output & "Name: " & $objItem.Name & @CRLF
		  $Output = $Output & "OSCreationClassName: " & $objItem.OSCreationClassName & @CRLF
		  $Output = $Output & "OSName: " & $objItem.OSName & @CRLF
		  $Output = $Output & "OtherOperationCount: " & $objItem.OtherOperationCount & @CRLF
		  $Output = $Output & "OtherTransferCount: " & $objItem.OtherTransferCount & @CRLF
		  $Output = $Output & "PageFaults: " & $objItem.PageFaults & @CRLF
		  $Output = $Output & "PageFileUsage: " & $objItem.PageFileUsage & @CRLF
		  $Output = $Output & "ParentProcessId: " & $objItem.ParentProcessId & @CRLF
		  $Output = $Output & "PeakPageFileUsage: " & $objItem.PeakPageFileUsage & @CRLF
		  $Output = $Output & "PeakVirtualSize: " & $objItem.PeakVirtualSize & @CRLF
		  $Output = $Output & "PeakWorkingSetSize: " & $objItem.PeakWorkingSetSize & @CRLF
		  $Output = $Output & "Priority: " & $objItem.Priority & @CRLF
		  $Output = $Output & "PrivatePageCount: " & $objItem.PrivatePageCount & @CRLF
		  $Output = $Output & "ProcessId: " & $objItem.ProcessId & @CRLF
		  $Output = $Output & "QuotaNonPagedPoolUsage: " & $objItem.QuotaNonPagedPoolUsage & @CRLF
		  $Output = $Output & "QuotaPagedPoolUsage: " & $objItem.QuotaPagedPoolUsage & @CRLF
		  $Output = $Output & "QuotaPeakNonPagedPoolUsage: " & $objItem.QuotaPeakNonPagedPoolUsage & @CRLF
		  $Output = $Output & "QuotaPeakPagedPoolUsage: " & $objItem.QuotaPeakPagedPoolUsage & @CRLF
		  $Output = $Output & "ReadOperationCount: " & $objItem.ReadOperationCount & @CRLF
		  $Output = $Output & "ReadTransferCount: " & $objItem.ReadTransferCount & @CRLF
		  $Output = $Output & "SessionId: " & $objItem.SessionId & @CRLF
		  $Output = $Output & "Status: " & $objItem.Status & @CRLF
		  $Output = $Output & "TerminationDate: " & WMIDateStringToDate($objItem.TerminationDate) & @CRLF
		  $Output = $Output & "ThreadCount: " & $objItem.ThreadCount & @CRLF
		  $Output = $Output & "UserModeTime: " & $objItem.UserModeTime & @CRLF
		  $Output = $Output & "VirtualSize: " & $objItem.VirtualSize & @CRLF
		  $Output = $Output & "WindowsVersion: " & $objItem.WindowsVersion & @CRLF
		  $Output = $Output & "WorkingSetSize: " & $objItem.WorkingSetSize & @CRLF
		  $Output = $Output & "WriteOperationCount: " & $objItem.WriteOperationCount & @CRLF
		  $Output = $Output & "WriteTransferCount: " & $objItem.WriteTransferCount & @CRLF
;~ 		  MsgBox(1,1,$Output)
;~ 		  if Msgbox(1,"WMI Output",$Output) = 2 then ExitLoop
		  _FileWriteLog(@ScriptDir & "\systemMonitor.txt", $Output)
		  $Output=""
	   Next
	Else
		$date_time = @YDAY &"-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC

	   Msgbox(0,"WMI Output","No WMI Objects Found for class: " & $ProcessID & $date_time )
	Endif
EndFunc

Func WMIDateStringToDate($dtmDate)

    Return (StringMid($dtmDate, 5, 2) & "/" & _
    StringMid($dtmDate, 7, 2) & "/" & StringLeft($dtmDate, 4) _
    & " " & StringMid($dtmDate, 9, 2) & ":" & StringMid($dtmDate, 11, 2) & ":" & StringMid($dtmDate,13, 2))
EndFunc
