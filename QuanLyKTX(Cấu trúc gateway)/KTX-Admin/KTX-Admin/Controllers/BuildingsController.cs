using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/buildings")]
[Authorize(Roles = "Admin,Officer")]
    public class BuildingsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public BuildingsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.ToaNhas.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var item = await _db.ToaNhas.AsNoTracking().FirstOrDefaultAsync(x => x.MaToaNha == id && !x.IsDeleted);
            return item == null ? NotFound() : Ok(item);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] ToaNha model)
        {
            _db.ToaNhas.Add(model);
            await _db.SaveChangesAsync();
            return CreatedAtAction(nameof(GetById), new { id = model.MaToaNha }, model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] ToaNha model)
        {
            var entity = await _db.ToaNhas.FirstOrDefaultAsync(x => x.MaToaNha == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.TenToaNha = string.IsNullOrEmpty(model.TenToaNha) ? entity.TenToaNha : model.TenToaNha;
            entity.DiaChi = model.DiaChi ?? entity.DiaChi;
            entity.SoTang = model.SoTang ?? entity.SoTang;
            entity.MoTa = model.MoTa ?? entity.MoTa;
            entity.TrangThai = model.TrangThai;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.ToaNhas.FirstOrDefaultAsync(x => x.MaToaNha == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }
    }
}


