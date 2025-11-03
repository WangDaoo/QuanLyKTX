using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Data.SqlClient;
using System.Data;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/reports")]
    [Authorize(Roles = "Admin,Officer")]
    public class ReportsController : ControllerBase
    {
        private readonly string _connectionString;

        public ReportsController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("KTX") ?? throw new ArgumentNullException(nameof(configuration));
        }

        [HttpGet("occupancy-rate")]
        public async Task<IActionResult> GetOccupancyRate([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_BaoCaoTyLeLapDay", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var report = new List<object>();

                while (await reader.ReadAsync())
                {
                    report.Add(new
                    {
                        TenToaNha = reader.GetString("TenToaNha"),
                        TongSoPhong = reader.GetInt32("TongSoPhong"),
                        SoPhongCoNguoi = reader.GetInt32("SoPhongCoNguoi"),
                        TyLeLapDay = reader.GetDecimal("TyLeLapDay")
                    });
                }

                return Ok(report);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("revenue")]
        public async Task<IActionResult> GetRevenueReport([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_BaoCaoDoanhThu", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var report = new List<object>();

                while (await reader.ReadAsync())
                {
                    report.Add(new
                    {
                        Thang = reader.GetInt32("Thang"),
                        Nam = reader.GetInt32("Nam"),
                        TongSoHoaDon = reader.GetInt32("TongSoHoaDon"),
                        TongDoanhThu = reader.GetDecimal("TongDoanhThu"),
                        DaThanhToan = reader.GetDecimal("DaThanhToan"),
                        ChuaThanhToan = reader.GetDecimal("ChuaThanhToan"),
                        QuaHan = reader.GetDecimal("QuaHan")
                    });
                }

                return Ok(report);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("debt")]
        public async Task<IActionResult> GetDebtReport([FromQuery] DateTime? ngayBaoCao = null)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_BaoCaoCongNo", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@NgayBaoCao", ngayBaoCao ?? DateTime.Now);

                using var reader = await command.ExecuteReaderAsync();
                var report = new List<object>();

                while (await reader.ReadAsync())
                {
                    report.Add(new
                    {
                        MSSV = reader.GetString("MSSV"),
                        HoTen = reader.GetString("HoTen"),
                        SDT = reader.IsDBNull("SDT") ? null : reader.GetString("SDT"),
                        Email = reader.IsDBNull("Email") ? null : reader.GetString("Email"),
                        SoPhong = reader.IsDBNull("SoPhong") ? null : reader.GetString("SoPhong"),
                        TenToaNha = reader.IsDBNull("TenToaNha") ? null : reader.GetString("TenToaNha"),
                        SoHoaDonChuaTra = reader.GetInt32("SoHoaDonChuaTra"),
                        TongCongNo = reader.GetDecimal("TongCongNo"),
                        HanThanhToanGanNhat = reader.GetDateTime("HanThanhToanGanNhat"),
                        SoNgayQuaHan = reader.GetInt32("SoNgayQuaHan")
                    });
                }

                return Ok(report);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("electricity-water")]
        public async Task<IActionResult> GetElectricityWaterReport([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_BaoCaoDienNuoc", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var report = new List<object>();

                while (await reader.ReadAsync())
                {
                    report.Add(new
                    {
                        TenToaNha = reader.GetString("TenToaNha"),
                        SoPhong = reader.GetString("SoPhong"),
                        Thang = reader.GetInt32("Thang"),
                        Nam = reader.GetInt32("Nam"),
                        ChiSoDien = reader.GetInt32("ChiSoDien"),
                        ChiSoNuoc = reader.GetInt32("ChiSoNuoc"),
                        ChiSoDienTruoc = reader.IsDBNull("ChiSoDienTruoc") ? (int?)null : reader.GetInt32("ChiSoDienTruoc"),
                        ChiSoNuocTruoc = reader.IsDBNull("ChiSoNuocTruoc") ? (int?)null : reader.GetInt32("ChiSoNuocTruoc"),
                        SoKwhTieuThu = reader.IsDBNull("SoKwhTieuThu") ? (int?)null : reader.GetInt32("SoKwhTieuThu"),
                        SoKhoiNuocTieuThu = reader.IsDBNull("SoKhoiNuocTieuThu") ? (int?)null : reader.GetInt32("SoKhoiNuocTieuThu")
                    });
                }

                return Ok(report);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("violations")]
        public async Task<IActionResult> GetViolationsReport([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_BaoCaoKyLuat", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var report = new List<object>();

                while (await reader.ReadAsync())
                {
                    report.Add(new
                    {
                        MSSV = reader.GetString("MSSV"),
                        HoTen = reader.GetString("HoTen"),
                        SoPhong = reader.IsDBNull("SoPhong") ? null : reader.GetString("SoPhong"),
                        TenToaNha = reader.IsDBNull("TenToaNha") ? null : reader.GetString("TenToaNha"),
                        LoaiViPham = reader.GetString("LoaiViPham"),
                        MoTa = reader.IsDBNull("MoTa") ? null : reader.GetString("MoTa"),
                        NgayViPham = reader.GetDateTime("NgayViPham"),
                        MucPhat = reader.GetDecimal("MucPhat"),
                        TrangThai = reader.GetString("TrangThai")
                    });
                }

                return Ok(report);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("generate-monthly-bills")]
        public async Task<IActionResult> GenerateMonthlyBills([FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_TaoHoaDonHangThang", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);
                command.Parameters.AddWithValue("@NguoiTao", User.Identity?.Name ?? "System");

                using var reader = await command.ExecuteReaderAsync();
                var result = new List<object>();

                while (await reader.ReadAsync())
                {
                    result.Add(new
                    {
                        KetQua = reader.GetString("KetQua")
                    });
                }

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("calculate-electricity")]
        public async Task<IActionResult> CalculateElectricity([FromQuery] int maPhong, [FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_TinhTienDien", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@MaPhong", maPhong);
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var result = new List<object>();

                while (await reader.ReadAsync())
                {
                    result.Add(new
                    {
                        SoKwhTieuThu = reader.GetInt32("SoKwhTieuThu"),
                        TongTienDien = reader.GetDecimal("TongTienDien")
                    });
                }

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("calculate-water")]
        public async Task<IActionResult> CalculateWater([FromQuery] int maPhong, [FromQuery] int thang, [FromQuery] int nam)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_TinhTienNuoc", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@MaPhong", maPhong);
                command.Parameters.AddWithValue("@Thang", thang);
                command.Parameters.AddWithValue("@Nam", nam);

                using var reader = await command.ExecuteReaderAsync();
                var result = new List<object>();

                while (await reader.ReadAsync())
                {
                    result.Add(new
                    {
                        SoKhoiNuocTieuThu = reader.GetInt32("SoKhoiNuocTieuThu"),
                        TongTienNuoc = reader.GetDecimal("TongTienNuoc")
                    });
                }

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }
    }
}












