namespace Trackvest.Api.Services;
using Trackvest.Api.Models;

public class AssetService
{
    private List<Asset?> _assets =
    [
        new()
        {
            Id = 1,
            StockSymbol = "AAPL",
            StockName = "Apple Inc.",
            BuyPrice = 150.00m,
            Quantity = 10,
            PurchaseDate = new DateTime(2023, 1, 1),
            Note = "First purchase"
        },
        new()
        {
            Id = 2,
            StockSymbol = "GOOGL",
            StockName = "Alphabet Inc.",
            BuyPrice = 2800.00m,
            Quantity = 5,
            PurchaseDate = new DateTime(2023, 2, 1),
            Note = "Long-term investment"
        }
    ];

    public List<Asset?> GetAllAssets() => _assets;

    public Asset CreateAsset(Asset asset)
    {
        asset.Id = _assets.Count + 1;
        _assets.Add(asset);
        return asset;
    }

    public Asset ModifyAsset(int id, Asset asset)
    {
        var existingAsset = _assets.FirstOrDefault(a => a!.Id == id);
        if (existingAsset != null)
        {
            existingAsset.StockSymbol = asset.StockSymbol;
            existingAsset.StockName = asset.StockName;
            existingAsset.BuyPrice = asset.BuyPrice;
            existingAsset.Quantity = asset.Quantity;
            existingAsset.PurchaseDate = asset.PurchaseDate;
            existingAsset.Note = asset.Note;
        }
        return existingAsset!;
    }
    public List<Asset> DeleteAsset(int id)
    {
        var asset = _assets.FirstOrDefault(a => a!.Id == id);
        if (asset != null)
        {
            _assets.Remove(asset);
        }
        return _assets!;
    }
}