#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
#include <GUIConstants.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>

; Script Start - Add your code below here

 ; List all the files and folders in the desktop directory using the default parameters and return the full path.
	Global $FilePath,$DeleteDateTime,$DateType,$flag
	$FilePath =""
	$DeleteDateTime =""
	$DateType =""
	$flag= 1

	$From1 = GUICreate("Delete Forder......",600,600)
	$FromSelectFolder = GUICtrlCreateLabel("Please select the folder to delete",40,40,300,10,$SS_LEFT) ; first cell 70 width
	$idButton_SelectFolder = GUICtrlCreateButton("Select", 400, 40, 85, 25)
	$LabelPath = GUICtrlCreateLabel("",40,80,500,60,$SS_LEFT)
	$ComboLabelPath = GUICtrlCreateLabel("",40,180,300,10,$SS_LEFT)
	$ComboDaysInput = GUICtrlCreateInput("30",40,200,85,22)
	$GuiCombo =  GUICtrlCreateCombo("", 200, 200,85,25,BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
	$Lable_DateTime = GUICtrlCreateLabel("",40,260,500,20,$SS_LEFT)
	$idButton_Delete = GUICtrlCreateButton("Delete", 400, 300, 85, 25)

	$LabelProcess = GUICtrlCreateLabel("Delete....",40,400,85,20,$SS_LEFT)
	$GUIprogress = GUICtrlCreateProgress(40,450,450,25,$PBS_SMOOTH)


	GUICtrlSetData($ComboLabelPath,"Config the datetime to delete:" )
	GUICtrlSetData($FromSelectFolder,"Please select the folder to delete" )
	GUICtrlSetData($GuiCombo, "d|m|s","d")
	GUICtrlSetData($Lable_DateTime,"N/A" )
	GUICtrlSetData($LabelPath,"N/A" )
	GUICtrlSetData($GUIprogress, 0)
	$GuiCombo_button =  GUICtrlCreateButton("Confirm", 400, 200,85,25)




	GUISetState(@SW_SHOW,$From1)

    While $flag = 1


        Switch GUIGetMsg()

            Case $GUI_EVENT_CLOSE
                ExitLoop

            Case $idButton_SelectFolder

                $sForlder = SelectFolder()
				If $sForlder <> "" Then
					GUICtrlSetData($LabelPath,"Selected folder path is: " &$sForlder )
					$FilePath = $sForlder
				EndIf

			Case $GuiCombo

				$sComboRead = GUICtrlRead($GuiCombo)
				$DateType = $sComboRead

			Case $GuiCombo_button
				$DateType = GUICtrlRead($GuiCombo)
				$DeleteDateTime = GUICtrlRead($ComboDaysInput)
				GUICtrlSetData($Lable_DateTime,"Date threshold value is:"  &$DeleteDateTime & $DateType )

			Case $idButton_Delete
				If 	$FilePath = "" or $DeleteDateTime ="" or $DateType ="" Then
					MsgBox(1,"no config", "Please select related parameters to delete folders.")
				Else
					$aFileList = GetFolderList($FilePath)

					$aNeedDeleteList = GetDeleteFolder($aFileList,$DateType,$DeleteDateTime)

					If ubound($aNeedDeleteList) = 0 Then
						MsgBox(1,"Confirm","There are no fodlers to delete.")

					EndIf

					If ubound($aNeedDeleteList) <> 0 Then
						_ArrayDisplay($aNeedDeleteList, "Please confirm the delete fodlers")

						$Rtn = MsgBox (1,"Confirm","Do you want to delete the information or not?" & @CRLF & "There are " & UBound($aNeedDeleteList) & " folders to delete...")
						If $Rtn = $IDCANCEL Then
							Exit
						EndIf

						If $Rtn = $IDOK Then
							$Rtn2 = MsgBox (1,"Confirm","The operation cannot roolback, are you still want to delete?")
							If $Rtn2 = $IDCANCEL Then
								Exit
							EndIf

							If $Rtn2 = $IDOK Then
								$count = 0
								For $i = 0 to ubound($aNeedDeleteList)-1 Step 1
									$bStatus = DirRemove($aNeedDeleteList[$i], $DIR_REMOVE)
									If $bStatus <> 1 Then
										MsgBox(1,1,"delete folder failed.please try again")
										Exit
									EndIf
									$count = $count+1
									GUICtrlSetData($GUIprogress, ($count/ubound($aNeedDeleteList))*100)

								Next


								$flag =0
							EndIf
						EndIf
					EndIf
				EndIf


        EndSwitch

    WEnd




	MsgBox(1,1,"Operation finished.")

	GUIDelete($From1)




Func SelectFolder()

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder("Seelct folder", "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

	Else
		; Display the selected folder.
		;MsgBox($MB_SYSTEMMODAL, "", "You chose the following folder:" & @CRLF & $sFileSelectFolder)
		return $sFileSelectFolder
	EndIf

EndFunc

Func GetFolderList($sForlder)
	Local $aFileList = _FileListToArray($sForlder, Default, $FLTA_FOLDERS, True)

	If @error = 1 Then
		MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")

	EndIf
	If @error = 4 Then
		MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")

	EndIf

;~ 	_ArrayDisplay($aFileList, "$aFileList")
	Return $aFileList

EndFunc

Func GetDeleteFolder($aFileList,$TimeType,$TimeLength)

	Local	$aNeedDeleteList[0]

	For $i = 1 to $aFileList[0] step 1

		$sDate = FileGetTime($aFileList[$i],$FT_CREATED ,$FT_STRING)
		$sConvert = StringLeft($sDate,4) & "/" & StringMid($sDate, 5, 2) & "/" & StringMid($sDate, 7, 2) & " " & _ ;date
					StringMid($sDate, 9, 2) & ":" & StringMid($sDate, 11, 2) & ":" & StringRight($sDate, 2) ;time

		Local $iDateCalc = _DateDiff($TimeType, $sConvert, _NowCalc())

		If $iDateCalc >= $TimeLength Then
			_ArrayAdd($aNeedDeleteList,String($aFileList[$i]))

		EndIf
	Next


	return $aNeedDeleteList
EndFunc