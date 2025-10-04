namespace KTX_Admin.Models
{
    public sealed class BienLaiThu
    {
        public int MaBienLai { get; set; }
        public int MaHoaDon { get; set; }
        public decimal SoTienThu { get; set; }
        public DateTime NgayThu { get; set; } = DateTime.UtcNow;
        public string? NguoiThu { get; set; }
        public string? GhiChu { get; set; }
    }
}


