-- First, clean up existing data in reverse order of dependencies
BEGIN TRY
    BEGIN TRANSACTION;

    -- Delete existing data
    DELETE FROM Assets;
    DELETE FROM Accounts;
    DELETE FROM Users;

    -- Reset identity columns
    DBCC CHECKIDENT ('Assets', RESEED, 0);
    DBCC CHECKIDENT ('Accounts', RESEED, 0);
    DBCC CHECKIDENT ('Users', RESEED, 0);

    -- Insert test users
    INSERT INTO Users (Name, Email, Password, CreatedAt, UpdatedAt)
    VALUES 
        ('John Doe', 'john.doe@example.com', 'hashed_password_1', GETDATE(), GETDATE()),
        ('Jane Smith', 'jane.smith@example.com', 'hashed_password_2', GETDATE(), GETDATE()),
        ('Bob Wilson', 'bob.wilson@example.com', 'hashed_password_3', GETDATE(), GETDATE());

    -- Get user IDs for reference
    DECLARE @JohnDoeId INT = (SELECT Id FROM Users WHERE Email = 'john.doe@example.com');
    DECLARE @JaneSmithId INT = (SELECT Id FROM Users WHERE Email = 'jane.smith@example.com');
    DECLARE @BobWilsonId INT = (SELECT Id FROM Users WHERE Email = 'bob.wilson@example.com');

    -- Insert test accounts
    INSERT INTO Accounts (UserId, Name, Description, CreatedAt, UpdatedAt)
    VALUES 
        -- John Doe's accounts
        (@JohnDoeId, 'Main Trading Account', 'Primary trading account for US stocks', GETDATE(), GETDATE()),
        (@JohnDoeId, 'Crypto Portfolio', 'Cryptocurrency investments', GETDATE(), GETDATE()),
        -- Jane Smith's accounts
        (@JaneSmithId, 'Retirement Portfolio', 'Long-term investment account', GETDATE(), GETDATE()),
        (@JaneSmithId, 'Day Trading Account', 'Active trading account', GETDATE(), GETDATE()),
        -- Bob Wilson's account
        (@BobWilsonId, 'Investment Account', 'General investment portfolio', GETDATE(), GETDATE());

    -- Get account IDs for reference
    DECLARE @JohnMainAccountId INT = (SELECT Id FROM Accounts WHERE UserId = @JohnDoeId AND Name = 'Main Trading Account');
    DECLARE @JohnCryptoAccountId INT = (SELECT Id FROM Accounts WHERE UserId = @JohnDoeId AND Name = 'Crypto Portfolio');
    DECLARE @JaneRetirementAccountId INT = (SELECT Id FROM Accounts WHERE UserId = @JaneSmithId AND Name = 'Retirement Portfolio');
    DECLARE @JaneTradingAccountId INT = (SELECT Id FROM Accounts WHERE UserId = @JaneSmithId AND Name = 'Day Trading Account');
    DECLARE @BobAccountId INT = (SELECT Id FROM Accounts WHERE UserId = @BobWilsonId AND Name = 'Investment Account');

    -- Insert test assets
    INSERT INTO Assets (StockSymbol, StockName, StockExchange, BuyPrice, SellPrice, Quantity, PurchaseDate, SaleDate, Notes, CreatedAt, UpdatedAt, ExchangeRate, UserId, AccountId)
    VALUES 
        -- John Doe's assets in Main Trading Account
        ('AAPL', 'Apple Inc.', 'NASDAQ', 150.25, NULL, 10, '2024-01-15', NULL, 'Long-term hold', GETDATE(), GETDATE(), 1.0, @JohnDoeId, @JohnMainAccountId),
        ('MSFT', 'Microsoft Corporation', 'NASDAQ', 280.50, NULL, 5, '2024-02-01', NULL, 'Tech growth stock', GETDATE(), GETDATE(), 1.0, @JohnDoeId, @JohnMainAccountId),
        -- John Doe's crypto assets
        ('BTC', 'Bitcoin', 'CRYPTO', 45000.00, NULL, 0.5, '2024-01-20', NULL, 'Crypto investment', GETDATE(), GETDATE(), 1.0, @JohnDoeId, @JohnCryptoAccountId),
        -- Jane Smith's assets in Retirement Portfolio
        ('VOO', 'Vanguard S&P 500 ETF', 'NYSE', 350.75, NULL, 20, '2024-01-10', NULL, 'Index fund', GETDATE(), GETDATE(), 1.0, @JaneSmithId, @JaneRetirementAccountId),
        ('JNJ', 'Johnson & Johnson', 'NYSE', 155.30, NULL, 15, '2024-02-15', NULL, 'Dividend stock', GETDATE(), GETDATE(), 1.0, @JaneSmithId, @JaneRetirementAccountId),
        -- Jane Smith's day trading assets
        ('TSLA', 'Tesla Inc.', 'NASDAQ', 180.00, 195.50, 5, '2024-02-01', '2024-02-20', 'Quick trade', GETDATE(), GETDATE(), 1.0, @JaneSmithId, @JaneTradingAccountId),
        -- Bob Wilson's assets
        ('GOOGL', 'Alphabet Inc.', 'NASDAQ', 140.25, NULL, 8, '2024-01-25', NULL, 'Tech investment', GETDATE(), GETDATE(), 1.0, @BobWilsonId, @BobAccountId),
        ('AMZN', 'Amazon.com Inc.', 'NASDAQ', 175.50, NULL, 6, '2024-02-10', NULL, 'E-commerce play', GETDATE(), GETDATE(), 1.0, @BobWilsonId, @BobAccountId),
        -- Completed trades
        ('NVDA', 'NVIDIA Corporation', 'NASDAQ', 450.00, 520.00, 2, '2024-01-05', '2024-02-15', 'Profitable trade', GETDATE(), GETDATE(), 1.0, @JohnDoeId, @JohnMainAccountId),
        ('META', 'Meta Platforms Inc.', 'NASDAQ', 300.00, 340.00, 3, '2024-01-20', '2024-02-10', 'Social media play', GETDATE(), GETDATE(), 1.0, @JaneSmithId, @JaneTradingAccountId);

    COMMIT TRANSACTION;
    PRINT 'Seed data inserted successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    PRINT 'Error occurred while inserting seed data:';
    PRINT ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
END CATCH;
