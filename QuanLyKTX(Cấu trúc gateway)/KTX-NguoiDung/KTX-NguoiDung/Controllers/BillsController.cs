using Microsoft.AspNetCore.Mvc;
using KTX_NguoiDung.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_NguoiDung.Controllers
{
    [ApiController]
    [Route("api/bills")]
    [Authorize(Roles = "Student")]
    public class BillsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public BillsController(AppDbContext db) { _db = db; }

        [HttpGet("my")]
        public async Task<IActionResult> My()
        {
            var userId = User.Identity?.Name ?? "0";
            if (!int.TryParse(userId, out var maSV)) maSV = 0;
            var items = await _db.HoaDons.AsNoTracking().Where(x => x.MaSinhVien == maSV && !x.IsDeleted).ToListAsync();
            return Ok(items);
        }
    }
}


