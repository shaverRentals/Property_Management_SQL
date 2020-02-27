DELETE FROM SETTINGS WHERE SETTING IN('Root_Directory','Lease_Folder_Name')
;

INSERT INTO Settings
(
 Setting
 ,Setting_Value
 ,Setting_Description
)
VALUES
(
 'Root_Directory'
 ,'C:\Users\shave\OneDrive\Documents\Property_Management\Properties'
 ,'Root directory for storing property management related documents'
)
,
(
 'Default_Folder'
 ,'Leases'
 ,'Name used for lease folder in the root directory'
)
;