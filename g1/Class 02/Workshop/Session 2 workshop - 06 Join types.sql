/*
List all possible combinations of Customer names and Product names that can be ordered from specific customer
List all Business Entities that has any order 
List all Entities without orders
List all Customers without orders (using Right Join)
*/


select c.Name AS CustomerName, p.Name as ProductName, p.Price
from dbo.Customer AS c
cross join dbo.Product AS p
ORder BY c.Name


select DISTINCT b.Name
from dbo.[Order] o
inner join dbo.BusinessEntity b on b.Id = o.BusinessEntityId


-- List of all Business Entities that have orders
select DISTINCT b.Name
from dbo.BusinessEntity b
inner join dbo.[Order] o on b.Id = o.BusinessEntityId
GO

-- List all Business Entities that don't have order 
select DISTINCT b.Name, o.*
from dbo.BusinessEntity b   
left join dbo.[Order] o on b.Id = o.BusinessEntityId
where o.BusinessEntityId is null
GO

select b.*
from dbo.[Order] o
right join dbo.BusinessEntity b   on b.Id = o.BusinessEntityId
where o.BusinessEntityId is null


-- Customers without orders - RIGHT
select c.*
from dbo.[Order] o
right join dbo.Customer c on o.CustomerId = c.Id
where o.CustomerId is null


-- right can be writen with Left as well
select c.*
from dbo.Customer c 
left join dbo.[Order] o on o.CustomerId = c.Id
where o.CustomerId is null


select b.Name as BEName, c.Name as CustomerName, e.FirstName+' '+e.LastName as Name, o.OrderDate, TotalPrice, Comment
from dbo.[Order] o
inner join dbo.Customer c on o.CustomerId = c.Id
join dbo.BusinessEntity b   on b.Id = o.BusinessEntityId
join [dbo].[Employee] e on e.Id=o.EmployeeId


select b.Name as BEName, c.Name as CustomerName, e.FirstName+' '+e.LastName as Name, o.OrderDate, p.Name as ProductName, p.Price, od.Quantity
from dbo.[Order] o
inner join dbo.OrderDetails od on od.OrderId=o.Id
inner join dbo.Product p on p.Id=od.ProductId 
inner join dbo.Customer c on o.CustomerId = c.Id
join dbo.BusinessEntity b   on b.Id = o.BusinessEntityId
join [dbo].[Employee] e on e.Id=o.EmployeeId
where o.Id=2



