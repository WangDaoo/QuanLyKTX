using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/contracts")]
    [Authorize(Roles = "Admin,Officer")]
    public class ContractsController : ControllerBase
    {
        private readonly string _connectionString;

        public ContractsController(IConfiguration configuration)
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
                using var command = new SqlCommand("sp_HopDong_GetAll", connection) { CommandType = CommandType.StoredProcedure };
                using var reader = await command.ExecuteReaderAsync();
                var items = new List<HopDong>();
                while (await reader.ReadAsync())
                {
                    items.Add(new HopDong
                    {
                        MaHopDong = reader.GetInt32("MaHopDong"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        MaGiuong = reader.GetInt32("MaGiuong"),
                        NgayBatDau = reader.GetDateTime("NgayBatDau"),
                        NgayKetThuc = reader.GetDateTime("NgayKetThuc"),
                        GiaPhong = reader.GetDecimal("GiaPhong"),
                        TrangThai = reader.GetString("TrangThai"),
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
                using var command = new SqlCommand("sp_HopDong_GetById", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaHopDong", id);
                using var reader = await command.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    var item = new HopDong
                    {
                        MaHopDong = reader.GetInt32("MaHopDong"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        MaGiuong = reader.GetInt32("MaGiuong"),
                        NgayBatDau = reader.GetDateTime("NgayBatDau"),
                        NgayKetThuc = reader.GetDateTime("NgayKetThuc"),
                        GiaPhong = reader.GetDecimal("GiaPhong"),
                        TrangThai = reader.GetString("TrangThai"),
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
        public async Task<IActionResult> Create([FromBody] HopDong model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_HopDong_Insert", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@MaGiuong", model.MaGiuong);
                command.Parameters.AddWithValue("@NgayBatDau", model.NgayBatDau);
                command.Parameters.AddWithValue("@NgayKetThuc", model.NgayKetThuc);
                command.Parameters.AddWithValue("@GiaPhong", model.GiaPhong);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
                command.Parameters.AddWithValue("@NguoiTao", (object?)model.NguoiTao ?? DBNull.Value);
                var newId = await command.ExecuteScalarAsync();
                model.MaHopDong = Convert.ToInt32(newId);
                return CreatedAtAction(nameof(GetById), new { id = model.MaHopDong }, model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] HopDong model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_HopDong_Update", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaHopDong", id);
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@MaGiuong", model.MaGiuong);
                command.Parameters.AddWithValue("@NgayBatDau", model.NgayBatDau);
                command.Parameters.AddWithValue("@NgayKetThuc", model.NgayKetThuc);
                command.Parameters.AddWithValue("@GiaPhong", model.GiaPhong);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
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
                using var command = new SqlCommand("sp_HopDong_Delete", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaHopDong", id);
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


