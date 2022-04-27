use AdventureWorks2019
go

exec sp_linkedservers


-- TABLA DE INSTANCIA 1 --------------------------------------------------------------------------
-- CUSTOMER------------------------------------------------------------------------
-- Recuperar
select *
from SERVIDOR2.SALES.[Sales].[Customer]
go

create or alter procedure sp_RecuperarCustomer
as begin 
	
	BEGIN TRY
		BEGIN TRANSACTION
			select *
			from SERVIDOR2.SALES.[Sales].[Customer]		
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH

end

-- Actualizacion
-- Todas las demas columnas no las deja actualizar.
update SERVIDOR2.SALES.[Sales].[Customer]
set PersonID=10, ModifiedDate=GETDATE()
where CustomerID=2
go

create or alter procedure sp_ActualizarCustomer
	@CustomerID int, @PersonID int
as begin 
	
	BEGIN TRY
		BEGIN TRANSACTION
			
			update
				SERVIDOR2.SALES.[Sales].[Customer]
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
use AdventureWorks2019
go

-- [SalesOrderDetail] -------------------------------------------------------------------
select * 
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]

-- INSERTAR
INSERT INTO SERVIDOR2.SALES.[Sales].[SalesOrderDetail] (SalesOrderID, CarrierTrackingNumber, [OrderQty], [ProductID],
	[SpecialOfferID], [UnitPrice], [UnitPriceDiscount], [ModifiedDate])
VALUES (121318,'fasdfsadfsaf', 3, 743, 1, 20, 0.5, getdate());
go

-- SalesOrderID: es el id de venta (uno por cada grupo de productos vendidos).
-- orderdetailID: es autoincrementable
-- carrierTrackin: a que se refiere?? Todo el grupo de una venta tiene el mismo.
-- orderQty: cuantos productos se piden ([produccion].[Product] ()), para ello se debe checar el stock
-- productID: debe existir.
-- specialofferid: representa el tipo de oferta. Todos los productos tienen oferta? la respuesta 
	--es que no, los que tienen el 1 no tienen descuento. Pero hay unos que no estan en la tabla
	-- pe product 1, 2, 3, 4 (que significa?).
-- unitprice: debe traerse de product (campo Listprice)
-- unitpricediscoutn: se trae de special offer
-- linetotal: resultado de qty*unitprice*(1-unitdiscount)
-- rowguid: Se trae de algun lado o solo son caracteres random(?)

-- Otras tablas involucradas:
	-- SpecialOfferProduct: Tipo de ofertas
	-- SpecialOffer: Tipo de descuento con base al tipo de oferta.
	-- Product: Informacion de los productos: costo del producto (StandardCost), saber si 
		-- existe (mediante el id), saber si hay en existencia/stock (mediante campo 
		-- SafetyStockLevel).


-- Para saber que existe el producto
select * 
from [produccion].[Product]
where ProductID=514

IF EXISTS (select * from [produccion].[Product] where ProductID = @ProductID )
    PRINT N' existe el producto que solicita';
	-- Actualizar el stock cuando tome productos.
ELSE 
    PRINT N'No existe el producto que solicita'; 


-- Actualizar el stock
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
from [produccion].[Product]

select *
from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct]
where ProductID = 1

select *
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]
where ProductID = 1

select * from openquery(MYSQL,'select * from AdventureWorks2019.product')


-- Validar existencia, cantidad stock y existencia de oferta
-- falta poner los openquery
create or alter procedure sp_ValidarInserccionSalesOrderDetail
	@ProductID int, @solicitud_stock int
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
		
			IF EXISTS (select * from [produccion].[Product] where ProductID = @ProductID)
			BEGIN
				Declare @nuevo_stock int
				set @nuevo_stock = (select [SafetyStockLevel] from [produccion].[Product] where ProductID = @ProductID ) - @solicitud_stock

				IF @nuevo_stock >= 0
				BEGIN
					
					exec sp_ActualizarProducto @ProductID, @nuevo_stock
					select 1

				END
				ELSE
				BEGIN
					PRINT N'No hay la cantidad de stock del producto que solicita';
					select -1
				END
			END
			ELSE 
			BEGIN
				PRINT N'No existe el producto que solicita';
				select 0
			END

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end
go

select *
from produccion.Product
where ProductID = 860

exec sp_ValidarInserccionSalesOrderDetail 3,10


-- Insertar 
-- Faltan los openquery
create or alter procedure sp_InsertarSalesOrderDetail
	@SalesOrderID int, @ProductID int, @cantidad int
as begin 
	BEGIN TRY
		BEGIN TRANSACTION
			IF EXISTS (select * from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct] where ProductID = @ProductID)
					BEGIN
						-- insertarlo pero aplicando su respectivo descuento.
					Declare @tipo_oferta int
					set @tipo_oferta = (select SpecialOfferID from  SERVIDOR2.SALES.[Sales].[SpecialOfferProduct] 
															   where ProductID = @ProductID)

					Declare @precio money
					set @precio = (select ListPrice from produccion.Product
								   where ProductID = @ProductID)

					Declare @descuento int
					set @descuento = (select DiscountPct from  SERVIDOR2.SALES.[Sales].[SpecialOffer]
										where SpecialOfferID = @tipo_oferta )
										
					Declare @total int
					set @total = @cantidad*@precio*(1-@descuento)
					
					INSERT INTO SERVIDOR2.SALES.[Sales].[SalesOrderDetail] (SalesOrderID, [OrderQty], [ProductID],
						[SpecialOfferID], [UnitPrice], UnitPriceDiscount, [LineTotal], rowguid, ModifiedDate)
					VALUES (@SalesOrderID, @cantidad, @ProductID, @tipo_oferta, @precio, @descuento, @total, 'ADDF-45484-SEREF-45684',getdate());	

					END
			ELSE
					BEGIN
						PRINT N'Esta producto no tiene algun tipo de oferta'; 
						-- insertarlo normal pero poniendo specialOfferID igual a 1
					
					END
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end
go


select *
from [produccion].[Product]
where ProductID = 797

select *
from SERVIDOR2.SALES.[Sales].[SalesOrderDetail]

exec sp_InsertarSalesOrderDetail 15,797,10








-- RECUPERAR
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


-- ACTUALIZAR
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




create or alter procedure sp_Test
as begin 
	
	BEGIN TRY
		BEGIN TRANSACTION
			
			select * from openquery(MYSQL,'select * from AdventureWorks2019.product')

		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH   
		ROLLBACK TRANSACTION   
		RAISERROR ('No se pudo realizar la accion',16,1)  
	END CATCH
end
go

exec sp_Test 