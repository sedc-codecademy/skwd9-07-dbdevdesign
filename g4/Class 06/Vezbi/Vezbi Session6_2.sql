

--CREATE PROCEDURE TO CREATE NEW EMPLOYEE
--RETURN THE RECORD FOR THE NEW EMPLOYEE


CREATE OR ALTER PROCEDURE dbo.InsertNewEmployee
(		@FirstName nvarchar(100),
        @LastName nvarchar(100),
        @DateOfBirth date,
        @Gender nchar(1),
        @HireDate date,
        @NationalIdNumber nvarchar(20))
AS 
BEGIN
	IF (SELECT COUNT(*) FROM dbo.Employee WHERE NationalIdNumber = @NationalIdNumber) = 0 BEGIN
		INSERT INTO [dbo].[Employee]
			   ([FirstName],[LastName],[DateOfBirth],[Gender],[HireDate],[NationalIdNumber])
		 VALUES
			   (@FirstName,@LastName,@DateOfBirth,@Gender,@HireDate,@NationalIdNumber)
		declare @id int
		select @Id = SCOPE_IDENTITY()
		select * from dbo.Employee WHERE ID = @id
	END ELSE BEGIN
		select 'Employee already exists in the system' as Message, * from dbo.Employee WHERE NationalIdNumber = @NationalIdNumber
	END
	-- DA SE NAPRAVI KONTROLA PO NationalIdNumber DALI EMPLOYEE VEKE POSTOI I AKO POSTOI DA SE VRATI PORAKA DEKA POSTOI
	
END

