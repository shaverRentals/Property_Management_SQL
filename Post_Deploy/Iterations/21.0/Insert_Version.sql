DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '21.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'21.0'
	,GETDATE()
	,'Create IRS income tax table'
	)
;
