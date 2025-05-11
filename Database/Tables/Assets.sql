CREATE TABLE Assets (
    id INT IDENTITY(1,1) PRIMARY KEY,
    StockSymbol NVARCHAR(10) NOT NULL,
    StockName NVARCHAR(100) NOT NULL,
    StockExchange NVARCHAR(10) NOT NULL,
    BuyPrice DECIMAL(18,4) NULL,
    SellPrice DECIMAL(18,4) NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    PurchaseDate DATETIME NULL,
    SaleDate DATETIME NULL,
    Notes NVARCHAR(MAX) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    ExchangeRate DECIMAL(18,4) NULL,
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    AccountId INT NOT NULL,
    FOREIGN KEY (AccountId) REFERENCES Accounts(Id)
);

