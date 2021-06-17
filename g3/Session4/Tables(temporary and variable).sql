--declate variable
DECLARE @EmployeeID INT
SET @EmployeeID = 1
select @EmployeeID
print @employeeid


CREATE TABLE #EmployeeDetails
(
  FirstName nvarchar(500)  NULL,
  LastName nvarchar(500)  NULL,
  Address nvarchar(500)  NULL
)

select *
from #EmployeeDetails

INSERT INTO #EmployeeDetails(FirstName,LastName,Address)
select firstname, lastname,'Address Details'
from dbo.Employee

select *
from #EmployeeDetails

select *
into ##EmployeeDetails
from #EmployeeDetails

select *
from ##EmployeeDetails

drop table ##EmployeeDetails

DECLARE @EmployeeDetails TABLE
(
   FirstName nvarchar(50),
   LastName nvarchar(100)
)

insert into @EmployeeDetails
select firstname, lastname
from dbo.Employee

select *
from @EmployeeDetails


select *
from #EmployeeDetails