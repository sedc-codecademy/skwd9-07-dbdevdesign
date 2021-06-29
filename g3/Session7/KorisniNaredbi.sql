--promena na podatocen tip na kolona vo tabela
ALTER TABLE dbo.Employee
ALTER COLUMN NationalIdNumber nvarchar(100)

--naredbi za detalen prikaz na kolonite i vrskite na tabela
--ALT+F1
dbo.Employee

sp_help 'dbo.Employee'

--za skriptiranje na proceduri, funkcii, trigeri, view .....
sp_helptext 'dbo.CreateOrderDetail'

--naredba za prebaruvanje na objekti vo bazata
select *
from sysobjects
where name like '%Order%' and xtype = 'p'