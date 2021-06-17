
USE SEDCHome

create table Price 
(	
	Id				int identity(1,1) not null,
	[Name]			nvarchar(100) not null,
	ProductID		int not null,
	SalesManId		int not null,
	Value			decimal(18,2) null,
	SalesDate		date not null,
	CreatedDate		datetime not null,
	CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED
	( 
		ID ASC
	)
)
--select * from Price
create table Product 
(	
	Id int IDENTITY(1,1) not null,
	Name nvarchar(50) not null
	CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
	( 
		ID ASC
	)
)

create table SalesMan 
(	
	Id int IDENTITY(1,1) not null,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50)
	CONSTRAINT [PK_SalesMan] PRIMARY KEY CLUSTERED
	( 
		ID ASC
	)
)

ALTER TABLE dbo.Price ADD CONSTRAINT FK_Price_SalesMan
FOREIGN KEY (SalesManID) REFERENCES dbo.SalesMan (Id)

ALTER TABLE dbo.Price ADD CONSTRAINT FK_Price_Product
FOREIGN KEY (ProductID) REFERENCES dbo.Product (Id)

ALTER TABLE dbo.Price ADD CONSTRAINT DF_Price_CreatedDate
default getdate() for CreatedDate