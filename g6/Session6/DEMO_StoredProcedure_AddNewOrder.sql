--Create new procedure called CreateOrder
--Procedure should create only Order header info (not Order details) 
--Procedure should return the total number of orders in the system for the Customer from the new order (regardless the BusinessEntity)
--Procedure should return second resultset with the total amount of all orders for the customer and business entity on input
--Insert few orders in the system




go

create procedure AddNewOrder(@OrderDate date
	, @Status smallint = 1
	, @BusinessEntityID int
	, @CustomerId int
	, @EmployeeId int
	, @TotalPrice decimal(18, 2))

as
begin

	insert into [Order](OrderDate, Status, BusinessEntityId, CustomerId, EmployeeId, TotalPrice)
	values(@OrderDate, @Status, @BusinessEntityID, @CustomerId, @EmployeeId, @TotalPrice)


	select count(*) as TotalOrdersByCustomer
	from [Order]
	where CustomerId = @CustomerId

	select sum(TotalPrice) as TotalPriceByCustomerBE
	from [Order]
	where CustomerId = @CustomerId AND BusinessEntityId = @BusinessEntityID

end


go


---test case


declare @OrderDate date = '2021-06-23'
	, @Status smallint = 1
	, @BusinessEntityID int
	, @CustomerId int
	, @EmployeeId int
	, @TotalPrice decimal(18, 2) = 450


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


exec AddNewOrder @OrderDate 
	, @Status 
	, @BusinessEntityID
	, @CustomerId
	, @EmployeeId 
	, @TotalPrice