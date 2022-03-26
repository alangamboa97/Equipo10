
use AdventureWorks2019

-- CUSTOMER------------------------------------------------------------------------
-- Recuperar
select *
from Sales.Customer

create or alter procedure sp_RecuperarCustomer
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
			select *
			from Sales.Customer				
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end

-- Actualizacion
-- Todas las demas columnas no las deja actualizar.
update Sales.Customer
set PersonID=10, ModifiedDate=GETDATE()
where CustomerID=2


create or alter procedure sp_ActualizarCustomer
	@CustomerID int, @PersonID int
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
			
			update
				Sales.Customer
			set  
				PersonID=@PersonID, ModifiedDate=GETDATE()
					where CustomerID=@CustomerID;

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end

exec sp_ActualizarCustomer 1,15 