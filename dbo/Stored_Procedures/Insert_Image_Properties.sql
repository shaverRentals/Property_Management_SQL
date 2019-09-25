CREATE PROCEDURE [dbo].[Insert_Image_Properties]
	@Path varchar(2000)
	,@Current_ID VARCHAR(50)
AS

DECLARE @New_Pic Varchar(8000)
SET @New_Pic = 'UPDATE Properties SET Property_Primary_Image = BulkColumn FROM OPENROWSET(BULK ' + @Path + ', SINGLE_BLOB) image where Property_ID = '  + @Current_ID 
EXEC(@New_Pic) 