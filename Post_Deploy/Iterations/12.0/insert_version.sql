DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '12.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'12.0'
	,GETDATE()
	,'reconciliations'
	)
;
