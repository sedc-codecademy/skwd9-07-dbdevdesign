-- String Functions

select
	FirstName
,	LastName
,	replace(FirstName,'ks', 'X') as Replace_ks_X
,	Substring(FirstName, 4, 2) as Substring_4_2
,	Left(FirstName, 3) as Left_3
,	Right(FirstName, 2) as Right_2
,	Len(FirstName) as LenColumn
,	Concat(FirstName, '-', LastName) as Concat_Name
,   FirstName + ' ' + LastName
from
	Employee
where
	FirstName = 'Aleksandar' and LastName = 'Stojanovski'
go

--ZA GOLEMI IMALI BUKVI
SELECT UPPER('tREWjdfhsjf')

SELECT LOWER('tREWjdfhsjf')

--ZA TRGANJE NA PRAZNI MESTA OD LEVO/DESNO
SELECT LTRIM(' test') AS testLtrim, ' test'

SELECT RTRIM('Test d ') AS testRtrim, 'Test d '

SELECT LTRIM(RTRIM(' test d ')) as testBoth

--ZA BARANJE NA KARAKTER/i VO KOLONA
SELECT CHARINDEX('a', 'barame ST na koja pozicija e vo kolonava', 1) -- na koja pozicija


--CAST, CONVERT
-- CAST, CONVERT

declare @dt datetime
set @dt = Getdate()
select @dt

select
 	cast('20' as int) as Varchar_Cast_Int
,	convert(int, '20') as Varchar_Convert_Int
,	@dt as Datetime_Default
,	convert(varchar(50), @dt, 104) as Datetime_Convert_Varchar	--dd.mm.yyyy
--DateTime
SELECT GETDATE() AS currentDate

--DODAVA intervali vo datumot. moze den, mesec ili godina i moze kolku sakame napred i nazad
SELECT DATEADD(m, 1, getdate())
SELECT DATEADD(m, -10, getdate())
SELECT DATEADD(month, 1, getdate()) --mm isto funkcionira

--DAVA RAZLIKA pomegu 2 datumi vo odnos na referenten interval den, mesec ili godina
SELECT DATEDIFF(yy, getdate(), '20210202') --Y ne funkcionira!!! samo YY ili YYYY, moze da se pise i YEAR
SELECT DATEDIFF(d, getdate(), '20210202') --DD ili DAY


