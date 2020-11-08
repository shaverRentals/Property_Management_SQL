CREATE TABLE [dbo].[Transactions]
(
[Transaction_ID] INT NOT NULL PRIMARY KEY IDENTITY,
[Property_Unit_ID] INT NULL,
[Person_ID] INT NULL,
[Transaction_Type_ID] INT NULL, 
[Transaction_Category_ID] INT NOT NULL,
[Transaction_Amount] MONEY NULL, 
[Transaction_Date] DATE NULL, 
    CONSTRAINT [FK_Transactions_ToTransition_Type] FOREIGN KEY ([Transaction_Type_ID]) REFERENCES [Transaction_Type]([Transaction_Type_ID])

)
