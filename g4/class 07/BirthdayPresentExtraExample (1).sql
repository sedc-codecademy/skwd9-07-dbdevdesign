CREATE FUNCTION dbo.fn_employeeage (@date datetime)
RETURNS int
as 
begin 
       
	   declare @output int
	   select @output = year(getdate())-year(@date)
	   return @output

end



CREATE OR ALTER PROCEDURE dbo.BirthdayPresents (@month int)
AS

BEGIN
         
		 CREATE TABLE #EmployeeDetails
		   (  
		     ID int,
			 FirstName nvarchar(50),
			 LastName nvarchar(50),
			 Gender nvarchar(5),
			 Age int,
			 PresentSuggestion nvarchar(500)
		   )

          INSERT INTO #EmployeeDetails (ID, FirstName,LastName,Gender,Age)
		  SELECT id,firstname,lastname,gender,dbo.fn_employeeage(dateofbirth)
		  from dbo.Employee
		  WHERE MONTH(dateofbirth)=@month

		  UPDATE #EmployeeDetails
		  SET PresentSuggestion = case when gender = 'M' and age between 35 and 40 then 'Chess'
		                               when gender = 'M' and age>40 then 'Book'
									   when gender = 'M' and age<35 then 'Football'
									   when gender = 'F' and age between 35 and 40 then 'Handbag'
									   when gender = 'F' and age>40 then 'Spa coupon'
									   when gender = 'F' and age<35 then 'Perfume'
								  else NULL end

           select firstname, lastname,presentsuggestion
		   from #EmployeeDetails

		   drop table #EmployeeDetails


END


exec dbo.BirthdayPresents 12

select *
from dbo.Employee
where MONTH(dateofbirth) = 12