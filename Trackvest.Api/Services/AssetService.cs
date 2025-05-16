namespace Trackvest.Api.Services;
using Trackvest.Api.Models;
using Trackvest.Api.Repositories;
public class AssetService
{
    private readonly AssetRepository _assetRepository;

    public AssetService(AssetRepository assetRepository)
    {
        _assetRepository = assetRepository;
    }
    
    public async Task<List<Asset?>> GetAllAssets(int userId) {
        return await _assetRepository.GetAllAssets(userId);
    }

    public async Task<Asset?> GetAssetByUserAndStockSymbol(int userId, string stockSymbol) {
        var userAllStock = await _assetRepository.GetAllAssets(userId);
        return userAllStock.FirstOrDefault(a => a!.StockSymbol == stockSymbol);
    }

    public async Task<Asset?> UpdateAsset(int userId, int assetId, Asset asset) {
        var userAllStock = await _assetRepository.GetAllAssets(userId);
        var userStock = userAllStock.FirstOrDefault(a => a!.Id == assetId);
        if (userStock == null) {
            return null;
        }
        asset.Id = userStock.Id;
        asset.UserId = userId;
        return await _assetRepository.UpdateAsset(asset);
    }

    public async Task<Asset> CreateAsset(Asset asset)
    {
        var id = await _assetRepository.InsertAsset(asset);
        asset.Id = id;
        return asset;
    }

    // public Asset ModifyAsset(int id, Asset asset)
    // {
    //     var existingAsset = _assets.FirstOrDefault(a => a!.Id == id);
    //     if (existingAsset != null)
    //     {
    //         existingAsset.StockSymbol = asset.StockSymbol;
    //         existingAsset.StockName = asset.StockName;
    //         existingAsset.BuyPrice = asset.BuyPrice;
    //         existingAsset.Quantity = asset.Quantity;
    //         existingAsset.PurchaseDate = asset.PurchaseDate;
    //         existingAsset.Note = asset.Note;
    //     }
    //     return existingAsset!;
    // }
    // public List<Asset> DeleteAsset(int id)
    // {
    //     var asset = _assets.FirstOrDefault(a => a!.Id == id);
    //     if (asset != null)
    //     {
    //         _assets.Remove(asset);
    //     }
    //     return _assets!;
    // }
}