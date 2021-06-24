CREATE OR ALTER FUNCTION dbo.fn_EmployeeProfit_MultiStatement (@EmployeeName nvarchar(100), @PeriodOfSales nvarchar(100))
RETURNS @table TABLE (EmployeeName nvarchar(100), TotalProfit decimal(18,2), PeriodOfSales nvarchar(20))
AS 
BEGIN
	INSERT INTO @table
	SELECT 
			FirstName + ' ' + LastName as EmployeeName
		,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
		,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
	FROM dbo.[Order] o
	JOIN dbo.Employee e ON o.EmployeeId = e.Id
	JOIN dbo.OrderDetails od ON o.Id = od.OrderId
	JOIN dbo.Product p ON od.ProductId = p.Id
	WHERE 
		FirstName + ' ' + LastName = @EmployeeName AND 
		cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) = @PeriodOfSales 
	GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName
	
	IF @EmployeeName IS NULL BEGIN
		INSERT INTO @table
		SELECT 
				FirstName + ' ' + LastName as EmployeeName
			,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
			,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
		FROM dbo.[Order] o
		JOIN dbo.Employee e ON o.EmployeeId = e.Id
		JOIN dbo.OrderDetails od ON o.Id = od.OrderId
		JOIN dbo.Product p ON od.ProductId = p.Id
		WHERE 
			cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) = @PeriodOfSales 
		GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName
	END
	IF @EmployeeName IS NULL AND @PeriodOfSales IS NULL BEGIN
		INSERT INTO @table
		SELECT 
				FirstName + ' ' + LastName as EmployeeName
			,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
			,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
		FROM dbo.[Order] o
		JOIN dbo.Employee e ON o.EmployeeId = e.Id
		JOIN dbo.OrderDetails od ON o.Id = od.OrderId
		JOIN dbo.Product p ON od.ProductId = p.Id
		GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName
	END
	IF @PeriodOfSales IS NULL AND @EmployeeName IS NOT NULL  BEGIN
		INSERT INTO @table
		SELECT 
				FirstName + ' ' + LastName as EmployeeName
			,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
			,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
		FROM dbo.[Order] o
		JOIN dbo.Employee e ON o.EmployeeId = e.Id
		JOIN dbo.OrderDetails od ON o.Id = od.OrderId
		JOIN dbo.Product p ON od.ProductId = p.Id
		WHERE 
			FirstName + ' ' + LastName = @EmployeeName 
		GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName
	END

	RETURN

END
GO

declare @EmployeeName nvarchar(100) = 'Aleksandar Mitrevski'
declare @PeriodOfSales nvarchar(100) = '4-2019'

select * from dbo.fn_EmployeeProfit_MultiStatement (@EmployeeName, @PeriodOfSales)


