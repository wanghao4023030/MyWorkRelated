#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.10.2
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

;define the demo data to copy
Local Const $sFilePath = @ScriptDir & "\demo.pdf"

Local Const $sDataFilePath = @ScriptDir & "\DataRecord.txt"

; Open the file for reading and store the handle to a variable.
$hFileOpen = FileOpen($sDataFilePath, $FO_OVERWRITE+$FO_UNICODE)



; Create 50 folders for test data
For $i = 1 To 100 Step 1

	;Create the folders which name like  performance + 1,2,3,4......
	DirCreate(@ScriptDir & "\Data\PerformanceTest" & $i)
	Local $sFolderPath = @ScriptDir & "\Data\PerformanceTest" & $i & "\"

	;create the pdf report and name like performance + 1,2,3,4....... to each folders.
	For $j = 1 To 1 Step 1
		FileCopy($sFilePath, $sFolderPath & "\Performance" & $j & ".pdf", $FC_OVERWRITE + $FC_CREATEPATH)
		FileWriteLine($hFileOpen, "PerformanceTest" & $i & "\Performance" & $j & ".pdf")

	Next

Next

FileClose($hFileOpen)


