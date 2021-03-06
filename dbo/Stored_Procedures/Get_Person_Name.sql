﻿CREATE PROCEDURE [dbo].[Get_Person_Name]
	
AS
	
SELECT        People.Person_Name_Combined, People.Person_ID
FROM            People INNER JOIN
                         Person_Role ON People.Person_ID = Person_Role.Person_ID INNER JOIN
                         Person_Role_Type ON Person_Role.Person_Role_Type_ID = Person_Role_Type.Person_Role_Type_ID
WHERE Person_Role_type = 'Tennant'
UNION
select
 'Default, Tennant'
 ,100000
FROM People 
order by Person_Name_Combined
;