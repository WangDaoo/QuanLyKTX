namespace KTX_Admin.Models
{
    public sealed class YeuCauChuyenPhong
    {
        public int MaYeuCau { get; set; }
        public int MaSinhVien { get; set; }
        public int MaPhongCu { get; set; }
        public int MaPhongMoi { get; set; }
        public string TrangThai { get; set; } = "ChoDuyet";
        public string? LyDo { get; set; }
        public DateTime NgayTao { get; set; } = DateTime.UtcNow;
        public DateTime? NgayCapNhat { get; set; }
    }
}


