using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using KTX_Admin.Models;

namespace KTX_Admin.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _cfg;
        private readonly AppDbContext _db;
        public AuthController(IConfiguration cfg, AppDbContext db)
        {
            _cfg = cfg;
            _db = db;
        }

        public sealed class LoginRequest
        {
            public string? username { get; set; }
            public string? password { get; set; }
        }

        [HttpPost("token")]
        public IActionResult Token([FromBody] LoginRequest body)
        {
            // Xác thực với bảng TaiKhoan (SQL Server thực)
            var secret = _cfg.GetValue<string>("AppSettings:Secret") ?? "super_secret_ktx_admin";
            var keyBytes = System.Security.Cryptography.SHA256.HashData(Encoding.UTF8.GetBytes(secret));
            var key = new SymmetricSecurityKey(keyBytes);
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256Signature);

            var username = (body.username ?? string.Empty).Trim();
            var password = body.password ?? string.Empty;

            var account = _db.Set<TaiKhoan>().FirstOrDefault(x => x.Username == username && x.TrangThai);
            if (account == null)
            {
                return Unauthorized(new { message = "Tài khoản không tồn tại hoặc bị khóa" });
            }
            // Với dữ liệu seed hiện tại, PasswordHash đang lưu plain. Nếu cần hash, thay kiểm tra này cho phù hợp.
            if (!string.Equals(account.PasswordHash, password, StringComparison.Ordinal))
            {
                return Unauthorized(new { message = "Sai mật khẩu" });
            }

            var role = string.IsNullOrWhiteSpace(account.Role) ? "Student" : account.Role;
            var nameValue = role == "Student" && account.MaSinhVien.HasValue
                ? account.MaSinhVien.Value.ToString()
                : account.Username;
            var claims = new[]
            {
                new Claim(ClaimTypes.Name, nameValue),
                new Claim(ClaimTypes.Role, role)
            };
            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.UtcNow.AddHours(8),
                signingCredentials: creds
            );
            var tokenString = new JwtSecurityTokenHandler().WriteToken(token);
            return Ok(new { token = tokenString, role });
        }
    }
}


