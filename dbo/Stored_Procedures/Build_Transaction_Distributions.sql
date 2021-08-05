CREATE PROCEDURE [dbo].[Build_Transaction_Distributions]


AS

	TRUNCATE TABLE Transaction_Distributions
	;

	CREATE TABLE #Transaction_Distributions
	(
		[Transaction_Distribution_ID] INT NOT NULL PRIMARY KEY IDENTITY, 
		[Transaction_ID] INT NOT NULL, 
		[Property_ID] INT NULL,
		[Property_Unit_ID] INT NULL,
		[Lease_ID] INT NULL, 
		[Transaction_Category_ID] INT NULL, 
		[Transaction_Category] VARCHAR(50) NULL, 
		[Transaction_Distribution_Type_ID] INT NULL, 
		[Transaction_Distribution_Type] VARCHAR(50) NULL,
		[Transaction_Type] Varchar(50) NULL,
		[Transaction_Amount] MONEY NULL, 
		[Transaction_Distributed_Amount] MONEY NULL,
		[Transaction_Date] DATE NULL,
		[Service_Begin_Date] DATE NULL, 
		[Service_End_Date] DATE NULL,
	)

	INSERT INTO #Transaction_Distributions
		(
		 Transaction_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Category_ID
		 ,Transaction_Category
		 ,Transaction_Distribution_Type_ID
		 ,Transaction_Distribution_Type
		 ,Transaction_Type
		 ,Transaction_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		)
	SELECT
		 Transaction_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,T.Transaction_Category_ID
		 ,TC.Transaction_Category
		 ,T.Transaction_Distribution_ID
		 ,TDT.Transaction_Distribution_Type
		 ,TT.Transaction_Type
		 ,T.Transaction_Amount
		 ,T.Transaction_Date
		 ,T.Service_Begin_Date
		 ,T.Service_End_Date
	FROM Transactions T
	INNER JOIN Transaction_Category TC ON
	TC.Transaction_Category_ID = T.Transaction_Category_ID
	INNER JOIN Transaction_Distribution_Type TDT ON
	TDT.Transaction_Distribution_ID = T.Transaction_Distribution_ID
	INNER JOIN Transaction_Type TT ON
	TT.Transaction_Type_ID = TC.Transaction_Type_ID
	;

	--Property/Unit Records: single transaction assigned to either a property or a single unit within a property
	INSERT INTO Transaction_Distributions
		(
		 Transaction_ID
		 ,Transaction_Category_ID
		 ,Transaction_Distribution_Type_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Amount
		 ,Transaction_Distributed_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
	)
	SELECT
		Transaction_ID
		,Transaction_Category_ID
		,Transaction_Distribution_ID
		,Property_ID
		,Property_Unit_ID
		,Transaction_Amount
		,Transaction_Amount
		,Transaction_Date
		,Service_Begin_Date
		,Service_End_Date
	FROM Transactions
	WHERE Transaction_Distribution_ID = 6
	;

	--Divided Units

	--Gas
	INSERT INTO Transaction_Distributions
		(
		 Transaction_ID
		 ,Transaction_Category_ID
		 ,Transaction_Distribution_Type_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Amount
		 ,Transaction_Distributed_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		)
		SELECT distinct
		 TD.Transaction_ID
		 ,TD.Transaction_Category_ID
		 ,TD.Transaction_Distribution_Type_ID
		 ,P.Property_ID
		 ,PU.Property_Unit_ID
		 ,TD.Transaction_Amount
		 ,(Transaction_Amount * Share_Gas) 
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		FROM #Transaction_Distributions TD
		INNER JOIN Properties P ON
		P.Property_ID = TD.Property_ID
		INNER JOIN Property_Units PU ON
		PU.Property_ID = P.Property_ID
		WHERE TD.Transaction_Distribution_Type_ID = 7
		AND Transaction_Category_ID = 12
		;
	--City
	INSERT INTO Transaction_Distributions
		(
		 Transaction_ID
		 ,Transaction_Category_ID
		 ,Transaction_Distribution_Type_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Amount
		 ,Transaction_Distributed_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		)
		SELECT distinct
		 TD.Transaction_ID
		 ,TD.Transaction_Category_ID
		 ,TD.Transaction_Distribution_Type_ID
		 ,P.Property_ID
		 ,PU.Property_Unit_ID
		 ,TD.Transaction_Amount
		 ,(Transaction_Amount * Share_City) 
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		FROM #Transaction_Distributions TD
		INNER JOIN Properties P ON
		P.Property_ID = TD.Property_ID
		INNER JOIN Property_Units PU ON
		PU.Property_ID = P.Property_ID
		WHERE TD.Transaction_Distribution_Type_ID = 7
		AND Transaction_Category_ID = 10
		;
	--Electric
	INSERT INTO Transaction_Distributions
		(
		 Transaction_ID
		 ,Transaction_Category_ID
		 ,Transaction_Distribution_Type_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Amount
		 ,Transaction_Distributed_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		)
		SELECT distinct
		 TD.Transaction_ID
		 ,TD.Transaction_Category_ID
		 ,TD.Transaction_Distribution_Type_ID
		 ,P.Property_ID
		 ,PU.Property_Unit_ID
		 ,TD.Transaction_Amount
		 ,(Transaction_Amount * Share_Electricity) 
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		FROM #Transaction_Distributions TD
		INNER JOIN Properties P ON
		P.Property_ID = TD.Property_ID
		INNER JOIN Property_Units PU ON
		PU.Property_ID = P.Property_ID
		WHERE TD.Transaction_Distribution_Type_ID = 7
		AND Transaction_Category_ID = 11
		;
	--General
	INSERT INTO Transaction_Distributions
		(
		 Transaction_ID
		 ,Transaction_Category_ID
		 ,Transaction_Distribution_Type_ID
		 ,Property_ID
		 ,Property_Unit_ID
		 ,Transaction_Amount
		 ,Transaction_Distributed_Amount
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		)
		SELECT distinct
		 TD.Transaction_ID
		 ,TD.Transaction_Category_ID
		 ,TD.Transaction_Distribution_Type_ID
		 ,P.Property_ID
		 ,PU.Property_Unit_ID
		 ,TD.Transaction_Amount
		 ,(Transaction_Amount * Transaction_Distribution_Proportion) 
		 ,Transaction_Date
		 ,Service_Begin_Date
		 ,Service_End_Date
		FROM #Transaction_Distributions TD
		INNER JOIN Properties P ON
		P.Property_ID = TD.Property_ID
		INNER JOIN Property_Units PU ON
		PU.Property_ID = P.Property_ID
		WHERE TD.Transaction_Distribution_Type_ID = 7
		AND Transaction_Category_ID NOT IN(10,11,12)
		;


	--Update property unit ID for single unit/property transactions
	UPDATE Transaction_Distributions
	SET Property_Unit_ID = PU.Property_Unit_ID
	FROM Transaction_Distributions TD
	INNER JOIN Property_Units PU ON
	PU.Property_ID = TD.Property_ID
	WHERE Transaction_Distribution_Type_ID = 6
	and TD.Property_unit_ID IS NULL
	OR TD.Property_Unit_ID = 0
	;

	--All properties
	DECLARE @Number_Properties INT = (SELECT COUNT (Property_ID) FROM Properties where Is_Active = 1)
	;
	INSERT INTO Transaction_Distributions
	(
		Transaction_ID
		,Transaction_Category_ID
		,Transaction_Distribution_Type_ID
		,Property_ID
		,Property_Unit_ID
		,Transaction_Amount
		,Transaction_Distributed_Amount
		,Transaction_Date
		,Service_Begin_Date
		,Service_End_Date
		)
	SELECT DISTINCT
	Transaction_ID 
	,Transaction_Category_ID
	,Transaction_Distribution_ID
	,P.Property_ID
	,NULL
	,Transaction_Amount
	,(Transaction_Amount/@Number_Properties) 
	 ,Transaction_Date
	,Service_Begin_Date
	,Service_End_Date
	FROM Transactions 
	CROSS JOIN Properties P 
	where Transaction_Distribution_ID = 8
	and Is_Active = 1
	;

	UPDATE Transaction_Distributions
	SET Transaction_Distribution_Payment_Month = LEFT(CONVERT(varchar(8),Transaction_Date,112),6)
	;
	UPDATE Transaction_Distributions
	SET [Transaction_Distribution_Service_Begin_Month] = LEFT(CONVERT(varchar(8),Service_Begin_Date,112),6)
	;
	UPDATE Transaction_Distributions
	SET [Transaction_Distribution_Service_End_Month] = LEFT(CONVERT(varchar(8),Service_End_Date,112),6)
	;
	UPDATE Transaction_Distributions
	SET Transaction_Distribution_Year = YEAR(Transaction_Date)
	;
	UPDATE Transaction_Distributions
	SET Date_Refreshed = GETDATE()
	;

	----Recons
	--CREATE TABLE [dbo].[#Transaction_Distributions_Recon]
	--(
	--[ID] [int] IDENTITY(1,1) NOT NULL,
	--[Transaction_Distribution_ID] [int],
	--[Transaction_ID] [int] NOT NULL,
	--[Lease_ID] [int] NULL,
	--[Lease_Begin_Date] [date] NULL,
	--[Lease_End_Date] [date] NULL,
	--[Transaction_Category_ID] [int] NULL,
	--[Transaction_Distribution_Type_ID] [int] NULL,
	--[Property_ID] [int] NULL,
	--[Property_Unit_ID] [int] NULL,
	--[Transaction_Amount] [money] NULL,
	--[Transaction_Distributed_Amount] [money] NULL,
	--[Transaction_Date] [date] NULL,
	--[Service_Begin_Date] [date] NULL,
	--[Service_End_Date] [date] NULL,
	--[Transaction_Distribution_Payment_Month] [int] NULL,
	--[Transaction_Distribution_Year] [int] NULL,
	--[Transaction_Distribution_Service_Begin_Month] [int] NULL,
	--[Transaction_Distribution_Service_End_Month] [int] NULL,
	--[Utility_Payment] [money] NULL,
	--[Days_Service_Period] [int] NULL,
	--[Payment_Days_Service_Period] [int] NULL,
	--[Partial_Service_Period] [int] NULL,
	--[Utility_Payment_Per_Day] [money] NULL,
	--[Adjusted_Utility_Payment] [money] NULL,
	--[Recon_Flag] [tinyint] NULL,
	--[Date_Refreshed] [datetime] NULL
	--)
	--;
	TRUNCATE TABLE Utility_Recon
	;
	INSERT INTO Utility_Recon
	(
	[Transaction_Distribution_ID]
	,[Transaction_ID] 
	,[Lease_ID] 
	,Lease_Description
	,[Lease_Begin_Date] 
	,[Lease_End_Date] 
	,[Transaction_Category_ID] 
	,Transaction_Category
	,[Transaction_Distribution_Type_ID] 
	,[Property_ID] 
	,[Property_Unit_ID] 
	,[Transaction_Amount] 
	,[Transaction_Distributed_Amount]
	,[Transaction_Date] 
	,[Service_Begin_Date] 
	,[Service_End_Date] 
	,[Transaction_Distribution_Payment_Month] 
	,[Transaction_Distribution_Year] 
	,[Transaction_Distribution_Service_Begin_Month] 
	,[Transaction_Distribution_Service_End_Month] 
	,[Utility_Payment] 
	,[Days_Service_Period] 
	--,[Payment_Days_Service_Period] 
	--,[Partial_Service_Period] 
	--,[Utility_Payment_Per_Day] 
	--,[Adjusted_Utility_Payment] 
	--,[Recon_Flag] 
	--,[Date_Refreshed] 
	)
	SELECT
	[Transaction_Distribution_ID]
	,[Transaction_ID] 
	,L.[Lease_ID] 
	,L.Lease_Description + ' -- ' + TRY_CONVERT(VARCHAR(50), L.Lease_ID)
	,L.[Lease_Begin_Date] 
	,L.[Lease_End_Date] 
	,TD.[Transaction_Category_ID] 
	,Case when TC.Transaction_Category_ID IN(17,20) THEN 'Tennant Paid' ELSE TC.Transaction_Category END
	,[Transaction_Distribution_Type_ID] 
	,[Property_ID] 
	,L.[Property_Unit_ID] 
	,[Transaction_Amount] 
	,[Transaction_Distributed_Amount]
	,[Transaction_Date] 
	,[Service_Begin_Date] 
	,[Service_End_Date] 
	,[Transaction_Distribution_Payment_Month] 
	,[Transaction_Distribution_Year] 
	,[Transaction_Distribution_Service_Begin_Month] 
	,[Transaction_Distribution_Service_End_Month] 
	,L.Utilitity_Payment
	,DATEDIFF(DAY,Service_Begin_Date,Service_End_Date) + 1
	--,[Payment_Days_Service_Period] 
	--,[Partial_Service_Period] 
	--,[Utility_Payment_Per_Day] 
	--,[Adjusted_Utility_Payment] 
	FROM Transaction_Distributions TD
	INNER JOIN Leases L ON L.Property_Unit_ID = TD.Property_Unit_ID
	INNER JOIN Transaction_Category TC ON
	TC.Transaction_Category_ID = TD.Transaction_Category_ID
	WHERE Service_Begin_Date < = L.Lease_End_Date
	AND Service_End_Date > = L.Lease_Begin_Date
	AND TD.Transaction_Category_ID IN(12,10,11,17,20)
	order by 
	Lease_Description
	,Lease_Begin_Date
	,Transaction_Category
	,Transaction_Date
	
	;
	UPDATE Utility_Recon
	SET Partial_Service_Period = 1
	WHERE Lease_Begin_Date BETWEEN Service_Begin_Date AND DATEADD(D,-1,Service_End_Date)
	;
	UPDATE Utility_Recon
	SET Partial_Service_Period = 2
	WHERE Lease_End_Date BETWEEN Service_Begin_Date AND Service_End_Date
	;
	UPDATE Utility_Recon
	SET Payment_Days_Service_Period = DATEDIFF(DAY,Lease_Begin_Date,Service_End_Date) + 1
	WHERE Partial_Service_Period = 1
	;
	UPDATE Utility_Recon
	SET Payment_Days_Service_Period = DATEDIFF(DAY,Service_Begin_date,Lease_End_Date) + 1
	WHERE Partial_Service_Period = 2
	;
	UPDATE Utility_Recon
	SET Utility_Payment_Per_Day = (Transaction_Distributed_Amount/Days_Service_Period)
	WHERE Partial_Service_Period < = 2
	AND Transaction_Category_ID NOT IN (17,20)
	;
	UPDATE Utility_Recon
	SET Adjusted_Utility_Payment = (Utility_Payment_Per_Day * Payment_Days_Service_Period)
	WHERE Partial_Service_Period < = 2
	AND Transaction_Category_ID NOT IN (17,20)
	;
	UPDATE Utility_Recon
	SET Adjusted_Utility_Payment = Utility_Payment
	WHERE Transaction_Category_ID = 17
	;

	WITH Partial_Rent_Month AS
	(
	SELECT
	 L.Lease_ID
	 ,Transaction_Distribution_ID
	 ,L.Rent_Payment
	 ,L.Utilitity_Payment
	 ,TD.Transaction_Distributed_Amount
	,(utility_payment/(Rent_Payment + Utilitity_Payment)) * TD.Transaction_Distributed_Amount  as P
	FROM Utility_Recon TD
	INNER JOIN Leases L ON
	L.Lease_ID = TD.Lease_ID
	where TD.Transaction_Category_ID = 20
	)
	UPDATE Utility_Recon
	SET Adjusted_Utility_Payment =PRM.P
	FROM Utility_Recon TD 
	INNER JOIN Partial_Rent_Month PRM ON
	TD.Transaction_Distribution_ID = PRM.Transaction_Distribution_ID
	;
	UPDATE Utility_Recon
	set Adjusted_Utility_Payment = CASE WHEN Transaction_Category_ID = 17 AND Utility_Payment IS NOT NULL THEN Utility_Payment ELSE Transaction_Distributed_Amount END
	WHERE Partial_Service_Period IS NULL
	and Transaction_Category_ID <> 20
	;
	UPDATE utility_Recon
	SET Adjusted_Utility_Payment = (Adjusted_Utility_Payment * -1)
	WHERE Transaction_Category_ID IN(10,11,12)
	UPDATE Utility_Recon
	SET Date_Refreshed = GETDATE()
	;
	
	
	TRUNCATE TABLE Recon_Pivot
	;
	INSERT INTO Recon_Pivot
	(
	 [Lease_ID]
	 ,[Lease_Description]
	 ,Lease_Begin_Date
	 ,Lease_End_Date
	 ,[Transaction_Date]
	 ,Transaction_Distribution_Payment_Month
	 ,[Utilities_Paid]
	 ,[Rent_Partial]
	 ,[City]
	 ,[Power]
	 ,[Gas]
	)
	SELECT DISTINCT
	 Lease_ID
	 ,Lease_Description
	 ,Lease_Begin_Date
	 ,Lease_End_Date
	 ,Transaction_Date 
	 ,Transaction_Distribution_Payment_Month
	 ,[Rent]
	 ,[Rent Reduced/Partial]
	 ,[Utilities City]
	 ,[Utilities Power]
	 ,[Utilities Gas]
	FROM 
	(
	SELECT 
		  TD.Lease_Description
		  ,TD.Lease_ID
		  ,Transaction_Date
		  ,Transaction_Distribution_Payment_Month
		  ,Adjusted_Utility_Payment
		  ,TD.Transaction_Category_ID
		  ,TC.Transaction_Category
		  ,L.Lease_Begin_Date
		  ,L.Lease_End_Date
		  FROM Utility_Recon
		  TD INNER JOIN
		  Leases L 
		  ON TD.Lease_ID = L.Lease_ID
		  INNER JOIN Transaction_Category TC ON
		  TC.Transaction_Category_ID = TD.Transaction_Category_ID
		 ) a
	PIVOT( MAX(Adjusted_Utility_Payment)
	FOR Transaction_Category IN([Rent],[Rent Reduced/Partial],[Utilities City],[Utilities Power],[Utilities Gas])
	) AS P 
	
	UPDATE Recon_Pivot set City = (city * - 1) 
	;
	UPDATE Recon_Pivot set City = (power * - 1)
	;
	UPDATE Recon_Pivot set City = (gas * - 1) 
	;
	UPDATE Recon_Pivot
	SET City = 0 where city IS NULL
	;
	UPDATE Recon_Pivot
	SET [Power] = 0 where [Power]IS NULL
	;
	UPDATE Recon_Pivot
	SET gas = 0 where gas IS NULL
	;
	UPDATE Recon_Pivot
	SET Utilities_Paid  = 0
	WHERE Utilities_Paid IS NULL
	;
	UPDATE Recon_Pivot
	SET Total_Utilites  = [POWER] + Gas + City
	;
	UPDATE Recon_Pivot
	SET Utilities_Paid = Rent_Partial
	where Rent_Partial is not null;
	;
	UPDATE Recon_Pivot
	SET Difference = (Utilities_Paid -Total_Utilites)
	;
	
	DROP TABLE #Transaction_Distributions
	;
