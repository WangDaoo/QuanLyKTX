namespace KTX_Admin.Models
{
    public sealed class ThongBaoQuaHan
    {
        public int MaThongBao { get; set; }
        public int MaHoaDon { get; set; }
        public DateTime NgayHetHan { get; set; }
        public DateTime NgayThongBao { get; set; } = DateTime.UtcNow;
        public string? HinhThuc { get; set; }
        public string? NoiDung { get; set; }
    }
}


