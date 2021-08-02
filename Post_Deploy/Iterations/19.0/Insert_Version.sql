DELETE FROM tV
FROM dbo.Version tV
WHERE 
	tV.number_Version = '19.0' 
	

INSERT INTO dbo.Version (
	Number_Version
	,Date_Version
	,Desc_Version
	)
VALUES (
	'19.0'
	,GETDATE()
	,'Application new record first day of month save fix. Transaction distribution adjusted utility payment reduced rent'
	)
;
