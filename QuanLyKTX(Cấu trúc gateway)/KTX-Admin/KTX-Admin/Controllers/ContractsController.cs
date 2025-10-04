using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/contracts")] 
    [Authorize(Roles = "Admin,Officer")]
    public class ContractsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public ContractsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.HopDongs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var item = await _db.HopDongs.AsNoTracking().FirstOrDefaultAsync(x => x.MaHopDong == id && !x.IsDeleted);
            return item == null ? NotFound() : Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] HopDong model)
        {
            _db.HopDongs.Add(model);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetById), new { id = model.MaHopDong }, model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] HopDong model)
        {
            var entity = await _db.HopDongs.FirstOrDefaultAsync(x => x.MaHopDong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.MaSinhVien = model.MaSinhVien == 0 ? entity.MaSinhVien : model.MaSinhVien;
            entity.MaGiuong = model.MaGiuong == 0 ? entity.MaGiuong : model.MaGiuong;
            entity.NgayBatDau = model.NgayBatDau == default ? entity.NgayBatDau : model.NgayBatDau;
            entity.NgayKetThuc = model.NgayKetThuc == default ? entity.NgayKetThuc : model.NgayKetThuc;
            entity.GiaPhong = model.GiaPhong == 0 ? entity.GiaPhong : model.GiaPhong;
            entity.TrangThai = string.IsNullOrEmpty(model.TrangThai) ? entity.TrangThai : model.TrangThai;
            entity.GhiChu = model.GhiChu ?? entity.GhiChu;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.HopDongs.FirstOrDefaultAsync(x => x.MaHopDong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }
    }
}


