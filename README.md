Script to backup MSSQL Server databases.
Perfect for EXPRESS Edition that does not have SQL Agent and therefor can't run Maintenance Plans as Full versions can.


Two part script 

	BackupDatabase.bat
		This file connects to the MSSQL Server and executes the second file of this combo.
		Path to SQLCMD.EXE (Depends on MSSQL Version. 2005/2008(R2)/2012/2014)
		It also deletes older files to keep it running without using to much space on the disk.
		Default is set to 5 days. Number of days can be changed in this file.



	BackupSQLDatabases.sql
		This file contains the SQL commands to backup every database except TEMPDB.
		In this file you must set the directory where backups should be saved.
		Backups will be saved in this format
			<Databasename>_db_<year-month-day>.bak
		