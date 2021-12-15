DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '22.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'22.0'
	,GETDATE()
	,'Expand transaction distributions for distributing 14th street properties'
	)
;
