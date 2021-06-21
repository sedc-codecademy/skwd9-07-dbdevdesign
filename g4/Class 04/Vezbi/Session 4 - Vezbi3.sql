

select *, dbo.fn_OrderQuantity(ID) as OrderQuantity 
from dbo.[Order]

CREATE OR ALTER FUNCTION dbo.fn_OrderQuantity (@OrderId int)
RETURNS int
AS 
BEGIN
	DECLARE @Output int
	select @Output = sum(Quantity) from dbo.OrderDetails 
	WHERE OrderId = @OrderId
RETURN @Output

END
GO




