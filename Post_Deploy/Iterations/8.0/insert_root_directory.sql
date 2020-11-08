DELETE FROM SETTINGS WHERE SETTING IN('Root_Directory','Default_Folder')
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
,
(
 'Default_Folder'
 ,'Docs'
 ,'Name used for Docs folder in the root directory'
)
,
(
 'Default_Folder'
 ,'Expenses'
 ,'Name used for Expenses folder in the root directory'
)
,
(
 'Default_Folder'
 ,'Income'
 ,'Name used for Income folder in the root directory'
)
;
;
