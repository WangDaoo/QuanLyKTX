using Microsoft.AspNetCore.Mvc;
using KTX_NguoiDung.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace KTX_NguoiDung.Controllers
{
    [ApiController]
    [Route("api/contracts")]
    [Authorize(Roles = "Student")]
    public class ContractsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ContractsController(AppDbContext db) { _db = db; }

        [HttpGet("my")]
        public async Task<IActionResult> My()
        {
            var userId = User.Identity?.Name ?? "0";
            if (!int.TryParse(userId, out var maSV)) maSV = 0; // demo lấy từ Name
            var items = await _db.HopDongs.AsNoTracking().Where(x => x.MaSinhVien == maSV && !x.IsDeleted).ToListAsync();
            return Ok(items);
        }
    }
}


