CREATE OR ALTER FUNCTION dbo.fn_EmployeeProfit_Inline (@EmployeeName nvarchar(100), @PeriodOfSales nvarchar(100))
RETURNS TABLE
AS
RETURN
	SELECT 
			FirstName + ' ' + LastName as EmployeeName
		,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
		,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
	FROM dbo.[Order] o
	JOIN dbo.Employee e ON o.EmployeeId = e.Id
	JOIN dbo.OrderDetails od ON o.Id = od.OrderId
	JOIN dbo.Product p ON od.ProductId = p.Id
	WHERE
		FirstName + ' ' + LastName = ISNULL(@EmployeeName, FirstName + ' ' + LastName) AND 
		cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) = ISNULL(@PeriodOfSales, cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10))) 
	GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName
GO
declare @EmployeeName nvarchar(100) = 'Aleksandar Mitrevski'
declare @PeriodOfSales nvarchar(100) = '4-2019'

select * from dbo.fn_EmployeeProfit_Inline (@EmployeeName, @PeriodOfSales)
--select * from dbo.vw_EmployeeProfit
