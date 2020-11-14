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
    [Transaction_Distributed_Amount] MONEY NULL, 
    [Transaction_Date] DATE NULL,
    [Service_Begin_Date] DATE NULL, 
    [Service_End_Date] DATE NULL, 
    [Transaction_Distribution_Payment_Month] INT NULL, 
    [Transaction_Distribution_Service_Begin_Month] INT NULL,
    [Transaction_Distribution_Service_End_Month] INT NULL
)
