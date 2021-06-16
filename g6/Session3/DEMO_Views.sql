--Create new view (vv_CustomerOrders) that will List all CustomerIds and sum of total Orders per customer
-- Change the view to show Customer Names instead of CustomerId
-- Change the view to show the results ordered by the customer with biggest total price

-- Create new view (vv_EmployeeOrders) that will List all Employees (FirstName and LastName) , Product name and total quantity sold 
-- Alter the view to show only sales from Business entities belonging to region 'Skopski'


go
create view vv_CustomerOrders
as

select CustomerId, sum(TotalPrice) as sum_price
from [Order]
group by CustomerId

go

select *
from vv_CustomerOrders v
inner join Customer c on v.CustomerID = c.Id