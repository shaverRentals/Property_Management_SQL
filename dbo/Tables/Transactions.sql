﻿CREATE TABLE [dbo].[Transactions]
(
[Transaction_ID] INT NOT NULL PRIMARY KEY IDENTITY,
[Property_ID] INT NULL,
[Property_Unit_ID] INT NULL,
[Person_ID] INT NULL,
[Transaction_Category_ID] INT NOT NULL,
[Transaction_Distribution_ID] INT NOT NULL,
[Transaction_Amount] MONEY NULL, 
[Transaction_Date] DATE NULL DEFAULT GetDate(), 
[Transaction_File_Path] VARCHAR(MAX) NULL, 
[Transaction_Notes] VARCHAR(MAX) NULL, 
[From_Security_Deposit] BIT NULL, 
[Service_Begin_Date] DATE NULL , 
[Service_End_Date] DATE NULL , 
[Historical_Record] TINYINT NULL DEFAULT 0, 
    CONSTRAINT [FK_Transactions_ToTransactionCategory] FOREIGN KEY ([Transaction_Category_ID]) REFERENCES [Transaction_Category]([Transaction_Category_ID]) 
    ,
    CONSTRAINT [FK_Transactions_ToTransactionDistributionType] FOREIGN KEY ([Transaction_Distribution_ID]) REFERENCES [Transaction_Distribution_Type]([Transaction_Distribution_ID]) 
)
