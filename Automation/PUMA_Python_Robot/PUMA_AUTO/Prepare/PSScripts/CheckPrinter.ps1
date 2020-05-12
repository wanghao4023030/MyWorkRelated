$Username = 'administrator'
$PWD = 'pdchi2002$'
$pass = ConvertTo-SecureString -AsPlainText $PWD -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$Server = '10.112.20.84'
$Printer = Invoke-Command -ComputerName $Server -ScriptBlock { Get-WmiObject -Query " SELECT * FROM Win32_Printer Where Name = ""{printerName}""" } -credential $Cred
$Printer.Name -eq "{printerName}"