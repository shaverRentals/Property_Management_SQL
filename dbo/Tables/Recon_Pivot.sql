CREATE TABLE [dbo].[Recon_Pivot]
(
	[ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Lease_ID] INT NULL,
    [Lease_Begin_Date] DATE NULL, 
    [Lease_End_Date] DATE NULL, 
    [Lease_Description] VARCHAR(244) NULL, 
    [Transaction_Date] DATE NULL , 
    [Transaction_Distribution_Payment_Month] INT NULL, 
    [Utilities_Paid] MONEY NULL, 
    [City] MONEY NULL, 
    [Power] MONEY NULL, 
    [Gas] MONEY NULL, 
    [Total_Utilites] Money NULL,
    [Difference] MONEY NULL
)
