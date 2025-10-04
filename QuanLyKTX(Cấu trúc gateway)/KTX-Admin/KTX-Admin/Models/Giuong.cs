namespace KTX_Admin.Models
{
    public sealed class Giuong
    {
        public int MaGiuong { get; set; }
        public int MaPhong { get; set; }
        public string SoGiuong { get; set; } = string.Empty;
        public string TrangThai { get; set; } = "Trống";
        public string? GhiChu { get; set; }
        public bool IsDeleted { get; set; }
    }
}


