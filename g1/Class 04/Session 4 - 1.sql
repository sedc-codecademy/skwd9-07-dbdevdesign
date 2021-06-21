CREATE FUNCTION fn_CustomerFullName (@CustomerID INT)
RETURNS NVARCHAR(1000)

AS

BEGIN

	DECLARE @result NVARCHAR(1000)

	select @result = [Name]+ N' '+ [City]
	from [dbo].[Customer]
	WHERE Id = @CustomerID

	RETURN @result

END