using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/registration")] 
    [Authorize(Roles = "Admin,Officer")]
    public class RegistrationController : ControllerBase
    {
        private readonly AppDbContext _db;
        public RegistrationController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.DonDangKys.AsNoTracking().ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] DonDangKy model)
        {
            _db.DonDangKys.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPost("approve/{id:int}")]
        public async Task<IActionResult> Approve(int id)
        {
            var don = await _db.DonDangKys.FirstOrDefaultAsync(x => x.MaDon == id);
            if (don == null) return NotFound();

            // tạo hợp đồng tối thiểu và cập nhật trạng thái phòng/giường (đơn giản hóa: chỉ cập nhật phòng là Đã ở)
            var room = don.MaPhongDeXuat.HasValue ? await _db.Phongs.FirstOrDefaultAsync(x => x.MaPhong == don.MaPhongDeXuat.Value) : null;
            if (room != null)
            {
                room.TrangThai = "Đã ở";
            }

            var contract = new HopDong
            {
                MaSinhVien = don.MaSinhVien,
                MaGiuong = 0,
                NgayBatDau = DateTime.UtcNow.Date,
                NgayKetThuc = DateTime.UtcNow.Date.AddMonths(6),
                GiaPhong = room?.GiaPhong ?? 0,
                TrangThai = "Hiệu lực",
                GhiChu = null,
                IsDeleted = false
            };
            _db.HopDongs.Add(contract);

            don.TrangThai = "DaDuyet";
            don.NgayCapNhat = DateTime.UtcNow;
            await _db.SaveChangesAsync();
            return Ok(new { don, contract });
        }

        [HttpPost("reject/{id:int}")]
        public async Task<IActionResult> Reject(int id, [FromBody] string lyDo)
        {
            var don = await _db.DonDangKys.FirstOrDefaultAsync(x => x.MaDon == id);
            if (don == null) return NotFound();
            don.TrangThai = "TuChoi";
            don.LyDo = lyDo;
            don.NgayCapNhat = DateTime.UtcNow;
            await _db.SaveChangesAsync();
            return Ok(don);
        }
    }
}


