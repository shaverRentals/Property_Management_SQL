CREATE PROCEDURE [dbo].[Insert_Image_Person]

	@Path varchar(2000)
	,@Current_ID VARCHAR(50)
AS

DECLARE @New_Pic Varchar(8000)
SET @New_Pic = 'UPDATE People SET Person_Image = BulkColumn FROM OPENROWSET(BULK ' + @Path + ', SINGLE_BLOB) image where Person_ID = '  + @Current_ID 
;
EXEC(@New_Pic)
;