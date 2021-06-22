CREATE FUNCTION dbo.fn_EmployeeDetails_MultiStatement (@EmployeeID int)
RETURNS @output TABLE (Id int, FirstName NVARCHAR(100), LastName NVARCHAR(100), DateOfBirth date)
AS
BEGIN

	DECLARE @employeetable table (Id int, FirstName NVARCHAR(100), LastName NVARCHAR(100), DateOfBirth date)

	INSERT INTO @employeetable(ID, FirstName, LastName, DateOfBirth)
	SELECT Id,FirstName,LastName,DateOfBirth
	FROM dbo.Employee e
	WHERE Id = @EmployeeID

	INSERT INTO @output(ID, FirstName, LastName, DateOfBirth)
	SELECT ID, FirstName, LastName, DateOfBirth
	FROM @employeetable

RETURN
END
GO


select *
from dbo.fn_EmployeeDetails_MultiStatement(11)


select *
from emplo