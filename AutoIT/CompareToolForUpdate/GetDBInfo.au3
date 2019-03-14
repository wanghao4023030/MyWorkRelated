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


;~ $SQL_queryDB = "use master select name from sysdatabases where filename not like '%Microsoft%' order by name"
$SQL_queryDB = "use master select name from sysdatabases where filename not like '%Microsoft%' order by name"
$adoRecordSet.Open($SQL_queryDB,$adCN)
While $adoRecordSet.EOF <> True

	$DBName = $adoRecordSet.Fields("name").Value

	$Table_SQL = "Use " &$DBName& "    select name from sys.tables  order by name"
	$adoRecordSet2.Open($Table_SQL,$adCN)

	While $adoRecordSet2.EOF <> True
		$TableName = $adoRecordSet2.Fields("name").Value

		FileWrite($sfilehandle,$DBName&"."&$TableName&":"&@TAB)

		; Get clomun count
		$cloumn_statement = "use "&$DBName&"  select count(name) as count from syscolumns where id = OBJECT_ID(N'"&$TableName&"') "
		$adoRecordSet3.Open($cloumn_statement,$adCN)
		While $adoRecordSet3.EOF <> True
			Local $name =  $adoRecordSet3.Fields("count").Value
			FileWrite($sfilehandle,$name&@TAB)
			$adoRecordSet3.MoveNext
		WEnd
		$adoRecordSet3.close

	; Get clomun name

		$cloumn_statement = "use "&$DBName&"  select name,xtype,prec from syscolumns where id = OBJECT_ID(N'"&$TableName&"') order by name"
		$adoRecordSet3.Open($cloumn_statement,$adCN)

		$cloumn_statement2 = "use "&$DBName&"  select DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'"&$TableName&"' order by COLUMN_NAME"
		$adoRecordSet4.Open($cloumn_statement2,$adCN)

		While $adoRecordSet3.EOF <> True and $adoRecordSet4.EOF <> True
			Local $name =  $adoRecordSet3.Fields("name").Value
			Local $xtype =  $adoRecordSet4.Fields("DATA_TYPE").Value
			Local $length =  $adoRecordSet3.Fields("prec").Value
			FileWrite($sfilehandle,$name&"_"&$xtype&"_"&$length&"|")
			$adoRecordSet3.MoveNext
			$adoRecordSet4.MoveNext
		WEnd
		FileWrite($sfilehandle,@CRLF)
		$adoRecordSet3.close
		$adoRecordSet4.close
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
	$Object_SQL = "Use " &$DBName& "    select name,xtype from  sysobjects where xtype in ('F','FN','K','P','R','RF','TF','TR','V','X','RF') order by  xtype,name "
	$adoRecordSet2.Open($Object_SQL,$adCN)
	While $adoRecordSet2.EOF <> True
		$objectName = $adoRecordSet2.Fields("name").Value
		$objectxtype = $adoRecordSet2.Fields("xtype").Value
		FileWriteLine($sfilehandle,$DBName&":"&$objectxtype&"(type): "&$objectName)
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
	$Object_SQL = "Use " &$DBName& "    select name from sys.tables  order by name"
	$adoRecordSet2.Open($Object_SQL,$adCN)
	While $adoRecordSet2.EOF <> True
		$TableName = $adoRecordSet2.Fields("name").Value
		FileWrite($sfilehandle,"index of table: "&$TableName&" : ")

		$cloumn_statement = "use "&$DBName&"  select object_id,name from sys.indexes where type_desc <> 'HEAP' and object_id >100 and object_id = object_id('"&$TableName&"') order by name "
		$adoRecordSet3.Open($cloumn_statement,$adCN)

		While $adoRecordSet3.EOF <> True
			$IndexName = $adoRecordSet3.Fields("name").Value
;~ 			msgbox(1,1,$IndexName)
			FileWrite($sfilehandle,$IndexName&"_")
			$adoRecordSet3.MoveNext
		Wend
		$adoRecordSet2.MoveNext
		$adoRecordSet3.close
		FileWrite($sfilehandle,@CRLF)
	WEnd
	$adoRecordSet2.close
	$adoRecordSet.MoveNext
WEnd

$adoRecordSet.close

FileClose($sfilehandle)

$adCN.Close


MsgBox(1,1,"operation finished")