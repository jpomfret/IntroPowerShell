# We're going to need dbatools
Import-Module dbatools

#region Set up connection
$securePassword = ('dbatools.IO' | ConvertTo-SecureString -AsPlainText -Force)
$containerCredential = New-Object System.Management.Automation.PSCredential('sqladmin', $securePassword)

$mssql1 = Connect-DbaInstance -SqlInstance 'localhost,4433' -SqlCredential $containerCredential
$mssql2 = Connect-DbaInstance -SqlInstance 'localhost,4434' -SqlCredential $containerCredential

$Global:PSDefaultParameterValues = @{
    "*dba*:SqlCredential"            = $containerCredential
    "*dba*:SourceSqlCredential"      = $containerCredential
    "*dba*:DestinationSqlCredential" = $containerCredential
    "*dba*:DestinationCredential"    = $containerCredential
    "*dba*:PrimarySqlCredential"     = $containerCredential
    "*dba*:SecondarySqlCredential"   = $containerCredential
}


# Take some backups
$null = Backup-DbaDatabase -SqlInstance $mssql2
$null = Backup-DbaDatabase -SqlInstance $mssql2 -Type Diff
$null = Backup-DbaDatabase -SqlInstance $mssql2 -Type Log