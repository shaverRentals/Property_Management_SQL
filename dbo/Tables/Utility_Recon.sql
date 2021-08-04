CREATE TABLE [dbo].[Utility_Recon]
	(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Transaction_Distribution_ID] [int],
	[Transaction_ID] [int] NOT NULL,
	[Lease_ID] [int] NULL,
	[Lease_Begin_Date] [date] NULL,
	[Lease_End_Date] [date] NULL,
	[Transaction_Category_ID] [int] NULL,
	[Transaction_Distribution_Type_ID] [int] NULL,
	[Property_ID] [int] NULL,
	[Property_Unit_ID] [int] NULL,
	[Transaction_Amount] [money] NULL,
	[Transaction_Distributed_Amount] [money] NULL,
	[Transaction_Date] [date] NULL,
	[Service_Begin_Date] [date] NULL,
	[Service_End_Date] [date] NULL,
	[Transaction_Distribution_Payment_Month] [int] NULL,
	[Transaction_Distribution_Year] [int] NULL,
	[Transaction_Distribution_Service_Begin_Month] [int] NULL,
	[Transaction_Distribution_Service_End_Month] [int] NULL,
	[Utility_Payment] [money] NULL,
	[Days_Service_Period] [int] NULL,
	[Payment_Days_Service_Period] [int] NULL,
	[Partial_Service_Period] [int] NULL,
	[Utility_Payment_Per_Day] [money] NULL,
	[Adjusted_Utility_Payment] [money] NULL,
	[Recon_Flag] [tinyint] NULL,
	[Date_Refreshed] [datetime] NULL, 
    CONSTRAINT [PK_Utility_Recon] PRIMARY KEY ([ID])
	)
	;



