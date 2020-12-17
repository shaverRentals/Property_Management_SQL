CREATE TABLE [dbo].[Bank_Balance]
(
	[Bank_Balance_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Balance_Date] DATE NULL, 
    [Balance_Amount] MONEY NULL, 
    [Balance_Year_Month] INT NULL
)
