DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '15.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'15.0'
	,GETDATE()
	,'Fix transactions filters when updating'
	)
;
