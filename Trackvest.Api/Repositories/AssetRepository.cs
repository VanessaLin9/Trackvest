using Dapper;
using System.Data;
using Trackvest.Api.Models;

public class AssetRepository {
    private readonly IDbConnection _db;

    public AssetRepository(IDbConnection db) {
        _db = db;
    }
    
}

