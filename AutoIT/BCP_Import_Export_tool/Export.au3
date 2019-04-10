#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
; Script Start - Add your code below here
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <Constants.au3>


; Script Start - Add your code below here
Dim $str_cmdContent
Dim $str_fileList
Dim $filePath
$ScriptfilePath = @ScriptDir & "\"

;******************************
; connect Database
;******************************
$constrim="DRIVER={SQL Server};SERVER=localhost\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection

$adoRecordSet = ObjCreate("ADODB.RecordSet")
$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
$Log_path = @ScriptDir & "\export_log.txt"


;~ Delete the log file if exist
If FileExists($Log_path) Then
	FileDelete($Log_path)
EndIf

_FileWriteLog($Log_path, "Start to export the data....")

$adCN.Open ($constrim) ; <== Connect with required credentials
If @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		_FileWriteLog($Log_path, "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!",30)
		_FileWriteLog($Log_path, "Connection to database successful!")
	EndIf


;*************************************************
; Get the Dtabase name in server
;*************************************************
$SQL_queryDB = "select name from sys.sysdatabases where filename not like '%Microsoft%'"
$SQL = "use OCRConfigDB  select name from sys.tables "

;~ get the database name
$adoRecordSet.Open($SQL_queryDB,$adCN)

While $adoRecordSet.EOF <> True
	;MsgBox (1,1,$adoRecordSet.Fields("name").Value)
	$DBName = $adoRecordSet.Fields("name").Value
	$ExportPath =  $ScriptfilePath & $DBName
	;MsgBox(1,1,$ExportPath)
	If (FileExists ( $ExportPath )) Then
		_FileWriteLog($Log_path, "The folder for " & $DBName & " is exist:" & $ExportPath)
	Else
		DirCreate($ExportPath)
		_FileWriteLog($Log_path, "Create folder for " & $DBName & " and path is " & $ExportPath)
		;MsgBox(1,1,$DBName,3)
	EndIf

	$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
;~ 	Get the tables for each database
	$Table_SQL = "Use " &$DBName& "    select name from sys.tables"
	$adoRecordSet2.Open($Table_SQL,$adCN)
	;MsgBox(1,1,$adoRecordSet2.EOF)
	While $adoRecordSet2.EOF <> True
		Local $TableName = $adoRecordSet2.Fields("name").Value
		Local $BCP_statement = "bcp " & $DBName&".dbo."&$TableName& " out "&$ExportPath&"\"&$TableName&".txt -c -T -S localhost\GCPACSWS -U sa -P sa20021224$"
		_FileWriteLog($Log_path, "Export " & $DBName&".dbo."&$TableName&  " to file:"  &$ExportPath&"\"&$TableName&".txt")
		;MsgBox(1,1,$BCP_statement)
		_FileWriteLog($Log_path, "Execute command " & $BCP_statement)

		local $PID = Run(@ComSpec & " /c " & $BCP_statement,"", @SW_HIDE, $STDERR_MERGED)
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog($Log_path, "Execute command result: " & $sOutput)

		$adoRecordSet2.MoveNext
	WEnd


 	$adoRecordSet.MoveNext

WEnd



;*************************************************
;Process PrinterReg
;*************************************************

_FileWriteLog($Log_path, "Change the data of PrinterReg.txt: ")

Local $tempContentArr[0]
$Filepath_PrinterReg = @ScriptDir & "\WGGC\PrinterReg.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"SIMPRINTER", 1)
	If $str_postion = 0 Then
		_ArrayAdd($tempContentArr,$contentArr[$i])
	EndIf
Next


$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
	_FileWriteLog($Log_path, "Over write the file of  PrinterReg.txt: " & $tempContentArr[$i])
Next


;*************************************************
;Process NetAE
;*************************************************
_FileWriteLog($Log_path, "Change the data of NetAE.txt: ")

Local $tempContentArr[0]
$Filepath_PrinterReg = @ScriptDir & "\WGGC\NetAE.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"MainServer",1)

	If $str_postion =0 Then
		If StringInStr($contentArr[$i],"LOCALAPP",1) = 0 Then
			If StringInStr($contentArr[$i],"SIMPRINTER",1) = 0 Then
				_ArrayAdd($tempContentArr,$contentArr[$i])
			EndIf
		EndIf
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
	_FileWriteLog($Log_path, "Over write the file of  NetAE.txt: " & $tempContentArr[$i])
Next



;*************************************************
;Process AFP_Department
;*************************************************
_FileWriteLog($Log_path, "Change the data of AFP_Department.txt: ")
Local $tempContentArr[0]
$Filepath_PrinterReg = @ScriptDir & "\WGGC\AFP_Department.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"∆‰À˚ø∆ “",1)

	If $str_postion =0 Then
				_ArrayAdd($tempContentArr,$contentArr[$i])
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
	_FileWriteLog($Log_path, "Over write the file of  AFP_Department.txt: " & $tempContentArr[$i])
Next


;*************************************************
;Process Users
;*************************************************
_FileWriteLog($Log_path, "Change the data of Users.txt: ")

Local $tempContentArr[0]
$Filepath_PrinterReg = @ScriptDir & "\WGGC\Users.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"admin",1)

	If $str_postion =0 Then
		If StringInStr($contentArr[$i],"cshsvc",1) = 0 Then
		_ArrayAdd($tempContentArr,$contentArr[$i])
		EndIf
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
	_FileWriteLog($Log_path, "Over write the file of  Users.txt: " & $tempContentArr[$i])
Next



;*************************************************
;Process UserProfile
;*************************************************
_FileWriteLog($Log_path, "Change the data of UserProfile.txt: ")

Local $tempContentArr[0]
$Filepath_PrinterReg = @ScriptDir & "\WGGC\UserProfile.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"admin",1)

	If $str_postion =0 Then
		If StringInStr($contentArr[$i],"cshsvc",1) = 0 Then
		_ArrayAdd($tempContentArr,$contentArr[$i])
		EndIf
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
	_FileWriteLog($Log_path, "Over write the file of  UserProfile.txt: " & $tempContentArr[$i])
Next

$adCN.Close
$adoRecordSet.Close
$adoRecordSet2.Close

MsgBox(1,1,"operation finished")