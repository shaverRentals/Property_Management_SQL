CREATE TABLE [dbo].[Leases]
(
	[Lease_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
	[Property_Unit_ID] INT NOT NULL,
	[Lease_Begin_Date] DATE NULL, 
    [Lease_End_Date] DATE NULL, 
    [Rent_Payment] MONEY NULL, 
    [Security_Deposit] MONEY NULL, 
    [Utilitity_Payment] MONEY NULL, 
    [Lease_Status] VARCHAR(50) NULL, 
    [Lease_Path] VARCHAR(MAX) NULL, 
    [Lease_Description] VARCHAR(244) NULL, 
    CONSTRAINT [FK_Properties_Leases] FOREIGN KEY ([Property_Unit_ID]) REFERENCES [dbo].[Property_Units] ([Property_Unit_ID])
)
