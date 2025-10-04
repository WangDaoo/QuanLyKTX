namespace KTX_Admin.Models
{
    public sealed class TaiKhoan
    {
        public int MaTaiKhoan { get; set; }
        public string Username { get; set; } = string.Empty;
        public string PasswordHash { get; set; } = string.Empty; // hiện lưu plain để demo
        public string Role { get; set; } = "Student"; // Admin/Officer/Student
        public int? MaSinhVien { get; set; }
        public bool TrangThai { get; set; } = true;
        public DateTime NgayTao { get; set; } = DateTime.UtcNow;
    }
}


