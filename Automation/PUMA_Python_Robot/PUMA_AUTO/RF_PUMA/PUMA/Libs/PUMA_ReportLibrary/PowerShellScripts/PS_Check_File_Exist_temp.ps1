$Username = 'administrator'
$PWD = 'pdchi2002$'
$pass = ConvertTo-SecureString -AsPlainText $PWD -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$Server = '10.112.20.84'
Invoke-Command -ComputerName $Server -ScriptBlock {test-path 'E:\Report\Archive\20191206\P20191206224418.pdf'} -credential $Cred

