#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <MsgBoxConstants.au3>
#include <Process.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

ProcessQuit("WeChat.exe")

Func ProcessGetWindows($PId)
	$PId = ProcessExists($PId)
	If $PId = 0 Then
		SetError(1)
	Else
		Local $WinList = WinList()
		Local $WindowTitle[1][2]
		Local $x = 0
	For $i = 1 To $WinList[0][0]
		If WinGetProcess($WinList[$i][1], "") = $PId And $WinList[$i][0] <> "" Then
			ReDim $WindowTitle[$x+1][2]
			$WindowTitle[$x][0] = $WinList[$i][0]
			$WindowTitle[$x][1] = $WinList[$i][1]
			$x += 1
		EndIf
	Next
	Return $WindowTitle
	EndIf
EndFunc

Func ProcessQuit($filename)
	$Return=0
	$a = ProcessList($filename)
	For $i = 1 To UBound($a) - 1
		$Return = ProcessGetWindows($a[$i][1])
	Next
	If($Return==0) Then
		Return
	EndIf
	DllCall("User32.dll", "int", "PostMessageA", "hwnd", $Return[0][1], "int", $WM_QUIT, "int", "", "int", "")
EndFunc