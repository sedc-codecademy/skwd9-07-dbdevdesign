--drop table dbo.[Log]

CREATE OR ALTER PROCEDURE usp_ExampleProc3 
AS
BEGIN
	BEGIN TRY
		SELECT 1/0; 
	END TRY
	BEGIN CATCH
		INSERT into dbo.[Log] (ErrorProcedure, ErrorLine, ErrorMessage, dateLogged)
		select			
			 ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE()      AS ErrorLine  
			,ERROR_MESSAGE()   AS ErrorMessage
			,getdate() as dateLogged
		END CATCH;
END



exec usp_ExampleProc3 


