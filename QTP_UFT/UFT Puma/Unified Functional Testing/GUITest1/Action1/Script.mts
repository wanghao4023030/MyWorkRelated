Setting("DefaultTimeout")=6000

CurrentDate = date
CurrentDate = Replace(CurrentDate,"/","")
LogPath = "C:\ReliabilityTest\Test"&CurrentDate&".log"
call WriteLog(LogPath,vbcrlf)


strDatapath = "C:\ReliabilityTest\1.csv"
arrTestData = GetAccN(strDatapath)
MonotiorScriptPath ="C:\ReliabilityTest\Monitor.vbs"


Dim TermianlStart
Dim stopServiceFlage
stopServiceFlage = 0

KillProc("'Unicorn.exe'" )
wait 5 
TermianlStart =  StartTerminal()
KillProc("'Wscript.exe'" )
wait 5

'systemutil.Run(MonotiorScriptPath)

While true
	
Call ResetAllDataByACC(arrTestData)
For i = 0 To Ubound(arrTestData) Step 1
	wait 1

	If WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").Exist Then
			varText = WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").GetROProperty("Text")
			If varText ="系统暂停服务" Then
				call WriteLog(LogPath,Date & " " & Time & " " & "系统暂停服务!")
				varText2 = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_version_FilmReport_info").GetROProperty("Text")
				call WriteLog(LogPath,varText2)
				
				stopServiceFlage = stopServiceFlage + 1
				temptext = inputbox("Input the error info","error verify")
				call WriteLog(LogPath,temptext)
				call WriteLog(LogPath,vbcrlf)
				
			End If
		Else
			varText = WpfWindow("Terminal_MainPanel").WpfObject("CacheContentControl").GetROProperty("Text")
			If varText ="系统暂停服务" Then
				call WriteLog(LogPath,Date & " " & Time & " " & "系统暂停服务!")
				varText2 = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_version_FilmReport_info").GetROProperty("Text")
				call WriteLog(LogPath,varText2)
				
				stopServiceFlage = stopServiceFlage + 1
				temptext = inputbox("Input the error info","error verify")
				call WriteLog(LogPath,temptext)
				call WriteLog(LogPath,vbcrlf)
			End if
		
	End If
	
	

'	If stopServiceFlage >3 Then
'		Exit For
'	End If
	


	
'	If stopServiceFlage <=0  Then
		
			arrtemp = Split(arrTestData(i),",")
			strACCN = arrtemp(0)
			strPID = arrtemp(1)
'			msgbox strACCN,65,1
'			msgbox strPID,65,1
			If TermianlStart and WpfWindow("Terminal_MainPanel").Exist Then
				Call WriteLog(LogPath,Date & " " & Time & " " & "Terminal start successfully")
				
				'Check the print task create successfully or not
				Dim InputResult 
				InputResult  = InputACCN(strACCN,strPID,LogPath)
				
				'Check Print operation successfully or not.
				If InputResult Then
					Call PrintTask(LogPath)	
				End If
				
					
				Else
					call WriteLog(LogPath,"Terminal start failed")
			End If
			
			
			Dim PrintCount
			PrintCount = GetReportPrintedCount(strACCN)
			'msgbox PrintCount,1,65
			If PrintCount >=1 Then
				call WriteLog(LogPath,"DB update successfully value is correct print " &PrintCount&" report(s)")
				Call WriteLog(LogPath,vbcrlf)
				Call ResetDataByACC(strACCN)
				Else
					call WriteLog(LogPath,"DB update failed value is incorrect print " &PrintCount&" report(s)")
					Call WriteLog(LogPath,vbcrlf)
					Call ResetDataByACC(strACCN)
			End If
			

			wait 1

'	End If

	
Next



Wend

Set oShell = nothing
