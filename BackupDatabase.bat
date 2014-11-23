@echo off
REM ----------
REM Database backups
REM Few things to change to make sure this script works.
REM 
REM This file should be executed using Task Scheduler
REM The User used to execute this script MUST have backup privileges on the MS SQL Server
REM 
REM Follow the rest of the instructions for each row and you will be fine

REM set the correct servername and instance 
	
	set servername=localhost\SQLEXPRESS

REM To things to update, first the path to SQLCMD.EXE (This depends on the version of MSSQL Express)
REM
REM  90 = MSSQL 2005
REM 100 = MSSQL 2008
REM 110 = MSSQL 2012
REM 120 = MSSQL 2014
REM
REM Second part is the path to the actual backupscript in T-SQL

	"C:\Program Files\Microsoft SQL Server\90\Tools\Binn\SQLCMD.EXE" -S %servername% -E -i "C:\SQL_Backup\Scripts\BackupSQLDatabases.sql"

REM Delete BackupFiles older then 5 days
REM
REM Change the path to the directory where the MSSQL Backups are saved (This is set in the BackupSQLDatabases.sql file)
REM 
	FORFILES /p "C:\SQL_Backup" /s /m *.BAK /d -5 /c "CMD /C del /Q @FILE"


REM ----------
REM End of File
REM ----------

