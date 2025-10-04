using Microsoft.AspNetCore.Mvc;
using KTX_NguoiDung.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_NguoiDung.Controllers
{
    [ApiController]
    [Route("api/receipts")] 
    [Authorize(Roles = "Student")]
    public class ReceiptsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ReceiptsController(AppDbContext db) { _db = db; }

        [HttpGet("my")]
        public async Task<IActionResult> My()
        {
            var userId = User.Identity?.Name ?? "0";
            if (!int.TryParse(userId, out var maSV)) maSV = 0;

            var bills = await _db.HoaDons.AsNoTracking().Where(x => x.MaSinhVien == maSV && !x.IsDeleted).Select(x => x.MaHoaDon).ToListAsync();
            var receipts = await _db.BienLaiThus.AsNoTracking().Where(x => bills.Contains(x.MaHoaDon)).ToListAsync();
            return Ok(receipts);
        }
    }
}


