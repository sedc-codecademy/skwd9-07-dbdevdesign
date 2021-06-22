

--select * from dbo.Customer
-- Da napravime funkcija koja ke vraka Account Number i Customer Size vo eden string

CREATE OR ALTER FUNCTION dbo.fn_CustomerTest1 (@CustomerID int)
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @output nvarchar(100)
	
	select @output = AccountNumber + '.' + 
		CASE 
			WHEN CustomerSize = 'Small' THEN 'Mal'  
			WHEN CustomerSize = 'Medium' THEN 'Sreden'
			WHEN CustomerSize = 'Large' THEN 'Golem'
		END
	from dbo.Customer 
	WHERE ID = @CustomerID

	RETURN
	@output

END;
GO
--	Small = Mal
--	Medium = Sreden
--	Large = Golem
select *, dbo.fn_CustomerTest1(Id) from dbo.Customer


