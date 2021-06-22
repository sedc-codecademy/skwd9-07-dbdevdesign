CREATE FUNCTION dbo.fn_EmployeeDetails_Inline(@EmployeeID int, @FirstName NVARCHAR(30))
RETURNS TABLE
AS 
RETURN
	SELECT Id, FirstName, LastName, DateOfBirth
	FROM dbo.Employee e
	WHERE Id = @EmployeeID AND FirstName = @FirstName
GO

SELECT *
FROM dbo.fn_EmployeeDetails_Inline(4, 'Viktor') i
INNER JOIN [Order] o on i.ID = o.EmployeeId
