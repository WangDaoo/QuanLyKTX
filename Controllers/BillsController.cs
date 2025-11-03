using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/bills")]
    [Authorize(Roles = "Admin,Officer")]
    public class BillsController : ControllerBase
    {
        private readonly string _connectionString;

        public BillsController(IConfiguration configuration)
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

                using var command = new SqlCommand("sp_HoaDon_GetAll", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                using var reader = await command.ExecuteReaderAsync();
                var bills = new List<HoaDon>();

                while (await reader.ReadAsync())
                {
                    bills.Add(new HoaDon
                    {
                        MaHoaDon = reader.GetInt32("MaHoaDon"),
                        MaSinhVien = reader.IsDBNull("MaSinhVien") ? null : reader.GetInt32("MaSinhVien"),
                        MaPhong = reader.IsDBNull("MaPhong") ? null : reader.GetInt32("MaPhong"),
                        MaHopDong = reader.IsDBNull("MaHopDong") ? null : reader.GetInt32("MaHopDong"),
                        Thang = reader.GetInt32("Thang"),
                        Nam = reader.GetInt32("Nam"),
                        TongTien = reader.GetDecimal("TongTien"),
                        TrangThai = reader.GetString("TrangThai"),
                        NgayTao = reader.GetDateTime("NgayTao"),
                        NgayHetHan = reader.IsDBNull("NgayHetHan") ? null : reader.GetDateTime("NgayHetHan"),
                        NgayThanhToan = reader.IsDBNull("NgayThanhToan") ? null : reader.GetDateTime("NgayThanhToan"),
                        GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu"),
                        IsDeleted = reader.GetBoolean("IsDeleted")
                    });
                }

                return Ok(bills);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] HoaDon model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_HoaDon_Insert", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@MaSinhVien", (object?)model.MaSinhVien ?? DBNull.Value);
                command.Parameters.AddWithValue("@MaPhong", (object?)model.MaPhong ?? DBNull.Value);
                command.Parameters.AddWithValue("@MaHopDong", (object?)model.MaHopDong ?? DBNull.Value);
                command.Parameters.AddWithValue("@Thang", model.Thang);
                command.Parameters.AddWithValue("@Nam", model.Nam);
                command.Parameters.AddWithValue("@TongTien", model.TongTien);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@NgayHetHan", (object?)model.NgayHetHan ?? DBNull.Value);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);

                var newId = await command.ExecuteScalarAsync();
                model.MaHoaDon = Convert.ToInt32(newId);

                return Ok(model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] HoaDon model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_HoaDon_Update", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@MaHoaDon", id);
                command.Parameters.AddWithValue("@MaSinhVien", (object?)model.MaSinhVien ?? DBNull.Value);
                command.Parameters.AddWithValue("@MaPhong", (object?)model.MaPhong ?? DBNull.Value);
                command.Parameters.AddWithValue("@MaHopDong", (object?)model.MaHopDong ?? DBNull.Value);
                command.Parameters.AddWithValue("@Thang", model.Thang);
                command.Parameters.AddWithValue("@Nam", model.Nam);
                command.Parameters.AddWithValue("@TongTien", model.TongTien);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@NgayHetHan", (object?)model.NgayHetHan ?? DBNull.Value);
                command.Parameters.AddWithValue("@NgayThanhToan", (object?)model.NgayThanhToan ?? DBNull.Value);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);

                var rowsAffected = await command.ExecuteNonQueryAsync();
                if (rowsAffected == 0)
                    return NotFound();

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

                using var command = new SqlCommand("sp_HoaDon_Delete", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@MaHoaDon", id);

                var rowsAffected = await command.ExecuteNonQueryAsync();
                if (rowsAffected == 0)
                    return NotFound();

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("generate-monthly")]
        public async Task<IActionResult> GenerateMonthly([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_HoaDon_GenerateMonthly", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                var result = await command.ExecuteScalarAsync();
                var generated = Convert.ToInt32(result);

                return Ok(new { generated });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }
    }
}

