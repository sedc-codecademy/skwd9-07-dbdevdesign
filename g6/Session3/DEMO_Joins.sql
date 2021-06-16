--01. List all possible combinations of Customer names and Product names that can be ordered from specific customer 


select c.[Name] as CustomerName, p.[Name] as ProductName
from Customer c --100
cross join Product p --51 -> 100 * 51 rows
order by c.[Name], p.[Name]

--02. List all Business Entities that has any order 


select b.Name, b.Zipcode, o.OrderDate, o.Status, o.TotalPrice, o.CustomerId
--select distinct b.Name, b.Region --distinct b.*
from BusinessEntity b
inner join [Order] o on b.Id = o.BusinessEntityId
order by b.Id


--03. List all Business Entities without orders

select *
from BusinessEntity b
left join [Order] o on b.Id = o.BusinessEntityId
where o.Id IS NULL

--04. List all Customers without orders


select *
from Customer c
left join [Order] o on c.Id = o.CustomerId
where o.Id is null



select b.Name as BusinessEntityName, b.Region, b.Zipcode
	, c.Name as CustomerName, c.AccountNumber
	, e.FirstName, e.LastName, e.DateOfBirth
	, o.OrderDate, o.Status, o.TotalPrice
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
inner join Customer c on o.CustomerId = c.Id
inner join Employee e on o.EmployeeId = e.Id