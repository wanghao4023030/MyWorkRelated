function Convert-WuaResultCodeToName
{
param( [Parameter(Mandatory=$true)]
[int] $ResultCode
)
$Result = $ResultCode
switch($ResultCode)
{
1
{
$Result = "In Progress"
}
2
{
$Result = "Succeeded"
}
3
{
$Result = "Succeeded With Errors"
}
4
{
$Result = "Failed"
}
5
{
$Result = "Aborted"
}

}
return $Result
}
function Get-WuaHistory
{
$session = (New-Object -ComObject 'Microsoft.Update.Session')
$Searcher = $Session.CreateUpdateSearcher()
$historyCount = $Searcher.GetTotalHistoryCount()
$history = $session.QueryHistory("",0,$historyCount) | ForEach-Object {
$Result = Convert-WuaResultCodeToName -ResultCode $_.ResultCode
$_ | Add-Member -MemberType NoteProperty -Value $Result -Name Result
$Product = $_.Categories | Where-Object {$_.Type -eq 'Product'} | Select-Object -First 1 -ExpandProperty Name
$_ | Add-Member -MemberType NoteProperty -Value $_.UpdateIdentity.UpdateId -Name UpdateId
$_ | Add-Member -MemberType NoteProperty -Value $_.UpdateIdentity.RevisionNumber -Name RevisionNumber
$_ | Add-Member -MemberType NoteProperty -Value $Product -Name Product -PassThru
}
$history |Where-Object {![String]::IsNullOrWhiteSpace($_.title)} |
Select-Object Product,Result, Title,Date  | Sort-Object Product,Date
}
Get-WuaHistory | Format-Table 