#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here


#include <Date.au3>
#include <String.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <Array.au3>


$strbatPath = @ScriptDir & "\ModifyAl_ForAutoIt.bat"
$strDestFilePath = @ScriptDir&"\test.bat"
$logPath = @ScriptDir & "\log.txt"
If FileExists($logPath) Then
	FileDelete($logPath)
	_FileWriteLog($logPath, "delete the exist file : " & $logPath)
EndIf

_FileWriteLog($logPath, "****************************** Start Create Film Data ******************************************")


;******************************
; connect Database
;******************************
Global $constrim="DRIVER={SQL Server};SERVER=localhost\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
Global $adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
$adCN.Open ($constrim) ; <== Connect with required credentials
Global $adoRecordSet = ObjCreate("ADODB.RecordSet")

Global $SQL = "select ID from wggc.dbo.AFP_Department"
$adoRecordSet.Open($SQL,$adCN)
_FileWriteLog($logPath, "Use the SQL to filter the current department list: " & @CRLF & $SQL)

$iIndex = 0
Global $aDepartmentArray[0]

While $adoRecordSet.EOF <> True
	_ArrayAdd($aDepartmentArray, $adoRecordSet.Fields("ID").Value)
	_FileWriteLog($logPath, "The departmentID : " & $adoRecordSet.Fields("ID").Value)
	$adoRecordSet.MoveNext
WEnd
$adoRecordSet.close()


$AccFilePath = @ScriptDir & "\AccessionNumber.txt"
If FileExists($AccFilePath) Then
	FileDelete($AccFilePath)
	_FileWriteLog($logPath, "delete the exist file : " & $AccFilePath)
EndIf

$i = 1
While $i <= $CmdLine[1]
	$strDate = @Year&@MON&@MDAY
	$strTime = @HOUR&@MIN&@SEC&@MSEC
	;$strTime = @HOUR&@MIN&@SEC
	$strDateTime = $strDate&$strTime
	$ExzamDateTime = @Year&"-"&@MON&"-"&@MDAY & " " & @HOUR&":"&@MIN&":"&@SEC&"."&@MSEC
	$PatientID = "P"&$strDateTime
	$AccnNum = "A"&$strDateTime
	$StudyUID = "UID"&$strDateTime
	$NameCN = "N"&$strDateTime
	$NameEN = "E"&$strDateTime
	Local $Grender[2] = ["F","M"]
	Local $Modality[5] = ["CR","CT","DX","MR","US"]
	Local $BodayPart[3] = ["Hand","Chest","Head"]

	$PatientSex = $Grender[mod($i,2)]
	$PatientModality = $Modality[mod($i,5)]
	$PatientBodayPart = $BodayPart[mod($i,3)]
	$patientDepartMent = $aDepartmentArray[mod($i, UBound($aDepartmentArray))]

	; The notify create ezam api data
	$sData = '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:car="http://care' _
	&'stream.org/"><soap:Header/><soap:Body> <car:NotifyExamInfo><car:exam><car:CreateDT>' & $ExzamDateTime  _
	&'</car:CreateDT><car:UpdateDT>'& $ExzamDateTime &'</car:UpdateDT><car:PatientID>  ' _
	&''& $PatientID &'</car:PatientID><car:AccessionNumber>'&$AccnNum&'</car:AccessionNumber><' _
	&'car:StudyInstanceUID>'& $StudyUID &'</car:StudyInstanceUID><car:NameCN>'&$NameCN&'<' _
	&'/car:NameCN><car:NameEN>'& $NameEN &'</car:NameEN><car:Gender>'& $PatientSex &'</car:Gender><car:Birthda' _
	&'y></car:Birthday><car:Modality>'& $PatientModality &'</car:Modality> <car:ModalityName>'& $PatientModality &'</car:ModalityName><car' _
	&':PatientType>3</car:PatientType><car:VisitID></car:VisitID><car:RequestID></car:RequestID>' _
	&'<car:RequestDepartment>'& $patientDepartMent &'</car:RequestDepartment><car:RequestDT>' & $ExzamDateTime &'</car:Requ' _
	&'estDT><car:RegisterDT>' & $ExzamDateTime & '</car:RegisterDT> <car:ExamDT>' & $ExzamDateTime & '</' _
	&'car:ExamDT> <car:ReportDT>' & $ExzamDateTime & '</car:ReportDT> <car:SubmitDT>' & $ExzamDateTime & '' _
	&'37</car:SubmitDT> <car:ApproveDT>' & $ExzamDateTime & ' </car:ApproveDT> <car:PDFReportURL></ca' _
	&'r:PDFReportURL> <car:StudyStatus></car:StudyStatus> <car:OutHospitalNo></car:OutHospitalNo' _
	&'><car:InHospitalNo></car:InHospitalNo><car:PhysicalNumber></car:PhysicalNumber><car:ExamNa' _
	&'me>'& $NameEN &'</car:ExamName><car:ExamBodyPart>'& $PatientBodayPart &'</car:ExamBodyPart><car:Optional0><' _
	&'/car:Optional0><car:Optional1></car:Optional1><car:Optional2></car:Optional2><car:Optional' _
	&'3></car:Optional3><car:Optional4></car:Optional4><car:Optional5></car:Optional5><car:Optio' _
	&'nal6></car:Optional6><car:Optional7></car:Optional7><car:Optional8></car:Optional8><car:Op' _
	&'tional9></car:Optional9> </car:exam></car:NotifyExamInfo></soap:Body></soap:Envelope>'

	;Create the http request to send the soap request.
	;Create a exzam order in table wggc.dbo.vi_KIOSK_ExamInfo_Order
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("POST","http://localhost/NotifyServer/NotifyService.asmx",False)
	$oHTTP.SetRequestHeader("Content-Type","application/soap+xml;charset=GB2312")
	$oHTTP.Send($sData)

	;Get the recive data and status
	$oReceived = $oHTTP.ResponseText
	$oStatusCode = $oHTTP.Status

	If $oStatusCode <> 200 Then
		_FileWriteLog($logPath, "Create the patient in integration table failed. The web return code is not 200.")
		Exit
	EndIf

	_FileWriteLog($logPath, "Create the patient in integration table successfully.")
	Sleep(1000)

	;Copy the bat file and name test.bat
	If FileExists($strbatPath) Then

		$Flag = FileCopy($strbatPath,@ScriptDir&"\test.bat",$FC_OVERWRITE)
		; Modify the parameter in the test.bat files and run the bat to insert data to database.
		If $Flag Then
			_ReplaceStringInFile($strDestFilePath,"strDate",$strDate)
			_ReplaceStringInFile($strDestFilePath,"strTime",$strTime)
			_ReplaceStringInFile($strDestFilePath,"strGrender",$PatientSex)
			_ReplaceStringInFile($strDestFilePath,"strModality",$PatientModality)
			_ReplaceStringInFile($strDestFilePath,"strBodayPart",$PatientBodayPart)
			_ReplaceStringInFile($strDestFilePath,"strUID",$StudyUID)
		Else
			_FileWriteLog($logPath, "Cannot find the file " & $strbatPath & " or " & @ScriptDir&"\test.bat" & " Copy file failed.")
			MsgBox(1, "", "Cannot find the file " & $strbatPath & " or " & @ScriptDir&"\test.bat" & "Copy file failed.")
			Exit
		EndIf

		Local $iPID = Run($strDestFilePath,"",@SW_HIDE)
		If ProcessWaitClose($iPID,30) Then
			_FileWriteLog($logPath, "Send films to PS successfully.")
		Else
			_FileWriteLog($logPath, "Send films to PS failed.")
		EndIf

		Sleep(10*1000)

		;update the films belong to some departments.
		$SQL = "Update wggc.dbo.AFP_FilmInfo set DepartmentID = '" & $patientDepartMent & "'" &" where PatientID = '" & $PatientID & "'"
		$adCN.execute($SQL)

		Sleep(5*1000)

		;Check the data insert to database successfully.
		$SQL = "Select AccessionNumber from  wggc.dbo.AFP_FilmInfo  where AccessionNumber='" & $AccnNum & "' and DeleteStatus =0 and FilmFlag =0 and MinDensity is not null"
		$adoRecordSet.Open($SQL,$adCN)

		While $adoRecordSet.EOF <> True and $adoRecordSet.Fields.count == 1
			Local $temp = StringStripWS($adoRecordSet.Fields("AccessionNumber").Value, $STR_STRIPLEADING +  $STR_STRIPTRAILING)
			If StringCompare($temp,$AccnNum) == 0 Then
				_FileWriteLog($logPath, "Verify the data with database and the result is correct.")

				; Write the correct data to txt file.
				If FileWrite($AccFilePath, $AccnNum & @CRLF) Then
					_FileWriteLog($logPath, "Write the created records to file successfully.")
				Else
					_FileWriteLog($logPath, "Write the created records to file failed. " & $AccFilePath & "-" & $AccnNum)
				EndIf

				$i += 1

			Else
				_FileWriteLog($logPath, "Verify the data with database and the result is incorrect. " & $AccnNum)
			EndIf

			$adoRecordSet.MoveNext
		WEnd
		$adoRecordSet.close()

	Else
		_FileWriteLog($logPath, "Cannot find the file " & $strbatPath)
		MsgBox(1, "", "Cannot find the file " & $strbatPath )
		Exit

	EndIf

WEnd

_FileWriteLog($logPath, "****************************** End Create Film Data ******************************************")




