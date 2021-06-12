CREATE TABLE Customers(
	ID INT NOT NULL,
	Customer_Name NVARCHAR(50),
	City NVARCHAR(30),
	Num_Employees INT,
	CONSTRAINT PK_ID PRIMARY KEY (ID)
)



CREATE TABLE Products(
	ID INT IDENTITY(1,1) NOT NULL,
	Product_Name NVARCHAR(50) NOT NULL,
	Price DECIMAL(18,6) NULL,
	CONSTRAINT PK_Product_ID PRIMARY KEY (ID)
)



SELECT Customer_Name, ID
FROM Customers


SELECT *
FROM Products

INSERT INTO Products(Product_Name, Price)
VALUES ('telefon', 50.5),
	('slusalki', 15.5),
	('polnac', 15.5)


DELETE
FROM Products
WHERE Product_Name = 'telefon' AND ID = 2



UPDATE Products 
SET Price = 30
WHERE Product_Name = 'telefon'


UPDATE p
SET Price = 30
FROM Products p
WHERE Product_Name = 'telefon'



SET IDENTITY_INSERT Products ON

INSERT INTO Products(ID, Product_Name, Price)
VALUES (2, 'cd', 10)

SET IDENTITY_INSERT Products OFF