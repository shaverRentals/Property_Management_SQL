CREATE VIEW [dbo].[Reconcilliations]
	AS 

	
select Lease_ID
		,Lease_Description
	   , Transaction_Distribution_Payment_Month
	   ,Lease_Begin_Date
	   ,Lease_End_Date
	   ,SUM(Utilities_Paid) Utility_Rent
	   ,SUM(City) City
	   ,SUM(Gas) Gas
	   ,SUM(Power) Power
	   ,SUM(Total_Utilites) Total_Utilities
	   ,SUM(Difference) Diff
	   from Recon_Pivot
	   GROUP BY
	  Lease_ID
		,Lease_Description
	   , Transaction_Distribution_Payment_Month
	    ,Lease_Begin_Date
	   ,Lease_End_Date
	   
	   ;