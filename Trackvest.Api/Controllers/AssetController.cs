using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Trackvest.Api.Models;
using Trackvest.Api.Services;

namespace Trackvest.Api.Controller;

[ApiController]
[Route("[controller]")]
public class AssetController(AssetService assetService) : ControllerBase
{

    [HttpGet]
    [Route("/")]
    public async Task<IActionResult> GetAll(int userId)
    {
        var result = await assetService.GetAllAssets(userId);
        return Ok(result);
    }

    [HttpGet]
    [Route("/{userId:int}/{stockSymbol}")]
    public async Task<IActionResult> GetByUserAndStockSymbol(int userId, string stockSymbol)
    {
        var result = await assetService.GetAssetByUserAndStockSymbol(userId, stockSymbol);
        return Ok(result);
    }

    [HttpPut]
    [Route("/{userId:int}/{assetId:int}")]
    public async Task<IActionResult> Update(int userId, int assetId, [FromBody] Asset asset)
    {
        var result = await assetService.UpdateAsset(userId, assetId, asset);
        return Ok(result);
    }

    [HttpPost]
    [Route("/")]
    public async Task<IActionResult> Create([FromBody] Asset asset)
    {
        if (asset == null)
        {
            return BadRequest("Asset cannot be null");
        }

        var result = await assetService.CreateAsset(asset);
        return CreatedAtAction(nameof(Create),new {id = result.Id}, result);
    }

    // [HttpGet]
    // [Route("{id:int}")]
    // public IActionResult GetById(int id)
    // {
    //     var asset = assetService.GetAllAssets().FirstOrDefault(a => a!.Id == id);
    //     if (asset == null)
    //     {
    //         return NotFound();
    //     }
    //     return Ok(asset);
    // }

    // [HttpPut]
    // [Route("{id:int}")]
    // public IActionResult Update(int id, [FromBody] Asset asset)
    // {
    //     if (asset == null)
    //     {
    //         return BadRequest("Asset cannot be null");
    //     }

    //     var modifiedAsset = assetService.ModifyAsset(id, asset);
    //     return Ok(modifiedAsset);
    // }
    // [HttpDelete]
    // [Route("{id:int}")]
    // public IActionResult Delete(int id)
    // {
    //     var asset = assetService.GetAllAssets().FirstOrDefault(a => a!.Id == id);
    //     if (asset == null)
    //     {
    //         return NotFound();
    //     }

    //     var modifiedAsset = assetService.DeleteAsset(id);
    //     return Ok(modifiedAsset);
    // }
}