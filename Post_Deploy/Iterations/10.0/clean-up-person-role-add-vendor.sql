DELETE FROM Person_Role_Type
WHERE Person_Role_Type <> 'Tennant'
;
INSERT INTO Person_Role_Type
(
 Person_Role_Type
)
VALUES
(
 'Vendor'
)
;