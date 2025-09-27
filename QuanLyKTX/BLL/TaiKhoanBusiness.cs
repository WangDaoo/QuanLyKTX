using DAL;
using Model;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace BLL
{
    public partial class TaiKhoanBusiness : ITaiKhoanBusiness
    {
        private ITaiKhoanRepository _res;
        private IConfiguration _configuration;
        
        public TaiKhoanBusiness(ITaiKhoanRepository res, IConfiguration configuration)
        {
            _res = res;
            _configuration = configuration;
        }

        public LoginResponse Authenticate(LoginRequest request)
        {
            // Business logic validation
            if (string.IsNullOrEmpty(request.TenDangNhap))
                throw new Exception("Tên đăng nhập không được để trống");
            
            if (string.IsNullOrEmpty(request.MatKhau))
                throw new Exception("Mật khẩu không được để trống");

            var user = _res.Authenticate(request.TenDangNhap, request.MatKhau);
            
            if (user == null)
                throw new Exception("Tên đăng nhập hoặc mật khẩu không đúng");

            if (user.trang_thai != "active")
                throw new Exception("Tài khoản đã bị khóa");

            // Tạo JWT token
            var token = GenerateJwtToken(user);
            
            return new LoginResponse
            {
                Token = token,
                TenDangNhap = user.ten_dang_nhap,
                HoTen = user.ho_ten,
                Email = user.email ?? "",
                VaiTro = user.vai_tro,
                NgayDangNhap = DateTime.UtcNow,
                ThanhCong = true,
                ThongBao = "Đăng nhập thành công"
            };
        }

        public bool Create(TaiKhoanModel model)
        {
            // Business logic validation
            if (string.IsNullOrEmpty(model.ten_dang_nhap))
                throw new Exception("Tên đăng nhập không được để trống");
            
            if (string.IsNullOrEmpty(model.mat_khau))
                throw new Exception("Mật khẩu không được để trống");
            
            if (string.IsNullOrEmpty(model.ho_ten))
                throw new Exception("Họ tên không được để trống");
            
            if (model.mat_khau.Length < 6)
                throw new Exception("Mật khẩu phải có ít nhất 6 ký tự");

            return _res.Create(model);
        }

        public bool Update(TaiKhoanModel model)
        {
            // Business logic validation
            if (model.ma_tai_khoan <= 0)
                throw new Exception("Mã tài khoản không hợp lệ");
            
            if (string.IsNullOrEmpty(model.ten_dang_nhap))
                throw new Exception("Tên đăng nhập không được để trống");
            
            if (string.IsNullOrEmpty(model.ho_ten))
                throw new Exception("Họ tên không được để trống");

            return _res.Update(model);
        }

        public TaiKhoanModel GetDatabyID(int id)
        {
            if (id <= 0)
                throw new Exception("Mã tài khoản không hợp lệ");

            return _res.GetDatabyID(id);
        }

        public List<TaiKhoanModel> GetDataAll()
        {
            return _res.GetDataAll();
        }

        public List<TaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string ten_dang_nhap, string vai_tro)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_dang_nhap, vai_tro);
        }

        public bool ChangePassword(int maTaiKhoan, string matKhauMoi, string matKhauCu)
        {
            if (maTaiKhoan <= 0)
                throw new Exception("Mã tài khoản không hợp lệ");
            
            if (string.IsNullOrEmpty(matKhauMoi))
                throw new Exception("Mật khẩu mới không được để trống");
            
            if (matKhauMoi.Length < 6)
                throw new Exception("Mật khẩu mới phải có ít nhất 6 ký tự");

            // Kiểm tra mật khẩu cũ
            var user = _res.GetDatabyID(maTaiKhoan);
            if (user == null)
                throw new Exception("Không tìm thấy tài khoản");
            
            if (user.mat_khau != matKhauCu)
                throw new Exception("Mật khẩu cũ không đúng");

            return _res.ChangePassword(maTaiKhoan, matKhauMoi);
        }

        private string GenerateJwtToken(TaiKhoanModel user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(GetSecretKey());
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.ma_tai_khoan.ToString()),
                    new Claim(ClaimTypes.Name, user.ten_dang_nhap),
                    new Claim(ClaimTypes.GivenName, user.ho_ten),
                    new Claim(ClaimTypes.Email, user.email ?? ""),
                    new Claim(ClaimTypes.Role, user.vai_tro)
                }),
                Expires = DateTime.UtcNow.AddMinutes(GetTokenExpiryMinutes()),
                Issuer = GetIssuer(),
                Audience = GetAudience(),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        private string GetSecretKey()
        {
            return _configuration["AppSettings:Secret"];
        }

        private string GetIssuer()
        {
            return _configuration["AppSettings:Issuer"];
        }

        private string GetAudience()
        {
            return _configuration["AppSettings:Audience"];
        }

        private int GetTokenExpiryMinutes()
        {
            var expiryMinutes = _configuration["AppSettings:ExpiryMinutes"];
            return int.TryParse(expiryMinutes, out int minutes) ? minutes : 60;
        }
    }
}