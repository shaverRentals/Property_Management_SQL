CREATE TABLE [dbo].[Transaction_Category]
(
	[Transaction_Category_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Transaction_Type_ID] INT NULL, 

    [Transaction_Category] VARCHAR(50) NULL, 
    CONSTRAINT [FK_Transactions_ToTransition_Type] FOREIGN KEY ([Transaction_Type_ID]) REFERENCES [Transaction_Type]([Transaction_Type_ID])

)
