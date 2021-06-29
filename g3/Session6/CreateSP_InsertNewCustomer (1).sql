ALTER PROCEDURE dbo.InsertNewCustomer 
(
   @Name nvarchar(100),
   @AccountNumber nvarchar(50),
   @City nvarchar(50),
   @Region nvarchar(50),
   @CSize nvarchar(50),
   @Phone nvarchar(50),
   @isActive bit = 1
)
AS
BEGIN
        
		INSERT INTO dbo.Customer (Name, AccountNumber,City,RegionName, CustomerSize,PhoneNumber, isActive)
        VALUES (@Name,@AccountNumber,@City,@Region,@CSize,@Phone,@isActive)

		SELECT count(*) as CustomerFirstLetter
		FROM dbo.Customer
		WHERE substring(Name,1,1) = SUBSTRING(@Name,1,1)

		SELECT count(*) as RegionCustomer
		FROM dbo.Customer
		WHERE RegionName = @Region

		PRINT 'Uspeshno vnesen Customer'

END

declare @Name nvarchar(100)
declare  @AccountNumber nvarchar(50)
declare  @City nvarchar(50)
declare @Region nvarchar(50)
declare @Phone nvarchar(50)
declare @size nvarchar(50)

set @Name = 'Tobaco 2'
set @AccountNumber = '587456'
set @City = 'Skopje'
set @Region = 'Skopski'
set @Phone = '070111222'
set @size = 'Small'

exec dbo.InsertNewCustomer @Name, @AccountNumber, @City, @Region,@size,@Phone


select *
from dbo.Customer
order by id desc