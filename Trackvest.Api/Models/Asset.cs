namespace Trackvest.Api.Models;
public class Asset
{
    public int Id { get; set; }
    public string StockSymbol { get; set; } = string.Empty;
    public string StockName { get; set; } = string.Empty;
    public string? StockExchange { get; set; } = string.Empty;
    public decimal? BuyPrice { get; set; }
    public decimal? SellPrice { get; set; }
    public decimal Quantity { get; set; }
    public DateTime? PurchaseDate { get; set; }
    public DateTime? SaleDate { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
    public decimal? ExchangeRate { get; set; }
    public int UserId { get; set; }
    public int AccountId { get; set; }
}