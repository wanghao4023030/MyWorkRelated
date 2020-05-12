
Dim OS_avaiableMemo
Dim OS_CPUusage
Dim OS_logicNumm
Dim ProcCPUuage
Dim ProcMem
const ProcName = "Unicorn.exe"
Dim fs
Dim f
Dim filePath
Dim logName

logName = Replace(Date,"/","")

filePath = "C:\ReliabilityTest\MonitorLog\"&logName&".log"


' End of WMI Example of a Kill Process


Set fs = CreateObject("Scripting.FileSystemObject")
if fs.FileExists(filePath) = false Then
 Set f = fs.CreateTextFile(filePath, True)
 f.WriteLine("DateTime,OS_Average Process %,OS_avaiable_memory MB,Process Process %,Process_UseMemory MB")
 f.close
End if

strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")



While true
		'Get OS AvailableMBytes
		Set colItems = objWMIService.ExecQuery("Select AvailableMBytes from Win32_PerfFormattedData_PerfOS_Memory",,48)

		For Each objItem in colItems
		OS_avaiableMemo = objItem.AvailableMBytes
		Next


		'Get OS AvailableMBytes
		OS_CPUusage = 0
		Set CPUInfo = objWMIService.ExecQuery("SELECT PercentProcessorTime FROM Win32_PerfFormattedData_PerfOS_Processor") 
		For Each Item in CPUInfo 
		OS_CPUusage = OS_CPUusage + Item.PercentProcessorTime
		Next
		OS_CPUusage = OS_CPUusage / CPUInfo.Count



		'Get logic CPU number 
		Set colCPUSystems = objWMIService.ExecQuery("Select NumberOfLogicalProcessors from Win32_Processor")
		proc = 0
		For Each objProc in colCPUSystems
		OS_logicNumm = objProc.NumberOfLogicalProcessors

		Next
		 
		proc = Replace(ProcName, ".exe", "")
		proc = lcase(proc)
		set objRefresher = CreateObject("WbemScripting.SWbemRefresher")
		Set colItems = objRefresher.AddEnum(objWMIService, "Win32_PerfFormattedData_PerfProc_Process").objectSet
		objRefresher.Refresh

		For Each objItem in colItems
		If lcase(objItem.Name) = proc Then 
			objRefresher.Refresh
			ProcCPUuage = objItem.PercentProcessorTime/OS_logicNumm
			ProcMem = objItem.PrivateBytes/1024/1024
			ProcMem = Cint(ProcMem)
		End If
		Next

		'Wscript.Echo "OS average PercentProcessorTime: " & OS_CPUusage
		'Wscript.Echo "OS Memory avaliable: " & OS_avaiableMemo
		'Wscript.Echo "Process Cpu logic : " & OS_logicNumm
		'Wscript.Echo "Process Cpu Uage : " & ProcCPUuage
		'Wscript.Echo "Process Memory : " & ProcMem


		Set f = fs.OpenTextFile(filePath,8,true,TristateTrue)
		f.WriteLine(Date &" "& Time&","& OS_CPUusage&","& OS_avaiableMemo&","& ProcCPUuage&","& ProcMem)
		f.close

		'Dim dteWait
		'dteWait = DateAdd("s", 10, Now())
		'Do Until (Now() > dteWait)
		'Loop
		Wscript.sleep 5000
wend