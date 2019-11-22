TRUNCATE TABLE Version
;

DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '6.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'6.0'
	,GETDATE()
	,'Person Roles'
	)
;
