DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '18.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'18.0'
	,GETDATE()
	,'Lease save issue. Remove inactive persons transactions. Sort lease members. Transaction filters first day of month'
	)
;
