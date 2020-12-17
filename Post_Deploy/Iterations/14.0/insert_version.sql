DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '14.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'14.0'
	,GETDATE()
	,'Automate backups. Fiscal objects'
	)
;
