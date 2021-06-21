CREATE FUNCTION fn_BusinessEntityFullName (@BusinessEntityId INT)
RETURNS NVARCHAR(2000)

AS

BEGIN

	DECLARE @result NVARCHAR(2000)

	select @result = [Name] + N' ' + ZipCode
	FROM dbo.BusinessEntity
	WHERE Id=@BusinessEntityId

	RETURN @result

END





select o.*,  dbo.fn_BusinessEntityFullName(BusinessEntityId) as BEFullName , dbo.fn_EmployeeFullName(EmployeeId) as Employee,
dbo.fn_CustomerFullName(CustomerId) as Customer
from [Order] o

