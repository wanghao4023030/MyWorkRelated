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
Dim $DBName
$ScriptfilePath = @ScriptDir & "\"

;******************************
; connect Database
;******************************
$constrim="DRIVER={SQL Server};SERVER=localhost\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
$adCN.ConnectionTimeout=6000
$adCN.Open ($constrim) ; <== Connect with required credentials
$adoRecordSet = ObjCreate("ADODB.RecordSet")
$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
$adoRecordSet3 = ObjCreate("ADODB.RecordSet")
$adoRecordSet4 = ObjCreate("ADODB.RecordSet")




if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!")
	EndIf

Local $KioksVersion = InputBox("Question", "What version do you want to archived?", "Flage eg£ºB16P08", "")
$ExportPath =  $ScriptfilePath & $KioksVersion &".txt"

If (FileExists ( $ExportPath )) Then
		FileDelete($ExportPath)
		_FileCreate($ExportPath)
		MsgBox(1,1,$ExportPath,3)

Else
		_FileCreate($ExportPath)
		MsgBox(1,1,$ExportPath,3)
EndIf
$sfilehandle =  FileOpen($ExportPath,$FO_OVERWRITE)


$SQL_queryDB = "use master select name from sysdatabases where filename not like '%Microsoft%' order by name"
$adoRecordSet.Open($SQL_queryDB,$adCN)
While $adoRecordSet.EOF <> True

	$DBName = $adoRecordSet.Fields("name").Value
;~ 	MsgBox(1,1,$DBName)
	$Table_SQL = "Use " &$DBName& "    select name from sys.tables order by name"
	$adoRecordSet2.Open($Table_SQL,$adCN)

	While $adoRecordSet2.EOF <> True
		$TableName = $adoRecordSet2.Fields("name").Value
;~ 		MsgBox(1,1,$TableName)
		FileWrite($sfilehandle,$DBName&"."&$TableName&":"&@TAB)

		; Get clomun count
		$cloumn_statement = "use "&$DBName&"  select count(*) as count from "&$TableName
;~ 		MsgBox(1,1,$cloumn_statement)
		$adoRecordSet3.Open($cloumn_statement,$adCN)
		While $adoRecordSet3.EOF <> True
			Local $name =  $adoRecordSet3.Fields("count").Value
;~ 			MsgBox(1,1,$name)
			FileWrite($sfilehandle,$name&@CRLF)
			$adoRecordSet3.MoveNext
		WEnd
		$adoRecordSet3.close

		$adoRecordSet2.MoveNext

	WEnd

	$adoRecordSet2.close
	$adoRecordSet.MoveNext
WEnd


$adoRecordSet.close



$SQL_queryDB = "use master select name from sysdatabases where filename not like '%Microsoft%' order by name"
$adoRecordSet.Open($SQL_queryDB,$adCN)
While $adoRecordSet.EOF <> True

	$DBName = $adoRecordSet.Fields("name").Value
;~ 	MsgBox(1,1,$DBName)
	$Table_SQL = "Use " &$DBName& "    select  name from sys.views order by name"
	$adoRecordSet2.Open($Table_SQL,$adCN)

	While $adoRecordSet2.EOF <> True
		$TableName = $adoRecordSet2.Fields("name").Value
;~ 		MsgBox(1,1,$TableName)
		FileWrite($sfilehandle,$DBName&"."&$TableName&":"&@TAB)

		; Get clomun count
		$cloumn_statement = "use "&$DBName&"  select count(*) as count from "&$TableName
;~ 		MsgBox(1,1,$cloumn_statement)
		$adoRecordSet3.Open($cloumn_statement,$adCN)
		While $adoRecordSet3.EOF <> True
			Local $name =  $adoRecordSet3.Fields("count").Value
;~ 			MsgBox(1,1,$name)
			FileWrite($sfilehandle,$name&@CRLF)
			$adoRecordSet3.MoveNext
		WEnd
		$adoRecordSet3.close

		$adoRecordSet2.MoveNext

	WEnd

	$adoRecordSet2.close
	$adoRecordSet.MoveNext
WEnd


$adoRecordSet.close

FileClose($sfilehandle)

$adCN.Close


MsgBox(1,1,"operation finished")