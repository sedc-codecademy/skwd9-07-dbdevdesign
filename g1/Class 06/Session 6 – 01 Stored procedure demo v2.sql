CREATE OR ALTER PROCEDURE dbo.InsertNewCustomer (@Name nvarchar(100), @AccountNumber nvarchar(50), 
				@City nvarchar(100), @RegionName nvarchar(100), @PhoneNumber nvarchar(20), @IsActive bit)

AS
BEGIN
	DECLARE @proverka int = 0 
	
	set @proverka = (select top 1  1 as Rezultat from dbo.Customer
					 where [Name]=@Name)

	print 'Proverka'
	print @proverka

	IF (@proverka=0)
	BEGIN
		print'Insertiraj nov klient'

		INSERT INTO dbo.Customer([Name], AccountNumber, City, RegionName, PhoneNumber, IsActive)
		VALUES (@Name, @AccountNumber, @City, @RegionName, @PhoneNumber, @IsActive)
	END
END


exec dbo.InsertNewCustomer 'Viva', '123', 'Skopje', 'Skopski', '070700500', 1

