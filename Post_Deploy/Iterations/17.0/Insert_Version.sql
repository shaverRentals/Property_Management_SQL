DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '17.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'17.0'
	,GETDATE()
	,'Add partial rent months to reconcilliation procedure'
	)
;
