--Calculate the total amount on all orders in the system

select count(*) as total
from [Order]

--Calculate the total amount per BusinessEntity on all orders in the system


select b.Id, b.Name, b.Region, count(*) as total --avg(TotalPrice) as maximum
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
group by b.ID, b.Name, b.Region
order by b.ID

--Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20

select b.Id, b.Name, b.Region, count(*) as total --avg(TotalPrice) as maximum
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
where o.CustomerId < 20
group by b.ID, b.Name, b.Region
order by b.ID



--Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system


select b.Id, b.Name, b.Region, avg(TotalPrice) as average, MAX(TotalPrice) as maximum
from [Order] o
inner join BusinessEntity b on o.BusinessEntityId = b.Id
group by b.ID, b.Name, b.Region
order by b.ID
