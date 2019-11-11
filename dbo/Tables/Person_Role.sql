CREATE TABLE [dbo].[Person_Role]
(
	[Person_Role_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Person_ID] INT NOT NULL, 
    [Person_Role] VARCHAR(244) NULL, 
    CONSTRAINT [FK_Person_Role_ToTable] FOREIGN KEY ([Person_ID]) REFERENCES [People]([Person_ID])
)
