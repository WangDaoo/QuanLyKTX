namespace KTX_Admin.Models
{
    public sealed class KyLuat
    {
        public int MaKyLuat { get; set; }
        public int MaSinhVien { get; set; }
        public string HanhVi { get; set; } = string.Empty;
        public string? HinhThucXuLy { get; set; }
        public DateTime NgayViPham { get; set; } = DateTime.UtcNow;
        public string? GhiChu { get; set; }
    }
}


