CREATE PROCEDURE [dbo].[Backup_Production]
AS

DECLARE @Dir Varchar(2000)
SET @Dir = (SELECT MAX(Setting_Value) from Settings where Setting = 'Production_Backup_Directory')
;
DECLARE @FILENAME Varchar(2000)
;
SET @FILENAME = @Dir + 'Property_Management_' + REPLACE (CONVERT(nvarchar(20),GetDate(),120),':','-') + '.bak'
BACKUP DATABASE Property_Management TO DISK = @FILENAME
;
