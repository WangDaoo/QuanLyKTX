using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/violations")]
    [Authorize(Roles = "Admin,Officer")]
    public class ViolationsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ViolationsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.KyLuats.AsNoTracking().ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] KyLuat model)
        {
            _db.KyLuats.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpGet("discipline-scores")]
        public async Task<IActionResult> GetScores()
            => Ok(await _db.DiemRenLuyens.AsNoTracking().ToListAsync());

        [HttpPost("discipline-scores")]
        public async Task<IActionResult> CreateScore([FromBody] DiemRenLuyen model)
        {
            _db.DiemRenLuyens.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }
    }
}


