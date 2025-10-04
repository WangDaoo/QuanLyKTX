using System;

namespace Model
{
    public class LoginResponse
    {
        public int MaTaiKhoan { get; set; }
        public string TenDangNhap { get; set; } = string.Empty;
        public string HoTen { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string VaiTro { get; set; } = string.Empty;
        public string Token { get; set; } = string.Empty;
        public DateTime NgayDangNhap { get; set; }
        public bool ThanhCong { get; set; }
        public string ThongBao { get; set; } = string.Empty;
    }
}