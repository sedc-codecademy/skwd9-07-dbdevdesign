CREATE PROCEDURE dbo.TestProcedure (
    @param1 int = 1,
	@param2 int = 2)
AS

BEGIN
       
	   PRINT 'First Parameter'
	   PRINT @param1
	   PRINT 'Second Parameter'
	   PRINT @param2

END
--1--
exec dbo.TestProcedure
--2--
exec dbo.TestProcedure 5,7
--3--
declare @p1 int
set @p1 = 5

declare @p2 int
set @p2 = 9

exec dbo.TestProcedure @p1,@p2