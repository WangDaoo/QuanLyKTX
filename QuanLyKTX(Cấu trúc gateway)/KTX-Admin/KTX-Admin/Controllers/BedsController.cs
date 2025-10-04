using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/beds")]
[Authorize(Roles = "Admin,Officer")]
    public class BedsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public BedsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.Giuongs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var item = await _db.Giuongs.AsNoTracking().FirstOrDefaultAsync(x => x.MaGiuong == id && !x.IsDeleted);
            return item == null ? NotFound() : Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Giuong model)
        {
            _db.Giuongs.Add(model);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetById), new { id = model.MaGiuong }, model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] Giuong model)
        {
            var entity = await _db.Giuongs.FirstOrDefaultAsync(x => x.MaGiuong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.MaPhong = model.MaPhong == 0 ? entity.MaPhong : model.MaPhong;
            entity.SoGiuong = string.IsNullOrEmpty(model.SoGiuong) ? entity.SoGiuong : model.SoGiuong;
            entity.TrangThai = string.IsNullOrEmpty(model.TrangThai) ? entity.TrangThai : model.TrangThai;
            entity.GhiChu = model.GhiChu ?? entity.GhiChu;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.Giuongs.FirstOrDefaultAsync(x => x.MaGiuong == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }
    }
}


