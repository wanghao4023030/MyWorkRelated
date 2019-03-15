' DATABASE公用函数 
' 
'########################################################################################################### 
'########################################################################################################### 

public objConnection                          'CONNECTION对象实例 
public objRecordSet                                   'RECORDSET对象实例        
public objCommand                                '命令对象实例 
public strConnectionString                        '连接字符串 

' ******************************************************************** 
' 函数说明：连接数据库; 
' 参数说明：(1)strDBType（数据库类型：如ORACEL；DB2；SQL；ACCESS） 
'           (2)strDBAlias（数据库别名） 
'           (3)strUID（用户名） 
'           (4)strPWD（密码） 
'           (5)strIP（数据库IP地址：仅SQL SERVER 使用） 
'           (6)strLocalHostName（本地主机名：仅SQL SERVER 使用） 
'           (7)strDataSource（数据源：仅ACCESS使用；如d:\yysc.mdb） 
' 返回结果：无 
' 调用方法: ConnectDatabase(strDBType, strDBAlias, strUID, strPWD, strIP, strLocalHostName, strDataSource) 
' ******************************************************************** 
Function ConnectDatabase() 

    strDBType = "SQL"
    strDBAlias = "wggc"
    strUID = "sa"
    strPWD = "sa20021224$"
    strIP = "10.184.129.171\GCPACSWS"
    strLocalHostName = "csps"
    strDataSource = ""

    Set objConnection = CreateObject("ADODB.CONNECTION" )               '1 - 建立CONNECTION对象的实例 
    
    Select Case UCase(Trim(strDBType)) 
        Case "ORACLE" 
            strConnectionString = "Driver={Microsoft ODBC for Oracle};Server=" & strDBAlias & ";Uid="_ 
                & strUID & ";Pwd=" & strPWD & ";"                                '2 - 建立连接字符串 
            objConnection.Open strConnectionString                                '3 - 用Open 方法建立与数据库连接 
        Case "DB2" 
            strConnectionString = "Driver={IBM DB2 ODBC DRIVER};DBALIAS=" & strDBAlias & ";Uid="_ 
                & strUID & ";Pwd=" & strPWD & ";"                                
            objConnection.Open strConnectionString                                
        Case "SQL" 
             strConnectionString = "DRIVER=SQL Server; SERVER=" & strIP & "; UID=" & strUID & "; PWD="_ 
                 & strPWD & "; APP=Microsoft Office 2003;WSID=" & strLocalHostName & "; DATABASE=" & strDBAlias & ";" 
            objConnection.Open strConnectionString                                            
        Case "ACCESS" 
            strConnectionString = "provider=microsoft.jet.oledb.4.0;data source=" & strDataSource &_ 
                ";Jet OLEDBatabase Password=" & strPWD & ";" 
            objConnection.Open strConnectionString                                                  
        Case Else 
            MsgBox "输入的数据库类型格式有误" & vbCrLf & "支持的数据库类型格式：ORACLE；DB2；SQL；ACCESS；EXCEL" 
    End Select 
    
    If (objConnection.State = 0) Then 
        MsgBox "连接数据库失败！" 
    End If 
    
End Function 


' ******************************************************************** 
' 函数说明：查询数据库（查询单列）; 
' 参数说明：  (1)strSql：SQL语句 
'           (2)strFieldName：字段名 
'           (3)str_Array_QueryResult：数组名（用来返回单列查询结果） 
' 返回结果：  intArrayLength：查询数据库返回的记录行数 
'           str_Array_QueryResult：数组名（用来返回单列查询结果） 
' 调用方法: intArrayLength = QueryDatabase(strSql, strFieldName, str_Array_QueryResult) 
' ******************************************************************** 
Function QueryDatabase(strSql, strFieldName, str_Array_QueryResult) 
    Dim intArrayLength                                                                                     '数组长度 
    i = 0   
    str_Array_QueryResult = Array()                                '重新初始化数组为一个空数组 
    
    Set objRecordSet = CreateObject("ADODB.RECORDSET" )               '4 - 建立RECORDSET对象实例 
    Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
    objCommand.ActiveConnection = objConnection 
    objCommand.CommandText = strSql 
        objRecordSet.CursorLocation = 3 
        objRecordSet.Open objCommand                            '6 - 执行SQL语句,将结果保存在RECORDSET对象实例中 
    
    intArrayLength = objRecordSet.RecordCount                  '将查询结果的行数作为数组的长度 
    
    If intArrayLength > 0 Then 
                ReDim str_Array_QueryResult(intArrayLength-1) 
                
                Do While NOT objRecordSet.EOF                                                '将数据库查询的列值赋值给数组             
                    str_Array_QueryResult(i) = objRecordSet(strFieldName) 
                        'Debug.WriteLine str_Array_QueryResult(i) 
                        objRecordSet.MoveNext 
                        i = i + 1 
                Loop 
'        Else 
                'ReDim str_Array_QueryResult(0)       
                'str_Array_QueryResult(0) = ""     
    End If 
    Set objCommand = Nothing 
    Set objRecordSet = Nothing 
    QueryDatabase = str_Array_QueryResult 
End Function 

' ******************************************************************** 
' 函数说明：更新数据库;包括INSERT、DELETE 和 UPDATE操作 
' 参数说明：(1)strSql：SQL语句 
' 返回结果：无 
' 调用方法: UpdateDatabase(strSql) 
' ******************************************************************** 
Function UpdateDatabase(strSql) 
        Dim objCommand 
        Dim objField        
        
        Set objCommand = CreateObject("ADODB.COMMAND") 
        Set objRecordSet = CreateObject("ADODB.RECORDSET") 
        objCommand.CommandText = strSql 
        objCommand.ActiveConnection = objConnection 
        Set objRecordSet = objCommand.Execute 
        
'        Do Until objRecordSet.EOF 
        
'                For Each objField In objRecordSet.Fields 
'                        Debug.Write objField.Name & ": " & objField.Value & "   " 
'                Next 
                
'                objRecordSet.MoveNext 
'                Debug.WriteLine 
'        Loop        
        
        Set objCommand = Nothing 
        Set objRecordSet = Nothing 
                
End Function 





' ******************************************************************** 
' 函数说明：返回符合查询结果的列的长度 
' 参数说明：(1)strSql：SQL语句 
' 返回结果：返回符合查询结果的列的长度 
' 调用方法: MaxLength = GetLenOfField(strSql) 
' ******************************************************************** 
Function GetLenOfField(strSql) 
    '如果SQL语句为空，则默认返回的列长度为0，结束函数;否则返回列的实际长度 
    If strSql = "" Then 
        GetLenOfField  = 0 
                Exit Function 
    Else 
            Set objRecordSet = CreateObject("ADODB.RECORDSET")                        '4 - 建立RECORDSET对象实例 
            Set objCommand = CreateObject("ADODB.COMMAND")              '5 - 建立COMMAND对象实例 
            objCommand.ActiveConnection = objConnection 
            objCommand.CommandText = strSql 
                objRecordSet.CursorLocation = 3 
                objRecordSet.Open objCommand                                '6 - 执行SQL语句,将结果保存在RECORDSET对象实例中 
            
            GetLenOfField = objRecordSet.RecordCount                              '返回符合查询结果的列的长度 
        
                Set objCommand = Nothing        
                Set objRecordSet = Nothing 
        End If 
End Function 


' ******************************************************************** 
' 函数说明：关闭数据库连接; 
' 参数说明：无 
' 返回结果：无 
' 调用方法: CloseDatabase() 
' ******************************************************************** 
Function CloseDatabase() 
'    objRecordSet.Close 
    objConnection.Close 
    
    Set objCommand = Nothing 
    Set objRecordSet = Nothing 
    Set objConnection = Nothing 
End Function 






Function StartTerminal()

	Dim MyVar

	'Start the application and wait for 10 seconds
	systemutil.Run "Unicorn.exe","","C:\Users\Carestream\AppData\Roaming\Carestream\KioskTerminal","open","1"
	wait 10
	
	Set oShell = nothing
	If WpfWindow("Terminal_MainPanel").Exist Then
		StartTerminal = true
		Else
		StartTerminal = false
	End If
	

End Function





Function WriteLog(LogPath,strtext)
	Dim fs,f
	Set fs = CreateObject("Scripting.FileSystemObject")
	
	If fs.FileExists(LogPath) = false Then
		fs.CreateTextFile(LogPath)
		Set f = fs.OpenTextFile(LogPath, 2,TristateFalse)
		f.WriteLine(date&Time & " Log as follow:")
		f.Close
		
	End If
	
	Set f = fs.OpenTextFile(LogPath, 8,TristateFalse)
	If strtext <> vbcrlf Then
		f.Write(strtext&",")
	Else
		f.Write(strtext)
	End If
	
	f.Close
	
	Set fs =nothing
	Set f = nothing

End Function


Function InputACCN(strACCN,strPID,LogPath)

	Dim oShell
	SET oShell = CreateObject("Wscript.shell")
	'Inoput the accession number and prepare print~
	If WpfWindow("Terminal_MainPanel").Exist Then
		WpfWindow("Terminal_MainPanel").Activate
	   	WpfWindow("Terminal_MainPanel").WpfObject("CacheContentControl").Click
	   	oShell.SendKeys strACCN&"{ENTER}"
'	   	msgbox strACCN,65,1

	Else
			MyVar = MsgBox ("Start failed!", 65, "OK")
	   	
	End If
	
	wait 3 
	
	'Wait the patient information display successfully.
	Dim varText
	Dim CanPrintFlag
	Dim Timeout
	Timeout = 0
	
	Do
		wait 1
		If WpfWindow("Terminal_MainPanel").WpfEdit("Edit_header_patientInfo").Exist() Then
			varText = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_header_patientInfo").GetROProperty("Text")
			result = instr(1,varText,strPID,vbTextCompare)
			If result >0 Then
				CanPrintFlag = true
				else
					CanPrintFlag= false
			End If
			
			else
				CanPrintFlag= false
		End If
		Timeout = Timeout + 1 
	'	msgbox 	CanPrintFlag,65,1
	
	Loop While CanPrintFlag = false and Timeout<=10
	
	If CanPrintFlag Then
		Call WriteLog(LogPath,strACCN&" Create print task successfully")
		Else
			Call WriteLog(LogPath,strACCN&" Create print task failed")
			varText = WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").GetROProperty("Text")
			Call WriteLog(LogPath,varText)
			varText = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_version_FilmReport_info").GetROProperty("Text")
			Call WriteLog(LogPath,varText)
			'Call WriteLog(LogPath,vbcrlf)
			WpfWindow("Terminal_MainPanel").WpfButton("返回").Click
			wait 1 
	End If
	
	Set oShell = nothing
	
	InputACCN = CanPrintFlag
	
End Function





Function PrintTask(LogPath)
		' Start print
		WpfWindow("Terminal_MainPanel").WpfButton("确认打印").Click
		wait 1 
		
		Dim TimeOut
		TimeOut = 0 
		Do
			wait 1
			TimeOut = TimeOut + 1 
			
		Loop While WpfWindow("Terminal_MainPanel").WpfProgressBar("WpfProgressBar").Exist and TimeOut <300
		If TimeOut>=300 Then
'			msgbox "Print failed",65,fail
			Call WriteLog(LogPath,"print failed")
		End If
		
		wait 1
		
		If WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").Exist Then
				varText = WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").GetROProperty("Text")
				call WriteLog(LogPath,"Print successfully " & varText )
								
				If varText <> "打印成功！" Then
						varText = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_version_FilmReport_info").GetROProperty("Text")
						call WriteLog(LogPath,"Print failed " & varText)
'						Call WriteLog(LogPath,vbcrlf)
						WpfWindow("Terminal_MainPanel").WpfButton("返回").Click
						wait 1 
						
					Else
						varText = WpfWindow("Terminal_MainPanel").WpfEdit("Edit_version_FilmReport_info").GetROProperty("Text")
						call WriteLog(LogPath,"Print successfully " & varText )
'						Call WriteLog(LogPath,vbcrlf)
						WpfWindow("Terminal_MainPanel").WpfButton("返回").Click
						wait 1 
					
				End If
				
				
		Else
				varText = WpfWindow("Terminal_MainPanel").WpfObject("打印成功！").GetROProperty("Text")
				call WriteLog(LogPath,"Print failed " & varText )
'				Call WriteLog(LogPath,vbcrlf)
				WpfWindow("Terminal_MainPanel").WpfButton("返回").Click
				
		End If
		

	
End Function

'Update the all data make the patient report can print~
Function ResetAllDataByACC(arrTestData)
	ConnectDatabase()
	For i = 0 To Ubound(arrTestData) Step 1
	
		Dim ResetAllSQL 
		arrtemp = Split(arrTestData(i),",")
		ResetAllSQL = "USE WGGC UPDATE WGGC.DBO.AFP_ReportInfo Set PrintStatus = 0 WHERE AccessionNumber = '"&arrtemp(0) &"'"
			
	    'msgbox ResetAllSQL,65,1
	    UpdateDatabase(ResetAllSQL) 
	
	Next
	CloseDatabase() 	
	
End Function

'Update the all data make the patient report can print~
Function ResetDataByACC(arrTestData)
	ConnectDatabase()
	Dim ResetAllSQL 
	ResetAllSQL = "USE WGGC UPDATE WGGC.DBO.AFP_ReportInfo Set PrintStatus = 0 WHERE AccessionNumber = '"&arrTestData&"'"
'    msgbox ResetAllSQL,65,1
    UpdateDatabase(ResetAllSQL) 
	CloseDatabase() 	
	
End Function

Function GetReportPrintedCount(strACCN)
    Dim strSQL 
    str_Array_QueryResult = Array()
    strSQL = "USE WGGC SELECT count(*) as ReportCount FROM WGGC.DBO.AFP_ReportInfo WHERE DeleteStatus ='0' AND ReportStatus ='2' AND PrintStatus = '1' AND AccessionNumber = '"& strACCN &"'"
    ConnectDatabase() 
    str_Array_QueryResult = QueryDatabase(strSql, "ReportCount", str_Array_QueryResult) 
    CloseDatabase() 
    GetReportPrintedCount = str_Array_QueryResult(0)

End Function



Function GetAccN(strDatapath)
	Dim fs,f
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set f = fs.OpenTextFile(strDatapath,1,TristateFalse)
	text = f.ReadAll
	ArrayLine = Split(text,vbcrlf)
	
'	For i = 1 To Ubound(ArrayLine) Step 1
'		msgbox ArrayLine(i),65,1
'	Next
	Set fs = nothing
	Set f = nothing
	GetAccN = ArrayLine
End Function


Function KillProc(procName)
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

'strProcessKill = "'Wscript.exe'" 

Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" _ 
& strComputer & "\root\cimv2") 

Set colProcess = objWMIService.ExecQuery _
("Select * from Win32_Process Where Name = " & procName )
For Each objProcess in colProcess
objProcess.Terminate()
Next 	
Set objWMIService = nothing
Set colProcess = nothing

End Function