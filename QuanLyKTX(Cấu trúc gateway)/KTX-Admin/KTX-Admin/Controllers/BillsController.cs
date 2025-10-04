using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/billing/bills")]
[Authorize(Roles = "Admin,Officer")]
    public class BillsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public BillsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.HoaDons.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] HoaDon model)
        {
            _db.HoaDons.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] HoaDon model)
        {
            var entity = await _db.HoaDons.FirstOrDefaultAsync(x => x.MaHoaDon == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.TongTien = model.TongTien == 0 ? entity.TongTien : model.TongTien;
            entity.TrangThai = string.IsNullOrEmpty(model.TrangThai) ? entity.TrangThai : model.TrangThai;
            entity.NgayThanhToan = model.NgayThanhToan ?? entity.NgayThanhToan;
            entity.GhiChu = model.GhiChu ?? entity.GhiChu;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.HoaDons.FirstOrDefaultAsync(x => x.MaHoaDon == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("generate-monthly")]
        public async Task<IActionResult> GenerateMonthly([FromQuery] int thang, [FromQuery] int nam)
        {
            var rooms = await _db.Phongs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync();
            var readings = await _db.ChiSoDienNuocs.AsNoTracking().Where(x => x.Thang == thang && x.Nam == nam && !x.IsDeleted).ToListAsync();
            var bacDien = await _db.BacGias.AsNoTracking().Where(x => x.Loai == "Dien" && x.TrangThai).OrderBy(x => x.ThuTu).ToListAsync();
            var bacNuoc = await _db.BacGias.AsNoTracking().Where(x => x.Loai == "Nuoc" && x.TrangThai).OrderBy(x => x.ThuTu).ToListAsync();
            var minDien = await _db.CauHinhPhis.AsNoTracking().FirstOrDefaultAsync(x => x.Loai == "Dien" && x.TrangThai);
            var minNuoc = await _db.CauHinhPhis.AsNoTracking().FirstOrDefaultAsync(x => x.Loai == "Nuoc" && x.TrangThai);

            int generated = 0;

            foreach (var r in rooms)
            {
                var rd = readings.FirstOrDefault(x => x.MaPhong == r.MaPhong);
                if (rd == null) continue;

                int soDien = Math.Max(0, rd.DienMoi - rd.DienCu);
                int soNuoc = Math.Max(0, rd.NuocMoi - rd.NuocCu);

                decimal tienDien = TinhTheoBac(soDien, bacDien);
                decimal tienNuoc = TinhTheoBac(soNuoc, bacNuoc);

                if (minDien != null && tienDien < minDien.MucToiThieu) tienDien = minDien.MucToiThieu;
                if (minNuoc != null && tienNuoc < minNuoc.MucToiThieu) tienNuoc = minNuoc.MucToiThieu;

                decimal tong = r.GiaPhong + tienDien + tienNuoc;

                var bill = new HoaDon
                {
                    MaSinhVien = 0,
                    MaPhong = r.MaPhong,
                    MaHopDong = null,
                    Thang = thang,
                    Nam = nam,
                    TongTien = tong,
                    TrangThai = "Chưa thanh toán",
                    NgayHetHan = new DateTime(nam, thang, DateTime.DaysInMonth(nam, thang)).AddDays(7),
                    GhiChu = null,
                    IsDeleted = false
                };
                _db.HoaDons.Add(bill);
                generated++;
            }
            await _db.SaveChangesAsync();
            return Ok(new { generated });
        }

        private static decimal TinhTheoBac(int soLuong, List<BacGia> bacList)
        {
            decimal tong = 0;
            int conLai = soLuong;
            foreach (var b in bacList)
            {
                int tu = b.TuSo ?? 0;
                int den = b.DenSo ?? int.MaxValue;
                int trongBac = 0;
                if (conLai <= 0) break;
                if (soLuong <= tu) continue;
                int upper = Math.Min(soLuong, den);
                trongBac = Math.Max(0, upper - tu);
                trongBac = Math.Min(trongBac, conLai);
                tong += trongBac * b.DonGia;
                conLai -= trongBac;
            }
            return tong;
        }
    }
}


