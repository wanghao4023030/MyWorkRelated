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
$constrim="DRIVER={SQL Server};SERVER=localhost\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
$adCN.Open ($constrim) ; <== Connect with required credentials
$DateTime = _DateAdd('h', -1, _NowCalc())


if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!")
	EndIf

while True

$SQL_queryDB = "select AccessionNumber from wggc.dbo.AFP_FilmInfo (Nolock) where CreatedTime >'"&$DateTime&"' and  FilmFlag = 0"
$adoRecordSet = ObjCreate("ADODB.RecordSet")
$adoRecordSet.Open($SQL_queryDB,$adCN)

	While $adoRecordSet.EOF <> True
		$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
		$Accn = $adoRecordSet.Fields("AccessionNumber").Value
		$sql = "update wggc.dbo.AFP_FilmInfo set FilmFlag =1 where AccessionNumber ='"&$Accn&"'"
		$adoRecordSet2.Open($sql,$adCN)
		Sleep(20*1000)
		$adoRecordSet.MoveNext
	WEnd
	Sleep(120*1000)
WEnd


