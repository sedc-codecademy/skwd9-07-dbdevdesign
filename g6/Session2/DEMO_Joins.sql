create table tableA(
ID INT
)

create table tableB(
ID INT
)


select * from tableA

select * from tableB

insert into tableA(ID)
values (1), (2), (3), (4)

insert into tableB(ID)
values (1), (2), (3), (5), (6)


--cross join

select *
from tableA
cross join tableB


--inner join

select a.ID as A_ID, b.ID as B_ID
from tableA a
inner join tableB b on a.ID = b.ID


select b.ID, b.Name, o.*
from BusinessEntity b
inner join [Order] o on b.ID = o.BusinessEntityId
where b.ID = 4


--left join

select *
from tableA a
left join tableB b on a.ID = b.ID
where b.ID IS NOT NULL