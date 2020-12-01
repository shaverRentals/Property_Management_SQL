DELETE FROM Settings where Setting IN('Production_Backup_Directory','Production_Backup_Retention')
;
INSERT INTO Settings
(
 Setting
 ,Setting_Value
 ,Setting_Description
)
VALUES
(
 'Production_Backup_Directory'
 ,'C:\Users\shave\OneDrive\Documents\Property_Management\Property_Management_Backups\Production\'
 ,'Prouction SQL backup directory'
)
,
(
 'Production_Backup_Retention'
 ,'3'
 ,'The number of production backups to retain'
)
;
