/*Show all orders with their details
  Show orders date of Emplyee name Goran, order from the last dateofbirth
  Show Customers without orders, order by City
*/
select o.OrderDate, o.BusinessEntityId, o.CustomerId, o.EmployeeId,od.ProductId, od.Quantity, od.Price
from [Order] o
inner join OrderDetails od on o.id=od.OrderId

select distinct e.FirstName, e.LastName, e.DateOfBirth, o.OrderDate
from dbo.Employee e
inner join dbo.[Order] o on e.id=o.EmployeeId
where e.FirstName = 'Goran'
order by DateOfBirth desc

select p.*
from dbo.Customer p
left join dbo.[Order] o on o.CustomerId=p.id
where o.CustomerId is null
order by City asc
