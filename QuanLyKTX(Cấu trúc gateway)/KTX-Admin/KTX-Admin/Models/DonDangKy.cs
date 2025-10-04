namespace KTX_Admin.Models
{
    public sealed class DonDangKy
    {
        public int MaDon { get; set; }
        public int MaSinhVien { get; set; }
        public int? MaPhongDeXuat { get; set; }
        public string TrangThai { get; set; } = "ChoDuyet";
        public string? LyDo { get; set; }
        public DateTime NgayTao { get; set; } = DateTime.UtcNow;
        public DateTime? NgayCapNhat { get; set; }
    }
}


