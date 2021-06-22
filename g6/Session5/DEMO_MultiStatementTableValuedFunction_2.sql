GO
CREATE FUNCTION dbo.fn_ProductByBusinessEntityCustomer(@BEName NVARCHAR(100)
	, @CustomerName NVARCHAR(100))
RETURNS @ProductByBECustomer TABLE (BEName NVARCHAR(100)
	, CustomerName NVARCHAR(100)
	, ProductName NVARCHAR(100)
	, TotalQuantity DECIMAL(18,2)
	, TotalPrice DECIMAL(18,2))
AS
BEGIN

	INSERT INTO @ProductByBECustomer(BEName, CustomerName, ProductName, TotalQuantity, TotalPrice)
	
	SELECT  
		  b.[Name] as BusinessEntityName
		, c.[Name] as CustomerName 
		, p.[Name] as ProductName
		, sum(od.Quantity) as TotalQuantity
		, sum(od.Quantity * od.Price) as TotalPrice
	FROM BusinessEntity b
	INNER JOIN [Order] o on b.Id = o.BusinessEntityId
	INNER JOIN Customer c on o.CustomerId = c.Id
	INNER JOIN OrderDetails od on o.ID = od.OrderId
	INNER JOIN Product p on od.ProductId = p.Id
	WHERE b.Name = @BEName AND c.Name = @CustomerName
	GROUP BY b.[Name], c.[Name], p.[Name] 

	RETURN
END

--test case 
--Vitalia Skopje, Makpetrol Skopje

DECLARE @BEName NVARCHAR(100)
	, @CustomerName NVARCHAR(100)

SET @BEName = 'Vitalia Skopje'
SET @CustomerName = 'Makpetrol Skopje'

SELECT *
FROM dbo.fn_ProductByBusinessEntityCustomer(@BEName, @CustomerName)