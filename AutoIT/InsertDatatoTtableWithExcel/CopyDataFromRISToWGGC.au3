#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------



; Script Start - Add your code below here


#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <Array.au3>
#include <File.au3>


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
		MsgBox(0, "Success!", "Connection to database successful!")
	EndIf



;******************************
; Find data from excel
;******************************

    ; List all the files and folders in the desktop directory using the default parameters.
    Local $aFileList = _FileListToArray(@ScriptDir, "*.xls")
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf


;~ 	for $i = 1 to 1 step 1
	for $i = 1 to $aFileList[0] step 1

		Local $sFilePath1 = @ScriptDir & "\" & $aFileList[$i] ;This file should already exist
		Local $oExcel = _ExcelBookOpen($sFilePath1,0,true,"","")

		If @error = 1 Then
			MsgBox($MB_SYSTEMMODAL, "Error!", "Unable to Create the Excel Object")
			Exit
		ElseIf @error = 2 Then
			MsgBox($MB_SYSTEMMODAL, "Error!", "File does not exist - Shame on you!")
			Exit
		EndIf


		Local $aDataArray = _ExcelReadSheetToArray($oExcel)
;~ 		_ArrayDisplay($aDataArray, "Sheet")
;~ 		MsgBox(1,1,$aDataArray[0][0])
;~ 		MsgBox(1,1,$aDataArray[2][2])
;~ 		MsgBox(1,1,$aDataArray[2][3])
;~ 		MsgBox(1,1,$aDataArray[2][4])
;~ 		MsgBox(1,1,$aDataArray[2][5])
;~ 		MsgBox(1,1,$aDataArray[2][6])

;~ 		insert data from one files
		for $j = 2 to $aDataArray[0][0] step 1

			$strDate = @Year&@MON&@MDAY
			;$strTime = @HOUR&@MIN&@SEC&@MSEC
			$strTime = @HOUR&@MIN&@SEC
			$strDateTime = $strDate&$strTime
			$DateDime = @Year&"-"&@MON&"-"&@MDAY & " " & @HOUR&":"&@MIN&":"&@SEC&"."&@MSEC
			$PatientID = $aDataArray[$j][2]
			$AccnNum = $aDataArray[$j][5]
			$StudyUID = "UID"&$strDateTime
			$NameCN = $aDataArray[$j][3]
			$NameEN = $aDataArray[$j][4]
			Local $Grender[2] = ["F","M"]
;~ 			Local $Modality[5] = ["CR","CT","DR","MR","US"]
;~ 			local $BodayPart[3] = ["Hand","Chest","Head"]

			$PatientSex = $Grender[mod($j,2)]
			$PatientModality = $aDataArray[$j][6]
;~ 			$PatientBodayPart = $BodayPart[mod($i,3)]

;~ 			Dim $InsertSql = 'INSERT [WGGC].[dbo].[vi_KIOSK_ExamInfo_Order]' _
;~ 			&'(' _
;~ 			&'[CreateDT],[UpdateDT],[PatientID],[AccessionNumber],[StudyInstanceUID],[NameCN],[NameEN],[Gender],[Birthday],[Modality],[ModalityName],[PatientType],[VisitID],[RequestID],[RequestDepartment],[RequestDT]         ' _
;~ 			&',[RegisterDT],[ExamDT],[SubmitDT],[ApproveDT],[PDFReportURL],[StudyStatus],[ReportStatus],[PDFFlag],[PDFDT],[VerifyFilmFlag],[VerifyFilmDT],[VerifyReportFlag],[VerifyReportDT],[FilmStoredFlag],[FilmStoredDT]    ' _
;~ 			&',[ReportStoredFlag],[ReportStoredDT],[NotifyReportFlag],[NotifyReportDT],[SetPrintModeFlag],[SetPrintModeDT],[FilmPrintFlag],[FilmPrintDoctor],[FilmPrintDT],[ReportPrintFlag],[ReportPrintDoctor],[ReportPrintDT] ' _
;~ 			&',[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart],[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]                 ' _
;~ 			&')' _
;~ 			&'VALUES ' _
;~ 			&'( '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '&"'"&$PatientID&"'"&', '&"'"&$AccnNum&"'"&', '&"'"&$StudyUID&"'"&',  '&"'"&$NameCN&"'"&', '&"'"&$NameEN&"'"&', '&"'"&$PatientSex&"'"&', '&"'"&$DateDime&"'"&', '&"'"&$PatientModality&"'"&', '&"'"&$PatientModality&"'"&',3,0,'''','''','''',' _
;~ 			&' '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '''','''','''',50,-10,-10,null,-10,null,-10,'&"'"&$DateDime&"'"&',-10,null,' _
;~ 			&'  -10,null, -10,null,0,null,-10,'''',null,-10,'''',null,' _
;~ 			&' '''','''','''','&"'"&$PatientModality&"'"&','&"'"&$PatientModality&"'"&','''','''',null,'&"'"&$DateDime&"'"&','''','''','''','''','''',''''' _
;~ 			&')'


			Dim $InsertSql = 'INSERT [WGGC].[dbo].[vi_KIOSK_ExamInfo_Order]' _
			&'(' _
			&'[CreateDT],[UpdateDT],[PatientID],[AccessionNumber],[StudyInstanceUID],[NameCN],[NameEN],[Gender],[Birthday],[Modality],[ModalityName],[PatientType],[VisitID],[RequestID],[RequestDepartment],[RequestDT]         ' _
			&',[RegisterDT],[ExamDT],[SubmitDT],[ApproveDT],[PDFReportURL],[StudyStatus]' _
			&',[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart],[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]                 ' _
			&')' _
			&'VALUES ' _
			&'( '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '&"'"&$PatientID&"'"&', '&"'"&$AccnNum&"'"&', '&"'"&$StudyUID&"'"&',  '&"'"&$NameCN&"'"&', '&"'"&$NameEN&"'"&', '&"'"&$PatientSex&"'"&', '&"'"&$DateDime&"'"&', '&"'"&$PatientModality&"'"&', '&"'"&$PatientModality&"'"&',3,0,'''',2,'''',' _
			&' '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&','&"'"&$DateDime&"'"&','&"'"&$DateDime&"'"&','''','''', ' _
			&' '''','''','''','&"'"&$NameEN&"'"&','&"'"&$PatientModality&"'"&','''','''',null,'&"'"&$DateDime&"'"&','''','''','''','''','''',''''' _
			&')'

			$result = $adCN.Execute($InsertSql)
;~ 			FileWrite("E:\log.txt",$InsertSql)
;~ 			MsgBox(1,1,1)

		Next




		_ExcelBookClose($oExcel)


	Next

$adCN.Close

MsgBox(1,1,"Import data successfully")


;~ $sQuery = "select * from wggc.dbo.AFP_ReportInfo"

;~ $result = $adCN.Execute($sQuery)
;~ MsgBox(0, "", $result.Fields( "PatientID" ).Value)
;~ $adCN.Close









;~     ; List all the files and folders in the desktop directory using the default parameters.
;~     Local $aFileList = _FileListToArray(@ScriptDir, "*.xls")
;~     If @error = 1 Then
;~         MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
;~         Exit
;~     EndIf
;~     If @error = 4 Then
;~         MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
;~         Exit
;~     EndIf




;~ Local $sFilePath1 = @ScriptDir & "\KioskData_1.xls" ;This file should already exist
;~ Local $oExcel = _ExcelBookOpen($sFilePath1,0,true,"","")

;~ If @error = 1 Then
;~     MsgBox($MB_SYSTEMMODAL, "Error!", "Unable to Create the Excel Object")
;~     Exit
;~ ElseIf @error = 2 Then
;~     MsgBox($MB_SYSTEMMODAL, "Error!", "File does not exist - Shame on you!")
;~     Exit
;~ EndIf


;~ Local $aDataArray = _ExcelReadSheetToArray($oExcel)
;~ _ArrayDisplay($aDataArray, "Sheet")
;~ MsgBox(1,1,$aDataArray[0][0])
;~ MsgBox(1,1,$aDataArray[2][2])
;~ MsgBox(1,1,$aDataArray[2][3])
;~ MsgBox(1,1,$aDataArray[2][4])
;~ MsgBox(1,1,$aDataArray[2][5])
;~ MsgBox(1,1,$aDataArray[2][6])





;~ for $i = 1 to $aDataArray[0][0] step 1

;~ Next

;~ _ExcelBookClose($oExcel)




;~ $constrim="DRIVER={SQL Server};SERVER=10.184.129.208\GCPACSWS;DATABASE=WGGC;uid=sa;pwd=sa20021224$;"
;~ $adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
;~ $adCN.Open ($constrim) ; <== Connect with required credentials


;~ if @error Then
;~     MsgBox(0, "ERROR", "Failed to connect to the database")
;~     Exit
;~ Else
;~     MsgBox(0, "Success!", "Connection to database successful!")
;~ EndIf

;~ $sQuery = "select * from wggc.dbo.AFP_ReportInfo"

;~ $result = $adCN.Execute($sQuery)
;~ MsgBox(0, "", $result.Fields( "PatientID" ).Value)
;~ $adCN.Close

;~ 	$i=1
;~ 	$strDate = @Year&@MON&@MDAY
;~ 	;$strTime = @HOUR&@MIN&@SEC&@MSEC
;~ 	$strTime = @HOUR&@MIN&@SEC
;~ 	$strDateTime = $strDate&$strTime
;~     $DateDime = @Year&"-"&@MON&"-"&@MDAY & " " & @HOUR&":"&@MIN&":"&@SEC&"."&@MSEC
;~ 	$PatientID = "P"&$strDateTime
;~ 	$AccnNum = "A"&$strDateTime
;~ 	$StudyUID = "UID"&$strDateTime
;~ 	$NameCN = "N"&$strDateTime
;~ 	$NameEN = "E"&$strDateTime
;~ 	Local $Grender[2] = ["F","M"]
;~ 	Local $Modality[5] = ["CR","CT","DR","MR","US"]
;~ 	local $BodayPart[3] = ["Hand","Chest","Head"]

;~ 	$PatientSex = $Grender[mod($i,2)]
;~ 	$PatientModality = $Modality[mod($i,5)]
;~ 	$PatientBodayPart = $BodayPart[mod($i,3)]

;~ Dim $InsertSql = 'INSERT [WGGC].[dbo].[T_Integration_ExamInfo]' _
;~ &'(' _
;~ &'[CreateDT],[UpdateDT],[PatientID],[AccessionNumber],[StudyInstanceUID],[NameCN],[NameEN],[Gender],[Birthday],[Modality],[ModalityName],[PatientType],[VisitID],[RequestID],[RequestDepartment],[RequestDT]         ' _
;~ &',[RegisterDT],[ExamDT],[SubmitDT],[ApproveDT],[PDFReportURL],[StudyStatus],[ReportStatus],[PDFFlag],[PDFDT],[VerifyFilmFlag],[VerifyFilmDT],[VerifyReportFlag],[VerifyReportDT],[FilmStoredFlag],[FilmStoredDT]    ' _
;~ &',[ReportStoredFlag],[ReportStoredDT],[NotifyReportFlag],[NotifyReportDT],[SetPrintModeFlag],[SetPrintModeDT],[FilmPrintFlag],[FilmPrintDoctor],[FilmPrintDT],[ReportPrintFlag],[ReportPrintDoctor],[ReportPrintDT] ' _
;~ &',[OutHospitalNo],[InHospitalNo],[PhysicalNumber],[ExamName],[ExamBodyPart],[Optional0],[Optional1],[Optional2],[Optional3],[Optional4],[Optional5],[Optional6],[Optional7],[Optional8],[Optional9]                 ' _
;~ &')' _
;~ &'VALUES ' _
;~ &'( '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '&"'"&$PatientID&"'"&', '&"'"&$AccnNum&"'"&', '&"'"&$StudyUID&"'"&',  '&"'"&$NameCN&"'"&', '&"'"&$NameEN&"'"&', '&"'"&$PatientSex&"'"&', '&"'"&$DateDime&"'"&', '&"'"&$PatientModality&"'"&', '&"'"&$PatientModality&"'"&',3,0,'''','''','''',' _
;~ &' '&"'"&$DateDime&"'"&' , '&"'"&$DateDime&"'"&', '''','''','''',50,-10,-10,null,-10,null,-10,'&"'"&$DateDime&"'"&',-10,null,' _
;~ &'  -10,null, -10,null,0,null,-10,'''',null,-10,'''',null,' _
;~ &' '''','''','''',''ChestL'',''Chest'','''','''',null,'&"'"&$DateDime&"'"&','''','''','''','''','''',''''' _
;~ &')                                                                                                                                                                                                                   ' _

;~ $hFileOpen = FileOpen("C:\test.txt",2)
;~     If $hFileOpen = -1 Then
;~         MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading the file.")

;~     EndIf

;~  FileWrite($hFileOpen, $InsertSql)
;~  FileClose($hFileOpen)


