--Declare scalar variable for storing FirstName values
--Assign value ‘Aleksandar’ to the FirstName variable

--Find all Employees having FirstName same as the variable

DECLARE @first_name NVARCHAR(100)
SET @first_name = 'ana'

SELECT @first_name

SELECT *
FROM Employee
WHERE FirstName = @first_name

--Declare table variable that will contain EmployeeId and DateOfBirth
--Fill the table variable with all Female employees

DECLARE @female_employees TABLE (EmployeeID INT, DateOfBirth DATE)

INSERT INTO @female_employees(EmployeeID, DateOfBirth)

SELECT Id, DateOfBirth
FROM Employee
WHERE Gender = 'F'

SELECT * FROM @female_employees

--Declare temp table that will contain LastName and HireDate columns
--Fill the temp table with all Male employees having First Name starting with ‘A’
--Retrieve the employees from the table which last name is with 7 characters

CREATE TABLE #Male_employees(LastName NVARCHAR(100), HireDate DATE)


INSERT INTO #Male_employees(LastName, HireDate)
SELECT LastName, HireDate
FROM Employee
WHERE Gender = 'M' AND FirstName LIKE 'A%'



select *, LEN(LastName) as len_lastname
from #Male_employees
where LEN(LastName) = 7