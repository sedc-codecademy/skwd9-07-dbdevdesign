create function dbo.fn_CustomerOrders(@CustomerName NVARCHAR(100))
returns table
as
return

	select o.CustomerId, c.[Name] as CustomerName, sum(o.TotalPrice) as Sum_Price
	from [Order] o
	inner join Customer c on o.CustomerId = c.Id
	where c.[Name] = @CustomerName
	group by o.CustomerId, c.[Name]

go

--test case:
--Eurofarm Bitola

declare @CustomerName NVARCHAR(100)
set @CustomerName = 'Eurofarm Tetovo'

select *
from dbo.fn_CustomerOrders(@CustomerName)