using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/billing/overdue")]
    [Authorize]
    public class OverdueController : ControllerBase
    {
        private readonly AppDbContext _db;
        public OverdueController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.ThongBaoQuaHans.AsNoTracking().ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] ThongBaoQuaHan model)
        {
            _db.ThongBaoQuaHans.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPost("generate")]
        public async Task<IActionResult> Generate()
        {
            var today = DateTime.UtcNow.Date;
            var overdueBills = await _db.HoaDons.AsNoTracking()
                .Where(x => !x.IsDeleted && x.TrangThai == "Chưa thanh toán" && x.NgayHetHan.Date < today)
                .ToListAsync();
            int created = 0;
            foreach (var b in overdueBills)
            {
                _db.ThongBaoQuaHans.Add(new ThongBaoQuaHan
                {
                    MaHoaDon = b.MaHoaDon,
                    NgayHetHan = b.NgayHetHan,
                    HinhThuc = "Notice",
                    NoiDung = $"Hoa don {b.MaHoaDon} qua han"
                });
                created++;
            }
            await _db.SaveChangesAsync();
            return Ok(new { created });
        }
    }
}


