USE [SEDCHome]
GO

INSERT INTO [dbo].[SalesMan]
           ([FirstName]
           ,[LastName])
     VALUES
           ('Edi', 'Jasharovski'), ('Marjan', 'Pushev'), ('Blagoj', 'Kostovski')
INSERT INTO [dbo].[Product]
           ([Name])
VALUES ('Product1'), ('Product2'), ('Product3')
select * from dbo.SalesMan
select * from dbo.Product

INSERT INTO [dbo].[Price]
           ([Name]
           ,[ProductID]
           ,[SalesManId]
           ,[Value]
           ,[SalesDate])
     VALUES
           ('Test'
           ,1
           ,1
           ,NULL
           ,'20200601'
)

INSERT INTO [dbo].[Price]
           ([Name]
           ,[ProductID]
           ,[SalesManId]
           ,[Value]
           ,[SalesDate])
select 
		SalesMan.FirstName + ' ' + Product.Name
	,	product.ID as ProductID 
	,	SalesMan.ID as SalesManID
	,	100
	,	dateadd(day, -7, getdate())
from SalesMan
cross join product


CREATE OR ALTER FUNCTION dbo.SalesManName (@SalesManID int)
RETURNS nvarchar(200)
AS
BEGIN
	declare @output nvarchar(200)
	select @output = FirstName + ' - ' + LastName from dbo.SalesMan
	WHERE ID = @SalesManID
	RETURN 
	@Output
END
GO

select *, dbo.SalesManName(SalesManID) as SalesManName from dbo.Price

