CREATE OR ALTER PROCEDURE UpdateAsset_v0_1
    @UserId INT,
    @AssetId INT,
    @StockSymbol NVARCHAR(10),
    @StockName NVARCHAR(100),
    @StockExchange NVARCHAR(10),
    @BuyPrice DECIMAL(18, 2),
    @SellPrice DECIMAL(18, 2),
    @Quantity INT,
    @PurchaseDate DATETIME,
    @SaleDate DATETIME,
    @Notes NVARCHAR(MAX),
    @ExchangeRate DECIMAL(18, 2)
AS
BEGIN
    UPDATE Assets
    SET StockSymbol = @StockSymbol,
        StockName = @StockName,
        StockExchange = @StockExchange,
        BuyPrice = @BuyPrice,
        SellPrice = @SellPrice,
        Quantity = @Quantity,
        PurchaseDate = @PurchaseDate,
        SaleDate = @SaleDate,
        Notes = @Notes,
        ExchangeRate = @ExchangeRate
    WHERE Id = @AssetId
        AND UserId = @UserId;
            SELECT * FROM Assets
    WHERE Id = @AssetId
        AND UserId = @UserId;
END