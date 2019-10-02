CREATE PROCEDURE [dbo].[Get_Person_Name]
	
AS
	
select
 Person_ID
 ,Person_Name_Combined
FROM People
UNION
select
 10000
 ,'Default, Tennant'
FROM People 
order by Person_Name_Combined
;