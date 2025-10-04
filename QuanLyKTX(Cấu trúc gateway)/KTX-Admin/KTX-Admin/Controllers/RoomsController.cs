using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/rooms")]
[Authorize(Roles = "Admin,Officer")]
    public class RoomsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public RoomsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.Phongs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var item = await _db.Phongs.AsNoTracking().FirstOrDefaultAsync(x => x.MaPhong == id && !x.IsDeleted);
            return item == null ? NotFound() : Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Phong model)
        {
            _db.Phongs.Add(model);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetById), new { id = model.MaPhong }, model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] Phong model)
        {
            var entity = await _db.Phongs.FirstOrDefaultAsync(x => x.MaPhong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.MaToaNha = model.MaToaNha == 0 ? entity.MaToaNha : model.MaToaNha;
            entity.SoPhong = string.IsNullOrEmpty(model.SoPhong) ? entity.SoPhong : model.SoPhong;
            entity.SoGiuong = model.SoGiuong == 0 ? entity.SoGiuong : model.SoGiuong;
            entity.LoaiPhong = string.IsNullOrEmpty(model.LoaiPhong) ? entity.LoaiPhong : model.LoaiPhong;
            entity.GiaPhong = model.GiaPhong == 0 ? entity.GiaPhong : model.GiaPhong;
            entity.MoTa = model.MoTa ?? entity.MoTa;
            entity.TrangThai = string.IsNullOrEmpty(model.TrangThai) ? entity.TrangThai : model.TrangThai;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.Phongs.FirstOrDefaultAsync(x => x.MaPhong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }
    }
}


