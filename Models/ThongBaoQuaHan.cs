namespace KTX_Admin.Models
{
    public sealed class ThongBaoQuaHan
    {
        public int MaThongBao { get; set; }
        public int MaSinhVien { get; set; }
        public int MaHoaDon { get; set; }
        public DateTime NgayThongBao { get; set; } = DateTime.UtcNow;
        public string NoiDung { get; set; } = string.Empty;
        public string TrangThai { get; set; } = "Đã gửi";
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }
}




