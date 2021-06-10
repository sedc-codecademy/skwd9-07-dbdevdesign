--1--Create database
--create database SEDCclass

--2--Create table
CREATE TABLE dbo.Customer
(
   ID int identity(1,1) NOT NULL,
   Name nvarchar(100) NOT NULL,
   City nvarchar(50) NULL,
   CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED
   (
     [ID] asc
   )
)

--3--Insert into dbo.Customer
INSERT INTO dbo.Customer(Name,City)
VALUES ('Dana Tasevska','Skopje')

INSERT INTO dbo.Customer(Name,City)
VALUES ('Dane Tasevski','Bitola')

--4--Select value from the table
SELECT *
FROM dbo.Customer
WHERE City = 'Bitola'

SELECT Name,City
FROM dbo.Customer
WHERE City='Bitola'

--5--UPDATE value
--1--
UPDATE dbo.Customer
SET City = 'Ohrid'
WHERE id = 2

--2--
UPDATE C
SET City = 'Prilep'
--select *
from dbo.Customer C
where id = 2

--6--DELETE ROW
DELETE FROM dbo.Customer
where id > 2

select *
from dbo.Customer

--7--DROP TABLE
DROP TABLE dbo.Customer

SELECT *
FROM dbo.Customer