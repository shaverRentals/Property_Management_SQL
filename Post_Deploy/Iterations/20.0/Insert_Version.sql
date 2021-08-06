DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '20.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'20.0'
	,GETDATE()
	,'Re-do reconcilliation source table'
	)
;
