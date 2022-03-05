# We're going to need dbatools
Import-Module dbatools

#region Set up connection
$securePassword = ('dbatools.IO' | ConvertTo-SecureString -AsPlainText -Force)
$continercredential = New-Object System.Management.Automation.PSCredential('sqladmin', $securePassword)

$Global:PSDefaultParameterValues = @{
    "*dba*:SqlCredential"            = $continercredential
    "*dba*:SourceSqlCredential"      = $continercredential
    "*dba*:DestinationSqlCredential" = $continercredential
    "*dba*:DestinationCredential"    = $continercredential
    "*dba*:PrimarySqlCredential"     = $continercredential
    "*dba*:SecondarySqlCredential"   = $continercredential
}
 