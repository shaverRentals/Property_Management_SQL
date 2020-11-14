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
    [Transaction_Distributed_Amount] MONEY NULL
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
     ,Transaction_Amount
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
)
SELECT
	Transaction_ID
    ,Transaction_Category_ID
    ,Transaction_Distribution_ID
    ,Property_ID
    ,Property_Unit_ID
    ,Transaction_Amount
    ,Transaction_Amount
FROM Transactions
WHERE Transaction_Distribution_ID = 6
;

--Divided Units
INSERT INTO Transaction_Distributions
	(
	 Transaction_ID
     ,Transaction_Category_ID
     ,Transaction_Distribution_Type_ID
     ,Property_ID
     ,Property_Unit_ID
     ,Transaction_Amount
     ,Transaction_Distributed_Amount
	)
	SELECT distinct
	 TD.Transaction_ID
	 ,TD.Transaction_Category_ID
	 ,TD.Transaction_Distribution_Type_ID
	 ,P.Property_ID
	 ,PU.Property_Unit_ID
	 ,TD.Transaction_Amount
	 ,(Transaction_Amount * Transaction_Distribution_Proportion) 
	FROM #Transaction_Distributions TD
	INNER JOIN Properties P ON
	P.Property_ID = TD.Property_ID
	INNER JOIN Property_Units PU ON
	PU.Property_ID = P.Property_ID
	WHERE TD.Transaction_Distribution_Type_ID = 7
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
	 )
	SELECT DISTINCT
	Transaction_ID 
	,Transaction_Category_ID
	,Transaction_Distribution_ID
	,P.Property_ID
	,NULL
	,Transaction_Amount
	,(Transaction_Amount/@Number_Properties) 
	FROM Transactions 
	CROSS JOIN Properties P 
	where Transaction_Distribution_ID = 8
	and Is_Active =1
	;

--Get Lease ID
WITH Lease AS
(
 SELECT DISTINCT
  T.Transaction_ID
  ,TD.Transaction_Distribution_ID
  ,T.Transaction_Amount
  ,T.Service_Begin_Date
  ,T.Service_End_Date
  ,Transaction_Date
  ,L.Lease_ID
  ,L.Lease_Begin_Date
  ,L.Lease_End_Date
 FROM Transaction_Distributions TD
 INNER JOIN Transactions T ON
 T.Transaction_ID = TD.Transaction_ID
 INNER JOIN Leases L ON
 L.Property_Unit_ID = TD.Property_Unit_ID
 where Transaction_Date BETWEEN Lease_Begin_Date AND Lease_End_Date
 UNION
 SELECT DISTINCT
  T.Transaction_ID
  ,TD.Transaction_Distribution_ID
  ,T.Transaction_Amount
  ,T.Service_Begin_Date
  ,T.Service_End_Date
  ,Transaction_Date
  ,L.Lease_ID
  ,L.Lease_Begin_Date
  ,L.Lease_End_Date
 FROM Transaction_Distributions TD
 INNER JOIN Transactions T ON
 T.Transaction_ID = TD.Transaction_ID
 INNER JOIN Leases L ON
 L.Property_Unit_ID = TD.Property_Unit_ID
 where Lease_End_Date >= Service_Begin_Date
 AND Lease_Begin_Date < = Service_End_Date
)
UPDATE Transaction_Distributions
SET Lease_ID = L.Lease_ID
FROM Transaction_Distributions TD
INNER JOIN Lease L ON
L.Transaction_Distribution_ID = TD.Transaction_Distribution_ID
;

DROP TABLE #Transaction_Distributions
;

