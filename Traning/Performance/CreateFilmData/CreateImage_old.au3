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
#include <File.au3>


Dim $strbatPath

$strbatPath = @ScriptDir & "\ModifyAl_ForAutoIt.bat"
$strDestFilePath = @ScriptDir&"\test.bat"

For $i = 1 To 200000 Step 1
	$strDate = @Year&@MON&@MDAY
	;$strTime = @HOUR&@MIN&@SEC&@MSEC
	$strTime = @HOUR&@MIN&@SEC
	$strDateTime = $strDate&$strTime
	$ExzamDateTime = @Year&"-"&@MON&"-"&@MDAY & " " & @HOUR&":"&@MIN&":"&@SEC&"."&@MSEC
	$PatientID = "P"&$strDateTime
	$AccnNum = "A"&$strDateTime
	$StudyUID = "UID"&$strDateTime
	$NameCN = "N"&$strDateTime
	$NameEN = "E"&$strDateTime
	Local $Grender[2] = ["F","M"]
	Local $Modality[5] = ["CR","CT","DR","MR","US"]
	local $BodayPart[3] = ["Hand","Chest","Head"]



	$PatientSex = $Grender[mod($i,2)]
	$PatientModality = $Modality[mod($i,5)]
	$PatientBodayPart = $BodayPart[mod($i,3)]

	; The notify create ezam api data
	$sData = '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:car="http://care' _
	&'stream.org/"><soap:Header/><soap:Body> <car:NotifyExamInfo><car:exam><car:CreateDT>' & $ExzamDateTime  _
	&'</car:CreateDT><car:UpdateDT>'& $ExzamDateTime &'</car:UpdateDT><car:PatientID>  ' _
	&''& $PatientID &'</car:PatientID><car:AccessionNumber>'&$AccnNum&'</car:AccessionNumber><' _
	&'car:StudyInstanceUID>'& $StudyUID &'</car:StudyInstanceUID><car:NameCN>'&$NameCN&'<' _
	&'/car:NameCN><car:NameEN>'& $NameEN &'</car:NameEN><car:Gender>'& $PatientSex &'</car:Gender><car:Birthda' _
	&'y></car:Birthday><car:Modality>'& $PatientModality &'</car:Modality> <car:ModalityName>'& $PatientModality &'</car:ModalityName><car' _
	&':PatientType>3</car:PatientType><car:VisitID></car:VisitID><car:RequestID></car:RequestID>' _
	&'<car:RequestDepartment></car:RequestDepartment><car:RequestDT>' & $ExzamDateTime &'</car:Requ' _
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
	$oHTTP.Open("POST","http://10.184.129.208/NotifyServer/NotifyService.asmx",False)
	$oHTTP.SetRequestHeader("Content-Type","application/soap+xml;charset=GB2312")
	$oHTTP.Send($sData)

	;Get the recive data and status
	$oReceived = $oHTTP.ResponseText
	$oStatusCode = $oHTTP.Status


	If $oStatusCode <> 200 Then
		Exit
	EndIf


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
		EndIf

		Local $iPID = Run($strDestFilePath)
		sleep(2000)
		ProcessWaitClose($iPID,30)

	EndIf

Next



