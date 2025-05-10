namespace Trackvest.Api.Models;
public class Asset
{
    public int Id { get; set; }
    public string StockSymbol { get; set; } = string.Empty;
    public string StockName { get; set; } = string.Empty;
    public decimal BuyPrice { get; set; }
    public decimal Quantity { get; set; }
    public DateTime PurchaseDate { get; set; }
    public string? Note { get; set; }
}