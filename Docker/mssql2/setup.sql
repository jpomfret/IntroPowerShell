Use Master
GO
CREATE DATABASE [ImportantAppDb]
GO
CREATE DATABASE [ImportantAppDbDW]
GO
CREATE DATABASE [DatabaseAdmin]
GO

BACKUP DATABASE [DatabaseAdmin] TO DISK = N'C:\var\opt\backups\DatabaseAdmin.bak'
WAITFOR DELAY '00:00:05';
BACKUP DATABASE [DatabaseAdmin] TO DISK = N'C:\var\opt\backups\DatabaseAdmin.diff' WITH DIFFERENTIAL
WAITFOR DELAY '00:00:05';
BACKUP LOG [DatabaseAdmin] TO DISK = N'C:\var\opt\backups\DatabaseAdmin.log'

BACKUP DATABASE [ImportantAppDbDW] TO DISK = N'C:\var\opt\backups\ImportantAppDbDW.bak'
WAITFOR DELAY '00:00:05';
BACKUP DATABASE [ImportantAppDbDW] TO DISK = N'C:\var\opt\backups\ImportantAppDbDW.diff' WITH DIFFERENTIAL
WAITFOR DELAY '00:00:05';
BACKUP LOG [ImportantAppDbDW] TO DISK = N'C:\var\opt\backups\ImportantAppDbDW.log'

-- backup system dbs
BACKUP DATABASE [master] TO DISK = N'C:\var\opt\backups\master.bak'
BACKUP DATABASE [msdb] TO DISK = N'C:\var\opt\backups\msdb.bak'
BACKUP DATABASE [model] TO DISK = N'C:\var\opt\backups\model.bak'