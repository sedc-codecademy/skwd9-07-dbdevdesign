--views

create view Orders
as

select b.Name as BusinessEntityName, b.Region, b.Zipcode
	, c.Name as CustomerName, c.AccountNumber
	, e.FirstName, e.LastName, e.DateOfBirth
	, o.OrderDate, o.Status, o.TotalPrice
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
inner join Customer c on o.CustomerId = c.Id
inner join Employee e on o.EmployeeId = e.Id


select *
from Orders


alter view Orders
as

select b.Name as BusinessEntityName, b.Region, b.Zipcode
	, c.Name as CustomerName, c.AccountNumber, c.City
	, e.FirstName, e.LastName, e.DateOfBirth
	, o.OrderDate, o.Status, o.TotalPrice
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
inner join Customer c on o.CustomerId = c.Id
inner join Employee e on o.EmployeeId = e.Id


--delete
----select *
--from [Order]
--where id = 4199


select *
from Customer