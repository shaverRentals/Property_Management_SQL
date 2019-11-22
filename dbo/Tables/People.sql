CREATE TABLE [dbo].[People]
(
	[Person_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Person_Name_Last] VARCHAR(50) NULL, 
    [Person_Name_First] VARCHAR(50) NULL, 
    [Email_Address] VARCHAR(50) NULL, 
    [Phone_Number] VARCHAR(24) NULL, 
    [Person_Address] VARCHAR(244) NULL, 
    [Person_Name_Combined] VARCHAR(124) NULL, 
    [Person_Image] IMAGE NULL, 
    [Person_Status_ID] INT NULL, 
    CONSTRAINT [FK_People_ToTable] FOREIGN KEY ([Person_Status_ID]) REFERENCES [Person_Status]([Person_Status_ID])
)
