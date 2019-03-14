#include <MsgBoxConstants.au3>
;~ msgbox(1,1,$Re)


$flag = 1

while $flag == 1
	If ProcessExists("Kiosk.EBulletin.Client.exe") Then
		sleep(30000)

		If ProcessExists("K2MonUIWPF.exe") Then ; Check if the Notepad process is running.
 			sleep(30000)
;~  	 		MsgBox($MB_SYSTEMMODAL, "检测","系统检测中，请稍等10秒....",10)
			$Re = WinWait("K2UI","",30)
			$Reflag = 0


			while($Re == 0 and $Reflag <= 6)
				$Re = WinWait("K2UI","",10)
				$Reflag = $Reflag + 1
			WEnd

			If($Re <> 0) Then
				$posX = MouseGetPos(0)
				$posY = MouseGetPos(1)
				MouseMove($posX-@DesktopWidth,$posY)
				MouseClick("left",MouseGetPos(0),MouseGetPos(1),1,10)
				Sleep(1000)
;~ 				msgbox($MB_SYSTEMMODAL,1,"Mouse OK")

			Else

				msgbox($MB_SYSTEMMODAL,1,"当前系统焦点不对，无法正常使用，请连接键盘鼠标移动到K2UI界面，进行点击操作")
			EndIf

			$flag = 0
		EndIf

	EndIf

	sleep(5000)
WEnd
Exit