CREATE TABLE [dbo].[Transactions]
(
[Transaction_ID] INT NOT NULL PRIMARY KEY IDENTITY,
[Property_ID] INT NULL,
[Property_Unit_ID] INT NULL,
[Lease_ID] INT NULL,
[Person_ID] INT NULL,
[Transaction_Category_ID] INT NOT NULL,
[Transaction_Amount] MONEY NULL, 
[Transaction_Date] DATE NULL DEFAULT GetDate(), 
[Transaction_File_Path] VARCHAR(MAX) NULL, 
[Transaction_Notes] VARCHAR(MAX) NULL, 
[From_Security_Deposit] BIT NULL, 
[Service_Begin_Date] DATE NULL DEFAULT GetDate(), 
[Service_End_Date] DATE NULL DEFAULT GetDate(), 
    CONSTRAINT [FK_Transactions_ToTransactionCategory] FOREIGN KEY ([Transaction_Category_ID]) REFERENCES [Transaction_Category]([Transaction_Category_ID]) 
)
