/*

Calculate the total amount per BusinessEntity on all orders in the system and filter only total orders greater then 635558
Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20 and filter only total orders less then 100000

*/


SELECT be.Name, SUM(o.TotalPrice) as Total
FROM dbo.[Order] o
inner join [dbo].[BusinessEntity] as BE on be.Id=O.BusinessEntityId
GROUP BY be.Name
HAVING SUM(o.TotalPrice) > 635558.00



SELECT be.Name, SUM(o.TotalPrice) as Total
FROM dbo.[Order] o
inner join [dbo].[BusinessEntity] as BE on be.Id=O.BusinessEntityId
WHERE CustomerId < 20
GROUP BY be.Name
HAVING SUM(TotalPrice) < 100000




--Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system. 
--				Filter only records where Total order amount is more then 4x bigger then average

SELECT BusinessEntityId, Max(TotalPrice) as Total, AVG(TotalPrice) as Average
FROM dbo.[Order]
GROUP BY BusinessEntityId
HAVING  Max(TotalPrice) > 4*AVG(TotalPrice)
GO

select 1518.297619*4

select 'A'+'a'


--- List all BusinessEntity names next to the other details

SELECT BusinessEntityId, b.Name as BusinessEntityName, Max(TotalPrice) as Total, AVG(TotalPrice) as Average
FROM dbo.[Order] o
inner join dbo.BusinessEntity b on b.id = o.BusinessEntityId
GROUP BY BusinessEntityId,b.Name 
HAVING  Max(TotalPrice) > 4*AVG(TotalPrice)
GO




