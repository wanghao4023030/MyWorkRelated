#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>


;******************************
; connect Database
;******************************
$constrim="DRIVER={SQL Server};SERVER=10.184.129.208\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
$adCN.Open ($constrim) ; <== Connect with required credentials

if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!",5)
	EndIf



;******************************
; Find data from excel
;******************************



for $i = 1 to 10 step 1



			$strDate = @Year&@MON&@MDAY
			;$strTime = @HOUR&@MIN&@SEC&@MSEC
			$strTime = @HOUR&@MIN&@SEC
			$strDateTime = $strDate&$strTime
			$DateDime = @Year&"-"&@MON&"-"&@MDAY & " " & @HOUR&":"&@MIN&":"&@SEC&"."&@MSEC
			$PatientID = "RP"&$strDateTime
			$AccnNum = "RA"&$strDateTime
			$StudyUID = "RUID"&$strDateTime
			$NameCN = "RN"&$strDateTime
			$NameEN = "RN"&$strDateTime
			Local $Grender[2] = ["F","M"]
			Local $Modality[5] = ["CR","CT","DX","MR","US"]
			local $BodayPart[3] = ["Hand","Chest","Head"]

			$PatientSex = $Grender[mod($i,2)]
			$PatientModality = $Modality[mod($i,5)]
			$PatientBodayPart = $BodayPart[mod($i,3)]

			Dim $InsertSql = 'INSERT [WGGC].[dbo].[vi_KIOSK_ExamInfo_Order]' _
			&'(' _
			&'[CreateDT],[UpdateDT],[PatientID],[AccessionNumber],[StudyInstanceUID],[NameCN],[NameEN],[Gender],[Birthday],[Modality],[ModalityName],[PatientType],[VisitID],[RequestID],[RequestDepartment],[RequestDT]         ' _
			&',[RegisterDT],[ExamDT],[SubmitDT],[ApproveDT],[PDFReportURL],[StudyStatus]' _
			&',[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart],[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]                 ' _
			&')' _
			&'VALUES ' _
			&'( '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '&"'"&$PatientID&"'"&', '&"'"&$AccnNum&"'"&', '&"'"&$StudyUID&"'"&',  '&"'"&$NameCN&"'"&', '&"'"&$NameEN&"'"&', '&"'"&$PatientSex&"'"&', '&"'"&$DateDime&"'"&', '&"'"&$PatientModality&"'"&', '&"'"&$PatientModality&"'"&',3,0,'''',2,'''',' _
			&' '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&','&"'"&$DateDime&"'"&','&"'"&$DateDime&"'"&','''','''', ' _
			&' '''','''','''','&"'"&$NameEN&"'"&','&"'"&$PatientBodayPart&"'"&','''','''',null,'&"'"&$DateDime&"'"&','''','''','''','''','''',''''' _
			&')'

			$result = $adCN.Execute($InsertSql)

			Sleep(5000)
			PrintReport($PatientID,$AccnNum)
			Sleep(5000)
		Next


$adCN.Close

MsgBox(1,1,"Import data successfully")





Func PrintReport($PID,$ACCN)
	$sFilePath  = @ScriptDir&"\Template.txt"
	$sReportPath = @ScriptDir&"\report.txt"

	$sFileHandle = FileOpen($sFilePath,$FO_READ)
	;~ MsgBox(1,$sFileHandle,1)
	$sFileText = FileRead($sFileHandle)
	;~ MsgBox(1,1,$sFileText)
	FileClose($sFileHandle)
	$sFileText = StringReplace($sFileText,"ACCN",$ACCN)
	$sFileText = StringReplace($sFileText,"PID",$PID)

	_FileCreate($sReportPath)
	$sFileHandle = fileopen($sReportPath,$FO_OVERWRITE )
	FileWrite($sFileHandle,$sFileText)
	FileClose($sFileHandle)


	_FilePrint($sReportPath)

EndFunc