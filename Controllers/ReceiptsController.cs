using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/receipts")]
[Authorize(Roles = "Admin,Officer")]
    public class ReceiptsController : ControllerBase
    {
        private readonly string _connectionString;

        public ReceiptsController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("KTX") ?? throw new ArgumentNullException(nameof(configuration));
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_BienLaiThu_GetAll", connection) { CommandType = CommandType.StoredProcedure };
                using var reader = await command.ExecuteReaderAsync();
                var items = new List<BienLaiThu>();
                while (await reader.ReadAsync())
                {
                    items.Add(new BienLaiThu
                    {
                        MaBienLai = reader.GetInt32("MaBienLai"),
                        MaHoaDon = reader.GetInt32("MaHoaDon"),
                        SoTienThu = reader.GetDecimal("SoTienThu"),
                        NgayThu = reader.GetDateTime("NgayThu"),
                        PhuongThucThanhToan = reader.GetString("PhuongThucThanhToan"),
                        NguoiThu = reader.GetString("NguoiThu"),
                        GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu"),
                        IsDeleted = reader.GetBoolean("IsDeleted"),
                        NgayTao = reader.GetDateTime("NgayTao"),
                        NguoiTao = reader.IsDBNull("NguoiTao") ? null : reader.GetString("NguoiTao"),
                        NgayCapNhat = reader.IsDBNull("NgayCapNhat") ? null : reader.GetDateTime("NgayCapNhat"),
                        NguoiCapNhat = reader.IsDBNull("NguoiCapNhat") ? null : reader.GetString("NguoiCapNhat")
                    });
                }
                return Ok(items);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_BienLaiThu_GetById", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaBienLai", id);
                using var reader = await command.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    var item = new BienLaiThu
                    {
                        MaBienLai = reader.GetInt32("MaBienLai"),
                        MaHoaDon = reader.GetInt32("MaHoaDon"),
                        SoTienThu = reader.GetDecimal("SoTienThu"),
                        NgayThu = reader.GetDateTime("NgayThu"),
                        PhuongThucThanhToan = reader.GetString("PhuongThucThanhToan"),
                        NguoiThu = reader.GetString("NguoiThu"),
                        GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu"),
                        IsDeleted = reader.GetBoolean("IsDeleted"),
                        NgayTao = reader.GetDateTime("NgayTao"),
                        NguoiTao = reader.IsDBNull("NguoiTao") ? null : reader.GetString("NguoiTao"),
                        NgayCapNhat = reader.IsDBNull("NgayCapNhat") ? null : reader.GetDateTime("NgayCapNhat"),
                        NguoiCapNhat = reader.IsDBNull("NguoiCapNhat") ? null : reader.GetString("NguoiCapNhat")
                    };
                    return Ok(item);
                }
                return NotFound();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] BienLaiThu model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_BienLaiThu_Insert", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaHoaDon", model.MaHoaDon);
                command.Parameters.AddWithValue("@SoTienThu", model.SoTienThu);
                command.Parameters.AddWithValue("@NgayThu", model.NgayThu);
                command.Parameters.AddWithValue("@PhuongThucThanhToan", model.PhuongThucThanhToan);
                command.Parameters.AddWithValue("@NguoiThu", model.NguoiThu);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
                command.Parameters.AddWithValue("@NguoiTao", (object?)model.NguoiTao ?? DBNull.Value);
                var newId = await command.ExecuteScalarAsync();
                model.MaBienLai = Convert.ToInt32(newId);
                return CreatedAtAction(nameof(GetById), new { id = model.MaBienLai }, model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] BienLaiThu model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_BienLaiThu_Update", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaBienLai", id);
                command.Parameters.AddWithValue("@MaHoaDon", model.MaHoaDon);
                command.Parameters.AddWithValue("@SoTienThu", model.SoTienThu);
                command.Parameters.AddWithValue("@NgayThu", model.NgayThu);
                command.Parameters.AddWithValue("@PhuongThucThanhToan", model.PhuongThucThanhToan);
                command.Parameters.AddWithValue("@NguoiThu", model.NguoiThu);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
                command.Parameters.AddWithValue("@NguoiCapNhat", (object?)model.NguoiCapNhat ?? DBNull.Value);
                var rows = await command.ExecuteNonQueryAsync();
                if (rows == 0) return NotFound();
            return Ok(model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_BienLaiThu_Delete", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaBienLai", id);
                var rows = await command.ExecuteNonQueryAsync();
                if (rows == 0) return NotFound();
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }
    }
}


