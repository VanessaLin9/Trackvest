using Dapper;
using System.Data;
using Trackvest.Api.Models;

namespace Trackvest.Api.Repositories;

public class AssetRepository {
    private readonly IDbConnection _db;

    public AssetRepository(IDbConnection db) {
        _db = db;
    }
    
    public async Task<int> InsertAsset(Asset asset) {
        return await _db.ExecuteScalarAsync<int>(
            "InsertAsset_v0_1",
            new {
                asset.StockSymbol,
                asset.StockName,
                asset.StockExchange,
                asset.BuyPrice,
                asset.SellPrice,
                asset.Quantity,
                asset.PurchaseDate,
                asset.SaleDate,
                asset.Notes,
                asset.ExchangeRate,
                asset.UserId,
                asset.AccountId
            },
            commandType: CommandType.StoredProcedure
        );
    }
}

