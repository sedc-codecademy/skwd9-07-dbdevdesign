--Create procedure for adding new customer
--As output from the procedure return the following data:
--Total number of customers starting with the same character as the new customer
--Additionally in second resultset return how many customers already exist in the new customer region



--select *
--from Customer

go

create procedure AddNewCustomer(@CustomerName nvarchar(100), @AccountNumber nvarchar(50)
	, @City nvarchar(100), @Region nvarchar(100), @CustomerSize nvarchar(10), @PhoneNumber nvarchar(20)
	, @IsActive bit)
as
begin

	insert into Customer([Name], AccountNumber, City, RegionName, CustomerSize, PhoneNumber, isActive)
	values (@CustomerName, @AccountNumber, @City, @Region, @CustomerSize, @PhoneNumber, @IsActive)

	select count(*) as TotalCustomers
	from Customer
	where left([Name], 1) = left(@CustomerName, 1)

	select count(*) as TotalRegions
	from Customer
	where RegionName = @Region

end



---test scenario
go

declare @CustomerName nvarchar(100) = 'Kapitol Mall'
	, @AccountNumber nvarchar(50) = '0123456'
	, @City nvarchar(100) = 'Ohrid'
	, @Region nvarchar(100) = 'Ohridski'
	, @CustomerSize nvarchar(10) = 'Medium'
	, @PhoneNumber nvarchar(20) = '0123456789'
	, @IsActive bit = 1

exec AddNewCustomer @CustomerName, @AccountNumber, @City, @Region, @CustomerSize, @PhoneNumber, @IsActive



--select *
--from Customer
--where left([Name], 1) = 'K'  --RegionName = 'Ohridski'