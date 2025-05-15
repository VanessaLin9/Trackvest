CREATE OR ALTER PROCEDURE InsertAsset_0.1
    @Id INT IDENTITY(1,1) PRIMARY KEY,
    @StockSymbol NVARCHAR(10),
    @StockName NVARCHAR(100),
    @StockExchange NVARCHAR(10),
    @BuyPrice DECIMAL(18,4),
    @SellPrice DECIMAL(18,4),
    @Quantity INT,
    @PurchaseDate DATETIME,
    @SaleDate DATETIME,
    @Notes NVARCHAR(MAX),
    @ExchangeRate DECIMAL(18,4) ,
    @UserId INT,
    @AccountId INT
AS
BEGIN
    INSERT INTO Assets (
        StockSymbol, 
        StockName, 
        StockExchange, 
        BuyPrice, 
        SellPrice, 
        Quantity, 
        PurchaseDate, 
        SaleDate, 
        Notes, 
        ExchangeRate, 
        UserId, 
        AccountId,
        CreatedAt,
        UpdatedAt
    ) VALUES (
        @StockSymbol, 
        @StockName, 
        @StockExchange, 
        @BuyPrice, 
        @SellPrice, 
        @Quantity, 
        @PurchaseDate, 
        @SaleDate, 
        @Notes, 
        @ExchangeRate, 
        @UserId, 
        @AccountId,
        GETDATE(),
        GETDATE()
    );

     SELECT CAST(SCOPE_IDENTITY() AS INT);
END


