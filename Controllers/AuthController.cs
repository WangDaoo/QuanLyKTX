using Microsoft.AspNetCore.Mvc;
using KTX_Admin.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using BCrypt.Net;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly string _connectionString;
        private readonly IConfiguration _configuration;

        public AuthController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("KTX") ?? throw new ArgumentNullException(nameof(configuration));
            _configuration = configuration;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("SELECT * FROM TaiKhoan WHERE TenDangNhap = @TenDangNhap AND IsDeleted = 0", connection);
                command.Parameters.AddWithValue("@TenDangNhap", request.TenDangNhap);

                using var reader = await command.ExecuteReaderAsync();
                if (!await reader.ReadAsync())
                    return Unauthorized(new { success = false, message = "Tên đăng nhập hoặc mật khẩu không đúng" });

                var maTaiKhoan = reader.GetInt32("MaTaiKhoan");
                var tenDangNhap = reader.GetString("TenDangNhap");
                var hoTen = reader.GetString("HoTen");
                var email = reader.IsDBNull("Email") ? null : reader.GetString("Email");
                var vaiTro = reader.GetString("VaiTro");
                var trangThai = reader.GetBoolean("TrangThai");
                var maSinhVienDb = reader.IsDBNull("MaSinhVien") ? (int?)null : reader.GetInt32("MaSinhVien");
                var dbPassword = reader.GetString("MatKhau");

                var isBcrypt = dbPassword.StartsWith("$2");
                var isPasswordValid = false;
                try
                {
                    if (isBcrypt)
                    {
                        isPasswordValid = BCrypt.Net.BCrypt.Verify(request.MatKhau, dbPassword);
                    }
                }
                catch
                {
                    isPasswordValid = false;
                }

                if (!isPasswordValid && !isBcrypt)
                {
                    // Fallback legacy: so sánh plaintext, nếu đúng thì migrate sang BCrypt
                    if (dbPassword == request.MatKhau)
                    {
                        isPasswordValid = true;
                        var newHash = BCrypt.Net.BCrypt.HashPassword(request.MatKhau);

                        await reader.DisposeAsync();

                        using var updateCmd = new SqlCommand("UPDATE TaiKhoan SET MatKhau = @MatKhau WHERE MaTaiKhoan = @MaTaiKhoan", connection);
                        updateCmd.Parameters.AddWithValue("@MatKhau", newHash);
                        updateCmd.Parameters.AddWithValue("@MaTaiKhoan", maTaiKhoan);
                        await updateCmd.ExecuteNonQueryAsync();
                    }
                }

                if (!isPasswordValid)
                    return Unauthorized(new { success = false, message = "Tên đăng nhập hoặc mật khẩu không đúng" });

                var user = new
                {
                    MaTaiKhoan = maTaiKhoan,
                    TenDangNhap = tenDangNhap,
                    HoTen = hoTen,
                    Email = email,
                    VaiTro = vaiTro,
                    TrangThai = trangThai,
                    MaSinhVien = maSinhVienDb
                };

                var token = GenerateJwtToken(user);

                return Ok(new
                {
                    success = true,
                    message = "Đăng nhập thành công",
                    user = user,
                    token = token,
                    expiresIn = DateTime.UtcNow.AddHours(24)
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            try
            {
                // Hash mật khẩu với BCrypt
                var hashedPassword = BCrypt.Net.BCrypt.HashPassword(request.MatKhau);

                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_TaiKhoan_Insert", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@TenDangNhap", request.TenDangNhap);
                command.Parameters.AddWithValue("@MatKhau", hashedPassword); // Sử dụng mật khẩu đã hash
                command.Parameters.AddWithValue("@HoTen", request.HoTen);
                command.Parameters.AddWithValue("@Email", request.Email ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@VaiTro", request.VaiTro);
                command.Parameters.AddWithValue("@MaSinhVien", request.MaSinhVien ?? (object)DBNull.Value);

                var newId = await command.ExecuteScalarAsync();

                return Ok(new { success = true, message = "Đăng ký thành công", MaTaiKhoan = newId });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpGet("users")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> GetAllUsers()
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                using var command = new SqlCommand("sp_TaiKhoan_GetAll", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                using var reader = await command.ExecuteReaderAsync();
                var users = new List<object>();

                while (await reader.ReadAsync())
                {
                    users.Add(new
                    {
                        MaTaiKhoan = reader.GetInt32("MaTaiKhoan"),
                        TenDangNhap = reader.GetString("TenDangNhap"),
                        HoTen = reader.GetString("HoTen"),
                        Email = reader.IsDBNull("Email") ? null : reader.GetString("Email"),
                        VaiTro = reader.GetString("VaiTro"),
                        TrangThai = reader.GetBoolean("TrangThai"),
                        NgayTao = reader.GetDateTime("NgayTao"),
                        TenSinhVien = reader.IsDBNull("TenSinhVien") ? null : reader.GetString("TenSinhVien"),
                        MSSV = reader.IsDBNull("MSSV") ? null : reader.GetString("MSSV")
                    });
                }

                return Ok(users);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server: " + ex.Message });
            }
        }

        [HttpPost("change-password")]
        [Authorize]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            try
            {
                var userId = GetCurrentUserId();
                if (userId == null)
                    return Unauthorized();

                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                // Kiểm tra mật khẩu cũ
                using var checkCommand = new SqlCommand("SELECT MatKhau FROM TaiKhoan WHERE MaTaiKhoan = @MaTaiKhoan", connection);
                checkCommand.Parameters.AddWithValue("@MaTaiKhoan", userId);

                var oldHashedPassword = await checkCommand.ExecuteScalarAsync() as string;
                if (oldHashedPassword == null || !BCrypt.Net.BCrypt.Verify(request.OldPassword, oldHashedPassword))
                {
                    return BadRequest(new { success = false, message = "Mật khẩu cũ không đúng" });
                }

                // Cập nhật mật khẩu mới
                var newHashedPassword = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
                using var updateCommand = new SqlCommand("UPDATE TaiKhoan SET MatKhau = @MatKhau WHERE MaTaiKhoan = @MaTaiKhoan", connection);
                updateCommand.Parameters.AddWithValue("@MatKhau", newHashedPassword);
                updateCommand.Parameters.AddWithValue("@MaTaiKhoan", userId);

                await updateCommand.ExecuteNonQueryAsync();

                return Ok(new { success = true, message = "Đổi mật khẩu thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Lỗi server: " + ex.Message });
            }
        }

        private string GenerateJwtToken(dynamic user)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings");
            var secretKey = jwtSettings["SecretKey"] ?? "KTX_SecretKey_2024_VeryLongAndSecureKey_ForJWT_Token_Generation";
            var issuer = jwtSettings["Issuer"] ?? "KTX-Admin";
            var audience = jwtSettings["Audience"] ?? "KTX-Users";
            var expiryHours = int.Parse(jwtSettings["ExpiryInHours"] ?? "24");

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey));
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.MaTaiKhoan.ToString()),
                new Claim(ClaimTypes.Name, user.TenDangNhap),
                new Claim(ClaimTypes.GivenName, user.HoTen),
                new Claim(ClaimTypes.Email, user.Email ?? ""),
                new Claim(ClaimTypes.Role, user.VaiTro),
                new Claim("MaSinhVien", user.MaSinhVien?.ToString() ?? ""),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Iat, new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds().ToString(), ClaimValueTypes.Integer64)
            };

            var token = new JwtSecurityToken(
                issuer: issuer,
                audience: audience,
                claims: claims,
                expires: DateTime.UtcNow.AddHours(expiryHours),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private int? GetCurrentUserId()
        {
            var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier);
            return userIdClaim != null ? int.Parse(userIdClaim.Value) : null;
        }
    }

    // Request Models
    public class LoginRequest
    {
        public string TenDangNhap { get; set; } = string.Empty;
        public string MatKhau { get; set; } = string.Empty;
    }

    public class RegisterRequest
    {
        public string TenDangNhap { get; set; } = string.Empty;
        public string MatKhau { get; set; } = string.Empty;
        public string HoTen { get; set; } = string.Empty;
        public string? Email { get; set; }
        public string VaiTro { get; set; } = "Student";
        public int? MaSinhVien { get; set; }
    }
    public class ChangePasswordRequest
    {
        public string OldPassword { get; set; } = string.Empty;
        public string NewPassword { get; set; } = string.Empty;
    }
}
