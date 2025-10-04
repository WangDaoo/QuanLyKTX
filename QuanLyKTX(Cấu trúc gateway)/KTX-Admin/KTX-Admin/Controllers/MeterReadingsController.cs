using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using ExcelDataReader;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/meter-readings")]
    [Authorize(Roles = "Admin,Officer")]
    public class MeterReadingsController : ControllerBase
    {
        private readonly AppDbContext _db;
        public MeterReadingsController(AppDbContext db) { _db = db; }

        [HttpGet]
        public async Task<IActionResult> GetAll()
            => Ok(await _db.ChiSoDienNuocs.AsNoTracking().Where(x => !x.IsDeleted).ToListAsync());

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] ChiSoDienNuoc model)
        {
            _db.ChiSoDienNuocs.Add(model);
            await _db.SaveChangesAsync();
            return Ok(model);
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] ChiSoDienNuoc model)
        {
            var entity = await _db.ChiSoDienNuocs.FirstOrDefaultAsync(x => x.MaChiSo == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.DienCu = model.DienCu;
            entity.DienMoi = model.DienMoi;
            entity.NuocCu = model.NuocCu;
            entity.NuocMoi = model.NuocMoi;
            entity.NgayGhi = model.NgayGhi ?? entity.NgayGhi;
            entity.GhiChu = model.GhiChu ?? entity.GhiChu;
            await _db.SaveChangesAsync();
            return Ok(entity);
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var entity = await _db.ChiSoDienNuocs.FirstOrDefaultAsync(x => x.MaChiSo == id && !x.IsDeleted);
            if (entity == null) return NotFound();
            entity.IsDeleted = true;
            await _db.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("import-excel")]
        public async Task<IActionResult> ImportExcel(IFormFile file, [FromQuery] int thang, [FromQuery] int nam)
        {
            if (file == null || file.Length == 0) return BadRequest("File rỗng");
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

            int imported = 0;
            using (var stream = file.OpenReadStream())
            using (var reader = ExcelReaderFactory.CreateReader(stream))
            {
                do
                {
                    // Giả sử header: MaPhong | DienCu | DienMoi | NuocCu | NuocMoi | NgayGhi(optional)
                    bool isHeader = true;
                    while (reader.Read())
                    {
                        if (isHeader) { isHeader = false; continue; }
                        if (reader.FieldCount < 5) continue;

                        var maPhongStr = reader.GetValue(0)?.ToString();
                        if (!int.TryParse(maPhongStr, out var maPhong)) continue;

                        int dienCu = ParseInt(reader.GetValue(1));
                        int dienMoi = ParseInt(reader.GetValue(2));
                        int nuocCu = ParseInt(reader.GetValue(3));
                        int nuocMoi = ParseInt(reader.GetValue(4));
                        DateTime? ngayGhi = ParseDate(reader.FieldCount > 5 ? reader.GetValue(5) : null);

                        var entity = await _db.ChiSoDienNuocs.FirstOrDefaultAsync(x => x.MaPhong == maPhong && x.Thang == thang && x.Nam == nam && !x.IsDeleted);
                        if (entity == null)
                        {
                            entity = new ChiSoDienNuoc
                            {
                                MaPhong = maPhong, Thang = thang, Nam = nam,
                                DienCu = dienCu, DienMoi = dienMoi,
                                NuocCu = nuocCu, NuocMoi = nuocMoi,
                                NgayGhi = ngayGhi, IsDeleted = false
                            };
                            _db.ChiSoDienNuocs.Add(entity);
                        }
                        else
                        {
                            entity.DienCu = dienCu;
                            entity.DienMoi = dienMoi;
                            entity.NuocCu = nuocCu;
                            entity.NuocMoi = nuocMoi;
                            entity.NgayGhi = ngayGhi ?? entity.NgayGhi;
                        }
                        imported++;
                    }
                } while (reader.NextResult());
            }
            await _db.SaveChangesAsync();
            return Ok(new { imported });
        }

        private static int ParseInt(object? o)
        {
            if (o == null) return 0;
            var s = o.ToString();
            return int.TryParse(s, out var v) ? v : 0;
        }

        private static DateTime? ParseDate(object? o)
        {
            if (o == null) return null;
            if (o is DateTime dt) return dt;
            var s = o.ToString();
            if (DateTime.TryParse(s, out var v)) return v;
            return null;
        }
    }
}


