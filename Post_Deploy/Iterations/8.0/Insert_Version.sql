DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '8.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'8.0'
	,GETDATE()
	,'Settings table and values'
	)
;
