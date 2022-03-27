use AdventureWorks2019

-- CUSTOMER------------------------------------------------------------------------
-- Recuperar
/*
select *
from Sales.Customer
Go

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
*/
/*
GO
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
*/
-------------------------- SalesOrderHeader --------------------------------------------------
-------- READ--------------------
 select *
 from Sales.SalesOrderHeader
 Go

 create or alter procedure sp_RecuperarSalesOrderHeader
 as begin 
		BEGIN TRY
				BEGIN TRANSACTION
								select SalesOrderID, CustomerID, SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID, ShipMethodID, CreditCardID, rowguid
								from Sales.SalesOrderHeader
				COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
				ROLLBACK TRANSACTION
				RAISERROR('No se pudo realizar la accion',16,1)
		END CATCH
end

---UPDATE---------
update Sales.SalesOrderHeader
set CustomerID=5
where SalesOrderID = 2

Go
create or alter procedure sp_ActualizarSalesOrderHeader
		@CustomerID int, @SalesOrderID int
as begin
		BEGIN TRY
				BEGIN TRANSACTION

				update
						Sales.SalesOrderHeader
				set CustomerID=@CustomerID
						where @SalesOrderID = @SalesOrderID;
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			RAISERROR('No se pudo realizar la accion',16,1)
			END CATCH
end

exec sp_ActualizarSalesOrderHeader 1,15

-------------- CREATE-----------
select*
from Sales.SalesOrderHeader
Go 
create or alter procedure sp_InsertarSalesOrderHeader
@SalesOrderID int, @CustomerID int, @SalesPersonID int, @TerritoryID int, @BillToAddressID int, @ShipToAddressID int, @ShipMethodID int, @CreditCardID int
as begin
		BEGIN TRY
				BEGIN TRANSACTION
							INSERT INTO Sales.SalesOrderHeader(SalesOrderID,CustomerID, SalesPersonID,TerritoryID, BillToAddressID, ShipToAddressID,ShipMethodID, CreditCardID)
							VALUES(@SalesOrderID, @CustomerID, @SalesPersonID, @TerritoryID, @BillToAddressID, @ShipToAddressID, @ShipMethodID, @CreditCardID)
				COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
				ROLLBACK TRANSACTION
				RAISERROR('No se pudo realizar la accion', 16,1)
		END CATCH
end


-------------DELETE----------
Select*
from Sales.SalesOrderHeader
Go
create or alter procedure sp_InsertarSalesOrderHeader
@SalesOrderID int
as begin	
			BEGIN TRY
					BEGIN TRANSACTION
						DELETE FROM Sales.SalesOrderHeader 
						WHERE SalesOrderID = @SalesOrderID
					COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
					ROLLBACK TRANSACTION
					RAISERROR('No se puedo realizar la elminiacion',16,1)
			END CATCH

end

