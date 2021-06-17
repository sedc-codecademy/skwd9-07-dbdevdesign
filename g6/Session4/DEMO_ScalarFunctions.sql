--Declare scalar function (fn_FormatProductName) for retrieving the 
--Product description for specific ProductId in the following format:

--Second and Third character from the Code
---
--Last three characters from the Name
---
--Product Price

GO

CREATE FUNCTION fn_FormatProductName(@ProductId INT)
RETURNS NVARCHAR(100)
AS
BEGIN

	DECLARE @output NVARCHAR(100)

	SELECT @output = SUBSTRING(Code, 2, 2) + '-' + RIGHT(Name, 3) + '-' + CAST(Price AS nvarchar(30))
	FROM Product
	WHERE Id = @ProductId

	RETURN @output

END



select *,  dbo.fn_FormatProductName(Id) as new_description
from Product

select dbo.fn_FormatProductName(51)


update p
set p.Description = dbo.fn_FormatProductName(p.ID)
--select *
from Product p
where id = 51