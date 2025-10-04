using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/change-requests")] 
    [Authorize(Roles = "Admin,Officer")]
    public class ChangeRequestsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ChangeRequestsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.YeuCauChuyenPhongs.AsNoTracking().ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] YeuCauChuyenPhong model)
        {
            _db.YeuCauChuyenPhongs.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPost("approve/{id:int}")]
        public async Task<IActionResult> Approve(int id)
        {
            var req = await _db.YeuCauChuyenPhongs.FirstOrDefaultAsync(x => x.MaYeuCau == id);
            if (req == null) return NotFound();

            var oldRoom = await _db.Phongs.FirstOrDefaultAsync(x => x.MaPhong == req.MaPhongCu);
            var newRoom = await _db.Phongs.FirstOrDefaultAsync(x => x.MaPhong == req.MaPhongMoi);
            if (oldRoom != null) oldRoom.TrangThai = "Trống";
            if (newRoom != null) newRoom.TrangThai = "Đã ở";

            req.TrangThai = "DaDuyet";
            req.NgayCapNhat = DateTime.UtcNow;
            await _db.SaveChangesAsync();
            return Ok(req);
        }

        [HttpPost("reject/{id:int}")]
        public async Task<IActionResult> Reject(int id, [FromBody] string lyDo)
        {
            var req = await _db.YeuCauChuyenPhongs.FirstOrDefaultAsync(x => x.MaYeuCau == id);
            if (req == null) return NotFound();
            req.TrangThai = "TuChoi";
            req.LyDo = lyDo;
            req.NgayCapNhat = DateTime.UtcNow;
            await _db.SaveChangesAsync();
            return Ok(req);
        }
    }
}


