using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/reports")]
    [Authorize(Roles = "Admin,Officer")]
    public class ReportsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ReportsController(AppDbContext db) { _db = db; }

        [HttpGet("occupancy")]
        public async Task<IActionResult> Occupancy()
        {
            var rooms = await _db.Phongs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync();
            var total = rooms.Count;
            var occupied = rooms.Count(x => x.TrangThai != "Trống");
            var rate = total == 0 ? 0 : (double)occupied / total;
            return Ok(new { totalRooms = total, occupiedRooms = occupied, occupancyRate = rate });
        }

        [HttpGet("revenue")]
        public async Task<IActionResult> Revenue([FromQuery] int? thang, [FromQuery] int? nam)
        {
            var query = _db.HoaDons.AsNoTracking().Where(x => !x.IsDeleted);
            if (thang.HasValue) query = query.Where(x => x.Thang == thang.Value);
            if (nam.HasValue) query = query.Where(x => x.Nam == nam.Value);
            var revenue = await query.SumAsync(x => x.TongTien);
            return Ok(new { revenue });
        }

        [HttpGet("debts")]
        public async Task<IActionResult> Debts([FromQuery] int? thang, [FromQuery] int? nam)
        {
            var query = _db.HoaDons.AsNoTracking().Where(x => !x.IsDeleted && x.TrangThai == "Chưa thanh toán");
            if (thang.HasValue) query = query.Where(x => x.Thang == thang.Value);
            if (nam.HasValue) query = query.Where(x => x.Nam == nam.Value);
            var totalDebt = await query.SumAsync(x => x.TongTien);
            var countBills = await query.CountAsync();
            return Ok(new { countBills, totalDebt });
        }
    }
}


