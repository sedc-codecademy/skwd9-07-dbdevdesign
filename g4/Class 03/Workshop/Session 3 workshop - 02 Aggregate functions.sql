/*
Calculate the total amount on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system 
from Customers with ID < 20
Find the Maximal Order amount, and the Average Order amount 
per BusinessEntity on all orders in the system
*/


SELECT SUM(TotalPrice) as Total	--6321732.00
from dbo.[Order]
GO

SELECT b.Name, SUM(TotalPrice) as Total
FROM dbo.[Order] o
join dbo.BusinessEntity b on o.BusinessEntityId = b.Id
GROUP BY b.Name
GO

SELECT b.Name, SUM(TotalPrice) as Total
FROM dbo.[Order] o
join dbo.BusinessEntity b on o.BusinessEntityId = b.Id
WHERE CustomerId < 20
GROUP BY b.Name
Order by SUM(TotalPrice) desc
GO

SELECT BusinessEntityId, SUM(TotalPrice) as Total
FROM dbo.[Order]
WHERE CustomerId < 20
GROUP BY BusinessEntityId
HAVING SUM(TotalPrice) > 628920

--Find the Maximal Order amount, and the Average Order amount 
--per BusinessEntity on all orders in the system


SELECT b.Region, b.Name as BusinessEntityName
, c.Name as CustomerName
, Min(TotalPrice) as MinOrder, Max(TotalPrice) as Total, AVG(TotalPrice) as Average
FROM dbo.[Order] o
join dbo.BusinessEntity b on o.BusinessEntityId = b.Id
join dbo.Customer c on o.CustomerId = c.Id
GROUP BY b.Region, b.Name, c.Name
GO


SELECT BusinessEntityId, SUM(TotalPrice) as Total
FROM dbo.[Order]
WHERE CustomerId < 20
GROUP BY BusinessEntityId
HAVING SUM(TotalPrice) > 628920
