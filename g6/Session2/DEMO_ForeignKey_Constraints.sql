select *
from BusinessEntity
where id = 10

select *
from [Order]
where ID = 4203


select * from Customer

insert into [Order](OrderDate, Status, BusinessEntityId, CustomerId, TotalPrice)
values ('2021-06-12', 1, 6, 100, 500)


alter table [Order] with check
add constraint fk_BusinessEntity FOREIGN KEY (BusinessEntityID) 
REFERENCES BusinessEntity (ID)

alter table [Order] with check
add constraint fk_Customer FOREIGN KEY (CustomerID) 
REFERENCES Customer (ID)