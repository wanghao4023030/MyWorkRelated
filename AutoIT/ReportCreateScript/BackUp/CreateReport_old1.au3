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

; Create 50 folders for test data
For $i = 1 to 50 step 1

   ;Create the folders which name like  performance + 1,2,3,4......
   DirCreate ( @ScriptDir & "\Data\PerformanceTest" & $i )
   Local $sFolderPath = @ScriptDir & "\Data\PerformanceTest" & $i &"\"

	;create the pdf report and name like performance + 1,2,3,4....... to each folders.
   For $j = 1 to 500 step 1
	  FileCopy($sFilePath,$sFolderPath & "\Performance" &$j& ".pdf",$FC_OVERWRITE + $FC_CREATEPATH)
   Next

Next

msgbox (1, "Create data","Create the data successfully", 5)

Func Test()

EndFunc



