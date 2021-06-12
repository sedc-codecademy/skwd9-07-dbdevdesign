SELECT *
FROM Employee
WHERE FirstName = 'aleksandar'
ORDER BY LastName asc-- FirstName asc, LastName asc


--Find all Employees with FirstName = Aleksandar ordered by Last Name



SELECT ID, FirstName, HireDate
FROM Employee
WHERE FirstName = 'aleksandar'

union 

SELECT ID, FirstName, HireDate
FROM Employee
WHERE FirstName = 'aleksandar'




SELECT FirstName,LastName 
FROM Employee
WHERE FirstName = 'Aleksandar'

INTERSECT

SELECT FirstName,LastName 
FROM Employee
WHERE LastName = 'Nikolovski'
