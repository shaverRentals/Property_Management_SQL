CREATE TABLE [dbo].[Transaction_Distributions]
(
	[Transaction_Distribution_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Transaction_ID] INT NOT NULL, 
    [Lease_ID] INT NULL, 
    [Transaction_Category_ID] INT NULL, 
    [Transaction_Distribution_Type_ID] INT NULL, 
    [Property_ID] INT NULL,
    [Property_Unit_ID] INT NULL,
    [Transaction_Amount] MONEY NULL, 
    [Transaction_Distributed_Amount] MONEY NULL
)
