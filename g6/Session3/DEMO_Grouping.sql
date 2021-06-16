--Calculate the total amount per BusinessEntity on all orders in the system and 
--filter only total orders greater then 650000

select b.Id, b.Name, b.Region, sum(TotalPrice) as sum_price
from [Order] o
	inner join BusinessEntity b on o.BusinessEntityId = b.Id
where CustomerId < 20 -- filtriranje na podatoci koi ne se grupirani , raw data
group by b.ID, b.Name, b.Region
having avg(TotalPrice) > 650000 -- filtriranje na veke grupirani podatoci
order by b.ID


--Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20 
--and filter only total orders less then 100000


--Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system. 
--Filter only records where Total order amount is more then 4x bigger then average
--List all BusinessEntity names next to the other details from the previous query


select b.Id, b.Name, b.Region, b.Zipcode, max(TotalPrice) as max_price, AVG(TotalPrice) as average
	, sum(TotalPrice) as sum_price
from [Order] o
	inner join BusinessEntity b on o.BusinessEntityId = b.Id
group by b.ID, b.Name, b.Region, b.Zipcode
having sum(TotalPrice) >= 4 * avg(TotalPrice)
order by b.ID


select *
from [Order]
where sum(CustomerId) < 10