use AdventureWorks2019


exec sp_linkedservers




-- TABLA DE INSTANCIA 1 --------------------------------------------------------------------------
-- CUSTOMER------------------------------------------------------------------------
-- Recuperar
select *
from Sales.Customer
go

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
go

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

-- TABLA DE INSTANCIA 2 --------------------------------------------------------------------------
-- [SalesOrderDetail] -------------------------------------------------------------------
select * 
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]

-- Insertar
INSERT INTO SERVIDOR2.SALES.[Sales].[SalesOrderDetail] (SalesOrderID, CarrierTrackingNumber, [OrderQty], [ProductID],
	[SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [ModifiedDate])
VALUES (121318,'fasdfsadfsaf', 3, 743, 1, 20, 0.5, getdate());
go

-- SalesOrderID es el id de venta (uno por cada grupo de productos vendidos).
-- orderdetailID es autoincrementable
-- carrierTrackin a que se refiere?? Puede ser null
-- orderQty, viene de cuantos productos se piden ([produccion].[Product] ()), para ello se debe checar el stock
-- productID, debe existir.
-- special offer id, representa el tipo de oferta. Todos los productos tienen oferta? la respuesta 
	--es que no, los que tienen el 1 no tienen descuento.
-- unit price debe traerse de 
-- unit price discoutn se trae de special offer
-- line total es el resultado de qty*unitprice*(1-unitdiscount)

-- Para saber que existe el producto
select * 
from [produccion].[Product]
where ProductID=776


IF EXISTS (select * from [produccion].[Product] where ProductID = @ProductID )
    PRINT N' existe el producto que solicita';
	-- Actualizar el stock cuando tome productos.
ELSE 
    PRINT N'No existe el producto que solicita'; 

-- Para la cantidad
select SafetyStockLevel 
from [produccion].[Product]

create or alter procedure sp_ActualizarProducto
	@ProductID int, @nuevo_stock int
as begin 
	BEGIN TRY
		BEGIN TRANSACTION

			update [produccion].[Product]
			set [SafetyStockLevel]=@nuevo_stock, ModifiedDate=getdate()
			where ProductID=@ProductID
		
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end
go

exec sp_ActualizarProducto 1,500


-- Para las ofertas
select * 
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]
where ProductID = 1
where CarrierTrackingNumber is null
where UnitPriceDiscount <> 0.00

select * 
from SERVIDOR2.SALES.[Sales].[SpecialOffer]

select *
from [Sales].[SpecialOfferProduct]


select * 
from [produccion].[Product]

select *
from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct]
where ProductID = 680

select *
from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct]
where ProductID = 680

select *
from [Sales].SalesOrderHeader






create or alter procedure sp_InsertarSalesOrderDetail
	@ProductID int, @solicitud_stock int
as begin 
	BEGIN TRY
		BEGIN TRANSACTION

			IF EXISTS (select * from [produccion].[Product] where ProductID = @ProductID )
			BEGIN
				Declare @nuevo_stock int
				set @nuevo_stock = (select [SafetyStockLevel] from [produccion].[Product] where ProductID = @ProductID ) - @solicitud_stock

				IF @nuevo_stock >= 0
				BEGIN
					exec sp_ActualizarProducto @ProductID, @nuevo_stock
					IF EXISTS (select * from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct] where ProductID = @ProductID)
					BEGIN
						declare @tipo_oferta int
						set @tipo_oferta = (select * from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct] where ProductID = @ProductID)


					END
					ELSE
						PRINT N'Esta oferta no existe'; 
				END
				ELSE
					PRINT N'No hay en stock el producto que solicita'; 
			END
			ELSE 
				PRINT N'No existe el producto que solicita'; 	

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end
go

exec sp_InsertarSalesOrderDetail 1,1000



@SalesOrderID int, @CarrierTrackingNumber nvarchar(25), @OrderQty smallint, @ProductID int, @SpecialOfferID int, 
	@UnitPrice money, @UnitPriceDiscount money



			INSERT INTO SERVIDOR2.SALES.[Sales].[SalesOrderDetail] (SalesOrderID,  CarrierTrackingNumber, [OrderQty], [ProductID],
				[SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [ModifiedDate])
			VALUES (@SalesOrderID, @CarrierTrackingNumber, @OrderQty, @ProductID,
				@SpecialOfferID, @UnitPrice, @UnitPriceDiscount, getdate())	

			INSERT INTO SERVIDOR2.SALES.[Sales].[SalesOrderDetail] (SalesOrderID,  CarrierTrackingNumber, [OrderQty], [ProductID],
				[SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [ModifiedDate])
			VALUES (@SalesOrderID, @CarrierTrackingNumber, @OrderQty, @ProductID,
				@SpecialOfferID, @UnitPrice, @UnitPriceDiscount, getdate())	



-- Recuperar
select * 
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]
where UnitPriceDiscount <> 0.00
go

create or alter procedure sp_RecuperarSalesOrderDetail
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
			select * 
			from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]	
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end


-- Actualizar
UPDATE [Sales].[SalesOrderDetail]
set
CarrierTrackingNumber='fasdfsadfsaf', [OrderQty]=3, [UnitPrice]=20, [UnitPriceDiscount]=0.5, 
[ModifiedDate]=getdate()
WHERE  [SalesOrderDetailID]= 16
go

create or alter procedure sp_ActualizarSalesOrderDetail
	@SalesOrderDetailID int, @CarrierTrackingNumber nvarchar(25), @OrderQty smallint, @UnitPrice money, 
	@UnitPriceDiscount money 
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
			
			update
				[Sales].[SalesOrderDetail]
			set  
				CarrierTrackingNumber=@CarrierTrackingNumber, [OrderQty]=@OrderQty, [UnitPrice]=@UnitPrice, 
					[UnitPriceDiscount]=@UnitPriceDiscount, [ModifiedDate]=getdate()
				WHERE [SalesOrderDetailID]= @SalesOrderDetailID;

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end

exec sp_ActualizarSalesOrderDetail 17,'fasdfsadfsaf', 3, 20, 0.5

-- Eliminar
DELETE 
FROM [Sales].[SalesOrderDetail]
WHERE  [SalesOrderDetailID]=121330 
