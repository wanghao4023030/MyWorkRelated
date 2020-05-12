$Username = 'administrator'
$PWD = 'pdchi2002$'
$pass = ConvertTo-SecureString -AsPlainText $PWD -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$Server = '10.112.20.84'
try
{
    $Session = New-PSSession -ComputerName $Server -Credential $Cred
    Copy-Item -Path "D:\Test" -Destination "E:" -ToSession $session -Recurse  -Verbose -PassThru -Force 
    $session | Remove-PSSession
    return $True
}
catch
{
    return $False
}

