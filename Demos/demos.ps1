# We're going to need dbatools
Import-Module dbatools

#region Set up connection
$securePassword = ('dbatools.IO' | ConvertTo-SecureString -AsPlainText -Force)
$continercredential = New-Object System.Management.Automation.PSCredential('sqladmin', $securePassword)

$mssql1 = Connect-DbaInstance -SqlInstance 'localhost,2500' -SqlCredential $continercredential
$mssql2 = Connect-DbaInstance -SqlInstance 'localhost,2600' -SqlCredential $continercredential

$Global:PSDefaultParameterValues = @{
    "*dba*:SqlCredential"            = $continercredential
    "*dba*:SourceSqlCredential"      = $continercredential
    "*dba*:DestinationSqlCredential" = $continercredential
    "*dba*:DestinationCredential"    = $continercredential
    "*dba*:PrimarySqlCredential"     = $continercredential
    "*dba*:SecondarySqlCredential"   = $continercredential
}


# Take some backups
$null = Backup-DbaDatabase -SqlInstance $mssql2 
$null = Backup-DbaDatabase -SqlInstance $mssql2 -Type Diff
$null = Backup-DbaDatabase -SqlInstance $mssql2 -Type Log
