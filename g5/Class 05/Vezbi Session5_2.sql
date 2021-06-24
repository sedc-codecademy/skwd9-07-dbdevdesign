CREATE OR ALTER VIEW dbo.EmployeeReport
AS
select FirstName +  ' ' + LastName as Employee, CAST(MONTH(OrderDate) as nvarchar(10)) + '-' + cast(YEAR(OrderDate) as nvarchar(10)) as [Period]
, SUM(p.Cost * od.Quantity) AS TotalCost
, SUM(od.Price * od.Quantity) as TotalSoldAmount
, SUM((od.Price - p.Cost) * od.Quantity) as TotalProfit
from dbo.[Order] o
JOIN dbo.Employee e ON o.EmployeeId = e.Id
JOIN dbo.OrderDetails od ON o.Id = od.OrderID
JOIN dbo.Product p on od.ProductId = p.Id
GROUP BY FirstName +  ' ' + LastName 
, CAST(MONTH(OrderDate) as nvarchar(10)) + '-' + cast(YEAR(OrderDate) as nvarchar(10))
GO

select * from dbo.EmployeeReport






