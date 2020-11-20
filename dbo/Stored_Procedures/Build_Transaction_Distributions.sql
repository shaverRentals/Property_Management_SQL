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
SET [Transaction_Distribution_Service_End_Month] = LEFT(CONVERT(varchar(8),Service_Begin_Date,112),6)
;

--Reconcilliations

--Get Lease ID
WITH Lease AS
(
 SELECT DISTINCT
  TD.Transaction_Distribution_ID
  ,L.Lease_ID
  ,L.Lease_Begin_Date
  ,L.Lease_End_Date
  ,L.Utilitity_Payment
 FROM Transaction_Distributions TD
 INNER JOIN Transactions T ON
 T.Transaction_ID = TD.Transaction_ID
 INNER JOIN Leases L ON
 L.Property_Unit_ID = TD.Property_Unit_ID
 where L.Lease_End_Date >= T.Service_Begin_Date
 AND L.Lease_Begin_Date < = T.Service_End_Date
 AND TD.Transaction_Category_ID IN(12,10,11,17)
)
UPDATE Transaction_Distributions
SET Lease_ID = L.Lease_ID
	,Lease_Begin_Date = L.Lease_Begin_Date
	,Lease_End_Date = L.Lease_End_Date
	,Recon_Flag = 1
	,Utility_Payment = L.Utilitity_Payment
	,Days_Service_Period = DATEDIFF(DAY,Service_Begin_Date,Service_End_Date)
FROM Transaction_Distributions TD
INNER JOIN Lease L ON
L.Transaction_Distribution_ID = TD.Transaction_Distribution_ID
;

UPDATE Transaction_Distributions
SET Partial_Service_Period = 1
WHERE Lease_Begin_Date BETWEEN Service_Begin_Date AND Service_End_Date
;
UPDATE Transaction_Distributions
SET Partial_Service_Period = 2
WHERE Lease_End_Date BETWEEN Service_Begin_Date AND Service_End_Date
;
UPDATE Transaction_Distributions
SET Payment_Days_Service_Period = DATEDIFF(DAY,Lease_Begin_Date,SErvice_End_Date)
WHERE Partial_Service_Period = 1
;
UPDATE Transaction_Distributions
SET Payment_Days_Service_Period = DATEDIFF(DAY,Service_Begin_date,Lease_End_Date)
WHERE Partial_Service_Period = 2
;

UPDATE Transaction_Distributions
SET Utility_Payment_Per_Day = (Transaction_Distributed_Amount/Days_Service_Period)
WHERE Partial_Service_Period <=2
AND Transaction_Category_ID <> 17
;
UPDATE Transaction_Distributions
SET Adjusted_Utility_Payment = (Utility_Payment_Per_Day * Payment_Days_Service_Period)
WHERE Partial_Service_Period <=2
AND Transaction_Category_ID <> 17
;
UPDATE Transaction_Distributions
SET Adjusted_Utility_Payment = Utility_Payment
WHERE Transaction_Category_ID = 17
;

update Transaction_Distributions
set Adjusted_Utility_Payment = CASE WHEN Transaction_Category_ID = 17 AND Utility_Payment IS NOT NULL THEN Utility_Payment ELSE Transaction_Distributed_Amount END
WHERE Recon_Flag = 1
and Partial_Service_Period IS NULL
;
Update Transaction_Distributions
SET Recon_Flag = 0
where Recon_Flag IS NULL
;

--Pivot recon data
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
 ,[Utilities City]
 ,[Utilities Power]
 ,[Utilities Gas]

FROM (SELECT 
	  Lease_Description
	  ,TD.Lease_ID
	  ,Transaction_Date
	  ,Transaction_Distribution_Payment_Month
	  ,Adjusted_Utility_Payment
	  ,TD.Transaction_Category_ID
	  ,TC.Transaction_Category
	  ,L.Lease_Begin_Date
	  ,L.Lease_End_Date
	  FROM Transaction_Distributions
	  TD INNER JOIN
	  Leases L 
	  ON TD.Lease_ID = L.Lease_ID
	  INNER JOIN Transaction_Category TC ON
	  TC.Transaction_Category_ID = TD.Transaction_Category_ID
	  WHERE Recon_Flag = 1 and L.Lease_ID = 47) a
PIVOT( MAX(Adjusted_Utility_Payment)
FOR Transaction_Category IN([Rent],[Utilities City],[Utilities Power],[Utilities Gas])
) AS P 
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
SET Difference = (Utilities_Paid -Total_Utilites)
;
