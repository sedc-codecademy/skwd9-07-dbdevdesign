DROP FUNCTION IF EXISTS dbo.fn_OrdersPerCustomer;
GO
--select *
--	from dbo.[Order] o
--	inner join dbo.OrderDetails d on o.Id = d.OrderId
--	inner join dbo.Product p on p.id = d.ProductId


CREATE FUNCTION dbo.fn_OrdersPerCustomer (@BusinessEntityId int, @CustomerId int)
RETURNS @output TABLE (ProductName nvarchar(100), TotalQuantity int, TotalCost decimal(18,2), TotalPrice decimal(18,2), TotalProfit decimal(18,2), TypeOfSales nvarchar(100))
AS
BEGIN

	
	INSERT INTO @output 
	
	select p.Name as ProductName, sum(d.Quantity) as TotalQuantity, sum(d.quantity* p.COst) as TotalCost, sum(d.Quantity*d.Price) as TotalPrice
	, sum(d.Quantity * (d.Price - p.Cost)) as TotalProfit
	, 'Per Customer ' + c.Name
	from dbo.[Order] o
	inner join dbo.OrderDetails d on o.Id = d.OrderId
	inner join dbo.Product p on p.id = d.ProductId
	INNER JOIN dbo.Customer c ON o.CustomerId = c.Id
	where o.BusinessEntityId = @BusinessEntityId
	and o.CustomerId = @CustomerId
	group by  p.name, c.Name
	ORDER BY TotalQuantity
	
	IF (select count(*) from @output) = 0 BEGIN
		INSERT INTO @output
		select p.Name as ProductName, sum(d.Quantity) as TotalQuantity, sum(d.quantity* p.COst) as TotalCost, sum(d.Quantity*d.Price) as TotalPrice
		, sum(d.Quantity * (d.Price - p.Cost)) as TotalProfit
		, 'All Customers per BusinessEntity ' + be.Name
		from dbo.[Order] o
		inner join dbo.OrderDetails d on o.Id = d.OrderId
		inner join dbo.Product p on p.id = d.ProductId
		INNER JOIN dbo.BusinessEntity be ON o.BusinessEntityId = be.Id
		where o.BusinessEntityId = @BusinessEntityId
		--and o.CustomerId = @CustomerId
		group by  p.name, be.Name
		ORDER BY TotalQuantity
	END

RETURN 
END

GO

-- Execution

declare @BusinessEntityId int = 1
declare @CustomerId int = 64

select * from dbo.fn_OrdersPerCustomer (@BusinessEntityId,@CustomerId)
order by TotalProfit desc