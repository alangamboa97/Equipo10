select *
 from Sales.SpecialOffer
 Go

--READ-----------

 create or alter procedure sp_ReadSpecialOffer
 as begin 
		BEGIN TRY
				BEGIN TRANSACTION
								select SpecialOfferID, Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty, ModifiedDate
								from Sales.SpecialOffer
				COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
				ROLLBACK TRANSACTION
				RAISERROR('No se pudo realizar la accion',16,1)
		END CATCH
end

---UPDATE---------

go
create or alter procedure sp_UpdateSpecialOffer
		@SpecialOfferID int, @Description nvarchar(255), @DiscountPct smallmoney, @Type nvarchar(255), @Category nvarchar(50), @MinQty int, @MaxQty int
as begin
		BEGIN TRY
				BEGIN TRANSACTION

				update
						Sales.SpecialOffer
				set Description=@Description, DiscountPct = @DiscountPct, Type = @Type, Category = @Category, MinQty = @MinQty, MaxQty = @MaxQty
						where @SpecialOfferID = @SpecialOfferID
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			RAISERROR('No se pudo realizar la accion',16,1)
			END CATCH
end

