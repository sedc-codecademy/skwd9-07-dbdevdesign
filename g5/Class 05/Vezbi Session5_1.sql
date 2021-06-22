
CREATE FUNCTION dbo.fn_EmployeeProfit (@EmployeeID int)
RETURNS decimal(18,2)
AS 
BEGIN
	declare @Output decimal(18,2)

	select @Output = SUM((od.Price - p.Cost) * od.Quantity) 
	from dbo.[Order] o
	JOIN dbo.Employee e ON o.EmployeeId = e.Id
	JOIN dbo.OrderDetails od ON o.Id = od.OrderID
	JOIN dbo.Product p on od.ProductId = p.Id
	WHERE o.EmployeeId = @EmployeeID
	RETURN
		@output
END

select *, dbo.fn_EmployeeProfit(ID) from dbo.Employee
