#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:  Ralf>wang
 Goal: automation the integration package

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <ListBoxConstants.au3>
#include <ProgressConstants.au3>

;Process bar variable.
If $CmdLine[0] > 0 Then
	Install($CmdLine[1])

Else
	Install('local')
EndIf




Func Install($sFlag)
	If FileExists(@ScriptDir &"\log.txt") Then
		FileDelete(@ScriptDir &"\log.txt")
	EndIf

	_FileWriteLog(@ScriptDir &"\log.txt", "***********************************************Start****************************************************")
	_FileWriteLog(@ScriptDir &"\log.txt", "Try to install integration to " & $sFlag)
	ExecSQL($sFlag)

	ChangeConfigFile()

	ChangeFilePrivllige()

	Add_application()

	_FileWriteLog(@ScriptDir &"\log.txt", "***********************************************Stop****************************************************")
EndFunc


#cs ----------------------------------------------------------------------------

Execute the folder in script path;
para:
	$flag: string parameter: "ris" or "local"

#ce ----------------------------------------------------------------------------
Func ExecSQL($flag)

	If(StringLower($flag) <> "local" and StringLower($flag) <> "ris" ) Then
		MsgBox(3,"error", "Cannot execute the SQL to connect RIS or local, please check the select options...")
		Exit
	EndIf

	; Query all sql file and add to array
	; Execute all sql with sqlcmd
	Local $aSqlFileList = _FileListToArray(@ScriptDir & "\SQLScript", "*", 1)
	_FileWriteLog(@ScriptDir &"\log.txt", "Execute Common SQL script")
	For $i = 1 to $aSqlFileList[0]
		$sSqlPath = @ScriptDir & "\SQLScript\" & $aSqlFileList[$i]
		_FileWriteLog(@ScriptDir &"\log.txt", "Execute SQL - " & $sSqlPath )

		local $PID = Run(@ComSpec & " /c " & 'sqlcmd -E -S localhost\gcpacsws -i ' & $sSqlPath, "", @SW_HIDE, $STDERR_MERGED)
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
		Sleep(1000 * 1)
	Next

	;Execute the SQl file to connect the RIS
	If(StringLower($flag) == "ris") Then
		Local $aSqlFileList = _FileListToArray(@ScriptDir & "\SQLScript\ris", "*", 1)

		_FileWriteLog(@ScriptDir &"\log.txt", "Execute SQL to connect RIS")

		For $i = 1 to $aSqlFileList[0]
			$sSqlPath = @ScriptDir & "\SQLScript\ris\" & $aSqlFileList[$i]
			_FileWriteLog(@ScriptDir &"\log.txt", "Execute SQL - " & $sSqlPath )

			local $PID = Run(@ComSpec & " /c " & 'sqlcmd -E -S localhost\gcpacsws -i ' & $sSqlPath, "", @SW_HIDE,  $STDERR_MERGED)
			ProcessWaitClose($PID)
			Local $sOutput = StdoutRead($PID,1, True )
			$sOutput = BinaryToString($sOutput)
			_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
			Sleep(1000 * 1)
		Next

	EndIf

	;Execute the SQl file to connect the RIS
	If(StringLower($flag) == "local") Then
		Local $aSqlFileList = _FileListToArray(@ScriptDir & "\SQLScript\local", "*", 1)
		_FileWriteLog(@ScriptDir &"\log.txt", "Execute SQl to connect local database")

		For $i = 1 to $aSqlFileList[0]
			$sSqlPath = @ScriptDir & "\SQLScript\local\" & $aSqlFileList[$i]
			_FileWriteLog(@ScriptDir &"\log.txt", "Execute SQL - " & $sSqlPath )

			local $PID = Run(@ComSpec & " /c " & 'sqlcmd -E -S localhost\gcpacsws -i ' & $sSqlPath, "", @SW_HIDE,  $STDERR_MERGED)
			ProcessWaitClose($PID)
			Local $sOutput = StdoutRead($PID,1, True )
			$sOutput = BinaryToString($sOutput)
			_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
			Sleep(1000 * 1)
		Next

	EndIf

EndFunc


Func Add_application()

	$sWorkFolder = @ScriptDir & "\"
	$sIntegrationXML = "KIOSK.Integration.config"

	; List all the folders in current directory using the folder parameters 2.
	Local $aFileList = _FileListToArray(@ScriptDir, "KIOSK.Integration*",2)
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		Exit
	EndIf
	If @error = 4 Then
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		Exit
	EndIf

	; Get the current app pool list
	$scmd_line_listPool = '%systemroot%\system32\inetsrv\appcmd list apppool '
	$PID = Run(@ComSpec & " /c " & $scmd_line_listPool, "", @SW_HIDE, $STDERR_MERGED)
	ProcessWaitClose($PID)
	Local $sApp_pool_list = StdoutRead($PID,1, True )
	$sApp_pool_list = BinaryToString($sApp_pool_list)
;~ 	_FileWriteLog(@ScriptDir &"\log.txt", "List the application pool: " & @CRLF & $sApp_pool_list)

	; Get the current app list
	$scmd_line_listapp = '%systemroot%\system32\inetsrv\appcmd list app '
	$PID = Run(@ComSpec & " /c " & $scmd_line_listapp, "", @SW_HIDE, $STDERR_MERGED)
	ProcessWaitClose($PID)
	Local $sApp_list = StdoutRead($PID,1, True )
	$sApp_list = BinaryToString($sApp_list)
;~ 	_FileWriteLog(@ScriptDir &"\log.txt", "List the application: "& @CRLF &$sApp_list)


	; delete app pool and web site
	_FileWriteLog(@ScriptDir &"\log.txt", " delete app pool and web site if exist.")
	For $i = 1 to $aFileList[0]
		; if the app exists in the system, delete it.
		If StringInStr($sApp_list, $aFileList[$i]) Then
			$sCmd_line_apppool = '%systemroot%\system32\inetsrv\appcmd delete app "Default Web Site/' & $aFileList[$i]
			_FileWriteLog(@ScriptDir &"\log.txt", $sCmd_line_apppool)
			$PID = Run(@ComSpec & " /c " & $sCmd_line_apppool, "", @SW_HIDE, $STDERR_MERGED )
			ProcessWaitClose($PID)
			Local $sOutput = StdoutRead($PID,1, True )
			$sOutput = BinaryToString($sOutput)
			_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
			Sleep(1000 * 1)
		EndIf

		; if the app pool exists in the system, delete it.
		If StringInStr($sApp_pool_list, $aFileList[$i]) Then
			$sCmd_line_apppool = '%systemroot%\system32\inetsrv\appcmd delete apppool ' & $aFileList[$i]
			_FileWriteLog(@ScriptDir &"\log.txt", $sCmd_line_apppool)
			$PID = Run(@ComSpec & " /c " & $sCmd_line_apppool, "", @SW_HIDE, $STDERR_MERGED )
			ProcessWaitClose($PID)
			Local $sOutput = StdoutRead($PID,1, True )
			$sOutput = BinaryToString($sOutput)
			_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
			Sleep(1000 * 1)
		EndIf
	Next


	; Add app pool and web site
	_FileWriteLog(@ScriptDir &"\log.txt", "Add app pool and web site")
	For $i = 1 to $aFileList[0]
		$scmd_line_addPool = '%systemroot%\system32\inetsrv\appcmd add apppool /name:' & $aFileList[$i] & ' /managedRuntimeVersion:"v4.0"'
		local $PID = Run(@ComSpec & " /c " & $scmd_line_addPool, "", @SW_HIDE, $STDERR_MERGED )
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)

		_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
		Sleep(1000 * 1)

		$sCmd_line_site = '%systemroot%\system32\inetsrv\appcmd add app /site.name:"Default Web Site" /path:"/' & $aFileList[$i] & '" /physicalpath:' &  @ScriptDir & "\" & $aFileList[$i] & '\KIOSK.Integration.WSProxy '
		_FileWriteLog(@ScriptDir &"\log.txt", $sCmd_line_site)
		$PID = Run(@ComSpec & " /c " & $sCmd_line_site, "", @SW_HIDE, $STDERR_MERGED )
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		Sleep(1000 * 1)

		$sCmd_line_apppool = '%systemroot%\system32\inetsrv\appcmd set app "Default Web Site/' & $aFileList[$i] & '" /applicationpool:' & $aFileList[$i]
		_FileWriteLog(@ScriptDir &"\log.txt", $sCmd_line_apppool)
		$PID = Run(@ComSpec & " /c " & $sCmd_line_apppool, "", @SW_HIDE, $STDERR_MERGED )
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		Sleep(1000 * 1)
	Next

EndFunc



; Change the value of KIOSK.Integration.config file in each integration folder
Func ChangeConfigFile()

	DirCopy(@ScriptDir & "\Package" , @ScriptDir & "\",$FC_OVERWRITE)

	$sWorkFolder = @ScriptDir & "\"
	$sIntegrationXML = "KIOSK.Integration.config"

	; List all the folders in current directory using the folder parameters 2.
	Local $aFileList = _FileListToArray(@ScriptDir, "KIOSK.Integration*",2)
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		Exit
	EndIf
	If @error = 4 Then
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		Exit
	EndIf

	; Give everyone user all rights to folders and files
	_FileWriteLog(@ScriptDir &"\log.txt", "Give everyone user all rights to folders and files.")
	For $i = 1 to $aFileList[0]

		;Replease the default path to current path of configuration file "KIOSK.Integration.config"
		$sFilePath = @ScriptDir & "\" & $aFileList[$i] & "\" & $sIntegrationXML
		$find = "E:\" & $aFileList[$i]
		$replace = @ScriptDir & "\" & $aFileList[$i]
		Local $retval = _ReplaceStringInFile($sFilePath, $find, $replace, $STR_NOCASESENSE ,1)
		If $retval = -1 Then
			MsgBox($MB_SYSTEMMODAL, "ERROR", "The pattern could not be replaced in file: " & $sFilePath & " Error: " & @error)
		EndIf
	Next

EndFunc


Func ChangeFilePrivllige()


	$sWorkFolder = @ScriptDir & "\"
	$sIntegrationXML = "KIOSK.Integration.config"

	; List all the folders in current directory using the folder parameters 2.
	Local $aFileList = _FileListToArray(@ScriptDir, "KIOSK.Integration*",2)
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		Exit
	EndIf
	If @error = 4 Then
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		Exit
	EndIf

	; Give everyone user all rights to folders and files
	_FileWriteLog(@ScriptDir &"\log.txt", "Give everyone user all rights to folders and files.")
	For $i = 1 to $aFileList[0]

;~ 		$scmd = 'icacls ' & @ScriptDir & "\" & $aFileList[$i] & ' /grant Everyone:(OI)(CI)F /T'
		$scmd = 'icacls ' & @ScriptDir & "\" & ' /grant Everyone:(OI)(CI)F /T'
		local $PID = Run(@ComSpec & " /c " & $scmd, "", @SW_HIDE,  $STDERR_MERGED )
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog(@ScriptDir &"\log.txt", $sOutput)
		Sleep(1000 * 1)
	Next

EndFunc