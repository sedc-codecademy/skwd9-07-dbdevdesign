CREATE FUNCTION dbo.fn_EmployeeFullName (@EmployeeID int)
RETURNS NVARCHAR(500)
AS 
BEGIN

	DECLARE @Result NVARCHAR(500)

	SELECT @Result = e.FirstName + N' ' + e.LastName
	FROM dbo.Employee e
	WHERE Id = @EmployeeID

	RETURN @Result
END

go

SELECT dbo.fn_EmployeeFullName(10) as full_name