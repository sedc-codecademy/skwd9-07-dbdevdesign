select * from dbo.Employee
WHERE FirstName='aleksandar'

-- Find all Employees with FirstName = Goran
select * from dbo.Employee
WHERE FirstName='Goran'

-- Find all Employees with LastName starting With ‘S’

select * from dbo.Employee
WHERE LastName like 'S%'

select * from dbo.Employee
WHERE LastName like '%S%'

select * from dbo.Employee
WHERE LastName like '%i'

-- Find first 10 records from table Employee
select top 10 * from dbo.Employee

-- Find all Employees with Date Of Birth greater than ‘01.01.1988’
select * from dbo.Employee
WHERE DateOfBirth >'1988-01-01'



-- Find all Male employees
select * from dbo.Employee
WHERE Gender='M'

-- Find all employees hired in January/1998
select * from dbo.Employee
WHERE HireDate>'1997-12-31' 
and HireDate<'1998-02-01'

select * from dbo.Employee
WHERE HireDate >= '1998-01-01'
and HireDate <= '1998-01-31'

select * from dbo.Employee
WHERE HireDate between '1998-01-01' and '1998-01-31'


-- Find all Employees with LastName starting With ‘A’ hired in January/2019

select * from dbo.Employee
WHERE LastName like 'A%'
AND HireDate between '2019-01-01' and '2019-01-31'


select * from dbo.Employee
WHERE LastName like 'P%'
AND HireDate between '1998-01-01' and '1998-01-31'


select * from dbo.Employee
WHERE LastName like 'A%'
OR LastName like 'P%'

