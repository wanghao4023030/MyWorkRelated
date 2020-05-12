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


 ; List all the files and folders in the desktop directory using the default parameters and return the full path.
    Local $aFileList = _FileListToArray(@ScriptDir, "*.jpg", 1 , False)
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
    ; Display the results returned by _FileListToArray.
;~     _ArrayDisplay($aFileList, "$aFileList")

   _FileCreate("jpglist.txt")




	for $i =1 to $aFileList[0] step 1
	  FileWriteLine("jpglist.txt", $aFileList[$i])


	Next

