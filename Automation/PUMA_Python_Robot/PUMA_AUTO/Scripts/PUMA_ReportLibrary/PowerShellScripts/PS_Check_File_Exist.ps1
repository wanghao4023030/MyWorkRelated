$Username = 'administrator'
$PWD = 'pdchi2002$'
$pass = ConvertTo-SecureString -AsPlainText $PWD -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$Server = '{server}'
Invoke-Command -ComputerName $Server -ScriptBlock {test-path '{file_path}'} -credential $Cred
