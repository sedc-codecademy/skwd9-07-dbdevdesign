--Create new procedure called CreateOrderDetail
--Procedure should take the single price for item from Product table (Price column)
--Procedure should add details for specific order (new record for new Product/Quantity for specific order)
--When the order detail is inserted procedure should correct the TotalPrice column in the main table (dbo.order)
--Output from this procedure should be resultset with order details in a form of pairs: ProductName and TotalPrice per product (Price*Quantity)


go

create procedure AddOrderDetails(@OrderId int, @ProductId int, @Quantity int)
as
begin

	--Variable for storing total price value calculated by specific Order and Price
	declare @TotalPrice decimal(18, 2)
		, @Price decimal(18, 2)

	--take the single price for item from Product table (Price column)
	select @Price = Price
	from Product
	where Id = @ProductId

	--insert new OrderDetails for specific Order and Product
	insert into OrderDetails(OrderId, ProductId, Quantity, Price)
	values(@OrderId, @ProductId, @Quantity, @Price)

	--Calculate total price per Order
	select @TotalPrice = SUM(Quantity * Price)
	from OrderDetails
	where OrderId = @OrderId

	--Update total price for Order in Order table
	update o
	set o.TotalPrice = @TotalPrice
	from [Order] o
	where Id = @OrderId

	--Return ProductName, TotalPrice per order
	select p.[Name] as ProductName, SUM(o.Quantity * o.Price) as TotalPrice
	from OrderDetails o
	inner join Product p on o.ProductId = p.Id
	where OrderId = @OrderId
	group by p.[Name]

end


-------------------------------------


--test case
GO


declare @BusinessEntityID int
	, @CustomerId int
	, @EmployeeId int
	, @OrderId INT
	, @ProductId INT
	, @Quantity INT = 2000
	, @Price decimal(18,2)
	, @TotalPrice decimal(18,2)


select @BusinessEntityID = Id
from BusinessEntity
where Name = 'Vitalia Tetovo'

select @CustomerId = Id
from Customer
where Name = 'DM Marketi'

select @EmployeeId = ID
from Employee
where FirstName = 'Aleksandar' AND LastName = 'Stojanovski'

select @BusinessEntityID as BE_ID, @CustomerId as CustomerID, @EmployeeId as EmployeeId


select  top 1 @OrderId = Id
from [Order]
where CustomerId = @CustomerId AND BusinessEntityId = @BusinessEntityID AND EmployeeId = @EmployeeId
	--AND TotalPrice = 75
	AND Id = 4210


select @ProductId = Id
from Product
where Name = 'Crunchy'


select * from [Order]

--set @OrderId = (select top 1 Id
--				from [Order]
--				where CustomerId = @CustomerId AND BusinessEntityId = @BusinessEntityID AND EmployeeId = @EmployeeId)

select @OrderId as OrderId
select @ProductId as Productid


exec AddOrderDetails @OrderId, @ProductId, @Quantity


select *
from [Order]
where id = @OrderId