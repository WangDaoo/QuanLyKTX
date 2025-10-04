using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/fees")]
[Authorize(Roles = "Admin")]
    public class FeesController : ControllerBase
    {
        private readonly AppDbContext _db;
        public FeesController(AppDbContext db) { _db = db; }

        [HttpGet("muc-phi")]
        public async Task<IActionResult> GetMucPhi()
            => Ok(await _db.MucPhis.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpGet("bac-gia")]
        public async Task<IActionResult> GetBacGia()
            => Ok(await _db.BacGias.AsNoTracking().ToListAsync());

        [HttpGet("cau-hinh-toi-thieu")]
        public async Task<IActionResult> GetCauHinhToiThieu()
            => Ok(await _db.CauHinhPhis.AsNoTracking().ToListAsync());

        [HttpPost("muc-phi")]
        public async Task<IActionResult> CreateMucPhi([FromBody] MucPhi model)
        {
            _db.MucPhis.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPut("muc-phi/{id:int}")]
        public async Task<IActionResult> UpdateMucPhi(int id, [FromBody] MucPhi model)
        {
            var entity = await _db.MucPhis.FirstOrDefaultAsync(x => x.MaMucPhi == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.TenMucPhi = string.IsNullOrEmpty(model.TenMucPhi) ? entity.TenMucPhi : model.TenMucPhi;
            entity.LoaiMucPhi = model.LoaiMucPhi ?? entity.LoaiMucPhi;
            entity.DonGia = model.DonGia == 0 ? entity.DonGia : model.DonGia;
            entity.DonViTinh = model.DonViTinh ?? entity.DonViTinh;
            entity.HieuLucTu = model.HieuLucTu ?? entity.HieuLucTu;
            entity.HieuLucDen = model.HieuLucDen ?? entity.HieuLucDen;
            entity.TrangThai = model.TrangThai;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("muc-phi/{id:int}")]
        public async Task<IActionResult> DeleteMucPhi(int id)
        {
            var entity = await _db.MucPhis.FirstOrDefaultAsync(x => x.MaMucPhi == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("bac-gia")]
        public async Task<IActionResult> CreateBacGia([FromBody] BacGia model)
        {
            _db.BacGias.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPut("bac-gia/{id:int}")]
        public async Task<IActionResult> UpdateBacGia(int id, [FromBody] BacGia model)
        {
            var entity = await _db.BacGias.FirstOrDefaultAsync(x => x.MaBac == id);
            if (entity == null) return NotFound();
            entity.Loai = string.IsNullOrEmpty(model.Loai) ? entity.Loai : model.Loai;
            entity.ThuTu = model.ThuTu == 0 ? entity.ThuTu : model.ThuTu;
            entity.TuSo = model.TuSo ?? entity.TuSo;
            entity.DenSo = model.DenSo ?? entity.DenSo;
            entity.DonGia = model.DonGia == 0 ? entity.DonGia : model.DonGia;
            entity.TrangThai = model.TrangThai;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("bac-gia/{id:int}")]
        public async Task<IActionResult> DeleteBacGia(int id)
        {
            var entity = await _db.BacGias.FirstOrDefaultAsync(x => x.MaBac == id);
            if (entity == null) return NotFound();
            _db.BacGias.Remove(entity);
            await _db.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("cau-hinh-toi-thieu")]
        public async Task<IActionResult> CreateCauHinh([FromBody] CauHinhPhi model)
        {
            _db.CauHinhPhis.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPut("cau-hinh-toi-thieu/{id:int}")]
        public async Task<IActionResult> UpdateCauHinh(int id, [FromBody] CauHinhPhi model)
        {
            var entity = await _db.CauHinhPhis.FirstOrDefaultAsync(x => x.MaCauHinh == id);
            if (entity == null) return NotFound();
            entity.Loai = string.IsNullOrEmpty(model.Loai) ? entity.Loai : model.Loai;
            entity.MucToiThieu = model.MucToiThieu == 0 ? entity.MucToiThieu : model.MucToiThieu;
            entity.TrangThai = model.TrangThai;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("cau-hinh-toi-thieu/{id:int}")]
        public async Task<IActionResult> DeleteCauHinh(int id)
        {
            var entity = await _db.CauHinhPhis.FirstOrDefaultAsync(x => x.MaCauHinh == id);
            if (entity == null) return NotFound();
            _db.CauHinhPhis.Remove(entity);
            await _db.SaveChangesAsync();
            return Ok();
        }
    }
}


