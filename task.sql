-- Use our database
USE ShopDB; 

-- Some data should be created outside the transaction (here)

-- Start the transaction 
START TRANSACTION; 

-- And some data should be created inside the transaction
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

SET @OrderID = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, ProductID, count)
VALUES (@OrderID, 1, 1);

UPDATE Products SET WarehouseAmount= WarehouseAmount -1 WHERE ID = 1;
SELECT WarehouseAmount INTO @StockCheck FROM Products WHERE ID = 1;
IF @StockCheck >= 0 THEN
    COMMIT;
ELSE
    ROLLBACK;
END IF;