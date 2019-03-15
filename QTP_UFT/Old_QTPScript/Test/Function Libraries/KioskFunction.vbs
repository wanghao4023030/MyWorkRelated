Function CreateTestData(strfilePath,sheetName,DicomNumber,Flag)

	SystemUtil.CloseProcessByName("EXCEL.exe")
	Dim ExcelObject,ExcelWB,ExcelSheet
	Set ExcelObject = CreateObject("Excel.Application") 
	ExcelObject.Visible = false
	Set ExcelWB = ExcelObject.Workbooks.open(strfilePath)
    Set ExcelSheet = ExcelWB.Sheets(sheetName)

	If Flag = "Y"Then
		ExcelObject.ActiveSheet.cells.clear
	End If

	ExcelObject.ActiveSheet.Columns("A").NumberFormatLocal = "0"
	ExcelObject.ActiveSheet.Columns("F").NumberFormatLocal = "0"
	ExcelObject.Cells(1,1).value = "ID"
	ExcelObject.Cells(1,2).value = "PatientID"
	ExcelObject.Cells(1,3).value = "PatientName"
	ExcelObject.Cells(1,4).value = "EnglishName"
	ExcelObject.Cells(1,5).value = "AccessionNo"
	ExcelObject.Cells(1,6).value = "DICOMTYPE"
	ExcelObject.Cells(1,7).value = "RISCreate"
	ExcelObject.Cells(1,8).value = "SendFlag"
	ExcelObject.Cells(1,9).value = "RISReportFlag"
	ExcelObject.Cells(1,10).value = "ReportSendFlag"
	ExcelObject.Cells(1,11).value = "OcrFlag"
	ExcelObject.DisplayAlerts = False
	
	Dim objConnection                          'CONNECTION对象实例 
	Dim objRecordSet                           'RECORDSET对象实例        
	Dim objCommand                                '命令对象实例 
	Dim strConnectionString                        '连接字符串 
    Dim i	
	Set objRecordSet = CreateObject("ADODB.RECORDSET")                '4 - 建立RECORDSET对象实例 
	Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
	objConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&strfilePath&";Extended Properties=Excel 8.0"
	objCommand.ActiveConnection = objConnection 
	strSql = "Select count(ID) as ID  from ["&SheetName&"$]"
	objCommand.CommandText = strSql 
	objRecordSet.CursorLocation = 3 
	objRecordSet.Open objCommand 
	'上文选出当前没有执行过的最大ID
	
'	msgbox "objRecordSet.MaxRecords===="&objRecordSet.MaxRecords
'	msgbox "objRecordSet(0)===="&objRecordSet(0)
	
	If objRecordSet(0)>0 then
			i = objRecordSet(0)
			i=i+1
		else
				i=1
	end if

	Set objCommand = Nothing 
	Set objRecordSet = Nothing 
	Set strConnectionString = Nothing
	Set  objConnection = Nothing
	For j=i to i+DicomNumber-1
			
			temp = RandomNumber(0,3)
		'	msgbox temp
				If temp =0 Then
					CTtype ="CR"
				End If
				If temp=1 Then
						CTtype = "DX"
				End If
				If temp =2 Then
					CTtype = "CT"
				End If
	
				If temp =3 Then
					CTtype = "MR"
				End If
	
				Guidtemp = CreateExtendInfo()
				Guidtemp= mid(Guidtemp,4,11)
				MyArr = split(GetIPMAC("."),".",-1,1)
	
				If len(MyArr(3)=3) then
					Guidtemp  = Guidtemp&MyArr(3)
					else 
							Guidtemp  = Guidtemp&"3"&MyArr(3)
				end if 
	
				
	
	
	
				ExcelObject.Cells(j+1,1).value = j
				ExcelObject.Cells(j+1,2).value = "P"&Guidtemp
				ExcelObject.Cells(j+1,3).value = "N"&Guidtemp
				ExcelObject.Cells(j+1,4).value = "E"&Guidtemp
				ExcelObject.Cells(j+1,5).value = "A"&Guidtemp
				ExcelObject.Cells(j+1,6).value =CTtype
				ExcelObject.Cells(j+1,7).value = "0"
				ExcelObject.Cells(j+1,8).value = "0"
				ExcelObject.Cells(j+1,9).value = "0"
				ExcelObject.Cells(j+1,10).value = "0"
				ExcelObject.Cells(j+1,11).value = "0"
	
	next
'			ExcelObject.Cells(j+100,1).value = strSql
	ExcelWB.Save 
	ExcelObject.Workbooks.Close
	ExcelObject.DisplayAlerts = true
	ExcelObject.Quit
	SystemUtil.CloseProcessByName("EXCEL.exe")
	Set objCommand = Nothing 
	Set objRecordSet = Nothing 
	Set strConnectionString = Nothing
	Set  objConnection = Nothing
	set Guid = Nothing
	Reporter.ReportEvent micPass, "数据输入","EXCEL——测试输入生成成功！导入"&DicomNumber&"条数据。输入文件目录"&strfilePath&DicomNumber&""
End Function



Function AddTestData(strfilePath,SheetName,DicomNumber)

	SystemUtil.CloseProcessByName("EXCEL.exe")
	Dim ExcelObject,ExcelWB,ExcelSheet
	Set ExcelObject = CreateObject("Excel.Application") 
	ExcelObject.Visible = false
	Set ExcelWB = ExcelObject.Workbooks.open(strfilePath)
    Set ExcelSheet = ExcelWB.Sheets(SheetName)
'	msgbox ExcelWB,1,"ExcelWB"
'	msgbox ExcelSheet,1,"ExcelSheet"
	'初始化文件的首字段名称
'	ExcelObject.Workbooks(SheetName ).Activate 
	ExcelObject.ActiveSheet.cells.clear
	ExcelObject.ActiveSheet.Columns("A").NumberFormatLocal = "0"
	ExcelObject.ActiveSheet.Columns("F").NumberFormatLocal = "0"
	ExcelObject.Cells(1,1).value = "ID"
	ExcelObject.Cells(1,2).value = "PatientID"
	ExcelObject.Cells(1,3).value = "PatientName"
	ExcelObject.Cells(1,4).value = "EnglishName"
	ExcelObject.Cells(1,5).value = "AccessionNo"
	ExcelObject.Cells(1,6).value = "DICOMTYPE"
	ExcelObject.Cells(1,7).value = "RISCreate"
	ExcelObject.Cells(1,8).value = "SendFlag"
	ExcelObject.Cells(1,9).value = "RISReportFlag"
	ExcelObject.Cells(1,10).value = "ReportSendFlag"
	ExcelObject.Cells(1,11).value = "OcrFlag"
	ExcelObject.DisplayAlerts = False
	
	Dim objConnection                          'CONNECTION对象实例 
	Dim objRecordSet                           'RECORDSET对象实例        
	Dim objCommand                                '命令对象实例 
	Dim strConnectionString                        '连接字符串 
    Dim i	
	Set objRecordSet = CreateObject("ADODB.RECORDSET")                '4 - 建立RECORDSET对象实例 
	Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
	objConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&strfilePath&";Extended Properties=Excel 8.0"
	objCommand.ActiveConnection = objConnection 
	strSql = "Select count(ID) as ID  from ["&SheetName&"$]"
	objCommand.CommandText = strSql 
	objRecordSet.CursorLocation = 3 
	objRecordSet.Open objCommand 
	'上文选出当前没有执行过的最大ID
	
'	msgbox "objRecordSet.MaxRecords===="&objRecordSet.MaxRecords
'	msgbox "objRecordSet(0)===="&objRecordSet(0)
	
	If objRecordSet(0)>0 then
			i = objRecordSet(0)
			i=i+1
		else
				i=1
	end if

Set objCommand = Nothing 
Set objRecordSet = Nothing 
Set strConnectionString = Nothing
Set  objConnection = Nothing
For j=i to i+DicomNumber-1
		
		temp = j mod 4
			If temp =0 Then
				CTtype ="CR"
			End If
			If temp=1 Then
					CTtype = "DX"
			End If
			If temp =2 Then
				CTtype = "CT"
			End If

			If temp =3 Then
				CTtype = "MR"
			End If
			Guidtemp = CreateExtendInfo()

			ExcelObject.Cells(j+1,1).value = j
			ExcelObject.Cells(j+1,2).value = "P"&Guidtemp
			ExcelObject.Cells(j+1,3).value = "N"&Guidtemp
			ExcelObject.Cells(j+1,4).value = "E"&Guidtemp
			ExcelObject.Cells(j+1,5).value = "A"&Guidtemp
			ExcelObject.Cells(j+1,6).value =CTtype
			ExcelObject.Cells(j+1,7).value = "0"
			ExcelObject.Cells(j+1,8).value = "0"
			ExcelObject.Cells(j+1,9).value = "0"
			ExcelObject.Cells(j+1,10).value = "0"
			ExcelObject.Cells(j+1,11).value = "0"
		
next
'			ExcelObject.Cells(j+100,1).value = strSql
			ExcelWB.Save 
			ExcelObject.Workbooks.Close
			ExcelObject.DisplayAlerts = true
			ExcelObject.Quit
			SystemUtil.CloseProcessByName("EXCEL.exe")
			Set objCommand = Nothing 
			Set objRecordSet = Nothing 
			Set strConnectionString = Nothing
			Set  objConnection = Nothing
			set Guid = Nothing
			Reporter.ReportEvent micPass, "数据输入","EXCEL——测试输入生成成功！导入"&DicomNumber&"条数据。输入文件目录"&strfilePath&DicomNumber&""
End Function



Function Gobal_EXCEL_Query(strSql,strEXCELpath,strEXCELSHEET, strFieldName, str_Array_QueryResult)
Dim objConnection                          'CONNECTION对象实例 
Dim objRecordSet                           'RECORDSET对象实例        
Dim objCommand                                '命令对象实例 
Dim strConnectionString                        '连接字符串 

Set objRecordSet = CreateObject("ADODB.RECORDSET")                '4 - 建立RECORDSET对象实例 
Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
	objConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&strEXCELpath&";Extended Properties=Excel 8.0"
    objCommand.ActiveConnection = objConnection 
'	strSql = "SELECT * FROM ["&strEXCELSHEET&"$] where ID = (Select min(ID) from ["&strEXCELSHEET&"$] where flag='0')"
    objCommand.CommandText = strSql 
	objRecordSet.CursorLocation = 3 
    objRecordSet.Open objCommand                            '6 - 执行SQL语句,将结果保存在RECORDSET对象实例中 
    Dim intArrayLength                                                                                     '数组长度 
    Dim i 
     i = 0   
   ' str_Array_QueryResult = Array()    

	intArrayLength = objRecordSet.RecordCount                  '将查询结果的行数作为数组的长度 
      If intArrayLength > 0 Then 
                ReDim str_Array_QueryResult(intArrayLength-1) 
                
                Do While NOT objRecordSet.EOF                                                '将数据库查询的列值赋值给数组             
                    str_Array_QueryResult(i) = objRecordSet(strFieldName) 
                        'Debug.WriteLine str_Array_QueryResult(i) 
'						msgbox str_Array_QueryResult(i) 
                        objRecordSet.MoveNext 
                        i = i + 1 
                Loop 
    End If 
	
    Gobal_EXCEL_Query = intArrayLength 

	    Set objCommand = Nothing 
        Set objRecordSet = Nothing 
		Set objConnection = Nothing
		Set strConnectionString = Nothing

End Function



Function Gobal_EXCEL_CommentUpdate(strEXCELpath,strEXCELSHEET,strQueryFileName,strQueryValue,strUpdateFileName,stUpdatevalue)
   	
Dim objConnection                          'CONNECTION对象实例 
Dim objRecordSet                           'RECORDSET对象实例        
Dim objCommand                                '命令对象实例 
Dim strConnectionString                        '连接字符串 

Set objRecordSet = CreateObject("ADODB.RECORDSET")                '4 - 建立RECORDSET对象实例 
Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
	objConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&strEXCELpath&";Extended Properties=Excel 8.0"
    objCommand.ActiveConnection = objConnection 

	Sql = "Update ["&strEXCELSHEET&"$] set  "&strUpdateFileName&" = '"&stUpdatevalue&"'  where  "&strQueryFileName&" ='"&strQueryValue&"'"
'	msgbox Sql
    objCommand.CommandText = Sql 
'	msgbox strSql
	objRecordSet.CursorLocation = 3 
	objCommand.Execute                           '6 - 执行SQL语句,将结果保存在RECORDSET对象实例中 
	
        Set objCommand = Nothing 
        Set objRecordSet = Nothing 
		Set objConnection = Nothing
	
End Function






Function CreateExtendInfo()
	cYear = Year (Now)
	cMonth = Month (Now)
	cDay = Day (Now)
	cTime=Hour(Now)
	cMin =Minute(Now)
    cSec= Second(Now)

	If cMonth < 10 Then
		cMonth = "0"&cMonth
	End If
	If cDay < 10 Then
		cDay = "0"&cDay
	End If
	If cMin < 10 Then
		cMin = "0"&cMin
	End If
   If cSec < 10 Then
		cSec = "0"&cSec
	End If

	If cTime <10 Then
		cTime= "0"&cTime
	End If

	MyTime = cYear&cMonth&cDay&cTime&cMin&cSec
   CreateExtendInfo = MyTime
   wait(1)

End Function


Function Global_DicomSendToolSend(DicomType,DicomName,str_DicomPatientName,str_DicomPatientID,str_DicomAccessionNumber,StudyNumber,SeriesNumber,ImageNumber)
	Dim DicomPatientName,DicomPatientID,DicomSOPInstanceUID,DicomStudyInstanceUID,DicomSeriesInstanceUID,DicomAccessionNumber
	DicomPatientName ="PatinetName"
	DicomPatientID ="PatinetID"
	DicomAccessionNumber = "ACCN"
	Dim Tool_path
	Tool_path=Environment.Value("ToolPath")
	Dim Dicom_FullPath
	Dicom_FullPath =Environment.Value("DicomPath")&DicomName&".dcm"    '-------------------
        Select Case DicomType
        Case "CR"
           PN=""&Dicom_FullPath&";(0010,0010)     PN     --Patient's Name;"&DicomPatientName
           PID=""&Dicom_FullPath&";(0010,0020)     LO     --Patient ID;"&DicomPatientID
           Acc=""&Dicom_FullPath&";(0008,0050)     SH     --Accession Number;"&DicomAccessionNumber
        Case "DX"
           PN=""&Dicom_FullPath&";(0010,0010)     PN     --Patient's Name;"&DicomPatientName
           PID=""&Dicom_FullPath&";(0010,0020)     LO     --Patient ID;"&DicomPatientID
           Acc=""&Dicom_FullPath&";(0008,0050)     SH     --Accession Number;"&DicomAccessionNumber
        Case "CT"
           PN=""&Dicom_FullPath&";(0010,0000)     UL     --Group Length;(0010,0010)     PN     --Patient's Name;"&DicomPatientName
           PID=""&Dicom_FullPath&";(0010,0000)     UL     --Group Length;(0010,0020)     LO     --Patient ID;"&DicomPatientID
           Acc=""&Dicom_FullPath&";(0008,0000)     UL     --Group Length;(0008,0050)     SH     --Accession Number;"&DicomAccessionNumber
        Case "MR"
           PN=""&Dicom_FullPath&";(0010,0000)     UL     --Group Length;(0010,0010)     PN     --Patient's Name;"&DicomPatientName
           PID=""&Dicom_FullPath&";(0010,0000)     UL     --Group Length;(0010,0020)     LO     --Patient ID;"&DicomPatientID
           Acc=""&Dicom_FullPath&";(0008,0000)     UL     --Group Length;(0008,0050)     SH     --Accession Number;"&DicomAccessionNumber
       Case Else
           Print "设备类型"&DicomType&"不存在!"
        End Select 
        SystemUtil.CloseProcessByName("DcmTool.exe")
	Dim oShell 
	Dim WshShell 
	Set oShell=CreateObject ("WScript.Shell")

	oShell.Exec ""&Tool_path&"\Dcmtool.exe"
	Set	oShell = Nothing

Window("Untitled").Activate
Window("Untitled").WinToolbar("ToolbarWindow32").Press 2


	Set WshShell=CreateObject ("WScript.Shell")

Window("Untitled").Dialog("Open").WinEdit("File name:").Set Dicom_FullPath
'Window("Untitled").Dialog("Open").WinButton("打开(O)").Click

Window("Untitled").Dialog("Open").WinButton("Open").Click

If  Dialog("Windows Explorer").Exist(3) Then
	Dialog("Windows Explorer").WinObject("Restart the program").Click
	wait (5)
End If
	wait (2)
Window("dcm").WinTreeView("SysTreeView32").Expand PN 
Window("dcm").WinTreeView("SysTreeView32").Select PN   '--------------
Window("dcm").WinTreeView("SysTreeView32").EditLabel PN
wait (1)
Sendkey  "{BackSpace}"&str_DicomPatientName&"{Enter}"
'WshShell.Run Tool_path&"\mouse.exe l"
wait (1)

'WshShell.SendKeys str_DicomPatientName :Wait 0,500
Window("dcm").WinTreeView("SysTreeView32").Expand PID
Window("dcm").WinTreeView("SysTreeView32").Select PID    '---------------
Window("dcm").WinTreeView("SysTreeView32").EditLabel PID
wait (1)
Sendkey  "{BackSpace}"&str_DicomPatientID&"{Enter}"
'WshShell.Run Tool_path&"\mouse.exe l"
wait (1)
'WshShell.SendKeys str_DicomPatientID :Wait 0,500
Window("dcm").WinTreeView("SysTreeView32").Expand  Acc
Window("dcm").WinTreeView("SysTreeView32").Select Acc   '----------
Window("dcm").WinTreeView("SysTreeView32").EditLabel Acc
wait (1)
Sendkey  "{BackSpace}"&str_DicomAccessionNumber&"{Enter}"
'WshShell.Run Tool_path&"\mouse.exe l"
wait (1)
'WshShell.SendKeys str_DicomAccessionNumber :Wait 0,500
wait (1)
Window("dcm").WinTreeView("SysTreeView32").Click
WshShell.SendKeys "%S"
WshShell.SendKeys "B"
Set WshShell = Nothing

Window("dcm").Dialog("批量发图").WinEdit("发几个Study：").Set StudyNumber
Window("dcm").Dialog("批量发图").WinEdit("一个Series含几个Images：").Set ImageNumber
Window("dcm").Dialog("批量发图").WinEdit("一个Study含几个Series：").Set SeriesNumber
Window("dcm").Dialog("批量发图").WinButton("发送").Click
do 
	wait(5)
loop until Window("dcm").Dialog("批量发图").WinButton("发送").WaitProperty("enabled",True,120)=True

Window("dcm").Dialog("批量发图").Close
systemutil.CloseProcessByName("mouse.exe")
 SystemUtil.CloseProcessByName("DcmTool.exe")


   If  Dialog("Dcmtool.exe_error").Exist(3)Then
			Dialog("Dcmtool.exe_error").WinObject("Close the program").Click
   End If
End Function











'*********************************************************************
'功能：打开指定RIS界面左侧的主菜单的子菜单
'参数：调用对象库中保存的对象属性swfname
'示例：Window("RIS_配置_排班管理").SwfObject("排班管理").ClickLeftMenu
'*********************************************************************
Function ClickLeftMenu(Object)
        if fg=0 then
            On error resume next
        end if 
        SubMenuName=Object.GetTOProperty("swfname")
        Set autoit=createobject("autoitx3.control")
		autoit.BlockInput(1)
        autoit.WinActivate "CARESTREAM RIS GC"
        autoit.Opt "WinTitleMatchMode", 4
        autoit.ControlClick "CARESTREAM RIS GC","","[NAME:"&SubMenuName&"]"
		autoit.BlockInput(0)
        set autoit=nothing 
		Wait 2
		  if fg=0 then
              Call ErrorHandle("ClickLeftMenu")
           end if
End Function
RegisterUserFunc"SwfObject","ClickLeftMenu","ClickLeftMenu"




'---------------------------------------------------------------------
'新建PID 和ACCN 格式的函数，输入参数 startnum 起始数字 ， accountNumber 要造的数量
'NumberLen 造数的长度（数字）
'数据格式  PID + 0000 + startnum   , 000+startnumber 长度 = NumberLen
'eg: NumberLen=3 PID001  ,PID002.......PID999 
'---------------------------------------------------------------------
Function CreatePIDACCNInfo(Start_Num,accountNumber,NumberLen)
Dim stringlen
Dim PIDACCN_start_Num
Dim PIDACCNex
call ConnectDatabase(strDBType, strDBAlias, strUID, strPWD, strIP, strLocalHostName, strDataSource) 
PIDACCN_start_Num = Start_Num

FOR i=1 to accountNumber
stringlen = (Len(PIDACCN_start_Num))
'msgbox i
PIDACCNex = PIDACCN_start_Num

	For stringlen = (Len(PIDACCN_start_Num))+1 to NumberLen '8 是ocr中正则表达式设置的数字长度
		PIDACCNex = "0"&PIDACCNex
		
	Next
accn=defineaccn&PIDACCNex
PID=definePID&PIDACCNex
PatinetName=definePatinetName&PIDACCNex
EnglishName=defineEnglishName&PIDACCNex
'msgbox accn
'msgbox PID
'msgbox PatinetName
'msgbox EnglishName

call SetstrSql()
'	msgbox strSql	
call UpdateDatabase(RIS_CreratePatinet_strSql) 
PIDACCN_start_Num =PIDACCN_start_Num+1
Next
call CloseDatabase
End Function 

 Function SetstrSql(accn,PID,PatinetName,EnglishName)
 SetstrSql ="EXEC [dbo].[Test_SP_REGISTRATIONPATIENT] "&Chr(13)&Chr(10)_
		&"@AccNo = N'"&accn&"',"&Chr(13)&Chr(10) _
		&"@PatientID = N'"&PID&"',"&Chr(13)&Chr(10) _
		&"@PatientName = N'"&PatinetName&"',"&Chr(13)&Chr(10) _
		&"@EnglishName = N'"&EnglishName&"',"&Chr(13)&Chr(10) _
		&"@ClinicNo = N'',"&Chr(13)&Chr(10) _
		&"@CurrentAge = N'26',"&Chr(13)&Chr(10) _
		&"@Gender = N'男',"&Chr(13)&Chr(10) _
		&"@ModalityType = N'CR',"&Chr(13)&Chr(10) _
		&"@Modality = N'KODAK_CR',"&Chr(13)&Chr(10) _
		&"@ProcedureCode = N'0220',"&Chr(13)&Chr(10) _
		&"@PatientType = N'住院病人',"&Chr(13)&Chr(10) _
		&"@ExamSystem = N'其他',"&Chr(13)&Chr(10) _
		&"@IsVIP = 0,"&Chr(13)&Chr(10) _
		&"@InHospitalNo= '',"&Chr(13)&Chr(10) _
		&"@InHospitalRegion = '',"&Chr(13)&Chr(10) _
		&"@BedNo = '',"&Chr(13)&Chr(10) _
		&"@PatientBirthday = '1987-04-16 00:00:00.000',"&Chr(13)&Chr(10) _
		&"@ApplyDoctor = '',"&Chr(13)&Chr(10) _
		&"@ApplyDept = '',"&Chr(13)&Chr(10) _
		&"@Observation = '',"&Chr(13)&Chr(10) _
		&"@HealthHistory='',"&Chr(13)&Chr(10) _
		&"@Address = '',"&Chr(13)&Chr(10) _
		&"@Telephone = '',"&Chr(13)&Chr(10) _
		&"@IsScan = '0'"&Chr(13)&Chr(10) 

End Function
 
 
 
 
' DATABASE公用函数 
' 
'########################################################################################################### 
'########################################################################################################### 

Public objConnection                          'CONNECTION对象实例 
Public objRecordSet                                   'RECORDSET对象实例        
Public objCommand                                '命令对象实例 
Public strConnectionString                        '连接字符串 

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
Function ConnectDatabase(strDBType, strDBAlias, strUID, strPWD, strIP, strLocalHostName, strDataSource) 

    Set objConnection = CreateObject("ADODB.CONNECTION" )               '1 - 建立CONNECTION对象的实例 
    
    Select Case UCase(Trim(strDBType)) 
        Case "ORACLE" 
            strConnectionString = "Driver={Microsoft ODBC for Oracle};Server=" & strDBAlias & ";Uid="_ 
                & strUID & ";Pwd=" & strPWD & ";"                              '2 - 建立连接字符串 
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
     Dim i 
    
    i = 0   
   ' str_Array_QueryResult = Array()                                '重新初始化数组为一个空数组 
    
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
    
    QueryDatabase = intArrayLength 
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
		'msgbox strSql
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
    'objRecordSet.Close 
   objConnection.Close 
    
    Set objCommand = Nothing 
    Set objRecordSet = Nothing 
    Set objConnection = Nothing 
End Function 


Function GetPrintFilmWinButtonNumber(PID)

Call ConnectDatabase(strDBType_GX, strDBAlias_GX, strUID_GX, strPWD_GX, strIP_GX, strLocalHostName_GX, strDataSource_GX)

strSql = "Select ImageCount  from Patient where patientid = '"&PID&"'"
call QueryDatabase(strSql,"ImageCount",str_Array_QueryResult)
ImageCount = str_Array_QueryResult(0)
strSql_excel= "Select DICOMTYPE  from ["&SheetName&"$] where patientid = '"&PID&"'"

call  Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"DICOMTYPE",str_Array_QueryResult)

DICOMTYPE = str_Array_QueryResult(0)
strSql = "select PropertyValue from systemprofile where PropertyName = 'DefPlayout."&DICOMTYPE&"'"
Call QueryDatabase(strSql,"PropertyValue",str_Array_QueryResult)
Dim PrimtDefPlayout
PrimtDefPlayout = str_Array_QueryResult(0)
PrimtDefPlayout =Mid(PrimtDefPlayout,1,1)*Mid(PrimtDefPlayout,2,1)

Dim PageNumberOfPrint
PageNumberOfPrint = ImageCount mod PrimtDefPlayout 
If  PageNumberOfPrint =0Then
	GetPrintFilmWinButtonNumber = ImageCount\PrimtDefPlayout
	else 
		GetPrintFilmWinButtonNumber= ImageCount\PrimtDefPlayout +1
End If

End Function



'*********************************************************************
'功能:获取列表中指定行和列的值
'参数:RowNum 行号 从0开始；ColumName  列名；返回该Cell的值
'示例：SwfWindow("CARESTREAM RIS GC - hospitalna").SwfObject("c1FlexGrid").GetCellText("1","病人编号")
''*********************************************************************
Function GetCellText(Object,RowNum,ColumName)
if fg=0 then
  On error resume next
end if 
If object.Exist(5) Then
For i=0 to  Object.Object.ColumnCount-1
 If Object.Object.Rows.Item(RowNum).cells.item(i).ColumnInfo.HeaderText=ColumName Then
      GetCellText=Object.Object.Rows.Item(RowNum).cells.item(i).value
	  Exit For
	elseif i=Object.Object.ColumnCount-1 then
	print ColumName&" not exist"
	Exittest
 End If
Next
else
        print  "对象："& object.GetTOProperty("class name")&"("""& object.GetTOProperty("testobjname")&""")"&"找不到！"
 end if 
if fg=0 then
  Call ErrorHandle("GetCellText")
end if
End Function
RegisterUserFunc"SwfObject","GetCellText","GetCellText"

'*********************************************************************
'功能:返回有指定单元格值的行号，行号从0开始，如果找不到，返回为-1
'参数:Text 指定单元格的内容  ； 
'示例：SwfWindow("CARESTREAM RIS GC - hospitalna").SwfObject("c1FlexGrid").FindRow("PID000000000051")

Function FindRow(Object,Text)
if fg=0 then
   On error resume next
end if 
If object.Exist(5) Then
FindRow=Object.Object.FindRow(Text,0,0,True,True)
else
       FindRow=-1
        print  "对象："& object.GetTOProperty("class name")&"("""& object.GetTOProperty("testobjname")&""")"&"找不到！"
end if 

if fg=0 then
Call ErrorHandle("FindRow")
end if 
End Function
RegisterUserFunc"SwfObject","FindRow","FindRow"

'*********************************************************************
'功能: 双击指定单元格
'参数: Rownum 指定行号 从0开始,ColumName 列名
'示例：SwfWindow("CARESTREAM RIS GC - hospitalna").SwfObject("c1FlexGrid").DbClickCell 0,"状态"

Function DbClickCell(Object,Rownum,ColumName)
if fg=0 then
   On error resume next
end if 
If object.Exist(5) Then
HeadCloumnHeight=28 '表头列的高度
Height=Object.Object.Rows.Item(0).Height
x=0
For i=0 to  Object.Object.ColumnCount-1
    If  Object.Object.Columns.Item(i).HeaderText=ColumName Then
         x=x+Object.Object.Columns.Item(i).width/2
		 Exit for 
	else 
	     x=x+Object.Object.Columns.Item(i).width
	End If
Next
	y=HeadCloumnHeight+(Rownum+1)*Object.Object.Rows.Item(0).Height-Object.Object.Rows.Item(0).Height/2
	Object.DblClick  x,y,micLeftBtn
 else
        print  "对象："& object.GetTOProperty("class name")&"("""& object.GetTOProperty("testobjname")&""")"&"找不到！"
 end if 
if fg=0 then
Call ErrorHandle("DbClickCell")
end if 
End Function
RegisterUserFunc"SwfObject","DbClickCell","DbClickCell"
'*********************************************************************
'功能: 单击指定单元格
'参数: Rownum 指定行号 从0开始,ColumName 列名
'示例：SwfWindow("CARESTREAM RIS GC - hospitalna").SwfObject("c1FlexGrid").ClickCell 0,"状态"

Function ClickCell(Object,Rownum,ColumName)
if fg=0 then
  On error resume next
end if 
If object.Exist(5) Then
HeadCloumnHeight=28 '表头列的高度
Height=Object.Object.Rows.Item(0).Height
x=0
For i=0 to  Object.Object.ColumnCount-1
    If  Object.Object.Columns.Item(i).HeaderText=ColumName Then
         x=x+Object.Object.Columns.Item(i).width/2
		 Exit for 
	else 
	     x=x+Object.Object.Columns.Item(i).width
	End If
Next
	y=HeadCloumnHeight+(Rownum+1)*Object.Object.Rows.Item(0).Height-Object.Object.Rows.Item(0).Height/2
	Object.Click  x,y,micLeftBtn
else
        print  "对象："& object.GetTOProperty("class name")&"("""& object.GetTOProperty("testobjname")&""")"&"找不到！"
 end if 
 
if fg=0 then
 Call ErrorHandle("ClickCell")
end if 
End Function
RegisterUserFunc"SwfObject","ClickCell","ClickCell"



'*********************************************************************
'功能：选择下列框的值   注：对象要取SwfObject，不要取Edit
'参数：text为要选择的内容。
'示例：Window("RIS_登记_预约").SwfObject("病人类型").DropDownListSelect "急诊病人"
'*********************************************************************
Sub DropDownListSelect(Object,text)
    if fg=0 then
            On error resume next
     end if 
    If object.Exist(5) Then
	    Object.Object.SelectedText=text
	else
        print  "对象："& object.GetTOProperty("class name")&"("""& object.GetTOProperty("testobjname")&""")"&"找不到！"
   end if 
    if fg=0 then
              Call ErrorHandle("DropDownListSelect")
    end if
End Sub
RegisterUserFunc "SwfObject", "DropDownListSelect", "DropDownListSelect"



'-------------------------------------------------------------------------------------------------------------与业务相关--------------------------
Function LoginGXPlatform()
   systemutil.CloseProcessByName "lcpacs.exe"
   wait 4
  systemutil.Run "lcpacs.exe","",Environment.Value("GXURL")
Do 
	wait 1
Loop until Dialog("GXLogin").exist(5)
If  Dialog("GXLogin").exist(2) Then
    Dialog("GXLogin").WinEdit("用户名").Set Environment.Value("GXUSER")
	Dialog("GXLogin").WinEdit("密码").Set Environment.Value("GXPassWord")
	wait(1)
	Dialog("GXLogin").WinButton("登录").Click
	wait(3)
    If Dialog("GXLogin").Dialog("GX Workstation_loginWarning").Exist(3) then
			Dialog("GXLogin").Dialog("GX Workstation_loginWarning").WinButton("否").Click
			If  Dialog("工作列表").Exist(30) Then
				wait(1)
				Else
				      sendkey"{ENTER}"
			End If
	end if
     If Dialog("GX_loginWarning_PreCD").Dialog("GX Workstation").WinButton("确定").Exist(5) then
        Dialog("GX_loginWarning_PreCD").Dialog("GX Workstation").WinButton("确定").Click
   end if 
        	If  Dialog("打印面板").Exist(2) Then
					Dialog("打印面板").Close
	        End If
	else
		msgbox  "info",1,"GXlogin failed~~~~"
end if
End Function

Function  RISStartandLogin()
    SystemUtil.CloseProcessByWndTitle"KODAK GC RIS 2.0",True
    SystemUtil.CloseProcessByWndTitle"CARESTREAM RIS GC.*",True
    SystemUtil.CloseProcessByWndTitle"Carestream.GCRIS.*",True
	wait 2
    RISInstallPath= Environment.Value("RISURL")
	SystemUtil.Run "Kodak.GCRIS.exe", "", RISInstallPath
    wait 5
    Login "管理员",Environment.Value("RISLoginUser"),Environment.Value("LoginPassWord")
End Function 






Function RISCreatePatient(strfilePath, sheetName)
	strSql_excel = "SELECT * FROM ["&SheetName&"$]  where RISCreate = 0 "

	Call  Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"ID",iCount_Array_QueryResult)
	iCount = UBound(iCount_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"PatientID",PatientID_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"PatientName",PatinetName_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"EnglishName",EnglishName_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"AccessionNo",accn_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"DICOMTYPE",DICOMTYPE_Array_QueryResult)

	For i =0 to iCount  
		PID = PatientID_Array_QueryResult(i)
		PatinetName = PatinetName_Array_QueryResult(i)
		EnglishName =  EnglishName_Array_QueryResult(i)
		accn =  accn_Array_QueryResult(i)
		DICOMTYPE = DICOMTYPE_Array_QueryResult(i)
		
		SwfWindow("RIS_登记_登记检查").SwfObject("登记检查").ClickLeftMenu
		If SwfWindow("RIS_登记_登记检查").SwfObject("新建登记(F2)").Object.Enabled=False  then
		   SwfWindow("RIS_登记_登记检查").SwfObject("取消").Click
			If   SwfWindow("RIS_登记_登记检查").SwfWindow("消息框").Exist(2) Then
				  SwfWindow("RIS_登记_登记检查").SwfWindow("消息框").SwfObject("否(N)").Click
			End If
		end if 
		
		SwfWindow("RIS_登记_登记检查").SwfObject("新建登记(F2)").Click
		SwfWindow("RIS_登记_登记检查").SwfEdit("病人姓名").Set "性能"&PatinetName:Wait 2
		SwfWindow("RIS_登记_登记检查").SwfEdit("病人编号").Set PID:Wait 1
		SwfWindow("RIS_登记_登记检查").SwfEdit("放射编号").Set accn:Wait 1
		
		SwfWindow("RIS_登记_登记检查").SwfObject("性别").DropDownListRandomSelect
		SwfWindow("RIS_登记_登记检查").SwfEdit("年龄").Set RandomNumber(1,100)
		SwfWindow("RIS_登记_登记检查").SwfObject("年龄单位").DropDownListRandomSelect
		SwfWindow("RIS_登记_登记检查").SwfObject("病人类型").DropDownListRandomSelect
	
		RegisterAddRP 1,1
		SwfWindow("RIS_登记_登记检查").SwfObject("保存(F4)").Click
		
		Call Gobal_EXCEL_CommentUpdate(strfilePath,SheetName,"PatientID",PID,"RISCreate","1")

		If  i+1 Mod 500 = 0 Then
			Systemutil.CloseProcessByName "Kodak.GCRIS.exe"	
			RISStartandLogin		
		End If
	Next
End Function



Function RISCreateReport (strfilePath, sheetName)
	strSql_excel = "SELECT * FROM ["&SheetName&"$]  where RISCreate = 1 and RISReportFlag = 0"
	Call  Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"ID",iCount_Array_QueryResult)
	iCount = UBound(iCount_Array_QueryResult)
	Call  Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"PatientID",PID_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"PatientName",PatinetName_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"EnglishName",EnglishName_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"AccessionNo",accn_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"DICOMTYPE",DICOMTYPE_Array_QueryResult)

	For i=0 to iCount
		PID = PID_Array_QueryResult(i)
		PatinetName = PatinetName_Array_QueryResult(i)
		EnglishName =  EnglishName_Array_QueryResult(i)
		accn =  accn_Array_QueryResult(i)
		DICOMTYPE = DICOMTYPE_Array_QueryResult(i)
	
		' Create report  
'		SwfWindow("RIS_报告_报告列表").SwfObject("报告列表").ClickLeftMenu
		SwfWindow("RIS_报告_报告列表").SwfEdit("放射编号").Set accn
		sendkey "{Enter}"
		num=SwfWindow("RIS_报告_报告列表").SwfObject("报告列表表格").Object.RowCount
	
		If  num>0  Then
			SwfWindow("RIS_报告_报告列表").SwfObject("报告列表表格").DbClickCell 0,"放射编号"
			Wait 2
'			SwfWindow("RIS_报告_报告编辑").SwfObject("临床诊断").DropDownListRandomSelect
'			SwfWindow("RIS_报告_报告编辑").SwfObject("阴阳性").DropDownListRandomSelect
'			SwfWindow("RIS_报告_报告编辑").SwfEditor("影像学表现").Type "所见的内容所见的内容所见的内容所见的内容所见的内容所见的内容所见的内容"
'			SwfWindow("RIS_报告_报告编辑").SwfEditor("影像学诊断").Type "所得的内容所得的内容所得的内容所得的内容所得的内容所得的内容所得的内容"
			
'			 SwfWindow("RIS_报告_报告编辑").SwfObject("编辑报告Tab").ClickShotCutTab("保存")
'			Wait 1
'			SwfWindow("RIS_报告_报告编辑").SwfObject("编辑报告Tab").ClickShotCutTab("审核")
			SwfWindow("RIS_报告_报告编辑").SwfObject("审核").Click

			Wait 3

			Call Gobal_EXCEL_CommentUpdate(strfilePath,SheetName,"PatientID",PID,"RISReportFlag","1")

			If  i+1 Mod 1000 = 0 Then
				Systemutil.CloseProcessByName "Kodak.GCRIS.exe"	
				RISStartandLogin		
			End If
		End If
	Next
	
End Function


Function RISPrintReport (strfilePath, sheetName)
	strSql_excel = "SELECT * FROM ["&sheetName&"$]  where RISReportFlag = 1 and ReportSendFlag=0"
	Call  Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"ID",str_Array_QueryResult)
	iCount = UBound(str_Array_QueryResult)
	Call Gobal_EXCEL_Query(strSql_excel,strfilePath,sheetName,"AccessionNo",accn_Array_QueryResult)

	For i=0 to iCount	
		accn =  accn_Array_QueryResult(i)

		SwfWindow("RIS_登记_打印报告").SwfObject("打印报告").ClickLeftMenu
		SwfWindow("RIS_登记_打印报告").SwfEdit("放射编号").Set accn
		sendkey "{Enter}"
		num=SwfWindow("RIS_登记_打印报告").SwfObject("打印报告表格").Object.RowCount
		
		If num>0 Then
			SwfWindow("RIS_登记_打印报告").SwfObject("打印报告表格").ClickCell 0, "放射编号"
			SwfWindow("RIS_登记_打印报告").SwfObject("打印").Click
		End If
		Call Gobal_EXCEL_CommentUpdate(strfilePath,SheetName,"AccessionNo",accn,"ReportSendFlag","1")

'		If  i+1 Mod 1000 = 0 Then
'			Systemutil.CloseProcessByName "Kodak.GCRIS.exe"	
'			RISStartandLogin		
'		End If
	Next
End Function

Function SetPDFCreatorDes (strDestination)
	runExeFile "C:\Program Files\PDFCreator\PDFCreator.exe"

	VbWindow("PDFConfig").WinMenu("PDFMenu").Select "打印机(P);选项	Ctrl+O"
	VbWindow("PDFConfig").VbWindow("ConfigOptions").VbTreeView("treeOptions").Select "程序;自动保存"
	VbWindow("PDFConfig").VbWindow("ConfigOptions").ActiveX("ActiveX").ActiveX("ActiveX").VbEdit("txtLocation").Set strDestination
	VbWindow("PDFConfig").VbWindow("ConfigOptions").VbButton("btnSave").Click
	
	If dialog("dlgPDFCreator").Exist(1) Then
		dialog("dlgPDFCreator").Close
	End If
End Function

Function PrintFilmInGX(PID,DICOMTYPE)
If not  Dialog("工作列表").WinListView("工作列表表格").Exist(2) Then
     Call LoginGXPlatform()
	 ColClick("病人编号")
		wait 1
		sendkey "{Backspace 3}"
        ColClick("病人编号")
		wait 2
		sendkey "{Backspace 3}"
		wait 2
       sendkey PID
	   sendkey "{Enter}"

	    ColClick("检查日期")
        ColClick("检查日期")
		sendkey"{right 10}"
		sendkey "{Enter}"
       If Dialog("工作列表").Dialog("日期面板").Exist(2) then 
            Dialog("工作列表").Dialog("日期面板").WinCalendar("结束日期：").SetDate "11-Aug-2210"
			Dialog("工作列表").Dialog("日期面板").WinButton("确定").Click
	   end if 
	   wait 2

End If
Dialog("工作列表").WinListView("工作列表表格").Select PID
wait(1)
Set FCObject = DotNetFactory.CreateInstance("System.Windows.Forms.Control")
intMouseX = FCObject.MousePosition.X
intMouseY = FCObject.MousePosition.Y
Set FCObject = Nothing
wait(1)
Dialog("工作列表").DblClick intMouseX,intMouseY,micLeftBtn

				If  Dialog("打印面板").Exist(5) Then
					Dialog("打印面板").Activate
				End If
				
				Call ConnectDatabase(strDBType_GX, strDBAlias_GX, strUID_GX, strPWD_GX, GetIPMAC(".")&Environment.Value("strIP_GX"), strLocalHostName_GX, strDataSource_GX)
				
				strSql = "Select ImageCount  from Patient where patientid = '"&PID&"'"
				call QueryDatabase(strSql,"ImageCount",str_Array_QueryResult)
				ImageCount = str_Array_QueryResult(0)
				strSql_excel= "Select DICOMTYPE  from ["&SheetName&"$] where patientid = '"&PID&"'"
				
				call  Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"DICOMTYPE",str_Array_QueryResult)
				
				DICOMTYPE = str_Array_QueryResult(0)
				strSql = "select PropertyValue from systemprofile where PropertyName = 'DefPlayout."&DICOMTYPE&"'"
				Call QueryDatabase(strSql,"PropertyValue",str_Array_QueryResult)
				Dim PrimtDefPlayout

				PrimtDefPlayout = str_Array_QueryResult(0)
				PrimtDefPlayout =Mid(PrimtDefPlayout,1,1)*Mid(PrimtDefPlayout,2,1)
    			PageNumberOfPrint = ImageCount mod PrimtDefPlayout 
	
				If  PageNumberOfPrint =0Then
					PageNumberOfPrint = ImageCount\PrimtDefPlayout
					
					else 
						PageNumberOfPrint= ImageCount\PrimtDefPlayout +1
					
				End If
				 ' PageNumberOfPrint = chr(34)&PageNumberOfPrint&chr(34)
				Dim WaitTime
				If  DICOMTYPE = "CT" or DICOMTYPE = "MR"Then
					WaitTime = 60
					Else 
							WaitTime=30
				End If
				'msgbox "1",1,"PageNumberOfPrint of DX"&PageNumberOfPrint
'				If Dialog("Login").Dialog("打印面板").WinButton("1").Exist then 
'						msgbox "1",1,"dui le "
'				end if
		'		reporter.ReportNote"------PageNumberOfPrint-----",PageNumberOfPrint


				If  Dialog("打印面板").WinButton("nativeclass:=Button","text:="&PageNumberOfPrint).Exist(WaitTime) Then
								Dialog("打印面板").WinComboBox("ComboBox_printer").Select "PS201" 
								num=Dialog("打印面板").WinComboBox("ComboBox_Filmtype").GetItemsCount
                                Pnum=Dialog("打印面板").WinComboBox("ComboBox_printer").GetItemsCount
                               For  i=0 to num-1
                                     If  Dialog("打印面板").WinComboBox("ComboBox_Filmtype").GetItem(i)="14 IN X 17 IN" then
	                                        Exit for
                                     elseif  i=num-1 then
                                                  If  Pnum>0 Then
                                                       Dialog("打印面板").WinComboBox("ComboBox_printer").Select 0
	                                             end if 
                                                 If  Pnum>1 Then
	                                                    Dialog("打印面板").WinComboBox("ComboBox_printer").Select 1
                                                End If
                                                 Dialog("打印面板").WinComboBox("ComboBox_printer").Select "PS201" 
                                    end if 
 
                                 Next

								Dialog("打印面板").WinComboBox("ComboBox_Filmtype").Select "14 IN X 17 IN"
								Dialog("打印面板").WinButton("btn_打印").Click
								If Dialog("打印面板").Dialog("GX Workstation").Exist Then
											Dialog("打印面板").Dialog("GX Workstation").Activate
											Dialog("打印面板").Dialog("GX Workstation").WinButton("是").Click
										If Dialog("打印面板").Dialog("GX Workstation").WinButton("确定").Exist(3) Then
											Dialog("打印面板").Dialog("GX Workstation").WinButton("确定").Click
											'Call CloseDatabase()
											Call PrintFilmInGX(PID,DICOMTYPE)
										else
										    Dialog("打印面板").Close
										End If
								End If
						Else
						 'Call CloseDatabase()
							Call PrintFilmInGX(PID,DICOMTYPE)
				End If
              
While Dialog("打印面板").Exist(2) and (not  Dialog("打印面板").WinButton("nativeclass:=Button","text:="&PageNumberOfPrint).Exist(WaitTime))	
Call LoginGXPlatform()
	 ColClick("病人编号")
		wait 1
		sendkey "{Backspace 3}"
        ColClick("病人编号")
		wait 2
		sendkey "{Backspace 3}"
		wait 2
       sendkey PID
	   sendkey "{Enter}"

	    ColClick("检查日期")
        ColClick("检查日期")
		sendkey"{right 10}"
		sendkey "{Enter}"
       If Dialog("工作列表").Dialog("日期面板").Exist(2) then 
            Dialog("工作列表").Dialog("日期面板").WinCalendar("结束日期：").SetDate "11-Aug-2210"
			Dialog("工作列表").Dialog("日期面板").WinButton("确定").Click
	   end if 
	   wait 2
Call PrintFilmInGX(PID,DICOMTYPE)
                       
Wend 
			'Call CloseDatabase()
End Function


Function GetHeightOfTaskBar()
	barHeight = Trim(Window("Carestream GC RIS3.0").WinObject("TaskBar").GetROProperty("height"))
	GetHeightOfTaskBar = barHeight
End Function

Function GetWidthOfTaskBar()
	barWidth = Trim(Window("Carestream GC RIS3.0").WinObject("TaskBar").GetROProperty("width"))
	GetWidthOfTaskBar = barWidth
End Function

Function GetBackToDefaultLocation()
	singleTabHeight = 35
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)
	y = Int(singleTabHeight / 2)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function ClickTab_Register()
   	singleTabHeight = 35
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(oHeight - singleTabHeight * 8 + singleTabHeight / 2 - 5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function ClickTab_Examination()
   	singleTabHeight = 35
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(oHeight - singleTabHeight * 7 + singleTabHeight / 2 - 5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function ClickTab_Report()
   	singleTabHeight = 35
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(oHeight - singleTabHeight * 6 + singleTabHeight / 2 - 5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function Register_ClickItem_BookInExam()
	Call GetBackToDefaultLocation
	Call ClickTab_Register
	singleTabHeight = 35
	singleItemHeight = 88
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(singleTabHeight * 2 + singleItemHeight * 1.5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function Register_ClickItem_RegisterList()
	Call GetBackToDefaultLocation
	Call ClickTab_Register
	singleTabHeight = 35
	singleItemHeight = 88
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(singleTabHeight * 2 + singleItemHeight * 2.5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function Examination_ClickItem_Exam()
	Call GetBackToDefaultLocation
	Call ClickTab_Examination
	singleTabHeight = 35
	singleItemHeight = 88
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(singleTabHeight * 3 + singleItemHeight * 0.5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function Report_ClickItem_ReportList()
	Call GetBackToDefaultLocation
	Call ClickTab_Report
	singleTabHeight = 35
	singleItemHeight = 88
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(singleTabHeight * 4 + singleItemHeight * 0.5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function

Function Register_PrintReport()
	Call GetBackToDefaultLocation
	Call ClickTab_Register
	singleTabHeight = 35
	singleItemHeight = 88
	oHeight  = GetHeightOfTaskBar
	oWidth = GetWidthOfTaskBar
	x = Int(oWidth / 2)	
	y = Int(singleTabHeight * 2 + singleItemHeight * 4.5)
	Window("Carestream GC RIS3.0").WinObject("TaskBar").Click x,y:Wait 2
End Function





Function GXplatformLogoff()
Dialog("taskbar").WinButton("Button_logoff").Click
SET WshShell_1 = CreateObject("WScript.Shell")

WshShell_1.SendKeys("{UP}")
wait(1)
WshShell_1.SendKeys("{UP}")
wait(1)
WshShell_1.SendKeys("{UP}")
wait(1)
WshShell_1.SendKeys("{ENTER}")

Do 
	wait(1)

Loop until Dialog("GXLogin").WinButton("登录").Exist

If  Dialog("GXLogin").exist Then

	Dialog("GXLogin").WinEdit("密码").Set Environment.Value("GXPassWord")
	wait(1)
	Dialog("GXLogin").WinButton("登录").Click
	wait(3)
    If Dialog("GXLogin").Dialog("GX Workstation_loginWarning").Exist(3) then
			Dialog("GXLogin").Dialog("GX Workstation_loginWarning").WinButton("否").Click
			If  Dialog("工作列表").Exist(30) Then
				wait(1)
				Else
						msgbox "info",1,"login failed~~~~"
			End If
	end if
	else
		msgbox "info",1,"login failed~~~~"


End If
End Function


'**************************************************************
'函数功能：点击指定的工作列表的某列列头查询项
'参数：ColName 表示列名
'示例：ColClick("病人编号")
'**************************************************************

Function  ColClick(ColName)
hHeader=Dialog("工作列表").WinObject("SysHeader32").GetROProperty("height")
iColumnCount=Dialog("工作列表").WinListView("工作列表表格").ColumnCount
y=5
x=0
 For  i=0 to iColumnCount-1
	        PName=Dialog("工作列表").WinListView("工作列表表格").GetColumnHeader(i)
			'print PName
	     If  PName=ColName  Then
			  x=x+GetColWidth(ColName)/2
			  Exit For
		 Else 
		      x=x+GetColWidth(ColName)			
		 End If
 Next
 y=y+hHeader/2

Dialog("工作列表").WinObject("SysHeader32").Click x,y
End Function

Function  GetColWidth(ColName)
Select  case  ColName
Case "病人编号"
	GetColWidth=75
Case  "病人姓名"
	 GetColWidth=80
Case "性别"
	 GetColWidth=75
Case "已打印"
	GetColWidth=70
Case  "放射编号"
	GetColWidth=70
Case "病人年龄"
	GetColWidth=70
Case  "出生日期"
	GetColWidth=70
Case "检查设备"
	GetColWidth=70
Case "检查日期"
		GetColWidth=69
Case "检查时间"
	GetColWidth=70
Case "检查部位","检查描述"
	GetColWidth=75
Case  "检查编号","序列数"
    GetColWidth=78
Case "影像数","已保留"
	 GetColWidth=80
Case else
	  print "目前不支持该列"&ColName&"的点击操作"
End Select
End Function


'拷贝数据追加到另一个数据表
Function CopyData(FromFilename,FromSheet,ToFileName,ToSheet)

strfilePath=FromFilename
SheetName=FromSheet
'查询 数据
	strSql_excel = "SELECT * FROM ["&SheetName&"$] where ID =(Select min(ID)  from ["&SheetName&"$] where RISCreate = 1 and SendFlag=1 and ReportSendFlag = 1 and RISReportFlag =1)  "
		call  Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"PatientID",str_Array_QueryResult)
		PID = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"PatientName",str_Array_QueryResult)
		PatinetName = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"EnglishName",str_Array_QueryResult)
		EnglishName =  str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"AccessionNo",str_Array_QueryResult)
		accn =  str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"DICOMTYPE",str_Array_QueryResult)
		DICOMTYPE = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"RISCreate",str_Array_QueryResult)
		RISCreate1 = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"SendFlag",str_Array_QueryResult)
		SendFlag = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"RISReportFlag",str_Array_QueryResult)
		RISReportFlag = str_Array_QueryResult(0)
		Call Gobal_EXCEL_Query(strSql_excel,strfilePath,SheetName,"ReportSendFlag",str_Array_QueryResult)
		ReportSendFlag = str_Array_QueryResult(0)
'------------------------
	SystemUtil.CloseProcessByName("EXCEL.exe")
strfilePath=ToFileName
SheetName=ToSheet

	Dim ExcelObject,ExcelWB,ExcelSheet
	Set ExcelObject = CreateObject("Excel.Application") 
	ExcelObject.Visible = false
	Set ExcelWB = ExcelObject.Workbooks.open(strfilePath)
    Set ExcelSheet = ExcelWB.Sheets(SheetName)



Dim objConnection                          'CONNECTION对象实例 
	Dim objRecordSet                           'RECORDSET对象实例        
	Dim objCommand                                '命令对象实例 
	Dim strConnectionString                        '连接字符串 
    Dim i	
	Set objRecordSet = CreateObject("ADODB.RECORDSET")                '4 - 建立RECORDSET对象实例 
	Set objCommand = CreateObject("ADODB.COMMAND" )             '5 - 建立COMMAND对象实例 
	objConnection = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&strfilePath&";Extended Properties=Excel 8.0"
	objCommand.ActiveConnection = objConnection 
	strSql = "Select count(ID) as ID  from ["&SheetName&"$]"
	objCommand.CommandText = strSql 
	objRecordSet.CursorLocation = 3 
	objRecordSet.Open objCommand 
	'上文选出当前没有执行过的最大ID
	
'	msgbox "objRecordSet.MaxRecords===="&objRecordSet.MaxRecords
'	msgbox "objRecordSet(0)===="&objRecordSet(0)
	
	If objRecordSet(0)>0 then
			i = objRecordSet(0)
			i=i+1
		else
				i=1
	end if

Set objCommand = Nothing 
Set objRecordSet = Nothing 
Set strConnectionString = Nothing
Set  objConnection = Nothing
For j=i to i+DicomNumber-1
		
		
			ExcelObject.Cells(j+1,1).value = j
			ExcelObject.Cells(j+1,2).value =PID
			ExcelObject.Cells(j+1,3).value =PatinetName
			ExcelObject.Cells(j+1,4).value =EnglishName
			ExcelObject.Cells(j+1,5).value =accn
			ExcelObject.Cells(j+1,6).value =DICOMTYPE
			ExcelObject.Cells(j+1,7).value =RISCreate1
			ExcelObject.Cells(j+1,8).value =SendFlag
			ExcelObject.Cells(j+1,9).value =RISReportFlag
			ExcelObject.Cells(j+1,10).value =ReportSendFlag
			ExcelObject.Cells(j+1,11).value = ""
		
next
'			ExcelObject.Cells(j+100,1).value = strSql
			ExcelWB.Save 
			ExcelObject.Workbooks.Close
			ExcelObject.DisplayAlerts = true
			ExcelObject.Quit
			SystemUtil.CloseProcessByName("EXCEL.exe")
			Set objCommand = Nothing 
			Set objRecordSet = Nothing 
			Set strConnectionString = Nothing
			Set  objConnection = Nothing
			set Guid = Nothing
		strfilePath =Environment.Value("strfilePath")
End Function 

'Besure that the WinDPSTester is installed, and has permission for accessing 10.186.32.194 
'And the OS should be x64 version, and the language should be Simplified Chinese
Function PSCUSimulator (strFile, strDesIP, iLoop)
	sheetName =Environment.Value("SheetName")
	strAutomationPath = Environment.Value("strAutomationPath")

	strParamFile = strAutomationPath & "\Resources\Tools\PSCUSimulator\Parameters.txt"
	
	strfilePath = strFile
	strIP = strDesIP

	strApplicationPath= Environment("strApplicationPath")
	strApplicationShell=Environment("strApplicationShell")
	
	Set fs = CreateObject("Scripting.FileSystemObject")
	Set ts = fs.OpenTextFile (strParamFile, 1, False)
	
	Do While ts.AtEndOfStream <> True
		strLine = ts.ReadLine
	
		If strLine <> "" Then
			arrLine = Split (strLIne,"=")
	
			Select Case arrLine(0)
				Case "strRawFilePath" 
					strRawFilePath= strAutomationPath & "Resources\Tools" & arrLine(1)
				Case "strSourceFilePath"
					strSourceFilePath = strAutomationPath & "Resources\Tools" &  arrLine(1)
				Case "strWaterMarkPath"
					strWaterMarkPath = strAutomationPath  & "Resources\Tools" &  arrLine(1)
				Case "strPort"
					strPort = arrLine(1)
				Case "strRequestedImageSize"
					strRequestedImageSize = arrLine(1)
				Case "strRows"
					strRows = arrLine(1)
				Case "strColmun"
					strColmun = arrLine(1)
				Case "strBitsAllocate"
					strBitsAllocate = arrLine(1)
				Case "strBitsStored"
					strBitsStored =arrLine(1)
				Case "strHighBit"
					strHighBit = arrLine(1)
				Case "strSmoothingType"
					strSmoothingType = arrLine(1)
				Case "strConfigurationInformation"
					strConfigurationInformation = arrLine(1)
				Case "strConfigurationInfo"
					strConfigurationInfo = arrLine(1)
				Case "strMinimumDensity"
					strMinimumDensity = arrLine(1)
				Case "strBorderDensity"
					strBorderDensity = arrLine(1)
				Case "strEmptyImageDensity"
					strEmptyImageDensity = arrLine(1)
				Case "strDisplayFormat"
					strDisplayFormat = arrLine(1)
				Case "strCopies"
					strCopies = arrLine(1)
				Case "strPrintTimes"
					strPrintTimes = arrLine(1)
			End Select
		End If
	Loop
	
	Set fs = Nothing
	Set ts = Nothing
	
	SystemUtil.Run strApplicationPath
	
	Dialog("dlgWinDPSTester").WinMenu("Menu").Select "Options..."
	
	Dialog("dlgOptions").WinTab("tbDPSTester").Select "DPSTester"
	Dialog("dlgOptions").WinButton("btnBrowse").Click
	Dialog("dlgOpenCN").WinEdit("txtFilenameCN").Set strApplicationShell
	Dialog("dlgOpenCN").WinButton("btnOpenCN").Click
	Dialog("dlgOptions").WinEdit("txtHost").Set strIP
	Dialog("dlgOptions").WinEdit("txtPort").Set strPort
	Dialog("dlgOptions").WinButton("btnOKCN").Click
	
	Dialog("dlgWinDPSTester").WinButton("btnLoadDefaults").Click
	Dialog("dlgWinDPSTester").Static("stcRawSelection").Click
	
	Dialog("dlgImageBoxAttributes").WinButton("btnBrowse").Click
	Dialog("dlgOpenCN").WinEdit("txtFilenameCN").Set strRawFilepath
	Dialog("dlgOpenCN").WinButton("btnOpenCN").Click
	Dialog("dlgImageBoxAttributes").WinEdit("txtRequestedImageSize").Set strRequestedImageSize
	Dialog("dlgImageBoxAttributes").WinEdit("txtRows").Set strRows
	Dialog("dlgImageBoxAttributes").WinEdit("txtColumns").Set strColmun
	Dialog("dlgImageBoxAttributes").WinEdit("txtBitsAllocated").Set strBitsAllocate
	Dialog("dlgImageBoxAttributes").WinEdit("txtBitsStored").Set strBitsStored
	Dialog("dlgImageBoxAttributes").WinEdit("txtHighBit").Set strHighBit
	Dialog("dlgImageBoxAttributes").WinEdit("txtSmoothingType").Set strSmoothingType
	Dialog("dlgImageBoxAttributes").WinEdit("txtConfigurationInformation").Set strConfigurationInformation
	Dialog("dlgImageBoxAttributes").WinButton("btnOK").Click
	
	Dialog("dlgWinDPSTester").WinEdit("txtDisplayFormat").Set strDisplayFormat 
	Dialog("dlgWinDPSTester").WinEdit("txtCopies").Set strCopies
	Dialog("dlgWinDPSTester").WinEdit("txtConfigurationInfo").Set strConfigurationInfo
	Dialog("dlgWinDPSTester").WinEdit("txtSmoothingType").Set strSmoothingType
	Dialog("dlgWinDPSTester").WinEdit("txtMinimumDensity").Set strMinimumDensity
	Dialog("dlgWinDPSTester").WinEdit("txtBorderDensity").Set strBorderDensity
	Dialog("dlgWinDPSTester").WinEdit("txtEmptyImageDensity").Set strEmptyImageDensity
	
	
	DataTable.AddSheet (sheetName)
	DataTable.ImportSheet strfilePath, sheetName, sheetName
	iRowCount=DataTable.GetSheet(sheetName).GetRowCount
	
	For j=1 to iLoop
		For i=1 to iRowCount
			Datatable.SetCurrentRow i
			strPatientID =  DataTable.Value ("PatientID", "RIS_PatientInfo")
			strAccNumber = DataTable.Value("AccessionNo", "RIS_PatientInfo")
			strRISCreate = DataTable.Value("RISCreate", "RIS_PatientInfo")
			strSendFlag = DataTable.Value("SendFlag", "RIS_PatientInfo")
		
			If strRISCreate  = "1" Then
				DeleteAFile strRawFilepath
				Wait 2
				CopyAFile strSourceFilePath,  strRawFilepath
				Wait 2
				
				SystemUtil.Run "cmd", "/C OutputText2BMP 30 " &strPatientID & " " & strAccNumber &" Demo.bmp", strWaterMarkPath, "", 0
				Wait 2
				SystemUtil.Run "cmd", "/C AddWaterMark.bat", strWaterMarkPath, "", 0
		
				Dialog("dlgWinDPSTester").WinButton("btnPrint").Click
		
				If Dialog("dlgDPSTesterOutputLog").Exist(120) Then
					Dialog("dlgDPSTesterOutputLog").Close
				End If
				DataTable.Value("SendFlag","RIS_PatientInfo")=1
			End If
			DataTable.ExportSheet strfilePath, sheetName	
	
			Wait 60
			If dialog("dlgExceptionWindow").Exist(1) Then
				Dialog("dlgExceptionWindow").Close
			End If
		Next
	Next
End Function

