CREATE TABLE [dbo].[Lease_Members]
(
	[Lease_Member_ID] INT NOT NULL PRIMARY KEY IDENTITY,
	[Lease_ID] INT NOT NULL,
    [Person_ID] INT NOT NULL, 
    [Lease_Member_Begin_Date] DATE NULL, 
    [Lease_Member_End_Date] DATE NULL
	 CONSTRAINT [FK_Lease_Members_Leases] FOREIGN KEY ([Lease_ID]) REFERENCES [dbo].[leases] ([Lease_ID])
)
