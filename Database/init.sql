-- Drop existing tables if they exist (in reverse order of dependencies)
IF OBJECT_ID('Assets', 'U') IS NOT NULL
    DROP TABLE Assets;
IF OBJECT_ID('Accounts', 'U') IS NOT NULL
    DROP TABLE Accounts;
IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;

-- Create Users table first (no dependencies)
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(256) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

-- Create Accounts table (depends on Users)
CREATE TABLE Accounts (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

-- Create Assets table (depends on Users and Accounts)
CREATE TABLE Assets (
    Id INT IDENTITY(1,1) PRIMARY KEY,
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
    AccountId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (AccountId) REFERENCES Accounts(Id)
);

-- Add indexes for better query performance
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Accounts_UserId ON Accounts(UserId);
CREATE INDEX IX_Assets_UserId ON Assets(UserId);
CREATE INDEX IX_Assets_AccountId ON Assets(AccountId);
CREATE INDEX IX_Assets_StockSymbol ON Assets(StockSymbol);
