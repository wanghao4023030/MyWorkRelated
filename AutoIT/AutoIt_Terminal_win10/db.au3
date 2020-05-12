DIM $conn,$RS
$conn = ObjCreate("ADODB.Connection")
$RS = ObjCreate("ADODB.Recordset")

$conn.open("Driver={SQL Server};Server=10.184.128.182\GCPACSWS;uid=sa;pwd=sa20021224$;database=wggc")
;~ $RS.ActiveConnection = $conn
$RS.Open("SELECT * FROM AFP_Filminfo",$conn)
While (Not $RS.eof And Not $RS.bof)
		msgbox(1,"1",$RS.Fields(0).value)
		msgbox(1,"1",$RS.Fields(1).name)
		msgbox(1,"1",$RS.Fields(2).name)
		msgbox(1,"1",$RS.Fields(3).name)

	$RS.movenext
WEnd