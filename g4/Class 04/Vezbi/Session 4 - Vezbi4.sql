
ALTER FUNCTION dbo.TableValueFunction (@InputParameter int)
RETURNS TABLE
AS
RETURN

	select be.Name, be.Region, c.Name as CustomerName, e.FirstName + ' ' + e.LastName as EmployeeName
	, sum(o.TotalPrice) as TotalSales
	from dbo.[Order] o
	JOIN dbo.BusinessEntity be ON o.BusinessEntityId = be.Id
	JOIN dbo.Customer c ON o.CustomerId = c.Id
	JOIN dbo.Employee e ON o.EmployeeId = e.Id
	WHERE o.BusinessEntityId = @InputParameter
	GROUP BY be.Name, be.Region, c.Name, e.FirstName + ' ' + e.LastName 
	
GO
select * from dbo.BusinessEntity
select * from dbo.TableValueFunction (2)

