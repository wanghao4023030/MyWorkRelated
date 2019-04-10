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
$adCN.Open ($constrim) ; <== Connect with required credentials
$adoRecordSet = ObjCreate("ADODB.RecordSet")
$adoRecordSet2 = ObjCreate("ADODB.RecordSet")

$SQL_queryDB = "select name from sys.sysdatabases where filename not like '%Microsoft%'"
$SQL = "use OCRConfigDB  select name from sys.tables "


if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!")
	EndIf



$adoRecordSet.Open($SQL_queryDB,$adCN)
While $adoRecordSet.EOF <> True
	;MsgBox (1,1,$adoRecordSet.Fields("name").Value)
	$DBName = $adoRecordSet.Fields("name").Value
	$ExportPath =  $ScriptfilePath & $DBName
	;MsgBox(1,1,$ExportPath)
	if (FileExists ( $ExportPath )) Then

	Else
		DirCreate($ExportPath)
		;MsgBox(1,1,$DBName,3)
	EndIf

	$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
	$Table_SQL = "Use " &$DBName& "    select name from sys.tables"
	$adoRecordSet2.Open($Table_SQL,$adCN)
	;MsgBox(1,1,$adoRecordSet2.EOF)
	While $adoRecordSet2.EOF <> True
		Local $TableName = $adoRecordSet2.Fields("name").Value
		Local $BCP_statement = "bcp " & $DBName&".dbo."&$TableName& " out "&$ExportPath&"\"&$TableName&".txt -c -T -S localhost\GCPACSWS -U sa -P sa20021224$"
		;MsgBox(1,1,$BCP_statement)
		RunWait (@ComSpec & " /c " & $BCP_statement)
		$adoRecordSet2.MoveNext
	WEnd


 	$adoRecordSet.MoveNext

; For printerReg table
;~ $Filepath_PrinterReg = $ExportPath&"\"&"PrinterReg.txt"

;~ $fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
;~ local $contentArr = FileReadToArray($Filepath_PrinterReg)
;~ FileClose($fhandle)
;~ _ArrayDelete($contentArr,0)
;~ $fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
;~ For $i = 0 To UBound($contentArr) - 1
;~ 	FileWriteLine($fhandle,$contentArr[$i])
;~ Next


Local $tempContentArr[0]
$Filepath_PrinterReg = $ExportPath&"\"&"PrinterReg.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"SIMPRINTER",1)
	If $str_postion =0 Then
		_ArrayAdd($tempContentArr,$contentArr[$i])
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
Next




Local $tempContentArr[0]
$Filepath_PrinterReg = $ExportPath&"\"&"Users.txt"

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
Next




Local $tempContentArr[0]
$Filepath_PrinterReg = $ExportPath&"\"&"UserProfile.txt"

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
Next



Local $tempContentArr[0]
$Filepath_PrinterReg = $ExportPath&"\"&"NetAE.txt"

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
Next


Local $tempContentArr[0]
$Filepath_PrinterReg = $ExportPath&"\"&"AFP_Department.txt"

$fhandle = FileOpen($Filepath_PrinterReg,$FO_READ)
$contentArr = FileReadToArray($Filepath_PrinterReg)
FileClose($fhandle)

For $i = 0 To UBound($contentArr) - 1
	local $str_postion
	$str_postion = StringInStr($contentArr[$i],"∑≈…‰ø∆",1)

	If $str_postion =0 Then
				_ArrayAdd($tempContentArr,$contentArr[$i])
	EndIf
Next

$fhandle = FileOpen($Filepath_PrinterReg, $FO_OVERWRITE )
For $i = 0 To UBound($tempContentArr) - 1
	FileWriteLine($fhandle,$tempContentArr[$i])
Next

Wend



$adCN.Close
;~ $adoRecordSet.Close
;~ $adoRecordSet2.Close






MsgBox(1,1,"operation finished")