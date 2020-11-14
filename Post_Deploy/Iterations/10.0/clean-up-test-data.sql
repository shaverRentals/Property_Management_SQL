
UPDATE Properties
SET Property_Owner_ID = 2
where Is_Active = 1
;
UPDATE Properties
set Property_Primary_Image = NULL
;
UPDATE Property_Units
SET Property_Description = REPLACE(property_description,'&','and')
;