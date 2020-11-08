UPDATE Leases
SET Lease_Description = P.Property_Description + ' From ' + TRY_CONVERT(VARCHAR(50),L.Lease_Begin_Date) + ' To ' + TRY_CONVERT(VARCHAR(50),L.Lease_End_Date)
FROM Leases L 
INNER JOIN Property_Units P ON
L.Property_Unit_ID = P.Property_Unit_ID