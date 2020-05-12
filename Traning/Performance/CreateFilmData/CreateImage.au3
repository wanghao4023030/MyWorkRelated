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

For $i = 1 To 2 Step 1
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
	Local $Grender[2] = ["ÄÐ","Å®"]
	Local $Modality[5] = ["CR","CT","DX","MR","US"]
	local $BodayPart[3] = ["Hand","Chest","Head"]

	$PatientSex = $Grender[mod($i,2)]
	$PatientModality = $Modality[mod($i,5)]
	$PatientBodayPart = $BodayPart[mod($i,3)]
	$PatientType = "¼±Õï²¡ÈË"


	; The notify create ezam api data
	$sData = '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:car="http://care' _
	&'stream.org/"><soap:Header/><soap:Body> <car:NotifyExamInfo><car:exam><car:CreateDT>' & $ExzamDateTime  _
	&'</car:CreateDT><car:UpdateDT>'& $ExzamDateTime &'</car:UpdateDT><car:PatientID>  ' _
	&''& $PatientID &'</car:PatientID><car:AccessionNumber>'&$AccnNum&'</car:AccessionNumber><' _
	&'car:StudyInstanceUID>'& $StudyUID &'</car:StudyInstanceUID><car:NameCN>'&$NameCN&'<' _
	&'/car:NameCN><car:NameEN>'& $NameEN &'</car:NameEN><car:Gender>'& $PatientSex &'</car:Gender><car:Birthda' _
	&'y></car:Birthday><car:Modality>'& $PatientModality &'</car:Modality> <car:ModalityName>'& $PatientModality &'</car:ModalityName><car' _
	&':PatientType>' & $PatientType & '</car:PatientType><car:VisitID></car:VisitID><car:RequestID></car:RequestID>' _
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
	$oHTTP.Open("POST","http://10.184.129.225/NotifyServer/NotifyService.asmx",False)
	$oHTTP.SetRequestHeader("Content-Type","application/soap+xml;charset=utf-8")
	$oHTTP.Send($sData)

	;Get the recive data and status
	$oReceived = $oHTTP.ResponseText
	$oStatusCode = $oHTTP.Status


	If $oStatusCode <> 200 Then
		Exit
	EndIf

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
		EndIf

		Local $iPID = Run($strDestFilePath,"",@SW_HIDE)

		ProcessWaitClose($iPID,30)

	EndIf


   sleep(10*1000)



	;Create Report
	$sData = '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:car="http://carestream.org/">' _
			&'<soap:Header/>' _
			&'<soap:Body>' _
			&' <car:NotifyReportFile>' _
			&'<car:exam>' _
			&'<car:CreateDT>'&$ExzamDateTime &'</car:CreateDT>' _
			&'<car:UpdateDT>'& $ExzamDateTime &'</car:UpdateDT>' _
			&'<car:PatientID>'& $PatientID &'</car:PatientID>' _
			&'<car:AccessionNumber>'&$AccnNum&'</car:AccessionNumber>' _
			&'<car:StudyInstanceUID>'&$StudyUID&'</car:StudyInstanceUID>' _
			&'<car:NameCN>'&$NameCN&'</car:NameCN>' _
			&'<car:NameEN>'&$NameEN&'</car:NameEN>' _
			&'<car:Gender>'&$PatientSex&'</car:Gender>' _
			&'<car:Birthday></car:Birthday>' _
			&'<car:Modality>'&$PatientModality&'</car:Modality>' _
			&'<car:ModalityName>'&$PatientModality&'</car:ModalityName>' _
			&'<car:PatientType>3</car:PatientType>' _
			&'<car:VisitID></car:VisitID>' _
			&'<car:RequestID></car:RequestID>' _
			&'<car:RequestDepartment></car:RequestDepartment>' _
			&'<car:RequestDT>'& $ExzamDateTime &'</car:RequestDT>' _
			&'<car:RegisterDT>'& $ExzamDateTime &'</car:RegisterDT>' _
			&'<car:ExamDT>'& $ExzamDateTime &'</car:ExamDT>' _
			&'<car:ReportDT>'& $ExzamDateTime &'</car:ReportDT>' _
			&'<car:SubmitDT>'& $ExzamDateTime &'</car:SubmitDT>' _
			&'<car:ApproveDT>'& $ExzamDateTime &'</car:ApproveDT>' _
			&'<car:PDFReportURL></car:PDFReportURL>' _
			&'<car:StudyStatus></car:StudyStatus>' _
			&'<car:OutHospitalNo></car:OutHospitalNo>' _
			&'<car:InHospitalNo></car:InHospitalNo>' _
			&'<car:PhysicalNumber></car:PhysicalNumber>' _
			&'<car:ExamName>'& $NameEN &'</car:ExamName>' _
			&'<car:ExamBodyPart>'&$PatientBodayPart&'</car:ExamBodyPart>' _
			&'<car:Optional0></car:Optional0>' _
			&'<car:Optional1></car:Optional1>' _
			&'<car:Optional2></car:Optional2>' _
			&'<car:Optional3></car:Optional3>' _
			&'<car:Optional4></car:Optional4>' _
			&'<car:Optional5></car:Optional5>' _
			&'<car:Optional6></car:Optional6>' _
			&'<car:Optional7></car:Optional7>' _
			&'<car:Optional8></car:Optional8>' _
			&'<car:Optional9></car:Optional9>' _
			&'</car:exam>' _
			&'<car:reportPath>E:\\1.pdf</car:reportPath>' _
			&'<car:reportStatus>2</car:reportStatus>' _
			&'<pdfPassword></pdfPassword>' _
			&'</car:NotifyReportFile>' _
			&'</soap:Body>' _
			&'</soap:Envelope>'


	;Create the http request to send the soap request.
	;Create a exzam order in table wggc.dbo.vi_KIOSK_ExamInfo_Order
	$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	$oHTTP.Open("POST","http://10.184.129.225/NotifyServer/NotifyService.asmx",False)
	$oHTTP.SetRequestHeader("Content-Type","application/soap+xml;charset=UTF-8")
	$oHTTP.Send($sData)

	;Get the recive data and status
	$oReceived = $oHTTP.ResponseText
	$oStatusCode = $oHTTP.Status


	If $oStatusCode <> 200 Then
		msgbox(1,1,"Create report failed and status code is " &$oStatusCode )

		Exit
	EndIf

	Sleep(1000)

Next

MsgBox(1,"Finished","Script execute finished")

