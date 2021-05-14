$excel = '.\Backups.xlsx'
rm $excel

Get-DbaLastBackup -SqlInstance 'localhost,2500', 'localhost,2600' |
    Select-Object SqlInstance, Database, LastFullBackup, LastDiffBackup, LastLogBackup |
    Export-Excel -Path $excel -Table tblBackup -WorksheetName Backups -AutoSize

$excelPackage = Open-ExcelPackage -Path $excel -KillExcel
$rows = $excelPackage.backups.Dimension.Rows

Add-ConditionalFormatting -Worksheet $excelPackage.Backups -RuleType LessThan (Get-Date).AddDays(-7).ToString() -Address ('C2:E{0}' -f $rows) -BackgroundColor Red

Close-ExcelPackage $excelPackage -Show