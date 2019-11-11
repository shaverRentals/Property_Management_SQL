DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '5.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'2.0'
	,GETDATE()
	,'Lease objects'
	)
;
