#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

while 1
    Local $hSearch = FileFindFirstFile("*.txt")
	$sFileName = FileFindNextFile($hSearch)
	Local $iFileSize = FileGetSize($sFileName)
	if ($iFileSize/1000/1000 >20 ) Then
		FileDelete($sFileName)
		MsgBox(1,1,'delete log files',5)
	EndIf
	sleep(6000)

WEnd
;~     ; Delete the temporary file.
;~     Local $iDelete = FileDelete($sFilePath)

;~     ; Display a message of whether the file was deleted.
;~     If $iDelete Then
;~         MsgBox($MB_SYSTEMMODAL, "", "The file was successfuly deleted.")
;~     Else
;~         MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst deleting the file.")
;~     EndIf


