--ALTER TABLE [dbo].[OrderDetails] WITH NOCHECK ADD CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product]([Id]);
--GO
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product]([Id]);
GO

exec dbo.CreateOrderDetail @OrderId = 4206, @ProductId = 12313122, @Quantity = 5
GO

CREATE OR ALTER PROCEDURE dbo.CreateOrderDetail (@OrderId int, @ProductId int, @Quantity int)
AS
BEGIN
	declare @Price decimal(18,9)
	declare @TotalPrice decimal(18,9)

	-- get the product price
	select @Price = Price 
	from dbo.Product 
	where  id = @ProductId

	-- insert new order detail
	BEGIN TRY
		INSERT INTO dbo.OrderDetails ([OrderId], [ProductId], [Quantity], [Price])
		VALUES (@OrderId, @ProductId, @Quantity, @Price)
	END TRY
	BEGIN CATCH  
		SELECT  
			ERROR_NUMBER() AS ErrorNumber
		,	ERROR_SEVERITY() AS ErrorSeverity
		,	ERROR_STATE() AS ErrorState
		,	ERROR_PROCEDURE() AS ErrorProcedure
		,	ERROR_LINE() AS ErrorLine
		,	ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;  

	-- calculate the total price
	SET @TotalPrice = 
	(
		SELECT sum(Quantity * Price)
		FROM dbo.[OrderDetails] o
		WHERE o.OrderId = @OrderId
	)

	-- correct the total price
	update o set TotalPrice = @TotalPrice
	from [Order] o 
	where id = @OrderId

	-- output
	SELECT p.Name, sum(o.Quantity) as TotalQuantity, sum(o.Quantity * o.Price) as TotalPricePerProduct
	FROM dbo.[OrderDetails] o
	INNER JOIN dbo.Product p on p.id = o.ProductId
	WHERE o.OrderId = @OrderId
	GROUP BY p.Name
END
GO