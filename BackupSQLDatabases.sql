DECLARE @File varchar(1000)
DECLARE @i int
DECLARE @Path varchar(128)
DECLARE @dateString CHAR(8), @dayStr CHAR(2), @monthStr CHAR(2)
-- , @hourStr CHAR(2), @minStr CHAR(2)
DECLARE @IDENT INT, @sql VARCHAR(1000), @DBNAME VARCHAR(200)
 
-- EDIT BELOW THIS LINE --

-- SET THE PATH TO WHERE BACKUPS WILL BE SAVED
SET @Path = 'C:\SQL_Backup\'
 
-- STOP EDITING --
 
--month variable
IF (SELECT LEN(CAST(MONTH(GETDATE()) AS CHAR(2))))=2
   SET @monthSTR=CAST(MONTH(GETDATE()) AS CHAR(2))
ELSE
   SET @monthSTR= '0' + CAST(MONTH(GETDATE()) AS CHAR(2))
--day variable
IF (SELECT LEN(CAST(DAY(GETDATE()) AS CHAR(2))))=2
   SET @daySTR=CAST(DAY(GETDATE()) AS CHAR(2))
ELSE
   SET @daySTR='0' + CAST(DAY(GETDATE()) AS CHAR(2))
--name variable based on time stamp
SET @dateString=CAST(YEAR(GETDATE()) AS CHAR(4)) + @monthStr + @dayStr

 
--=================================================================
 
SELECT @IDENT=MIN(database_id) FROM SYS.DATABASES WHERE [database_id] > 0 AND NAME NOT IN ('TEMPDB')
WHILE @IDENT IS NOT NULL
BEGIN
   SELECT @DBNAME = NAME FROM SYS.DATABASES WHERE database_id = @IDENT
SET @File = @Path + @DBNAME + '_db_' + @dateString +'.BAK'
-- PRINT @FILE
  SELECT @SQL = 'BACKUP DATABASE '+@DBNAME+' TO DISK = '''+ @Path + @DBNAME + '_db_' + @dateString +'.BAK'' WITH INIT'
  EXEC (@SQL)
  SELECT @IDENT=MIN(database_id) FROM SYS.DATABASES WHERE [database_id] > 0 AND database_id>@IDENT AND NAME NOT IN ('TEMPDB')
 
END