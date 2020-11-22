DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '13.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'13.0'
	,GETDATE()
	,'Clean up: Production instance'
	)
;
