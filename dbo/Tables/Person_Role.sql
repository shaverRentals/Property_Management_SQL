CREATE TABLE [dbo].[Person_Role]
(
	[Person_Role_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Person_ID] INT NOT NULL, 
    [Person_Role_Type_ID] INT NULL, 
    CONSTRAINT [FK_Person_Role_Person] FOREIGN KEY ([Person_ID]) REFERENCES [People]([Person_ID]), 
    CONSTRAINT [FK_Person_Role_Type] FOREIGN KEY ([Person_Role_Type_ID]) REFERENCES [Person_Role_Type]([Person_Role_Type_ID])
)
