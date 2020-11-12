DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '10.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'10.0'
	,GETDATE()
	,'Transactions distributions'
	)
;
