CREATE TABLE [dbo].[Income_Tax_IRS]
(
	[ID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Transaction_Distribution_ID] INT,
    [Transaction_Date] DATE NULL, 
    [Property_Name] VARCHAR(50) NULL, 
    [Property_Owner_Name] VARCHAR(50) NULL,
    [Transaction_Category_IRS] VARCHAR(50) NULL, 
    [Transaction_Amount] MONEY NULL, 
    [Transaction_Payment_Year_IRS] INT,
)
