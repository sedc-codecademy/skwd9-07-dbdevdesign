ALTER FUNCTION dbo.fn_MaleEmolyees (@employeeID int)
RETURNS @ReturnTable TABLE 
(
  FirstName nvarchar(50),
  LastName nvarchar(50),
  DateOfBirth nvarchar(50)
)
AS

BEGIN
       IF exists (select NULL from dbo.Employee where id = @employeeID and gender = 'M')
	      BEGIN
		         INSERT INTO @ReturnTable (FirstName,LastName,DateOfBirth)
				 SELECT upper(FirstName), upper(LastName), convert(nvarchar(50),DateOfBirth,102)
				 FROM dbo.Employee
				 WHERE id = @employeeID

		  END

RETURN
END


select *
from dbo.fn_MaleEmolyees (2)

select *
from dbo.Employee
where id = 2


select e.*, f.*
from dbo.Employee e
cross apply dbo.fn_MaleEmolyees(e.id) f 


select e.*, f.*
from dbo.Employee e
outer apply dbo.fn_MaleEmolyees(e.id) f
