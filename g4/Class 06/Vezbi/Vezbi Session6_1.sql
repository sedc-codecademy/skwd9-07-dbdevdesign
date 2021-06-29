
-- PROCEDURA KOJA KE PREBARUVA PO IME NA PRODUKT
-- KE VRATI KOLKU PRODUKTI IMA SO SLICNO IME (LIKE) SINTAKSA
-- KE VRATI KOJA E CENATA NA PRODUKTOT

CREATE OR ALTER PROCEDURE dbo.FindProductByName
	@ProductName nvarchar(200),
	@ProductCount int OUT,
	@ProductPrice decimal(18,2) OUT,
	@ProductCode nvarchar(20) = null
AS
BEGIN

	SELECT @ProductCount = COUNT(*) 
	FROM dbo.Product
	WHERE Name LIKE '%' + @ProductName + '%'

	SELECT @ProductPrice = Price
	FROM dbo.Product
	WHERE Name = @ProductName AND ISNULL(@ProductCode, Code) = Code
	IF (SELECT COUNT(*) FROM dbo.Product WHERE Name = @ProductName) > 1 and @ProductCode is null BEGIN
		SELECT 'There are more than one product with the same name. Use optional parameter ProductCode'
	END
END

select * from dbo.Product order by Name
declare @ProductCount int, @ProductPrice Decimal(18,2)
exec dbo.FindProductByName 'Gluten Free', @ProductCount out, @ProductPrice out--, 'Glu12'
select @ProductCount, @ProductPrice
