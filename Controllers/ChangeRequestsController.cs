using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/change-requests")] 
    [Authorize(Roles = "Admin,Officer")]
    public class ChangeRequestsController : ControllerBase
    {
        private readonly string _connectionString;

        public ChangeRequestsController(IConfiguration configuration)
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
                using var command = new SqlCommand("sp_YeuCauChuyenPhong_GetAll", connection) { CommandType = CommandType.StoredProcedure };
                using var reader = await command.ExecuteReaderAsync();
                var items = new List<YeuCauChuyenPhong>();
                while (await reader.ReadAsync())
                {
                    items.Add(new YeuCauChuyenPhong
                    {
                        MaYeuCau = reader.GetInt32("MaYeuCau"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        PhongHienTai = reader.GetInt32("PhongHienTai"),
                        PhongMongMuon = reader.GetInt32("PhongMongMuon"),
                        LyDo = reader.GetString("LyDo"),
                        NgayYeuCau = reader.GetDateTime("NgayYeuCau"),
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
                using var command = new SqlCommand("sp_YeuCauChuyenPhong_GetById", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaYeuCau", id);
                using var reader = await command.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    var item = new YeuCauChuyenPhong
                    {
                        MaYeuCau = reader.GetInt32("MaYeuCau"),
                        MaSinhVien = reader.GetInt32("MaSinhVien"),
                        PhongHienTai = reader.GetInt32("PhongHienTai"),
                        PhongMongMuon = reader.GetInt32("PhongMongMuon"),
                        LyDo = reader.GetString("LyDo"),
                        NgayYeuCau = reader.GetDateTime("NgayYeuCau"),
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
        public async Task<IActionResult> Create([FromBody] YeuCauChuyenPhong model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_YeuCauChuyenPhong_Insert", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@PhongHienTai", model.PhongHienTai);
                command.Parameters.AddWithValue("@PhongMongMuon", model.PhongMongMuon);
                command.Parameters.AddWithValue("@LyDo", model.LyDo);
                command.Parameters.AddWithValue("@NgayYeuCau", model.NgayYeuCau);
                command.Parameters.AddWithValue("@TrangThai", model.TrangThai);
                command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
                var newId = await command.ExecuteScalarAsync();
                model.MaYeuCau = Convert.ToInt32(newId);
                return CreatedAtAction(nameof(GetById), new { id = model.MaYeuCau }, model);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPut("{id:int}")]
        public async Task<IActionResult> Update(int id, [FromBody] YeuCauChuyenPhong model)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();
                using var command = new SqlCommand("sp_YeuCauChuyenPhong_Update", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaYeuCau", id);
                command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
                command.Parameters.AddWithValue("@PhongHienTai", model.PhongHienTai);
                command.Parameters.AddWithValue("@PhongMongMuon", model.PhongMongMuon);
                command.Parameters.AddWithValue("@LyDo", model.LyDo);
                command.Parameters.AddWithValue("@NgayYeuCau", model.NgayYeuCau);
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
                using var command = new SqlCommand("sp_YeuCauChuyenPhong_Delete", connection) { CommandType = CommandType.StoredProcedure };
                command.Parameters.AddWithValue("@MaYeuCau", id);
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


