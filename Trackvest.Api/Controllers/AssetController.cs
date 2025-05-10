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
    public IActionResult GetAll()
    {
        var result = assetService.GetAllAssets();
        return Ok(result);
    }

    [HttpPost]
    [Route("/")]
    public IActionResult Create([FromBody] Asset asset)
    {
        if (asset == null)
        {
            return BadRequest("Asset cannot be null");
        }

        var result = assetService.CreateAsset(asset);
        return CreatedAtAction(nameof(GetAll), result);
    }
    
}