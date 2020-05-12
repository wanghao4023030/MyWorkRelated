#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>



 Local $aFileList = _FileListToArrayRec("C:\Users\", "Unicorn.exe" ,  $FLTA_FILES, $FLTAR_RECUR , $FLTAR_NOSORT,  $FLTAR_FULLPATH)
    If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
        Exit
    EndIf
    ; Display the results returned by _FileListToArray.
    _ArrayDisplay($aFileList, "$aFileList")

string

