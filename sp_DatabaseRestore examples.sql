	--This example will NOT execute the restore.  Commands will be printed in a copy/paste ready format only
	EXEC dbo.sp_DatabaseRestore
		@Database = 'WideWorldImporters',
		@BackupPathFull = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\FULL\',
		@BackupPathDiff = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\DIFF',
		@BackupPathLog = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\LOG\',
		@RestoreDiff = 1,
		@ContinueLogs = 1,
		@RunRecovery = 1,
		@TestRestore = 1,
		@RunCheckDB = 1,
		@Debug = 0,
		@Execute = 'N';


	--This example will restore the latest differential backup, and stop transaction logs at the specified date time.  It will execute and print debug information.
	EXEC dbo.sp_DatabaseRestore
		@Database = 'WideWorldImporters',  
		@BackupPathFull = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\FULL\',
		@BackupPathDiff = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\DIFF',
		@BackupPathLog = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\LOG\',
		@RestoreDiff = 1,
		@ContinueLogs = 1,
		@RunRecovery = 1,
		@StopAt = '20170508201501',
		@Debug = 1;

	-- 3. This example restores to location other than the target instance defaults
	EXEC dbo.sp_DatabaseRestore
		@Database = 'WideWorldImporters',  
		@BackupPathFull = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\FULL\',
		@BackupPathDiff = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\DIFF',
		@BackupPathLog = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\LOG\',
		@RestoreDiff = 1,
		@ContinueLogs = 1,
		@RunRecovery = 1,
		@RunCheckDB = 1,
		-- Move data files to a new drive (E:), keeping the same file names as in the backup
		@MoveDataDrive = 'E:\SQLData\WWI\',
		-- Move log file to a new drive (F:), keeping the same log file name as in the backup
		@MoveLogDrive  = 'F:\SQLLogs\WWI\',
		@Execute = 'N';
	
	-- code run in example 3
		RESTORE DATABASE [WideWorldImporters] 
		FROM DISK = '\\SQLSRV01\Backup\SQLSRV01\WideWorldImporters\DIFF\SQLSRV01_WideWorldImporters_DIFF_20251130_170429.bak' WITH NORECOVERY, 
		MOVE 'WWI_Primary' TO 'E:\SQLData\WWI\WideWorldImporters.mdf', 
		MOVE 'WWI_UserData' TO 'E:\SQLData\WWI\WideWorldImporters_UserData.ndf', 
		MOVE 'WWI_Log' TO 'F:\SQLLogs\WWI\WideWorldImporters.ldf'
		RESTORE DATABASE [WideWorldImporters] WITH RECOVERY

		DBCC CHECKDB ([WideWorldImporters]) WITH NO_INFOMSGS, ALL_ERRORMSGS, DATA_PURITY;

