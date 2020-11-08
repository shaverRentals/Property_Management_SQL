CREATE TABLE [dbo].[Transactions]
(
[Transaction_ID] INT NOT NULL PRIMARY KEY IDENTITY,
[Property_Unit_ID] INT NULL,
[Person_ID] INT NULL,
[Transaction_Type_ID] INT NULL, 
[Transaction_Category_ID] INT NOT NULL,
[Transaction_Amount] MONEY NULL, 
[Transaction_Date] DATE NULL, 
[Transaction_File_Path] VARCHAR(MAX) NULL, 
[Transaction_Notes] VARCHAR(MAX) NULL, 
[From_Security_Deposit] BIT NULL, 
    CONSTRAINT [FK_Transactions_ToTransactionCategory] FOREIGN KEY ([Transaction_Category_ID]) REFERENCES [Transaction_Category]([Transaction_Category_ID]) 
)
