ALTER FUNCTION dbo.fn_CustomerOrders (@CustomerID int)
RETURNS TABLE
AS

RETURN
      select distinct C.Name as CustomerName,
	                  C.AccountNumber as AccountNumber, 
	                  c.City as City, 
			          o.OrderDate as OrderDate, 
			          o.Status as Status
	  from dbo.Customer c
	  inner join dbo.[Order] o on c.id=o.CustomerId
	  where c.id = @CustomerID



declare @CustomerID int
set @CustomerID = 1

select *
from dbo.fn_CustomerOrders(@CustomerID)


