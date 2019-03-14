#include <MsgBoxConstants.au3>


;~ $posX = MouseGetPos(0)
;~ $posY = MouseGetPos(1)

;~ MouseMove($posX-@DesktopWidth,$posY)
;~ MouseClick("left",MouseGetPos(0),MouseGetPos(1),1,10)



;~ $posX = MouseGetPos(0)
;~ $posY = MouseGetPos(1)

;~ MsgBox(1,1,$posX & "-" & $posY)





$flag = 1

while $flag == 1
	If ProcessExists("Kiosk.EBulletin.Client.exe") Then
		sleep(30000)

		If ProcessExists("K2MonUIWPF.exe") Then ; Check if the Notepad process is running.
 			sleep(30000)
;~  	 		MsgBox($MB_SYSTEMMODAL, "检测","系统检测中，请稍等10秒....",10)
			$posX = MouseGetPos(0)
			$posY = MouseGetPos(1)

			MouseMove($posX-@DesktopWidth,$posY)
			MouseClick("left",MouseGetPos(0),MouseGetPos(1),1,10)
			Sleep(1000)
;~ 			MsgBox($MB_SYSTEMMODAL,"启动","系统启动完毕，请稍等10秒...",10)
;~ 			$posX = MouseGetPos(0)
;~ 			$posY = MouseGetPos(1)
;~ 			MouseClick("left",MouseGetPos(0),MouseGetPos(1),1,10)
			$flag = 0

		EndIf
	EndIf

WEnd
Exit