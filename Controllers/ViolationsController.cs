using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/violations")]
    [Authorize(Roles = "Admin,Officer")]
    public class ViolationsController : ControllerBase
    {
        private readonly string _connectionString;

        public ViolationsController(IConfiguration configuration)
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
                using var command = new SqlCommand("sp_KyLuat_GetAll", connection) { CommandType = CommandType.StoredProcedure };
                using var reader = await command.ExecuteReaderAsync();
                var items = new List<KyLuat>();
                while (await reader.ReadAsync())
                {
                    items.Add(new KyLuat
                    {
                        MaKyLuat = reader.GetInt32("MaKyLuat"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        LoaiViPham = reader.GetString("LoaiViPham"),
                        MoTa = reader.GetString("MoTa"),
                        NgayViPham = reader.GetDateTime("NgayViPham"),
                        MucPhat = reader.GetDecimal("MucPhat"),
                        TrangThai = reader.GetString("TrangThai"),
                        GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu"),
                        IsDeleted = reader.GetBoolean("IsDeleted")
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
                using var command = new SqlCommand("sp_KyLuat_GetById", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaKyLuat", id);
                using var reader = await command.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    var item = new KyLuat
                    {
                        MaKyLuat = reader.GetInt32("MaKyLuat"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        LoaiViPham = reader.GetString("LoaiViPham"),
                        MoTa = reader.GetString("MoTa"),
                        NgayViPham = reader.GetDateTime("NgayViPham"),
                        MucPhat = reader.GetDecimal("MucPhat"),
                        TrangThai = reader.GetString("TrangThai"),
                        GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu"),
                        IsDeleted = reader.GetBoolean("IsDeleted")
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
        public async Task<IActionResult> Create([FromBody] KyLuat model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_KyLuat_Insert", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@LoaiViPham", model.LoaiViPham);
                command.Parameters.AddWithValue("@MoTa", model.MoTa);
                command.Parameters.AddWithValue("@NgayViPham", model.NgayViPham);
                command.Parameters.AddWithValue("@MucPhat", model.MucPhat);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
                var newId = await command.ExecuteScalarAsync();
                model.MaKyLuat = Convert.ToInt32(newId);
                return CreatedAtAction(nameof(GetById), new { id = model.MaKyLuat }, model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] KyLuat model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_KyLuat_Update", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaKyLuat", id);
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@LoaiViPham", model.LoaiViPham);
                command.Parameters.AddWithValue("@MoTa", model.MoTa);
                command.Parameters.AddWithValue("@NgayViPham", model.NgayViPham);
                command.Parameters.AddWithValue("@MucPhat", model.MucPhat);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
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
                using var command = new SqlCommand("sp_KyLuat_Delete", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaKyLuat", id);
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


