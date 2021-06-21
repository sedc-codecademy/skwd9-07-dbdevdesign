SELECT MIN(TotalPrice) as Total
from dbo.[Order]


-- Calculate the total amount on all orders in the system


SELECT SUM(TotalPrice) as Total
from dbo.[Order]



-- Calculate the total amount per BusinessEntity on all orders in the system

SELECT BusinessEntityId, SUM(TotalPrice) as Total
from dbo.[Order]
GROUP BY BusinessEntityId


SELECT be.[Name], SUM(TotalPrice) as Total
from dbo.[Order] as O
inner join [dbo].[BusinessEntity] as BE on be.Id=O.BusinessEntityId
GROUP BY be.[Name]
ORDER By be.[Name]


-- Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20



SELECT be.[Name], SUM(TotalPrice) as Total
from dbo.[Order] as O
inner join [dbo].[BusinessEntity] as BE on be.Id=O.BusinessEntityId
WHERE CustomerId<20
GROUP BY be.[Name]
ORDER By be.[Name]


-- Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system


SELECT be.[Name], MAX(TotalPrice) as MaxAmount, AVG(TotalPrice) as AVGAmount
from dbo.[Order] as O
inner join [dbo].[BusinessEntity] as BE on be.Id=O.BusinessEntityId
GROUP BY be.[Name]
ORDER By be.[Name]





SELECT Name FROM BusinessEntity
---------------------------------------------
SELECT STRING_AGG(Name,'-') AS Result FROM BusinessEntity





SELECT DISTINCT be.Name,e.FirstName+' '+e.LastName as EmployeeName
into #temp
FROM BusinessEntity be
INNER JOIN [dbo].[Order] o on o.BusinessEntityId=be.Id
INNER JOIN [dbo].[Employee] e on e.Id=o.EmployeeId
GROUP BY be.Name, e.FirstName+' '+e.LastName
ORDER BY be.Name asc


select * from #temp

--drop table #temp

--Vitalia Bitola

SELECT Name,STRING_AGG(EmployeeName,',')  
WITHIN GROUP ( ORDER BY EmployeeName ASC)  AS
Result 
FROM #temp 
where Name='Vitalia Bitola'
GROUP BY Name
ORDER BY Name asc





select 'A'+'a' as Temp


select CONCAT('A','a') as Temp

