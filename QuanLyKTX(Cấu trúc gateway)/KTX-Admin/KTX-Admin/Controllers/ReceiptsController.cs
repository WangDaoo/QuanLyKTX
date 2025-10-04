using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/billing/receipts")]
[Authorize(Roles = "Admin,Officer")]
    public class ReceiptsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ReceiptsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.BienLaiThus.AsNoTracking().ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] BienLaiThu model)
        {
            _db.BienLaiThus.Add(model);
            await _db.SaveChangesAsync();
            var bill = await _db.HoaDons.FirstOrDefaultAsync(x => x.MaHoaDon == model.MaHoaDon && !x.IsDeleted);
            if (bill != null)
            {
                bill.TrangThai = "Đã thanh toán";
                bill.NgayThanhToan = model.NgayThu;
                await _db.SaveChangesAsync();
            }
            return Ok(model);
        }
    }
}


