'****************************************************************************************
'[函数] ReNameFile(参数1, 参数2)
'[描述] 结果决定了返回值，布尔型。
'[语法] 参数1:目标文件路径(String)，必选。参数2:新文件名(String)，必选。
'[说明] 参数1、2文件名包含扩展名, 须符合命名规则。
Function ReNameFile(FilesPec, NewFileName)

'On Error Resume Next

Set fso = CreateObject("Scripting.FileSystemObject")

If fso.FileExists(FilesPec)=false then

ReNameFile = false

Exit Function

End If

If FilesPec = "" or NewFileName = "" then

ReNameFile = false

Exit Function

End If

Dim MyArray, sPath

MyArray = Split(FilesPec, "\")

sPath = Left(FilesPec, Len(FilesPec)-Len(MyArray(UBound(MyArray))))

fso.MoveFile FilesPec, sPath & "\" & NewFileName

Set MyFile = Nothing 

Set fso = Nothing 

ReNameFile = true

End Function


'*********************************************************************************************
'[函数] ReNameFolder(参数1, 参数2)
'[描述] 结果决定了返回值，布尔型。
'[语法] 参数1:目标文件夹路径(String)，必选。参数2:新文件夹名(String)，必选。
'[说明] 参数1, 参数2须符合命名规则。

Function ReNameFolder(FolderSpec, NewFolderName)

'On Error Resume Next

set fso = createobject("scripting.filesystemobject") 

If FolderSpec="" or NewFolderName="" Then

ReNameFolder = false

Exit Function

End If

If fso.FolderExists(FolderSpec)=false then

ReNameFolder = false

Exit Function

End If

set f = fso.GetFolder(FolderSpec) 

f.Copy Left(f.Path, Len(f.Path)-Len(f.Name)) & NewFolderName

fso.DeleteFolder FolderSpec, True

Set f = nothing

Set fso = nothing

ReNameFolder = true

End Function

'*****************************************************************
'功能：从QC中下载文件，如果本地已经有此文件则不下载
'参数：FileName QC中存贮的文件名，注：下载到本地的位置有环境变量TempDir指定
'示例：LoadFile "SQL.ini"
Function LoadFile(FileName)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FileExists(Environment("TempDir")&FileName)) Then
   Else
      GetResourceOnQC FileName, Environment("TempDir")
   End If
End Function 

'**********************************************************
' 示例：SendKey "{UP 2}"   sendKey "{Down}"
'**********************************************************
Function SendKey(KeyName)
   Set autoit=createobject("autoitx3.control")
   autoit.BlockInput(1)
   autoit.Send KeyName
   autoit.BlockInput(0)
   Set autoit=nothing
End Function
'**********************************************************
' 示例：KeyPress("+%{F4}")
'**********************************************************
Function KeyPress(keyvalue)
   Set wshshell=createobject("WScript.Shell")
	wshshell.SendKeys keyvalue
End Function
'*******************************************************************************************
'功能：设置GCRIS-ClientCfg.xml的配置项
'参数： 'ModuleName=Global, ClientConfiguration, Authorization, ExamApplication, Booking, 
                 'Registration, Report, Teaching,Examination, Statistic, Template, QualityControl, Oam
'示例： ClientConfig "DefaultPrinter", "Microsoft XPS Document Writer", "Global"
'*******************************************************************************************
Function ClientConfig(ConfigName, SetValue, ModuleName)
	Set xmlDoc = CreateObject ("Microsoft.XMLDOM")
	filename=Environment("ClientConfigFileName")
	xmlDoc.Load filename
	If xmlDoc.parseError.errorCode<>0 Then
		Set myErr=xmlDoc.parseError
		MsgBox("XML Loads Failed."&myErr.reason)
        ExitAction
	Else
		Set rNode=xmlDoc.documentElement
		found=False
		iLen=rNode.childNodes.length
		If iLen>0 Then
			For i=0 to iLen-1
				Set child=rNode.childNodes.item(i)
				jLen=child.childNodes.length
				If jLen>0 Then
					For j=0 to jLen-1
						Set child2=child.childNodes.item(j)
						If  child2.nodeName="ConfigName" Then
							If  child2.childNodes.item(0).nodeValue=ConfigName Then
								fi=i
								found=true
							End If
						End If
						If  found=true and child2.nodeName="Value" Then
							fj=j
						End If
						If  found=true and child2.nodeName="ModuleName" Then
							If not child2.childNodes.item(0).nodeValue=ModuleName then
								found=false
							else
								 i=iLen
							end if
						End If													
					Next
				End If
			Next
		End If
		rNode.childNodes.item(fi).childNodes.item(fj).childNodes.item(0).nodeValue=SetValue
		xmlDoc.Save(filename)
	end if
End Function

'********************************************
'对外部Excel的操作类
'示例“：
'set Data=AddData("C:\Users\Bob\Desktop\Data.xls","a")
'msgbox Data.RowsCount
'Data.setcurrentRow 3
'msgbox Data.GetValue("性别")
'********************************************

Class PocDataObject
    Dim app, RISwork, RISsheet, Value, Err, path, sheet, row, column, content,GetLineNum
    Private Sub Class_Initialize()
    Set app = CreateObject("Excel.Application")
    app.Visible = False
    End Sub
    
    Function AddSheet(path, sheet)
    Set RISwork = app.Workbooks.Open(path)
    Set RISsheet = RISwork.sheets(sheet)
    End Function
    Function RowsCount()
          RowsCount=RISsheet.usedRange.Rows.Count
    End Function
    Function ColumnsCount()
          ColumnsCount=RISsheet.usedRange.Columns.Count
    End Function
    Private Function Activatebook(sheet)
     On Error Resume Next
    app.Workbooks(sheet).Activate
     On Error GoTo 0
    End Function
    Function SetCurrentRow(RowNumber)
          GetLineNum=RowNumber
          SetCurrentRow=GetLineNum
    End Function
    Public Property Get GetCurrentRow
	    GetCurrentRow= GetLineNum
	End Property
	Public Function GetValue(ColumnName)
	   Dim i
	   For i=1 To RISsheet.usedRange.Columns.Count Step 1
	       If Trim(RISsheet.Cells(1,i))=ColumnName Then
	          GetValue=RISsheet.Cells(GetLineNum,i)
	          Exit For
	       End If 
	    Next 
	End Function
	Public Function SetValue(ColumnName,content)
	   Dim i
	   For i=1 To RISsheet.usedRange.Columns.Count Step 1
	       If Trim(RISsheet.Cells(1,i))=ColumnName Then
			  RISsheet.Cells(GetLineNum, i).Value = content
              RISwork.Save
              SetValue = content
	          Exit For
	       End If 
	    Next 
	End Function
    Function GetCell(row, column)
      Value = 0
      Err = 0
    On Error Resume Next
    GetCell = RISsheet.Cells(row, column)
    If Err = 0 Then
        Value = GetCell
        Err = 0
    End If
    On Error GoTo 0
    GetCell = Value
    End Function
     
    Function WriteCell(row, column, content)
    RISsheet.Cells(row, column).Value = content
    RISwork.Save
    WriteCell = content
    End Function
       
    Private Sub Class_Terminate()
    RISwork.Close
    app.Quit
    Set RISsheet = Nothing
    Set RISwork = Nothing
    Set app = Nothing
    End Sub
End Class 

Function AddData(FileName,SheetName)
   Set AddData=New  PocDataObject
            AddData.AddSheet FileName,SheetName
			AddData.SetCurrentRow 2
End Function

'*******************************************************************************
' 功能：远程访问机器中的指定文件
'参数：IP要访问机器的IP,SourceDriveName需要访问的盘符,MapDriveName映射盘符,UserName远程访问机器的用户名,PassWord 密码
'示例：CreateLink "10.184.193.157","c","h","Administrator","Admin2007"
'               DeletLink "h"

Function  CreateLink(IP,SourceDriveName,MapDriveName,UserName,PassWord)
   CreateLinkcmd="net use "&MapDriveName&": \\"&IP&"\"&SourceDriveName&"$ """&PassWord&""" /user:"""&UserName&""""
   Set BatRunner=createobject("wscript.shell")
   BatRunner.Run "cmd /c "&"net use "&MapDriveName&": /del"
   BatRunner.Run "cmd /c "&CreateLinkcmd
End Function
Function DeletLink(MapDriveName)
     Set BatRunner=createobject("wscript.shell")
     BatRunner.Run "cmd /c "&"net use "&MapDriveName&": /del"
     BatRunner.Run "cmd /c "&"y"
End Function

'****************************************************************************************
'示例：EnterNode "测试点"',"测试点详细描述"
'               Reporter.ReportEvent MicPass,"step1","具体描述"
'               ExitNode
'@Description 指定把日志写入节点下
Public Function EnterNode(ByRef NodeName, ByRef NodeContent)
   Reporter.Filter=rfEnableAll
' 用一个Dictionary对象来存储节点的信息
Set dicMetaDescription = CreateObject("Scripting.Dictionary")
' 设置节点的状态
dicMetaDescription("Status") = MicDone
' 设置节点的名称
dicMetaDescription("PlainTextNodeName") = NodeName
' 设置节点的详细描述信息（可以使用HTML格式）
dicMetaDescription("StepHtmlInfo") = NodeContent
' 设置节点的图标
dicMetaDescription("DllIconIndex") = 210
dicMetaDescription("DllIconSelIndex") = 210
' 节点图标从ContextManager.dll这个DLL文件中读取
dicMetaDescription("DllPAth")=Environment("ProductDir")&"\bin\ContextManager.dll"
' 使用Reporter对象的LogEvent写入新节点
intContext = Reporter.LogEvent("User", dicMetaDescription, Reporter.GetContext)
' 调用Reporter对象的SetContext把新写入的节点作为父节点
Reporter.SetContext intContext 
'If ReportFlag=0 Then
	Reporter.Filter=rfDisableAll
'End If
End Function

'@Description 退出当前日志节点（与EnterNode配对使用）
Public Function ExitNode
'调用Reporter对象的UnSetContext，返回上一层
Reporter.UnSetContext
End Function

'******************************************************
' 功能：重写Report函数
'参数：Status 为Pass/Fail/Done/Warning  ReportFlag 为1时全部报告显示，为0时只显示Report输出的报告
Function Report(Status,StepName,Detail)
Reporter.Filter=rfEnableAll
Select Case Status
Case "Pass"
	Reporter.ReportEvent micPass,StepName,Detail
Case "Fail"
	Reporter.ReportEvent micFail,StepName,Detail
Case "Done"
	Reporter.ReportEvent micDone,StepName,Detail
Case  "Warning"
	Reporter.ReportEvent micWarning,StepName,Detail
End Select
If ReportFlag=0 Then
	Reporter.Filter=rfDisableAll
End If
WriteToFile "C:\initTime.txt",Environment("TestName")&time
 RISpath=RISClientPath()
WriteToFile "C:\RISClientPath.txt",RISpath
End Function

'******************************************************
' 功能：重写Report函数
'参数：Status 为Passed/Failed  ReportFlag 为1时全部报告显示，为0时只显示Report输出的报告
'              TestID 为自动脚本的Check点映射的 手动测试用例的Test ID值
'示例 ：ReportByID "1154","Failed","步骤一","检查点XXXX错误"    
Function ReportByID(TestID,Status,StepName,Detail)
'If Not FileExists(Environment("TResultDir")) Then 
'   initResultExcel(Environment("TResultDir"))
'else 
'End If 
'set DataReport=AddData(Environment("TResultDir"),"Result")
'i=2
'While  DataReport.GetValue("TS_NAME") <>""
'	i=i+1
'	DataReport.setcurrentRow i
'Wend
'DataReport.SetValue "Project_Test_ID",TestID
'DataReport.SetValue "TC_STATUS",Status
'DataReport.SetValue "TC_ACTUAL_TESTER",QCUtil.QCConnection.UserName
'DataReport.SetValue "TS_NAME",Environment("TestName")
'DataReport.SetValue "Description",StepName&":"&Detail
'DataReport.SetValue "Date",Date
'DataReport.SetValue "Time",time
'set DataReport=Nothing 
'Report Status,StepName,Detail
End Function 

'******************************************
'功能：判断文件是否存在 存在返回True,否则返回False
Function FileExists(filespec)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FileExists(filespec)) Then
       FileExists =True
   Else
       FileExists =False
   End If
   Set fso=nothing 
End Function

'******************************************
'功能：判断文件夹是否存在 存在返回True,否则返回False
Function FolderExists(FolderPath)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If (fso.FolderExists(FolderPath)) Then
     FolderExists = True
   Else
     FolderExists =False
   End If
   Set fso=nothing 
End Function

'******************************************
'功能：创建文件夹，只能创建向上一层的文件夹
Function CreateFolder(FolderPath)
   Dim fso, f
   If  FolderExists(FolderPath)Then
	   Exit Function 
   End If
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set f = fso.CreateFolder(FolderPath)
   CreateFolder = f.Path
Set f=nothing
Set fso=nothing 
End Function

'******************************************
'功能：创建文本文件，只能创建已知路径下的 文件
' 参数：Flag 为True 为覆盖，为False 为不覆盖
Function CreateFile(FilePath,flag)
   On error resume next 
   Dim fso, MyFile
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set MyFile = fso.CreateTextFile(FilePath,flag)
   MyFile.Close
   Set MyFile=nothing
   Set fso=nothing
End Function

'******************************************************************
'功能：删除文件
Sub DeleteAFolder(filespec)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   fso.DeleteFolder(filespec)
   Set fso=nothing
End Sub

'******************************************************************
'功能：删除文件
Sub DeleteAFile(filespec)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   fso.DeleteFile filespec,True
   Set fso=nothing
End Sub

'******************************************************************
'功能：拷贝文件
Sub CopyAFile( SourceFile,filespec)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   fso.CopyFile  SourceFile, filespec,True
   Set fso=nothing
End Sub

Sub CopyAFolder (strSource, strDesc)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")

   If Not fso.FolderExists(strDesc) Then
	   fso.CreateFolder strDesc
   End If
   fso.CopyFolder strSource & "*", strDesc
   Set fso = nothing
End Sub

Sub CopyAllFilesInFolder (strSource, StrDesc)
	Set fso =  CreateObject("Scripting.FileSystemObject")
	Set sourceFolder = fso.GetFolder(strSource)

	For Each f in sourceFolder.Files
		   fso.CopyFile   f , StrDesc, True
	Next
	 Set fso=nothing
End Sub
'*************************************************************
'初始化测试报告文件
'*************************************************************
Function initResultExcel(sTablePath)
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set oExcel=CreateObject("Excel.Application")
	oExcel.Visible=false
	If  not fso.FileExists(sTablePath) Then
		oExcel.workbooks.Add
		Set objSheets=oExcel.Sheets.Item(1)
		objSheets.Select
		objSheets.Name="Result"
		oExcel.ActiveWindow.FreezePanes=true
		oExcel.ActiveWorkbook.SaveAs sTablePath
		oExcel.Quit
		Set objSheets=Nothing
	End If
	Datatable.addSheet "Result"
	'Datatable.importSheet sTablePath, "Result","Result"
	iParamCount = Datatable.getSheet("Result").getParameterCount
	if iParamCount = 0 Then
		Datatable.getSheet("Result").addParameter "Project_Test_ID",""
		Datatable.getSheet("Result").addParameter "TC_STATUS",""
		Datatable.getSheet("Result").addParameter "TC_ACTUAL_TESTER",""
		Datatable.getSheet("Result").addParameter "TS_NAME",""
		Datatable.getSheet("Result").addParameter "Description",""
		Datatable.getSheet("Result").addParameter "Date",""
		Datatable.getSheet("Result").addParameter "Time",""
	End If 
	Datatable.ExportSheet sTablePath,"Result"
End Function
'*************************************************************
'用当前时间生成随机数
'*************************************************************
Function CreateUniqueID()
	tDate=now()
   	CreateUniqueID=datepart("yyyy",tDate)&datepart("m",tDate)&datepart("d",tDate)&datepart("h",tDate)&datepart("n",tDate)&datepart("s",tDate)
End Function

'******************************************************
' 功能：为HISConn.XML某个Tag重新设值
'示例 ：HISXMLConfig "NAMESC","testPName",Environment.Value("HisconXMLPath")
Function HISXMLConfig(ConfigName, SetValue, FilePath)
	Set xmlDoc = CreateObject ("Microsoft.XMLDOM")
	xmlDoc.Load FilePath
	If xmlDoc.parseError.errorCode<>0 Then
		Set myErr=xmlDoc.parseError
		print "XML Loads Faild."&myErr.reason
        ExitTest
	Else
		Set rNode=xmlDoc.documentElement
		iLen=rNode.childNodes.length
		If iLen>0 Then

				For i=0 to iLen-1
					Set child=rNode.childNodes.item(i)
					jLen=child.childNodes.length
					If jLen>0 Then
						For j=0 to jLen-1
							Set child2=child.childNodes.item(j)
							If ConfigName="PROCEDURECODE"  or ConfigName="MODALITYTYPE" or ConfigName="MODALITY" Then
								If  child2.nodeName="STUDYITEMS" Then
									Set child3=child2.childNodes.item(0)
									zLen=child3.childNodes.length
									For z=0 to zLen-1
										Set child4=child3.childNodes.item(z)
										If  child4.nodeName=ConfigName Then
											If child4.childNodes.length>0 Then
												child4.childNodes.item(0).nodeValue=SetValue
											else
												child4.text=SetValue
											End If							
										End If	
									Next
								end if
							else
								If  child2.nodeName=ConfigName Then
									If child2.childNodes.length>0 Then
										child2.childNodes.item(0).nodeValue=SetValue
									else
										child2.text=SetValue
									End If							
								End If	
							End If
									
						Next
					End If
				Next

		End If
		xmlDoc.Save(FilePath)
	end if
End Function

'******************************************************
' 功能： 读取文本文件的全部内容并返回
' 参数：FilePath 为文件的路径和文件名
'示例：txt=ReadAllFile("C:\sp.txt")
Function ReadAllFile(FilePath)
Set objFSO=CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(FilePath)then
Set objFile=objFSO.OpenTextFile(FilePath,1)
txt=objFile.ReadAll
Set objFile=Nothing
ReadAllFile=txt
Else
print "文件"&FilePath&"不存在"
ReadAllFile=""
Exit Function
End If 
Set objFSO=Nothing
End Function

'功能：向文本文件中写内容，覆盖写入
Function WriteToFile(path,text)
   If path = "" Then 
		path = "C:\initTime.txt"
	Else
	End If 
   Const ForReading = 1, ForWriting = 2
   Dim fso, f
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set f = fso.OpenTextFile(path, ForWriting, True)
   f.Write text
   Set f = fso.OpenTextFile(path, ForReading)
   WriteToFile =   f.ReadLine
End Function



'***********************************************************************************
' 功能：比较两个图片的差异
'参数：SourcePicPath: 源图片文件的路径    ObjPicPath:对象图片文件的路径
'返回值：图片一致返回为True；图片不一致返回为不一致图像的拼图地址


Function ComparePicture(SourcePicPath,ObjPicPath)

'Create the screen capture object
Set oScreenCapture = CreateObject("KnowledgeInbox.ScreenCapture")

'Get count of pixels which are different in both images
PixelCountDiff = oScreenCapture.CompareImages (SourcePicPath,ObjPicPath, "[PixelDiffCount]")

'Get percentage of pixels which are different in both images
PixelDiffPerc = oScreenCapture.CompareImages (SourcePicPath,ObjPicPath, "[PixelDiffPerc]")

print  PixelCountDiff 
print  PixelDiffPerc 
'Save the difference image
oScreenCapture.CompareImages SourcePicPath,ObjPicPath, "C:\Difference.png"
wait 2

 MERGE_Image1LeftImage2 = 1

'Combine images with a padding of 10 pixels
oScreenCapture.CombineImages SourcePicPath,ObjPicPath, "C:\Combined.png", MERGE_Image1LeftImage2, 10
oScreenCapture.CombineImages "C:\Combined.png",  "C:\Difference.png", "C:\Combined1.png", MERGE_Image1LeftImage2, 10

'Destroy the object
Set oScreenCapture = Nothing
If   PixelCountDiff =0 or  PixelDiffPerc=0  Then
     ComparePicture=true
     print "图像一致"
else
     ComparePicture="C:\Combined1.png"
	 print "图像不一致"
End If
'systemutil.Run "C:\Combined1.png"
End Function
'***********************************************************************************

'***********************************************************************************
' 功能：取得本机IP地址，根据此从tOnlineClient取得当前客户端的Site值
'参数：ComputerName: 可通过环境变量LocalHostName取得
'返回值：本机IP
Function GetIPMAC(ComputerName) 
	Dim objWMIService,colItems,objItem,objAddress
	Set objWMIService = GetObject("winmgmts://" & ComputerName & "/root/cimv2")
	Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
	For Each objItem in colItems
		For Each objAddress in objItem.IPAddress
			If objAddress <> "" then
				GetIPMAC = objAddress  '& ",MAC:" & objItem.MACAddress
				Exit For
			End If  
		Next
		Exit For
	Next
End Function

'******************************************************************
'功能：解析字符串
'参数：str为“x1=xx|x2=xx|x3=xx....”格式的字符串
'返回值：字符串中指定参数的值，若无此参数返回空，并打印错误信息
'示例：str="a=1|b=2|c=3"
'               A=Xstr(str,"a")     结果A=“1”
Function  Xstr(str,paraname)
 Set para= CreateObject("Scripting.Dictionary")
     para.RemoveAll
     arr=split(str,"|")

      For  i=0 to  Ubound(arr)
	         arr1=split(arr(i),"=")
              para(arr1(0))=arr1(1)
      Next
      If  para.Exists(paraname) Then
           Xstr= para(paraname)
      else
           Xstr=""
           print "参数"&paraname&"不存在于字符串"&str&"中"
       End If
        para.RemoveAll
  Set para=nothing 
End Function

'******************************************************************
'功能：验证下拉框可以通过键盘操作打开：Alt+Down，多选下拉框通过空格键选中，单选下拉框通过回车键选中，ESC删除
'参数：str为“x1=xx|x2=xx|x3=xx....”格式的字符串
'返回值：字符串中指定参数的值，若无此参数返回空，并打印错误信息
'示例：KeyBoardVerify("ParentWinName=RIS_转诊_检查申请|FieldName="病人类型|ControlType=0|VCount=3|SetValue=急诊病人"）
'               ControlType： 0代表多选下拉框，1代表单选下拉框
'               ParentWinName： 面板名称
'               FieldName： 下拉框名称，SwfEdit
'               VCount： 下拉框内值的个数
'               SetValue：下拉框第一个值
Function KeyBoardVerify(str) 'FieldName-控件名,ControlType-多选OR单选(0为多选，1为单选)
		err_str=""
		ParentWinName=Xstr(str, "ParentWinName")
		FieldName=Xstr(str, "FieldName")
		VCount=Xstr(str, "VCount")+1
		ControlType=Xstr(str, "ControlType")
		SetValue=Xstr(str, "SetValue")
		With Swfwindow(ParentWinName)
			.SwfEdit(FieldName).Click 
			If  not .Swfedit(FieldName).GetROProperty("text")="" Then
				sendkey "{ESC}"
				If  not .Swfedit(FieldName).GetROProperty("text")="" Then
						err_str=FieldName&"的值不能通过ESC清除，无法做下一步验证"
				End If
			End If
			If  err_str="" Then
				sendkey "!{down}{up "&VCount&"}"'光标选中下拉框第一个值			
				If  .SwfObject(FieldName).Object.Items.item(0).text="" Then
					sendkey "{down}"'检查面板的下拉框第一个值为空
				End If
				wait 1
				If ControlType=0 Then
					sendkey "{space}"
					If not .Swfedit(FieldName).GetROProperty("text")=SetValue Then
						err_str=err_str&"；"&FieldName&"不能用空格键选中"
					else
						sendkey "{space}"
						If  not .Swfedit(FieldName).GetROProperty("text")="" Then
							err_str=err_str&"；"&FieldName&"能用空格键选中，但不能通过空格键反选"
						else
							sendkey "{space}"'再次选中
						End If
					end if	
				end if
				sendkey "{enter}"
				wait 1
				If not .Swfedit(FieldName).GetROProperty("text")=SetValue Then
					err_str=err_str&"；"&FieldName&"不能用键盘操作"
				else
					.SwfEdit(FieldName).Click 
					sendkey "{ESC}"
					wait 1
					If  not .Swfedit(FieldName).GetROProperty("text")="" Then
							err_str=err_str&"；"&FieldName&"能用键盘打开选择，但不能通过ESC清除"
					End If
				End If
			End If
		End With
		KeyBoardVerify=err_str
End Function


'****************************************************
'功能：将日期转换为yymmdd的格式    
'参数：Tday  要转换格式的日期   
'示例： FormatDay(Date)
Function FormatDay(Tday)

 arr=split (FormatDateTime(Tday, 2),"/" )

yy=arr(0)
If  len(arr(1))=1 Then
	mm="0"&arr(1)
else
    mm=arr(1)
End If
If  len(arr(2))=1 Then
	dd="0"&arr(2)
else
    dd=arr(2)
End If

strtoday=yy&mm&dd
FormatDay=strtoday
End Function



'*********************************************
'功能：查找指定文件加下的最新时间的文件夹或者文件，返回为最新文件夹或者文件的路径

Function FindNewestFilePath(FPath)
	path1=FPath
	Set fs=createobject("Scripting.FileSystemObject")
	Set f=fs.GetFolder(path1)
	Set fc=f.SubFolders
	g_i=0
	For each fi in fc
		If  initDate<=fi.DateCreated Then
			initDate=fi.DateCreated
			FindNewestFilePath=path1&"\" & fi.name
		End If
	Next
End Function

Public Function ErrorHandle(FuncName)
'print FuncName
If Err.number<>0 Then
	print "脚本"&Environment("TestName")&"的函数"&FuncName&"出错，错误信息为"&Err.Number&Err.Source&Err.Description&Now&",脚本退出！"
	Err.clear
	Exittest
End If
End Function
'------------------------------------------------------------------------kiosk-----------------------------------
Function WSHOperation (methodName, methodVal, waitTime_Seconds)
	Set Wsh = CreateObject ("WScript.Shell")
		Select Case methodName
			Case "Run"
				Wsh.Run methodVal
				Wait waitTime_Seconds
			Case "SendKeys"
				Wsh.SendKeys methodVal
				Wait waitTime_Seconds
			Case "AppActivate"
				Wsh.AppActivate methodVal
				Wait waitTime_Seconds
			Case Else
				Reporter.ReportEvent micWarning,_
				"目前已经实现的方法（区分大小写）：Run, SendKeys, AppActivate",_
				"用法示例：" &vbCrlf&  _
				"Call WSHOperation(""Run"", ""Notepad"", 2)" &vbCrlf& _
				"Call WSHOperation(""SendKeys"", ""YuJie"", 0)"
		End Select
	Set Wsh = Nothing
End Function

Function runExeFile (strfile)
	Set wsShell = CreateObject ("WScript.Shell")
	wsShell.Exec strfile
	Set wsShell=Nothing
End Function

Function XMLExist (xmlPath)
	Set fso = CreateObject ("Scripting.FileSystemObject")
	xmlExist = fso.FileExists (xmlPath)
	Set fso = Nothing
	XMLExist = xmlExist
End Function

Function GetCurrentDateAndConvert ()
	cYear = Year (Now)
	cMonth = Month (Now)
	cDay = Day (Now)

	If cMonth < 10 Then
		cMonth = "0"&cMonth
	End If
	If cDay < 10 Then
		cDay = "0"&cDay
	End If

	curDateAfterConverting = cYear&cMonth&cDay
	GetCurrentDateAndConvert = curDateAfterConverting
End Function

Function ReservedData (xmlPath, valFlagLastDate, valFlagLastRunTimes)
   If valFlagLastRunTimes <10 Then
		valFlagLastRunTimes = "00"&valFlagLastRunTimes
	End If
	If valFlagLastRunTimes >=10 and valFlagLastRunTimes<100 Then
		valFlagLastRunTimes = "0"&valFlagLastRunTimes
	End If
	Set fso = CreateObject ("Scripting.FileSystemObject")
	Set objXml = fso.CreateTextFile (xmlPath)
	objXml.Write _
		"<Environment>"& vbCrlf & _
		vbCrlf & _
			"<Variable>"& vbCrlf & _
				"<Name>flagLastDate</Name>" & vbCrlf & _
				"<Value>" & valFlagLastDate & "</Value>" & vbCrlf & _
			"</Variable>" & vbCrlf & _
			vbCrlf & _
			"<Variable>"& vbCrlf & _
				"<Name>flagLastRunTimes</Name>" & vbCrlf & _
				"<Value>" & valFlagLastRunTimes & "</Value>" & vbCrlf & _
			"</Variable>" & vbCrlf & _
		vbCrlf & _
        "</Environment>"
	Set objXml = Nothing
	Set fso = Nothing
End Function

Function ReservedPIDAndAccNo (xmlPath, valReservedPID, valReservedAccNo)
	Set fso = CreateObject ("Scripting.FileSystemObject")
	Set objXml = fso.CreateTextFile (xmlPath)
	objXml.Write _
		"<Environment>"& vbCrlf & _
		vbCrlf & _
			"<Variable>"& vbCrlf & _
				"<Name>ReservedPID</Name>" & vbCrlf & _
				"<Value>" & valReservedPID & "</Value>" & vbCrlf & _
			"</Variable>" & vbCrlf & _
			vbCrlf & _
			"<Variable>"& vbCrlf & _
				"<Name>ReservedAccNo</Name>" & vbCrlf & _
				"<Value>" & valReservedAccNo & "</Value>" & vbCrlf & _
			"</Variable>" & vbCrlf & _
		vbCrlf & _
        "</Environment>"
	Set objXml = Nothing
	Set fso = Nothing
End Function

Function RecordTestResult (TC_Title, patID, TC_Result)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Result\TestResult.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"

	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = TC_Title
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = TC_Result
	Sheet1.Cells(usedRows+1,4) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Add
								
	Set Sheet1 = excelApp.Sheets.Item(1)
	Sheet1.Name = "测试结果"
	Sheet1.Cells(1,1) = "TC_Title"
	Sheet1.Cells(1,2) = "PatientID"
	Sheet1.Cells(1,3) = "TC_Result"
	Sheet1.Cells(1,4) = "日期与时间"
    Sheet1.Range("A1:B1:C1:D1").Font.Bold = True
	Sheet1.Range("A1:B1:C1:D1").Font.ColorIndex = 5
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
'	Sheet1.Range("A1:B1:C1:D1").HorizontalAlignment = "xlCenter"
'	Sheet1.Range("A1:B1:C1:D1").VerticalAlignment = "xlCenter"
	Set Sheet1 = Nothing
    excelApp.ActiveWorkbook.SaveAs "D:\Investigation\Test Result\TestResult.xls"
	excelApp.Quit:Wait 0,500



	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"
	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = TC_Title
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = TC_Result
	Sheet1.Cells(usedRows+1,4) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
End If
Set fso = Nothing
End Function

Function RecordPIDandACC (ID,patID, AccNo)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Result\TestResult.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"

	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = ID
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = AccNo
	Sheet1.Cells(usedRows+1,4) = Now
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Add
								
	Set Sheet1 = excelApp.Sheets.Item(1)
	Sheet1.Name = "PIDandAcc"
	Sheet1.Cells(1,1) = "ID"
	Sheet1.Cells(1,2) = "PatientID"
	Sheet1.Cells(1,3) = "AccNo"
	Sheet1.Cells(1,4) = "日期与时间"
    Sheet1.Range("A1:B1:C1:D1").Font.Bold = True
	Sheet1.Range("A1:B1:C1:D1").Font.ColorIndex = 5
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
'	Sheet1.Range("A1:B1:C1:D1").HorizontalAlignment = "xlCenter"
'	Sheet1.Range("A1:B1:C1:D1").VerticalAlignment = "xlCenter"
	Set Sheet1 = Nothing
    excelApp.ActiveWorkbook.SaveAs "D:\Investigation\Test Result\TestResult.xls"
	excelApp.Quit:Wait 0,500



	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"
	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = ID
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = AccNo
	Sheet1.Cells(usedRows+1,4) = Now
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
End If
Set fso = Nothing
End Function

Function RecordOCRTestResult (AccNo, patID, TC_Result, ActualAccNo, ActualpatID)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Result\TestResult.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"

	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = AccNo
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = TC_Result
	Sheet1.Cells(usedRows+1,4) = ActualAccNo
	Sheet1.Cells(usedRows+1,5) = ActualpatID
	Sheet1.Cells(usedRows+1,6) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Add
								
	Set Sheet1 = excelApp.Sheets.Item(1)
	Sheet1.Name = "测试结果"
	Sheet1.Cells(1,1) = "AccNo"
	Sheet1.Cells(1,2) = "PatientID"
	Sheet1.Cells(1,3) = "TC_Result"
	Sheet1.Cells(1,4) = "ActualAccNo"
	Sheet1.Cells(1,5) = "ActualpatID"
	Sheet1.Cells(1,6) = "日期与时间"
    Sheet1.Range("A1:B1:C1:D1:E1:F1").Font.Bold = True
	Sheet1.Range("A1:B1:C1:D1:E1:F1").Font.ColorIndex = 5
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
'	Sheet1.Range("A1:B1:C1:D1").HorizontalAlignment = "xlCenter"
'	Sheet1.Range("A1:B1:C1:D1").VerticalAlignment = "xlCenter"
	Set Sheet1 = Nothing
    excelApp.ActiveWorkbook.SaveAs "D:\Investigation\Test Result\TestResult.xls"
	excelApp.Quit:Wait 0,500



	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"
	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = AccNo
	Sheet1.Cells(usedRows+1,2) = patID
	Sheet1.Cells(usedRows+1,3) = TC_Result
	Sheet1.Cells(usedRows+1,4) = ActualAccNo
	Sheet1.Cells(usedRows+1,5) = ActualpatID
	Sheet1.Cells(usedRows+1,6) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("C"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("C"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
End If
Set fso = Nothing
End Function

Function RecordOCRTimeTestResult (ID, AccNo, patID, TC_Result, finalTime)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Result\TestResult.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"

	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = ID
	Sheet1.Cells(usedRows+1,2) = AccNo
	Sheet1.Cells(usedRows+1,3) = patID
	Sheet1.Cells(usedRows+1,4) = TC_Result
	Sheet1.Cells(usedRows+1,5) = finalTime
	Sheet1.Cells(usedRows+1,6) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("D"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("D"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("D"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("D"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Add
								
	Set Sheet1 = excelApp.Sheets.Item(1)
	Sheet1.Name = "测试结果"
	Sheet1.Cells(1,1) = "ID"
	Sheet1.Cells(1,2) = "AccNo"
	Sheet1.Cells(1,3) = "PatientID"
	Sheet1.Cells(1,4) = "TC_Result"
	Sheet1.Cells(1,5) = "FinalTime"
	Sheet1.Cells(1,6) = "日期与时间"
    Sheet1.Range("A1:B1:C1:D1:E1:F1").Font.Bold = True
	Sheet1.Range("A1:B1:C1:D1:E1:F1").Font.ColorIndex = 5
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
'	Sheet1.Range("A1:B1:C1:D1").HorizontalAlignment = "xlCenter"
'	Sheet1.Range("A1:B1:C1:D1").VerticalAlignment = "xlCenter"
	Set Sheet1 = Nothing
    excelApp.ActiveWorkbook.SaveAs "D:\Investigation\Test Result\TestResult.xls"
	excelApp.Quit:Wait 0,500



	excelApp.Workbooks.Open "D:\Investigation\Test Result\TestResult.xls"
	Set Sheet1 = excelApp.Sheets.Item(1)
	usedRows = Sheet1.UsedRange.Rows.Count
	Sheet1.Cells(usedRows+1,1) = ID
	Sheet1.Cells(usedRows+1,2) = AccNo
	Sheet1.Cells(usedRows+1,3) = patID
	Sheet1.Cells(usedRows+1,4) = TC_Result
	Sheet1.Cells(usedRows+1,5) = finalTime
	Sheet1.Cells(usedRows+1,6) = Now
	Select Case TC_Result
							Case "Fail" 
													Sheet1.Range("D"&usedRows+1&"").Font.ColorIndex = 3
													Sheet1.Range("D"&usedRows+1&"").Font.Bold = True
						 	Case "Pass" 
													  Sheet1.Range("D"&usedRows+1&"").Font.ColorIndex = 10
													  Sheet1.Range("D"&usedRows+1&"").Font.Bold = True
	End Select
	Sheet1.Columns("A:A").EntireColumn.AutoFit
	Sheet1.Columns("B:B").EntireColumn.AutoFit
	Sheet1.Columns("C:C").EntireColumn.AutoFit
	Sheet1.Columns("D:D").EntireColumn.AutoFit
	Sheet1.Columns("E:E").EntireColumn.AutoFit
	Sheet1.Columns("F:F").EntireColumn.AutoFit
	Set Sheet1 = Nothing

	excelApp.ActiveWorkbook.Save
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
End If
Set fso = Nothing
End Function


Dim NeedReport, DcmFileName, DcmFileType, LoadImageCount, SelectFilmPrinter, SelectFilmSize, PatientName, PrintMode, IPAddress
Public Function ReadNormalTestData (strTcId, sheetName)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Data\TestData.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Data\TestData.xls"

	Set Sheet1 = excelApp.Sheets.Item(sheetName)
	usedRows = Sheet1.UsedRange.Rows.Count
	usedColumn = Sheet1.UsedRange.Columns.Count

	For i = 1 to usedRows
		If strTcId = Sheet1.Cells(i+1,1)Then
'			For j =2 to usedColumn
'				a = Sheet1.Cells(i+1,j)
'				msgbox a
'			Next
			NeedReport = Sheet1.Cells(i+1,2)
			DcmFileName = Sheet1.Cells(i+1,3)
			DcmFileType = Sheet1.Cells(i+1,4)
			LoadImageCount = Sheet1.Cells(i+1,5)
            SelectFilmPrinter = Sheet1.Cells(i+1,6)
            SelectFilmSize = Sheet1.Cells(i+1,7)
            PatientName = Sheet1.Cells(i+1,8)
			PrintMode = Sheet1.Cells(i+1,9)
			IPAddress = Sheet1.Cells(i+1,10)
			Exit for
		End If

	Next
	Set Sheet1 = Nothing
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Reporter.ReportEvent micFail, "Check testdata file", "There is no testdata file"
End If
Set fso = Nothing
End Function


'Dim PrintMode, IPAddress
'Public Function ReadPMTestData (strTcId, sheetName)
'Set fso = CreateObject("Scripting.FileSystemObject")
'xlsExists =  fso.FileExists ("D:\Investigation\Test Data\TestData.xls")
'If xlsExists Then
'	Set excelApp = CreateObject("Excel.Application")
'	excelApp.Visible = False
'	excelApp.Workbooks.Open "D:\Investigation\Test Data\TestData.xls"
'
'	Set Sheet1 = excelApp.Sheets.Item(sheetName)
'	usedRows = Sheet1.UsedRange.Rows.Count
'	usedColumn = Sheet1.UsedRange.Columns.Count
'
'	For i = 1 to usedRows
'		If strTcId = Sheet1.Cells(i+1,1)Then
'			PrintMode = Sheet1.Cells(i+1,9)
'			IPAddress = Sheet1.Cells(i+1,10)
'			Exit for
'		End If
'
'	Next
'	Set Sheet1 = Nothing
'	excelApp.Workbooks.Close
'	excelApp.Quit
'	Set excelApp = Nothing
'Else
'	Reporter.ReportEvent micFail, "Check testdata file", "There is no testdata file"
'End If
'Set fso = Nothing
'End Function

Dim UserName, Pwd, IP
Public Function LoginWebTestData (strTcId, sheetName)
Set fso = CreateObject("Scripting.FileSystemObject")
xlsExists =  fso.FileExists ("D:\Investigation\Test Data\TestData.xls")
If xlsExists Then
	Set excelApp = CreateObject("Excel.Application")
	excelApp.Visible = False
	excelApp.Workbooks.Open "D:\Investigation\Test Data\TestData.xls"

	Set Sheet1 = excelApp.Sheets.Item(sheetName)
	usedRows = Sheet1.UsedRange.Rows.Count
	usedColumn = Sheet1.UsedRange.Columns.Count

	For i = 1 to usedRows
		If strTcId = Sheet1.Cells(i+1,1)Then
			UserName = Sheet1.Cells(i+1,9)
			Pwd = Sheet1.Cells(i+1,10)
			IP = Sheet1.Cells(i+1,11)
			Exit for
		End If

	Next
	Set Sheet1 = Nothing
	excelApp.Workbooks.Close
	excelApp.Quit
	Set excelApp = Nothing
Else
	Reporter.ReportEvent micFail, "Check testdata file", "There is no testdata file"
End If
Set fso = Nothing
End Function



Public Function CheckPoint(ExpResult, ActResult)
		If ActResult = ExpResult Then
			strResult = "Pass"
		Else
			strResult = "Fail"
		End If
		CheckPoint = strResult
End Function

'Public Function GetTime()
'   GetTime = now()
'End Function

'获得本机器的IP地址   
'示例：msgbox GetIPMAC(".")
Function GetIPMAC(ComputerName) 
Dim objWMIService,colItems,objItem,objAddress
Set objWMIService = GetObject("winmgmts://" & ComputerName & "/root/cimv2")
Set colItems = objWMIService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration Where IPEnabled = True")
For Each objItem in colItems
 For Each objAddress in objItem.IPAddress
  If objAddress <> "" then
  'GetIPMAC = objAddress & ",MAC:" & objItem.MACAddress
   GetIPMAC = objAddress
  Exit For
 End If  
 Next
 Exit For
Next
End Function

'读取xml文件里所有环境变量，返回一个DIctionary对象
Public Function ReadXmlEnvVars(fileName)    
Dim xmlObj,xmlDic
Dim xmlRoot,xmlNode    
Dim varName,varValue     
Set xmlObj = CreateObject("MSXML2.DOMDocument")    
Set xmlDic = CreateObject("Scripting.Dictionary")
 xmlObj.Load fileName     
Set xmlRoot = xmlObj.LastChild     
For i = 0 to xmlRoot.ChildNodes.Length - 1   
Set xmlNode = xmlRoot.ChildNodes.Item(i)   
varName = xmlNode.ChildNodes.Item(0).nodeTypedValue   
varValue = xmlNode.ChildNodes.Item(1).nodeTypedValue   
xmlDic.AddvarName,varValue    
Next     
Set ReadXmlEnvVars = xmlDic    
Set xmlObj = nothing
Set xmlDic = nothing    
Set xmlRoot = nothing    
Set xmlNode = nothing 
End Function 


'更新xml格式环境变量文件  
Public Sub UpdateXmlEnvVars(fileName,varName,varValue)   
Dim xmlObj     
Dim xmlRoot,xmlNode    
Dim nodeName,nodeValue     
Set xmlObj = CreateObject("MSXML2.DOMDocument")
 xmlObj.Load fileName     
Set xmlRoot = xmlObj.LastChild     
For i = 0 to xmlRoot.ChildNodes.Length - 1   
Set xmlNode = xmlRoot.ChildNodes.Item(i)   
nodeName = xmlNode.ChildNodes.Item(0).nodeTypedValue   'nodeValue = xmlNode.ChildNodes.Item(1).nodeTypedValue
If UCase(Trim(nodeName)) = UCase(Trim(varName)) Then    
	xmlNode.ChildNodes.Item(1).nodeTypedValue = varValue   
End If    
Next  
xmlObj.Save fileName    
Set xmlObj = nothing    
Set xmlRoot = nothing    
Set xmlNode = nothing 
End Sub


'删除xml格式环境变量文件里的一个节点 
Public Sub DelXmlEnvVars(fileName,varName)    
Dim xmlObj
Dim xmlRoot,xmlNode    
Dim nodeName,nodeValue     
Set xmlObj = CreateObject("MSXML2.DOMDocument") 
xmlObj.LoadfileName     
Set xmlRoot = xmlObj.LastChild     
If xmlRoot.ChildNodes.Length = 1 Then     
Exit Sub    
End If     
For i = 0 to xmlRoot.ChildNodes.Length - 1   
Set xmlNode = xmlRoot.ChildNodes.Item(i)   
nodeName = xmlNode.ChildNodes.Item(0).nodeTypedValue   'nodeValue = xmlNode.ChildNodes.Item(1).nodeTypedValue
If UCase(Trim(nodeName)) = UCase(Trim(varName)) Then 
	   xmlRoot.RemoveChild(xmlNode)    
Exit For   
End If    
Next  
xmlObj.Save fileName    
Set xmlObj = nothing    
Set xmlRoot = nothing    
Set xmlNode = nothing 
End Sub

'增加一个新的节点到xml格式的环境变量  
'可以增加判断，如果varName重复，则调用UpdateXmlEnvVars() 
Public Sub AddXmlEnvVars(fileName,varName,varValue)    
Dim xmlObj     
Dim xmlRoot,xmlNode    
Dim nodeName,nodeValue    
Dim index     
Set xmlObj = CreateObject("MSXML2.DOMDocument") 
xmlObj.load  fileName  
Set xmlRoot = xmlObj.LastChild     
Set xmlNode = xmlRoot.ChildNodes.Item(0).CloneNode(1) 
xmlNode.ChildNodes.Item(0).nodeTypedValue = varName
xmlNode.ChildNodes.Item(1).nodeTypedValue = varValue 
xmlRoot.AppendChild(xmlNode) 
xmlObj.Save fileName    
Set xmlObj = nothing    
Set xmlRoot = nothing    
Set xmlNode = nothing 
End Sub
