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
Global $count

If StringInStr(@ScriptDir, ' ') Then
	msgbox(0, 'error', "The application path has black space, please change it and try again." &@CRLF & @ScriptDir)
	Exit
EndIf

Local $hGUI = GUICreate("Install integration", 400, 400)
GUICtrlCreateLabel("Select option to install integration package...", 30, 10)
GUICtrlCreateLabel("By Ralf Wang", 310, 380)
Local $iOKButton = GUICtrlCreateButton("OK", 300, 350, 60)
Local $iLOGButton = GUICtrlCreateButton("Log", 200, 350, 60)
Local $iInputBox = GUICtrlCreateInput("", 30, 140, 340,200, $ES_MULTILINE + $WS_HSCROLL + $WS_VSCROLL)
;~ $mylist = GUICtrlCreateList("", 30, 140, 340,200)
$progressbar1 = GUICtrlCreateProgress(30, 100, 340, 20, $PBS_SMOOTH)
GUICtrlSetColor(-1, 32250); not working with Windows XP Style

$ichk_ris = GUICtrlCreateCheckbox("To RIS", 30, 40, 90, 50)
$ichk_local = GUICtrlCreateCheckbox("To Local", 200, 40, 90, 50)

GUISetState(@SW_SHOW, $hGUI)

Local $iMsg = 0
While 1
    $iMsg = GUIGetMsg()
	GUICtrlSetState($ichk_ris, $GUI_ENABLE)
	GUICtrlSetState($ichk_local, $GUI_ENABLE)
	GUICtrlSetState($iOKButton, $GUI_ENABLE)
	GUICtrlSetState($iLOGButton, $GUI_ENABLE)
	GUICtrlSetState($iInputBox, $GUI_ENABLE)
	Switch $iMsg
		Case $iOKButton
			$count=0
			$stats_ris = BitAND(GUICtrlRead($ichk_ris), $GUI_CHECKED) = $GUI_CHECKED
			$stats_local = BitAND(GUICtrlRead($ichk_local), $GUI_CHECKED) = $GUI_CHECKED
			GUICtrlSetState($ichk_ris, $GUI_DISABLE)
			GUICtrlSetState($ichk_local, $GUI_DISABLE)
			GUICtrlSetState($iOKButton, $GUI_DISABLE)
			GUICtrlSetState($iLOGButton, $GUI_DISABLE)
			GUICtrlSetState($iInputBox, $GUI_DISABLE)

			If $stats_ris == $stats_local Then
				MsgBox(1,1, "please select ris or local to install....")
				GUICtrlSetState($ichk_ris, $GUI_ENABLE)
				GUICtrlSetState($ichk_local, $GUI_ENABLE)
				GUICtrlSetState($iOKButton, $GUI_ENABLE)
				GUICtrlSetState($iLOGButton, $GUI_ENABLE)
				GUICtrlSetState($iInputBox, $GUI_ENABLE)
				ContinueCase
			Else

				If $stats_ris Then
					Install("ris")
				EndIf

				If $stats_local Then
					Install("local")
				EndIf

				Local $stext = view_log()
				GUICtrlSetData($iInputBox, $stext)
				MsgBox(1, "Notice", "Install work has finished...")
				GUICtrlSetState($iOKButton, $GUI_HIDE)

;~ 				ExitLoop
			EndIf

		Case $ichk_ris
			If _IsChecked($ichk_ris) Then
				GUICtrlSetState($ichk_local, $GUI_UNCHECKED)
			EndIf

		Case $ichk_local
			If _IsChecked($ichk_local) Then
				GUICtrlSetState($ichk_ris, $GUI_UNCHECKED)
			EndIf

		Case $iLOGButton
			Local $stext = view_log()
			GUICtrlSetData($iInputBox, $stext)

        Case $GUI_EVENT_CLOSE

            ExitLoop
	EndSwitch
	Sleep(50)
WEnd

GUIDelete($hGUI)



Func _IsChecked($iControlID)
	Return BitAND(GUICtrlRead($iControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func view_log()
	Local $PID = FileOpen(@ScriptDir & "\log.txt")
	Local $slog_context = FileRead($PID)
	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		FileClose($PID)
		Exit
	EndIf
	If @error = 4 Then
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		FileClose($PID)
		Exit
	EndIf
	FileClose($PID)
	Return $slog_context
EndFunc

Func Install($sFlag)
	If FileExists(@ScriptDir &"\log.txt") Then
		FileDelete(@ScriptDir &"\log.txt")
	EndIf
	_FileWriteLog(@ScriptDir &"\log.txt", "***********************************************Start****************************************************")
	ExecSQL($sFlag)
	GUICtrlSetData($progressbar1, $count)
	$count = 25

	ChangeConfigFile()
	GUICtrlSetData($progressbar1, $count)
	$count = 50

	ChangeFilePrivllige()
	GUICtrlSetData($progressbar1, $count)
	$count = 75

	Add_application()
	$count = 100
	GUICtrlSetData($progressbar1, $count)

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
		GUICtrlSetData($progressbar1, $count)
		$count += 1
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
			GUICtrlSetData($progressbar1, $count)
			$count += 1
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
			GUICtrlSetData($progressbar1, $count)
			$count += 1
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
			GUICtrlSetData($progressbar1, $count)
			$count += 1
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
			GUICtrlSetData($progressbar1, $count)
			$count += 1
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
		GUICtrlSetData($progressbar1, $count)
		$count += 1

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
		GUICtrlSetData($progressbar1, $count)
		$count += 1
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
		GUICtrlSetData($progressbar1, $count)
		$count += 1
	Next

EndFunc