--Create new view (vv_EmployeeOrders) that will List all Employees (FirstName and LastName) , 
--Product name and total quantity sold 
-- Alter the view to show only sales from Business entities belonging to region 'Skopski'

create view vv_EmployeeOrders
as
 select e.ID, e.FirstName, e.LastName, p.[Name] as ProductName, sum(od.Quantity) as QuantitySold -- o.*, od.*, p.*
 from Employee e
 inner join [Order] o on e.Id = o.EmployeeId
 inner join OrderDetails od on o.ID = od.OrderId 
 inner join Product p on od.ProductId = p.Id
 group by e.Id, e.FirstName, e.LastName, p.[Name]

go


select *
from vv_EmployeeOrders

go 
alter view vv_EmployeeOrders
as

 select e.ID, e.FirstName, e.LastName, p.[Name] as ProductName, be.Region, sum(od.Quantity) as QuantitySold -- o.*, od.*, p.*
 from Employee e
 inner join [Order] o on e.Id = o.EmployeeId
 inner join OrderDetails od on o.ID = od.OrderId 
 inner join Product p on od.ProductId = p.Id
 inner join BusinessEntity be on o.BusinessEntityId = be.Id
 where be.Region = 'Skopski'
 group by e.Id, e.FirstName, e.LastName, p.[Name], be.Region

go

 select * from vv_EmployeeOrders