
-- Kolku ima neto dobivka po vraboten
CREATE OR ALTER VIEW dbo.vw_EmployeeProfit
AS
SELECT 
		FirstName + ' ' + LastName as EmployeeName
	,	SUM(od.Quantity * (od.Price - p.Cost) ) as TotalProfit
	,	cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)) as PeriodOfSales
FROM dbo.[Order] o
JOIN dbo.Employee e ON o.EmployeeId = e.Id
JOIN dbo.OrderDetails od ON o.Id = od.OrderId
JOIN dbo.Product p ON od.ProductId = p.Id
GROUP BY cast(MONTH(o.OrderDate) as nvarchar(10)) + '-' + cast(YEAR(o.OrderDate) as nvarchar(10)), FirstName + ' ' + LastName

select * from dbo.vw_EmployeeProfit
WHERE PeriodOfSales = '4-2019'

-- VRABOTENI STO NEMAAT NIKAKOV PROFIT
SELECT 
		FirstName + ' ' + LastName as EmployeeName
FROM dbo.[Order] o
RIGHT JOIN dbo.Employee e ON o.EmployeeId = e.Id
WHERE o.ID is null

SELECT 
*
FROM dbo.[Order] o
RIGHT JOIN dbo.Customer c ON o.CustomerId = c.Id
WHERE o.ID is null

SELECT * FROM dbo.Customer
WHERE ID not IN 
(
	select CustomerID from dbo.[Order]
)
