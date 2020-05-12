#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>

; Script Start - Add your code below here
 ; List all the files and folders in the desktop directory using the default parameters and return the full path.
    Local $aFileList = _FileListToArray(@ScriptDir, "*.jpg", Default, False)
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
    ; Display the results returned by _FileListToArray.


   If Not _FileCreate(@ScriptDir & "\filelist.txt") Then
    MsgBox($MB_SYSTEMMODAL, "Error", " Error Creating/Resetting log.      error:" & @error)
   EndIf


	$handle = FileOpen(@ScriptDir & "\filelist.txt",$FO_APPEND)

   for $i = 1 to $aFileList[0]
	   FileWriteLine($handle,$aFileList[$i])
   Next
   FileClose($handle)
