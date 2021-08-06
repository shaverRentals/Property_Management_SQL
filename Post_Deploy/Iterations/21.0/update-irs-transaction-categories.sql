
UPDATE Transaction_Category
SET Transaction_Category_IRS = 'Management'
where Transaction_Category_ID = 8
;
UPDATE Transaction_Category
SET Transaction_Category_IRS = 'Utilities'
where Transaction_Category_ID IN(10,11,12,15)
;
UPDATE Transaction_Category
SET Transaction_Category_IRS = 'Rent'
where Transaction_Category_ID IN(18,20,16)
;
UPDATE Transaction_Category
SET Transaction_Category_IRS = Transaction_Category
where Transaction_Category_IRS IS NULL
;
UPDATE Transaction_Category
SET Transaction_Category_IRS = 'Other'
where Transaction_Category_ID IN(14)
;