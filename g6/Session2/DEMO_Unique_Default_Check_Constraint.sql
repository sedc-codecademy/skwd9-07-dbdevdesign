--Change Products table always to insert value 1 
--in price column if no price is provided on insert
--Change Products table to prevent inserting Price that will more than 2x bigger then the cost price
--Change Products table to guarantee unique codes across the products




select *
from Product


insert into Product(Code, [Name], Price, Cost)
values('angelaaa', 'blabla2', 10, 50)


alter table Product
add constraint df_price default 1 for Price

alter table Product with check
add constraint chk_price check (Price <= 5 * Cost)


alter table Product
add constraint uq_code unique (Code)