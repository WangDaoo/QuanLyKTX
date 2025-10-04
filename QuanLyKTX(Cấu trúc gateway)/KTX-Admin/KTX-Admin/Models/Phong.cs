namespace KTX_Admin.Models
{
    public sealed class Phong
    {
        public int MaPhong { get; set; }
        public int MaToaNha { get; set; }
        public string SoPhong { get; set; } = string.Empty;
        public int SoGiuong { get; set; }
        public string LoaiPhong { get; set; } = string.Empty;
        public decimal GiaPhong { get; set; }
        public string? MoTa { get; set; }
        public string TrangThai { get; set; } = "Trống";
        public bool IsDeleted { get; set; }
    }
}


