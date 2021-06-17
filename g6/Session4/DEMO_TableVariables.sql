DECLARE @name nvarchar(30)
SET @name = 'angela'


DECLARE @tableProduct TABLE (Code NVARCHAR(50), Name NVARCHAR(100))

select *
from @tableProduct



insert into @tableProduct(Code, [Name])

select Code, Name
from Product


select *
from @tableProduct

