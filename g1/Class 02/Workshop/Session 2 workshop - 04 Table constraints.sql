/*

Change Products table always to insert value 1 in price column if no price is provided on insert
Change Products table to prevent inserting Price that will more than 2x bigger then the cost price
Change Products table to guarantee unique names across the products

*/


--  select * from [dbo].[Product]

ALTER TABLE Product
ADD CONSTRAINT DF_Product_Price
DEFAULT 1 FOR [Price]
GO


ALTER TABLE [dbo].[Product] WITH CHECK
ADD CONSTRAINT CHK_Products_Price
CHECK (price<=Cost*2);
GO



-- This will fail due to duplicates (remove all duplicates)
ALTER TABLE [dbo].[Product] WITH CHECK
ADD CONSTRAINT UC_Product_Name UNIQUE (Name)
GO


select * from [dbo].[Product]
where name = 'Gluten Free'
Order by [Name]

update p set Name = 'Gluten Free New'
from dbo.Product p
where name = 'Gluten Free'
and id = 12
GO


ALTER TABLE [dbo].[Product] WITH CHECK
ADD CONSTRAINT UC_Product_Name UNIQUE (Name)
GO

