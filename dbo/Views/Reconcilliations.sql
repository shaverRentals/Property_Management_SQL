CREATE VIEW [dbo].[Reconcilliations]
	AS 

	
select 
TD.Lease_ID
,TD.Lease_Begin_Date
,TD.Lease_End_Date
,L.Lease_Description
,TD.Utility_Payment
,TD.Service_Begin_Date
,TD.Service_End_Date
,Days_Service_Period
,Payment_Days_Service_Period
,Partial_Service_Period
,TD.Transaction_Distribution_Service_End_Month
,TD.Transaction_Category_ID
,TC.Transaction_Category
,Transaction_Distributed_Amount
,Utility_Payment_Per_Day
,Adjusted_Utility_Payment
,Transaction_Date
FROM Transaction_Distributions TD
INNER JOIN Leases L ON
L.Lease_ID = TD.Lease_ID
INNER JOIN Transaction_Category TC ON
TC.Transaction_Category_ID = TD.Transaction_Category_ID
where Recon_Flag = 1
--order by Transaction_Distribution_Service_Begin_Month
;