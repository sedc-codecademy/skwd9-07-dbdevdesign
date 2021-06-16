
CREATE OR ALTER VIEW TestView
AS
	SELECT 
		  o.*
		, be.Name as BusinessEntity
		, c.Name as Customer
		, e.FirstName + ' ' + e.LastName as Employee
		, e.Gender
	FROM dbo.[Order] o
	INNER JOIN dbo.BusinessEntity be ON o.BusinessEntityId = be.Id
	INNER JOIN dbo.Customer c ON o.CustomerId = c.Id
	INNER JOIN dbo.Employee e ON o.EmployeeId = e.Id
	
go
select * from TestView
ORDER BY Gender

select 
		Gender, 
		Employee,
		Sum(TotalPrice) as TotalOrders 
	from TestView v
	group by Gender, Employee

