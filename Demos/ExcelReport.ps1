$excel = '.\Backups.xlsx'

if((Test-Path $excel)){
    Remove-Item $excel
}

$conTxt = New-ConditionalText -Text '=now()-7' -ConditionalType LessThan
Get-DbaLastBackup -SqlInstance $mssql1, $mssql2 |
    Select-Object SqlInstance, Database, LastFullBackup, LastDiffBackup, LastLogBackup |
    Export-Excel -Path $excel -Table tblBackup -WorksheetName Backups -AutoSize -ConditionalText $conTxt -Show
