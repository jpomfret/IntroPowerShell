CREATE DATABASE [AdventureWorks2017] ON
(FILENAME = '/var/opt/sqlserver/AdventureWorks2017.mdf'),
(FILENAME = '/var/opt/sqlserver/AdventureWorks2017_log.ldf') FOR ATTACH;

GO

Use Master
CREATE DATABASE DatabaseAdmin
GO

ALTER DATABASE [AdventureWorks2017] SET RECOVERY FULL ;

BACKUP DATABASE [AdventureWorks2017] TO DISK = N'C:\var\opt\backups\AdventureWorks2017.bak'
WAITFOR DELAY '00:00:05';
BACKUP DATABASE [AdventureWorks2017] TO DISK = N'C:\var\opt\backups\AdventureWorks2017.diff' WITH DIFFERENTIAL
WAITFOR DELAY '00:00:05';
BACKUP LOG [AdventureWorks2017] TO DISK = N'C:\var\opt\backups\AdventureWorks2017.log'

-- backup system dbs
BACKUP DATABASE [master] TO DISK = N'C:\var\opt\backups\master.bak'
BACKUP DATABASE [msdb] TO DISK = N'C:\var\opt\backups\msdb.bak'
BACKUP DATABASE [model] TO DISK = N'C:\var\opt\backups\model.bak'