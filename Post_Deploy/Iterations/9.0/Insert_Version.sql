DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '9.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'9.0'
	,GETDATE()
	,'Transactions'
	)
;
