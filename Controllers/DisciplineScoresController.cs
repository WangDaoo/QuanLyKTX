using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
	[ApiController]
	[Route("api/discipline-scores")]
	[Authorize(Roles = "Admin,Officer")]
	public class DisciplineScoresController : ControllerBase
	{
		private readonly string _connectionString;

		public DisciplineScoresController(IConfiguration configuration)
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

				using var command = new SqlCommand("sp_DiemRenLuyen_GetAll", connection)
				{
					CommandType = CommandType.StoredProcedure
				};

				using var reader = await command.ExecuteReaderAsync();
				var scores = new List<DiemRenLuyen>();

				while (await reader.ReadAsync())
				{
					scores.Add(new DiemRenLuyen
					{
						MaDiem = reader.GetInt32("MaDiem"),
						MaSinhVien = reader.GetInt32("MaSinhVien"),
						Thang = reader.GetInt32("Thang"),
						Nam = reader.GetInt32("Nam"),
						DiemSo = reader.GetDecimal("DiemRenLuyen"),
						GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu")
					});
				}

				return Ok(scores);
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

				using var command = new SqlCommand("sp_DiemRenLuyen_GetById", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				command.Parameters.AddWithValue("@MaDiem", id);

				using var reader = await command.ExecuteReaderAsync();
				if (await reader.ReadAsync())
				{
					var score = new DiemRenLuyen
					{
						MaDiem = reader.GetInt32("MaDiem"),
						MaSinhVien = reader.GetInt32("MaSinhVien"),
						Thang = reader.GetInt32("Thang"),
						Nam = reader.GetInt32("Nam"),
						DiemSo = reader.GetDecimal("DiemRenLuyen"),
						GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu")
					};
					return Ok(score);
				}
				return NotFound();
			}
			catch (Exception ex)
			{
				return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
			}
		}

		[HttpGet("by-student/{studentId:int}")]
		public async Task<IActionResult> GetByStudent(int studentId)
		{
			try
			{
				using var connection = new SqlConnection(_connectionString);
				await connection.OpenAsync();

				using var command = new SqlCommand("sp_DiemRenLuyen_GetBySinhVien", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				command.Parameters.AddWithValue("@MaSinhVien", studentId);

				using var reader = await command.ExecuteReaderAsync();
				var scores = new List<DiemRenLuyen>();

				while (await reader.ReadAsync())
				{
					scores.Add(new DiemRenLuyen
					{
						MaDiem = reader.GetInt32("MaDiem"),
						MaSinhVien = reader.GetInt32("MaSinhVien"),
						Thang = reader.GetInt32("Thang"),
						Nam = reader.GetInt32("Nam"),
						DiemSo = reader.GetDecimal("DiemRenLuyen"),
						GhiChu = reader.IsDBNull("GhiChu") ? null : reader.GetString("GhiChu")
					});
				}

				return Ok(scores);
			}
			catch (Exception ex)
			{
				return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
			}
		}

		[HttpPost]
		public async Task<IActionResult> Create([FromBody] DiemRenLuyen model)
		{
			try
			{
				using var connection = new SqlConnection(_connectionString);
				await connection.OpenAsync();

				using var command = new SqlCommand("sp_DiemRenLuyen_Insert", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
				command.Parameters.AddWithValue("@Thang", model.Thang);
				command.Parameters.AddWithValue("@Nam", model.Nam);
				command.Parameters.AddWithValue("@DiemRenLuyen", model.DiemSo);
				command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
				command.Parameters.AddWithValue("@NguoiTao", (object?)model.NguoiTao ?? DBNull.Value);

				var newId = await command.ExecuteScalarAsync();
				model.MaDiem = Convert.ToInt32(newId);

				return CreatedAtAction(nameof(GetById), new { id = model.MaDiem }, model);
			}
			catch (Exception ex)
			{
				return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
			}
		}

		[HttpPut("{id:int}")]
		public async Task<IActionResult> Update(int id, [FromBody] DiemRenLuyen model)
		{
			try
			{
				using var connection = new SqlConnection(_connectionString);
				await connection.OpenAsync();

				using var command = new SqlCommand("sp_DiemRenLuyen_Update", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				command.Parameters.AddWithValue("@MaDiem", id);
				command.Parameters.AddWithValue("@MaSinhVien", model.MaSinhVien);
				command.Parameters.AddWithValue("@Thang", model.Thang);
				command.Parameters.AddWithValue("@Nam", model.Nam);
				command.Parameters.AddWithValue("@DiemRenLuyen", model.DiemSo);
				command.Parameters.AddWithValue("@GhiChu", (object?)model.GhiChu ?? DBNull.Value);
				command.Parameters.AddWithValue("@NguoiCapNhat", (object?)model.NguoiCapNhat ?? DBNull.Value);

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

				using var command = new SqlCommand("sp_DiemRenLuyen_Delete", connection)
				{
					CommandType = CommandType.StoredProcedure
				};
				command.Parameters.AddWithValue("@MaDiem", id);

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
	}
}
