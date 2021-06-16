select *
from tableA

select *
from tableB

--select *
--from tableA
--cross join tableB

select *
from tableA a
inner join tableB b on a.ID = b.ID 


select *
from tableA a
left join tableB b on a.ID = b.ID 


select *
from tableA a
right join tableB b on b.ID = a.ID

select *
from tableA a
full join tableB b on b.ID = a.ID