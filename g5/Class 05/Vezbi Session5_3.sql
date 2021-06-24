
/*
select * from dbo.[Order]
select * from dbo.BusinessEntity
select * from dbo.Customer
*/
--- Size			za BusinessEntity
--- CustomerSize	za Customer
--declare @size nvarchar(100), @CustomerSize nvarchar(100)
--set @size = 'Small'
--set @CustomerSize = 'Large'

--Create multi-statement table value function that for specific BusinessEntity and Customer will return list of products sold, 
--together with the total quantity sold and total price per product

--DECLARE @BusinessEntityID int, @customerID int

CREATE OR ALTER FUNCTION dbo.SalesPerBusinessEntity (@BusinessEntityID int, @CustomerID int)
RETURNS TABLE 
AS
RETURN
SELECT be.Name as BusinessEntity, c.Name as Customer, SUM(TotalPrice) as TotalPrice, sum(Quantity) as Quantity FROM dbo.[Order] o
JOIN dbo.BusinessEntity be on o.BusinessEntityId = be.Id
JOIN dbo.Customer c on o.CustomerId = c.Id
JOIN dbo.OrderDetails od on o.Id = od.OrderId
JOIN dbo.Product p on od.ProductId = p.Id
WHERE o.BusinessEntityId = @BusinessEntityID AND o.CustomerId = @customerID
GROUP BY be.Name , c.Name
GO

CREATE OR ALTER FUNCTION dbo.TestFunction (@size nvarchar(100), @CustomerSize nvarchar(100))
RETURNS @TableVariable TABLE (BusinessEntity nvarchar(100), Customer nvarchar(100), [Period] int, TotalSales decimal(18,2), NoSales INT, SalesType nvarchar(100))
AS
BEGIN
		INSERT INTO @TableVariable
		select be.Name as BusinessEntity, c.Name as Customer, Month(OrderDate) 'Month', SUM(TotalPrice) as TotalSales, Count(*) as NoSales, 'Large' 
		from dbo.[Order] o
		INNER JOIN dbo.BusinessEntity be ON o.BusinessEntityId = be.Id
		INNER JOIN dbo.Customer c ON o.CustomerId = c.Id
		WHERE be.Size = @size AND c.CustomerSize = @CustomerSize
		GROUP BY be.Name, c.Name, Month(OrderDate)
RETURN
END
GO

SELECT * FROM dbo.SalesPerBusinessEntity (1,64)
select * from dbo.TestFunction ('Small', 'Small')
select * from dbo.TestFunction ('Medium', 'Small')
select * from dbo.TestFunction ('Large', 'Small')

