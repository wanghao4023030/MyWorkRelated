#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <FileConstants.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <StringConstants.au3>
#include <Constants.au3>
#include "hello.au3"


Global $oDict
Global $sFolderPath
Global $sIntegrationPath
Global $sIntegrationOption
Global $sLogPath = @ScriptDir & "\log.txt"
Global $sDBInstallAppPath
Global $sSQLPath
Global $sCreateFilmDataPath
Global $sFilmsCount
Global $sReportDataPath
Global $sReportDestPath
Global $sReconlicationReportPath
Global $sReconlicationReportDestPath
Global $sReconlicationReportResultPath



If FileExists($sLogPath) Then
	FileDelete($sLogPath)
EndIf

_FileWriteLog($sLogPath, "***********************************************Start prepared the peformance environment....*********************************************")

$oDict = ObjCreate("Scripting.Dictionary")

;Get the para from parameter.txt and orginazie to dictionary.
ParaParse()

;~ ; Set the paramter from the parameter.txt files.
SetParam()

;~ ;Copy the related files from the file server
;~ CopySourceFiles()

;~ Dim the global the parameters.
Global $sIntegrationFullPath = $sIntegrationPath &"\Integration"
Global $sSourFolder = @ScriptDir &"\Integration"

;~ Start install the integration application and service
;~ Intergration_Install()

;~ Import the history databadatabase
;~ DB_Import()
;~ DB_Restart()

;~ Execute the extended script
;~ SQL_Execute()
;~ DB_Restart()

;~ Create the film print data
;~ CreateFilms_ExecApp($sFilmsCount)

;~ CreateReport_CopyTestData()

Reconlication_CreateReport(10)



;Phase the parameter.txt file and return a dictionary to script.
Func ParaParse()
	$sParameter_file_path = @ScriptDir & "\parameter.txt"

	Local $aArray = 0
	If Not _FileReadToArray($sParameter_file_path, $aArray, 0) Then
		MsgBox($MB_SYSTEMMODAL, "", "There was an error reading the file. @error: " & @error) ; An error occurred reading the current script file.
	EndIf


	If @error Then
		MsgBox(0,'' ,'Error creating the dictionary object')
	Else
		For $i = 0 To UBound($aArray) - 1
			Local $aTempArr = StringSplit($aArray[$i], '=', $STR_NOCOUNT  )
			Local $skey = StringStripWS($aTempArr[0], $STR_STRIPLEADING +  $STR_STRIPTRAILING)
			Local $svalue = StringStripWS($aTempArr[1], $STR_STRIPLEADING +  $STR_STRIPTRAILING)
			$oDict.Add($skey, $svalue)
		Next
	EndIf

EndFunc

Func SetParam()
	If $oDict.Exists('FolderPath')  Then
		$sFolderPath = $oDict.Item('FolderPath')
		_FileWriteLog($sLogPath, "Get the parameter 'FolderPath' successfully")
	Else
		MsgBox(1,"", "Get FolderPath failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'FolderPath' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('IntegrationPath')  Then
		$sIntegrationPath = $oDict.Item('IntegrationPath')
		_FileWriteLog($sLogPath, "Get the parameter 'IntegrationPath' successfully")
	Else
		MsgBox(1,"", "Get IntegrationPath failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'IntegrationPath' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('IntegrationOption')  Then
		$sIntegrationOption = $oDict.Item('IntegrationOption')
		_FileWriteLog($sLogPath, "Get the parameter 'IntegrationOption' successfully")
	Else
		MsgBox(1,"", "Get IntegrationOption failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'IntegrationOption' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('DBInstallAppPath')  Then
		$sDBInstallAppPath = @ScriptDir & "\" & $oDict.Item('DBInstallAppPath') & "\"
		_FileWriteLog($sLogPath, "Get the parameter 'DBInstallAppPath' successfully")
	Else
		MsgBox(1,"", "Get DBInstallAppPath failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'DBInstallAppPath' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('SQLPath')  Then
		$sSQLPath = @ScriptDir & "\" & $oDict.Item('SQLPath') & "\"
		_FileWriteLog($sLogPath, "Get the parameter 'SQLPath' successfully")
	Else
		MsgBox(1,"", "Get SQLPath failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'SQLPath' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('CreateFilmDataPath')  Then
		$sCreateFilmDataPath = @ScriptDir & "\" & $oDict.Item('CreateFilmDataPath') & "\"
		_FileWriteLog($sLogPath, "Get the parameter 'CreateFilmDataPath' successfully")
	Else
		MsgBox(1,"", "Get CreateFilmDataPath failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'CreateFilmDataPath' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('FilmsCount')  Then
		$sFilmsCount = $oDict.Item('FilmsCount')
		_FileWriteLog($sLogPath, "Get the parameter 'FilmsCount' successfully")
	Else
		MsgBox(1,"", "Get FilmsCount failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'FilmsCount' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('ReportDataPath')  Then
		$sReportDataPath = $oDict.Item('ReportDataPath')
		_FileWriteLog($sLogPath, "Get the parameter 'ReportDataPath ' successfully")
	Else
		MsgBox(1,"", "Get ReportDataPath  failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'ReportDataPath ' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('ReportDestPath')  Then
		$sReportDestPath = $oDict.Item('ReportDestPath')
		_FileWriteLog($sLogPath, "Get the parameter 'ReportDestPath  ' successfully")
	Else
		MsgBox(1,"", "Get ReportDestPath   failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'ReportDestPath  ' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('ReconlicationReportPath')  Then
		$sReconlicationReportPath = $oDict.Item('ReconlicationReportPath')
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportPath  ' successfully")
	Else
		MsgBox(1,"", "Get ReconlicationReportPath   failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportPath  ' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

	If $oDict.Exists('ReconlicationReportDestPath')  Then
		$sReconlicationReportDestPath = $oDict.Item('ReconlicationReportDestPath')
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportDestPath  ' successfully")
	Else
		MsgBox(1,"", "Get ReconlicationReportDestPath   failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportDestPath  ' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf


	If $oDict.Exists('ReconlicationReportResultPath')  Then
		$sReconlicationReportResultPath = $oDict.Item('ReconlicationReportResultPath')
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportResultPath  ' successfully")
	Else
		MsgBox(1,"", "Get ReconlicationReportResultPath   failed.")
		_FileWriteLog($sLogPath, "Get the parameter 'ReconlicationReportResultPath  ' failed, please review the parameter.txt and ensure the varable is exist.")
	EndIf

EndFunc

Func CopySourceFiles()

	Local $sReturn = DirCopy($sFolderPath, @ScriptDir &"\", $FC_OVERWRITE)

	If $sReturn Then
		_FileWriteLog($sLogPath, "Copy the folder " & $sFolderPath & " to " &  @ScriptDir & "\" & " successfully." )
		Return True
	Else
		MsgBox(1, "Files Copy", "Copy the files from " &  $sFolderPath & " to " & @ScriptDir &"\" & " failed.")
		_FileWriteLog($sLogPath, "Copy the folder " & $sFolderPath & " to " &  @ScriptDir & "\" & " failed." )
		Exit
		Return False

	EndIf
EndFunc

Func StopServices($sServiceName)

	$scmd = 'sc.exe query ' & $sServiceName
	local $PID = Run(@ComSpec & " /c " & $scmd, "", @SW_HIDE,  $STDERR_MERGED )
	ProcessWaitClose($PID)
	Local $sOutput = StdoutRead($PID,1, True )
	$sOutput = BinaryToString($sOutput)

	_FileWriteLog($sLogPath, "Execute CMD to query the service status.  " & $scmd )
	_FileWriteLog($sLogPath, "result: " & $sOutput )

	If StringInStr($sOutput, "RUNNING") > 0 Then
		Local $sReturn = RunWait(@ComSpec & " /c" & "net stop " & $sServiceName , "", @SW_HIDE)
		_FileWriteLog($sLogPath, "Execute CMD to stop the service.  " & "net stop " & $sServiceName )

		If $sReturn == 0 Then
			_FileWriteLog($sLogPath, "The service is stop. ")
			Return True
		Else
			_FileWriteLog($sLogPath, "The service stop failed. ")
			Return False
		EndIf
	EndIf

	If (StringInStr($sOutput, "STOPPED")) > 0 Then
		_FileWriteLog($sLogPath, "The service is stopped, doesn`t need to execute cmd. ")
;~ 		MsgBox(1, "", "The service has stopped. " & $sServiceName)
		Return True
	EndIf

	If ((StringInStr($sOutput, "STOPPED")) == 0  or StringInStr($sOutput, "RUNNING") = 0) Then
;~ 		MsgBox(1, "", "The service status is abnormal " & $sServiceName & " " & $sOutput)
		_FileWriteLog($sLogPath, "The service is not in running or stopped status, please double check.")
		Return False
	EndIf

EndFunc

Func StartServices($sServiceName)
		$scmd = 'sc.exe query ' & $sServiceName
		local $PID = Run(@ComSpec & " /c " & $scmd, "", @SW_HIDE,  $STDERR_MERGED )
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog($sLogPath, "Execute CMD to query the service status.  " & $scmd )
		_FileWriteLog($sLogPath, "result: " & $sOutput )


		If StringInStr($sOutput, "STOPPED") > 0 Then
			Local $sReturn = RunWait(@ComSpec & " /c" & "net start " & $sServiceName , "", @SW_HIDE)
			_FileWriteLog($sLogPath, "Execute CMD to start the service.  " & "net start " & $sServiceName )

			If $sReturn == 0 Then
				_FileWriteLog($sLogPath, "The service is start. ")
				Return True
			Else
				_FileWriteLog($sLogPath, "The service start failed. ")
				Return False
			EndIf
		EndIf

		If (StringInStr($sOutput, "RUNNING")) > 0 Then
;~ 			MsgBox(1, "", "The service is running " & $sServiceName)
			_FileWriteLog($sLogPath, "The service is running, doesn`t need to execute cmd. ")
			Return True
		EndIf

		If ((StringInStr($sOutput, "STOPPED")) == 0  or StringInStr($sOutput, "RUNNING") = 0) Then
;~ 			MsgBox(1, "", "The service status is abnormal " & $sServiceName & " " & $sOutput)
			_FileWriteLog($sLogPath, "The service is not in running or stopped status, please double check.")
			Return False
		EndIf

EndFunc

;~ *****************************************************************************
;~ Operate the IIS
;~ *****************************************************************************

Func StopIIS()

	$scmd = 'IISRESET /STOP '
	local $PID = Run(@ComSpec & " /c " & $scmd, "", @SW_HIDE,  $STDERR_MERGED )
	ProcessWaitClose($PID)
	Local $sOutput = StdoutRead($PID,1, True )
	$sOutput = BinaryToString($sOutput)
	_FileWriteLog($sLogPath, "Execute CMD to stop IIS service.  " & $scmd )
	_FileWriteLog($sLogPath, "result: " & $sOutput )

	If StringInStr($sOutput, "成功停止") > 0 Then
;~ 		MsgBox(1, "Stop IIS", "IIS stop successfully.")
		_FileWriteLog($sLogPath, "The IIS serivce  stop successfully" )
		Return True
	Else
;~ 		MsgBox(1, "Stop IIS", "IIS stop failed.")
		_FileWriteLog($sLogPath, "The IIS serivce  stop successfully" )
		Return False
	EndIf

EndFunc

Func StartIIS()
	$scmd = 'IISRESET /START '
	local $PID = Run(@ComSpec & " /c " & $scmd, "", @SW_HIDE,  $STDERR_MERGED )
	ProcessWaitClose($PID)
	Local $sOutput = StdoutRead($PID,1, True )
	$sOutput = BinaryToString($sOutput)
	_FileWriteLog($sLogPath, "Execute CMD to start IIS service.  " & $scmd )
	_FileWriteLog($sLogPath, "result: " & $sOutput )

	If StringInStr($sOutput, "成功启动") > 0 Then
		_FileWriteLog($sLogPath, "The IIS serivce start successfully." )
;~ 		MsgBox(1, "Start IIS", "IIS start successfully.")
;~ 		MsgBox(1, "Start IIS", $sOutput)
		Return True
	Else
;~ 		MsgBox(1, "Start IIS", "IIS start Failed.")
		_FileWriteLog($sLogPath, "The IIS serivce start failed" )
		Return False
	EndIf

EndFunc

;~ *************************************************************************
;~ integration related Function
;~ *************************************************************************

Func CopyFiles($sSourFolder, $sIntegrationFullPath)
	; Ensure the integration folder exist or not
	If FileExists($sIntegrationFullPath) Then
		; If exist, delete the folder
		If DirRemove($sIntegrationFullPath, 1) Then
			If (DirCopy($sSourFolder, $sIntegrationFullPath, $FC_OVERWRITE)) <> 1 Then
				MsgBox(1, "", "Copy files from " & $sSourFolder & " to " & $sIntegrationFullPath & "Failed.")
				_FileWriteLog($sLogPath, "Copy files from " & $sSourFolder & " to " & $sIntegrationFullPath & "Failed." )
				Exit
			EndIf
		Else
			MsgBox(1, "", "Delete the folder " & $sIntegrationFullPath & " Failed.")
			_FileWriteLog($sLogPath, "Delete the folder " & $sIntegrationFullPath & " Failed." )
			Exit
		EndIf
	Else
		If (DirCopy($sSourFolder, $sIntegrationFullPath, $FC_OVERWRITE)) <> 1 Then
			MsgBox(1, "", "Copy files from " & $sSourFolder & " to " & $sIntegrationFullPath & " Failed.")
			_FileWriteLog($sLogPath, "Copy files from " & $sSourFolder & " to " & $sIntegrationFullPath & " Failed." )
			Exit
		Else
			_FileWriteLog($sLogPath, "Copy files from " & $sSourFolder & " to " & $sIntegrationFullPath & " successfully." )
		EndIf
	EndIf
EndFunc

Func Intergration_ExecApp($sOption)

	If (ProcessExists("Installintegration.exe")) Then
;~ 		MsgBox(1, "", "The InstallIntegration.exe is running, please close them and Re-run the script.")
		_FileWriteLog($sLogPath, "The InstallIntegration.exe is running, Try to close it.")
		If ProcessClose("Installintegration.exe") Then
			_FileWriteLog($sLogPath, "Close the Installintegration.exe successfully.")
		Else
			MsgBox(1, "", "Close the process Installintegration.exe failed, please close them and Re-run the script.")
			Exit
		EndIf
	EndIf

	RunWait(@ComSpec & " /c" & "Installintegration.exe " & $sOption, $sIntegrationFullPath , @SW_HIDE)
	_FileWriteLog($sLogPath, "execute the integration install application. " & "Installintegration.exe " & $sOption & " From " & $sIntegrationFullPath)
EndFunc

Func Intergration_Install()
	If StopIIS() Then
		CopyFiles($sSourFolder, $sIntegrationFullPath)
		Intergration_ExecApp($sIntegrationOption)
		StartIIS()
		Local $sTemptext = Fileread( $sIntegrationFullPath & "\log.txt")
		_FileWriteLog($sLogPath, $sTemptext)
	Else
		MsgBox(1, "" , "Stop IIS failed. please check the Service. The application will exit.")
		Exit
	EndIf
EndFunc

;~ **********************************************************************************************
;~ DB import or export related Function
;~ **********************************************************************************************
Func DB_Import()
	_FileWriteLog($sLogPath, "****************************Start Database Import*********************************")

	If (ProcessExists("Import.exe")) Then
		MsgBox(1, "", "The Import.exe is running, please close them and Re-run the script.")
		_FileWriteLog($sLogPath, "The Import.exe is running, please close them and Re-run the script.")
		Exit
	EndIf

	_FileWriteLog($sLogPath, "Execute the database import application. " & "Import.exe " & " From " & $sDBInstallAppPath)
	RunWait(@ComSpec & " /c" & "Import.exe ", $sDBInstallAppPath , @SW_HIDE)
	_FileWriteLog($sLogPath, "Finish execute the database import application. " & "Import.exe " & " From " & $sDBInstallAppPath)

	_FileWriteLog($sLogPath, "****************************End Database Import*********************************")
EndFunc


Func DB_Export()
	_FileWriteLog($sLogPath, "****************************Start Database Export*********************************")

	If (ProcessExists("Export.exe")) Then
		MsgBox(1, "", "The Export.exe is running, please close them and Re-run the script.")
		_FileWriteLog($sLogPath, "The Export.exe is running, please close them and Re-run the script.")
		Exit
	EndIf

	_FileWriteLog($sLogPath, "Execute the export application. " & "Export.exe " & " From " & $sDBInstallAppPath)
	RunWait(@ComSpec & " /c" & "Export.exe ", $sDBInstallAppPath , @SW_HIDE)
	_FileWriteLog($sLogPath, "Finish execute the database export application. " & "Export.exe " & " From " & $sDBInstallAppPath)

	_FileWriteLog($sLogPath, "****************************End Database Export*********************************")
EndFunc

Func DB_Restart()
	_FileWriteLog($sLogPath, "****************************Start Restart Database*********************************")

	StopServices("SQLAgent$GCPACSWS")
	Sleep(1000)
	StopServices("MSSQL$GCPACSWS")
	Sleep(1000)
	StartServices("SQLAgent$GCPACSWS")
	Sleep(1000)
;~ 	StartServices("MSSQL$GCPACSWS")
;~ 	Sleep(1000)

	_FileWriteLog($sLogPath, "****************************End Restart Database*********************************")
EndFunc


Func SQL_Execute()
	_FileWriteLog($sLogPath, "****************************Start SQL Script*********************************")
	Local $aFileList = _FileListToArray($sSQLPath, "*.sql", 1, True)
	For $i = 1 to $aFileList[0]

		_FileWriteLog($sLogPath, "Execute SQL - " & $aFileList[$i] )
		local $PID = Run(@ComSpec & " /c " & 'sqlcmd -E -S localhost\gcpacsws -i ' & $aFileList[$i], "", @SW_HIDE, $STDERR_MERGED)
		ProcessWaitClose($PID)
		Local $sOutput = StdoutRead($PID,1, True )
		$sOutput = BinaryToString($sOutput)
		_FileWriteLog($sLogPath, $sOutput)
		Sleep(1000 * 1)
	_FileWriteLog($sLogPath, "****************************End SQL Script*********************************")
	Next
EndFunc




;~ **********************************************************************************************
;~ Create filems data related Function
;~ **********************************************************************************************

Func CreateFilms_ExecApp($sOption)

	_FileWriteLog($sLogPath, "****************************Start Create films image*********************************")
	While ProcessExists("CreateImage.exe")
;~ 		MsgBox(1, "", "The CreateImage.exe is running, please close them and Re-run the script.")
		_FileWriteLog($sLogPath, "The CreateImage.exe is running, try to close it.")

		If ProcessClose("CreateImage.exe") Then
			_FileWriteLog($sLogPath, "Close the CreateImage.exe successfully.")
		Else
			MsgBox(1, "", "Close the process CreateImage.exe failed, please close them and Re-run the script.")
			Exit
		EndIf
	WEnd

	RunWait(@ComSpec & " /c" & "CreateImage.exe " & $sOption, $sCreateFilmDataPath , @SW_HIDE)
	_FileWriteLog($sLogPath, "execute the  application. " & "CreateImage.exe " & $sOption & " From " & $sCreateFilmDataPath)
	Local $sTemptext = Fileread( $sCreateFilmDataPath & "\log.txt")
	_FileWriteLog($sLogPath, $sTemptext)
	_FileWriteLog($sLogPath, "****************************End Create films image*********************************")
EndFunc


;~ Copy the report data files to dest folder.
;~ The loadrunner script will use it to create the paper reports.
Func CreateReport_CopyTestData()

	_FileWriteLog($sLogPath, "****************************Start Copy Report Prepare Test Data*********************************")
	; List all the files and folders in the desktop directory using the default parameters and return the full path.
    Local $aFileList = _FileListToArray($sReportDataPath, "*",2 ,False)
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", $sReportDataPath & " Path was invalid.")
		_FileWriteLog($sLogPath, $sReportDataPath & " Path was invalid." )
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", $sReportDataPath & " No file(s) were found.")
		_FileWriteLog($sLogPath, $sReportDataPath & " No file(s) were found." )
        Exit
    EndIf

;~ 	Copy the folder to dest folder one by one
	For $i = 1 to $aFileList[0] step 1
		Local $sReturn = DirCopy($sReportDataPath , $sReportDestPath, $FC_OVERWRITE)
		If $sReturn Then
			_FileWriteLog($sLogPath, "Copy the folder " & $sReportDataPath & " to " &  $sReportDestPath & " successfully." )
			Return True
		Else
			MsgBox(1, "Files Copy", "Copy the files from " &  $sReportDataPath & " to " & $sReportDestPath & " failed.")
			_FileWriteLog($sLogPath, "Copy the folder " & $sReportDataPath & " to " &  $sReportDestPath & " failed." )
			Exit
			Return False
		EndIf

	Next

	_FileWriteLog($sLogPath, "****************************End Copy Report Prepare Test Data*********************************")

EndFunc



Func Reconlication_CreateReport($iCount)

	_FileWriteLog($sLogPath, "****************************Start Create Report *********************************")
	Local $source = @ScriptDir & "\" & $sReconlicationReportPath
	Local $dest = $sReconlicationReportDestPath

	$constrim="DRIVER={SQL Server};SERVER=localhost\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
	$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
	$adCN.Open ($constrim) ; <== Connect with required credentials
	$adoRecordSet = ObjCreate("ADODB.RecordSet")

	$SQL = "select COUNT(*) as count from wggc.dbo.AFP_ReportInfo where ReportStatus = -1"
	$adoRecordSet.Open($SQL,$adCN)
	Local $startCount = $adoRecordSet.Fields("count").Value

	$adoRecordSet.Close()

	Local $iAllCounts = $startCount + $iCount
	Local $iReportCount = 1

	While($iReportCount <= $iAllCounts)

		FileCopy($source, $dest, $FC_NOOVERWRITE )
		Sleep(5*1000)

		$SQL = "select COUNT(*) as count from wggc.dbo.AFP_ReportInfo where ReportStatus = -1"
		$adoRecordSet.Open($SQL,$adCN)
		$iReportCount = $adoRecordSet.Fields("count").Value
		$adoRecordSet.Close()

	WEnd

	$ExportPath =  @ScriptDir & "\" & $sReconlicationReportResultPath
	If (FileExists ( $ExportPath )) Then
		FileDelete($ExportPath)
	EndIf

	$SQL = "select top " & $iCount & " StudyInstanceUID from wggc.dbo.AFP_ReportInfo where ReportStatus = -1 order by CreatedTime desc"
	$adoRecordSet.Open($SQL,$adCN)
	While $adoRecordSet.EOF <> True
		Local $StudyInstanceUID = $adoRecordSet.Fields("StudyInstanceUID").Value

		If FileWrite($ExportPath, $StudyInstanceUID & @CRLF) Then
			_FileWriteLog($sLogPath, "Write the created records to file successfully.")
		Else
			_FileWriteLog($sLogPath, "Write the created records to file failed. " & $ExportPath & "-" & $StudyInstanceUID)
		EndIf
		$adoRecordSet.MoveNext
	WEnd

	$adCN.Close
	$adoRecordSet.Close()

	_FileWriteLog($sLogPath, "****************************End Create Report *********************************")


EndFunc






















