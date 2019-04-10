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
$adCN.Open ($constrim) ; <== Connect with required credentials
$adoRecordSet = ObjCreate("ADODB.RecordSet")
$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
$adoRecordSet3 = ObjCreate("ADODB.RecordSet")
$adoRecordSet4 = ObjCreate("ADODB.RecordSet")
$Log_path = @ScriptDir & "\import_log.txt"

;~ Delete the log file if exist
If FileExists($Log_path) Then
	FileDelete($Log_path)
EndIf

_FileWriteLog($Log_path, "Start to import the data....")

$SQL_queryDB = "select name from sys.sysdatabases where filename not like '%Microsoft%'"
$SQL = "use OCRConfigDB  select name from sys.tables "


if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database,please run the application in PS server.")
		_FileWriteLog($Log_path, "Failed to connect to the database,please run the application in PS server.")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!")
		_FileWriteLog($Log_path, "Connection to database successful!")
	EndIf

$adoRecordSet.Open($SQL_queryDB,$adCN)

$Delete_sql =  "use wggc delete from wggc.dbo.NetAE where NetAEName not in ('MainServer', 'LOCALAPP', 'SIMPRINTER')"
$adCN.execute($Delete_sql)
_FileWriteLog($Log_path, "Delete data of wggc.dbo.NetAE")

$Delete_sql =  "use WGGC delete from wggc.dbo.AFP_Department where ID not in (select distinct DepartmentID from wggc.dbo.AFP_FilmInfo)"
$adCN.execute($Delete_sql)
_FileWriteLog($Log_path, "Delete data of wggc.dbo.AFP_Department")

$Delete_sql = "use WGGC delete from wggc.dbo.Users where UserID not in ('Admin', 'cshsvc')"
$adCN.execute($Delete_sql)
_FileWriteLog($Log_path, "Delete data of  wggc.dbo.Users")

$Delete_sql = "use WGGC delete from wggc.dbo.UserProfile where UserName not in ('admin', 'cshsvc')"
$adCN.execute($Delete_sql)
_FileWriteLog($Log_path, "Delete data of  wggc.dbo.UserProfile")

While $adoRecordSet.EOF <> True
	;MsgBox (1,1,$adoRecordSet.Fields("name").Value)
	$DBName = $adoRecordSet.Fields("name").Value
	$ExportPath =  $ScriptfilePath & $DBName
	if (FileExists ( $ExportPath )) Then

	Else
		DirCreate($ExportPath)
		MsgBox(1,1,$DBName,10)
	EndIf
	$adoRecordSet2 = ObjCreate("ADODB.RecordSet")
	$Table_SQL = "Use " &$DBName& "    select name from sys.tables"
	$adoRecordSet2.Open($Table_SQL,$adCN)
	While $adoRecordSet2.EOF <> True
		Local $TableName = $adoRecordSet2.Fields("name").Value
		Local $BCP_statement = "bcp " & $DBName&".dbo."&$TableName& " IN "&$ExportPath&"\"&$TableName&".txt -e "&$ScriptfilePath&"ImportErroLog.log -c -T -S localhost\GCPACSWS -U sa -P sa20021224$"
		_FileWriteLog($Log_path, "Execute the BCP command: " & $BCP_statement)
		;MsgBox(1,1,$BCP_statement)
;~ 		RunWait (@ComSpec & " /c " & $BCP_statement)
		local $PID = Run(@ComSpec & " /c " & $BCP_statement,"", @SW_HIDE, $STDERR_MERGED)
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog($Log_path, "Execute command result: " & $sOutput)

		$adoRecordSet2.MoveNext
	WEnd


 	$adoRecordSet.MoveNext
Wend

Sleep(60000)


Dim $QuerySQL
$QuerySQL = "use wggc select NetAEName,NetAEDBID from wggc.dbo.NetAE"

$adoRecordSet3.Open($QuerySQL,$adCN)

While $adoRecordSet3.EOF <> True
	Local $Net_NetAEName,$Net_NetAEDBID
	$Net_NetAEName = $adoRecordSet3.Fields("NetAEName").Value
	$Net_NetAEDBID = $adoRecordSet3.Fields("NetAEDBID").Value

	Local $UpdateSQL = "use wggc update wggc.dbo.PrinterReg set NetAEConfigDBID = '"&$Net_NetAEDBID&"' where PrinterName ='"&$Net_NetAEName&"'"

	$adoRecordSet4.Open($UpdateSQL,$adCN)
 	$adoRecordSet3.MoveNext
Wend

$adCN.Close
$adoRecordSet.Close()
$adoRecordSet2.Close()
$adoRecordSet3.Close()
$adoRecordSet4.Close()


MsgBox(0, "Finish", "Operation Finished!")